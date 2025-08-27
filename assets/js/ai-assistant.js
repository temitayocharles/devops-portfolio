// AI Assistant Module
class AIAssistant {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.isOpen = false;
        this.initialize();
    }

    initialize() {
        this.createToggleButton();
        this.createChatInterface();
        this.bindEvents();
    }

    createToggleButton() {
        const button = document.createElement('button');
        button.className = 'ai-toggle';
        button.innerHTML = '🤖';
        button.setAttribute('aria-label', 'Toggle AI Assistant');
        button.setAttribute('title', 'Ask me anything about DevOps!');
        document.body.appendChild(button);
        
        this.toggleButton = button;
    }

    createChatInterface() {
        const chatHtml = `
            <div class="ai-chat-header">
                <h3>DevOps AI Assistant</h3>
                <button class="ai-close" aria-label="Close AI Assistant">×</button>
            </div>
            <div class="ai-chat-messages"></div>
            <div class="ai-chat-input">
                <textarea 
                    placeholder="Ask me about DevOps, cloud architecture, or any of my projects..."
                    rows="1"
                    aria-label="Chat input"
                ></textarea>
                <button class="ai-send" aria-label="Send message">
                    <span>Send</span>
                </button>
            </div>
        `;

        this.container.innerHTML = chatHtml;
        this.messagesContainer = this.container.querySelector('.ai-chat-messages');
        this.input = this.container.querySelector('textarea');
        this.sendButton = this.container.querySelector('.ai-send');
    }

    bindEvents() {
        // Toggle chat
        this.toggleButton.addEventListener('click', () => this.toggleChat());
        this.container.querySelector('.ai-close').addEventListener('click', () => this.toggleChat());

        // Send message
        this.sendButton.addEventListener('click', () => this.sendMessage());
        this.input.addEventListener('keypress', (e) => {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                this.sendMessage();
            }
        });

        // Auto-resize textarea
        this.input.addEventListener('input', () => {
            this.input.style.height = 'auto';
            this.input.style.height = (this.input.scrollHeight) + 'px';
        });
    }

    toggleChat() {
        this.isOpen = !this.isOpen;
        this.container.classList.toggle('open', this.isOpen);
        this.toggleButton.classList.toggle('open', this.isOpen);
        
        if (this.isOpen) {
            this.input.focus();
            if (this.messagesContainer.children.length === 0) {
                this.addMessage("Hello! I'm your DevOps AI assistant. Feel free to ask me about containerization, cloud architecture, CI/CD, or any of my projects!", 'assistant');
            }
        }
    }

    addMessage(text, sender) {
        const messageDiv = document.createElement('div');
        messageDiv.className = `ai-message ${sender}`;
        messageDiv.innerHTML = `
            <div class="ai-message-content">
                <span class="ai-message-text">${this.formatMessage(text)}</span>
                ${sender === 'assistant' ? '<span class="ai-message-icon">🤖</span>' : ''}
            </div>
        `;
        this.messagesContainer.appendChild(messageDiv);
        this.messagesContainer.scrollTop = this.messagesContainer.scrollHeight;
    }

    formatMessage(text) {
        // Convert URLs to links
        text = text.replace(/(https?:\/\/[^\s]+)/g, '<a href="$1" target="_blank">$1</a>');
        
        // Convert code blocks
        text = text.replace(/`([^`]+)`/g, '<code>$1</code>');
        
        // Convert bold text
        text = text.replace(/\*\*([^\*]+)\*\*/g, '<strong>$1</strong>');
        
        // Convert bullet points
        text = text.replace(/^- (.+)$/gm, '• $1');
        
        return text;
    }

    async sendMessage() {
        const message = this.input.value.trim();
        if (!message) return;

        // Clear input
        this.input.value = '';
        this.input.style.height = 'auto';

        // Add user message
        this.addMessage(message, 'user');

        // Show typing indicator
        const loadingDiv = document.createElement('div');
        loadingDiv.className = 'ai-message assistant typing';
        loadingDiv.innerHTML = '<div class="typing-indicator"><span></span><span></span><span></span></div>';
        this.messagesContainer.appendChild(loadingDiv);

        // Process the message and get response
        const response = await this.processMessage(message);
        
        // Remove typing indicator
        loadingDiv.remove();
        
        // Add assistant response
        this.addMessage(response, 'assistant');
    }

    async processMessage(message) {
        // Simulate AI processing with predefined responses
        const responses = {
            containerization: "I specialize in containerization! My Ultimate DevOps Container comes with 30+ pre-installed tools and features like built-in monitoring, security hardening, and automated setup. Check out the demos in the Projects section!",
            cicd: "I've implemented various CI/CD solutions using GitHub Actions, Jenkins, and GitLab. My enterprise CI/CD pipeline project showcases zero-downtime deployments with automated security scanning.",
            cloud: "I work extensively with AWS, Azure, and GCP. My portfolio includes projects ranging from serverless architectures to Kubernetes clusters. Each cloud solution is designed with scalability and security in mind.",
            default: "I'd be happy to help you with that! You can find detailed information about my projects and expertise in the portfolio. Feel free to ask specific questions about any technology or project."
        };

        // Simple keyword matching for demo purposes
        let response = responses.default;
        const lowercaseMessage = message.toLowerCase();
        
        if (lowercaseMessage.includes('container') || lowercaseMessage.includes('docker')) {
            response = responses.containerization;
        } else if (lowercaseMessage.includes('ci') || lowercaseMessage.includes('cd') || lowercaseMessage.includes('pipeline')) {
            response = responses.cicd;
        } else if (lowercaseMessage.includes('cloud') || lowercaseMessage.includes('aws') || lowercaseMessage.includes('azure')) {
            response = responses.cloud;
        }

        // Simulate network delay
        await new Promise(resolve => setTimeout(resolve, 1000));
        return response;
    }
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new AIAssistant('ai-assistant');
});
