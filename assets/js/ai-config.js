// AI Assistant Configuration
class AIConfig {
    constructor() {
        this.useHybrid = true;  // Enable hybrid mode (local + Gemini)
        this.apiEndpoint = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';
    }

    async loadConfig() {
        try {
            const response = await fetch('/.env.public.json');
            const config = await response.json();
            this.apiKey = config.GEMINI_API_KEY;
            return true;
        } catch (error) {
            console.warn('Using local-only mode: API key not found');
            return false;
        }
    }

    // Add methods for handling both local and API responses
    async getResponse(query) {
        // Try local response first
        const localResponse = this.getLocalResponse(query);
        if (localResponse) return localResponse;

        // Fall back to Gemini if available
        if (this.apiKey && this.useHybrid) {
            return await this.getGeminiResponse(query);
        }

        return "I'm not sure how to help with that. Could you try rephrasing your question?";
    }

    getLocalResponse(query) {
        // Pre-programmed responses for common queries
        const responses = {
            // About Me & Skills
            'what technologies do you use': 'I specialize in cloud technologies and DevOps practices including:\n• AWS (S3, EC2, ECS, Lambda, RDS, CloudWatch)\n• Docker & Kubernetes\n• Terraform for infrastructure as code\n• CI/CD tools like Jenkins and GitHub Actions\n• Shell scripting and Python\n• Front-end development with React and JavaScript',
            'tell me about your experience': 'I am a DevOps Engineer with hands-on experience in:\n• Building and managing cloud infrastructure on AWS\n• Automating deployments using CI/CD pipelines\n• Containerizing applications with Docker\n• Infrastructure automation with Terraform\n• Application development with JavaScript/React\n• Server management and Linux administration',
            'what are your skills': 'My technical skills include:\n• Cloud: AWS (S3, EC2, ECS, Lambda, RDS)\n• Infrastructure: Terraform, Docker, Kubernetes\n• CI/CD: Jenkins, GitHub Actions\n• Languages: Python, JavaScript, Shell Script\n• Frontend: React, HTML5, CSS3\n• Databases: MySQL, PostgreSQL\n• Version Control: Git, GitHub\n• Operating Systems: Linux (Ubuntu, CentOS)',
            'what cloud platforms': 'I primarily work with AWS, utilizing services like:\n• EC2 for compute resources\n• S3 for object storage\n• ECS for container orchestration\n• Lambda for serverless computing\n• RDS for managed databases\n• CloudWatch for monitoring\nI have experience designing and implementing scalable cloud architectures.',
            
            // Projects & Portfolio
            'tell me about your projects': 'Here are some of my key projects:\n• NFT-Based Learning Platform - Built with React and AWS services\n• DevOps Portfolio Site - Showcasing cloud and automation projects\n• Cloud Infrastructure Automation - AWS infrastructure as code with Terraform\n• CI/CD Pipeline Implementation - Automated deployments with Jenkins\n• Containerization Projects - Docker and Kubernetes implementations\nWould you like details about any specific project?',
            'show me your best project': 'My featured project is the NFT-Based Learning Platform, which demonstrates my full-stack capabilities:\n• React-based frontend with modern UI/UX\n• AWS cloud infrastructure (S3, EC2, Lambda)\n• CI/CD pipeline with automated deployments\n• Infrastructure as Code using Terraform\n• Container orchestration with Docker\n• Monitoring and logging implementation',
            
            // Services & Expertise
            'what services do you offer': 'I offer a range of DevOps and cloud engineering services:\n• AWS Cloud Infrastructure Design and Implementation\n• CI/CD Pipeline Setup and Optimization\n• Infrastructure Automation with Terraform\n• Docker Containerization and Kubernetes Orchestration\n• Application Development with React/JavaScript\n• Cloud Monitoring and Cost Optimization\nWould you like details about any specific service?',
            'tell me about your education': 'I have a solid educational background in technology:\n• Higher National Diploma (HND) in Computer Science\n• Focus on software development and systems architecture\n• Continuous learning through professional development\n• Hands-on experience with modern cloud technologies',
            
            // Technical Questions
            'how do you handle ci/cd': 'I implement CI/CD pipelines focusing on automation and efficiency:\n• Jenkins and GitHub Actions for automated builds\n• Automated testing and code quality checks\n• Docker container builds and deployments\n• Infrastructure as Code with Terraform\n• Continuous monitoring with CloudWatch\n• Automated rollback capabilities',
            'explain your cloud experience': 'My AWS cloud experience includes:\n• EC2 instance management and Auto Scaling\n• S3 bucket configuration and management\n• ECS container service implementation\n• Lambda serverless functions\n• RDS database administration\n• CloudWatch monitoring and alerting',
            'tell me about your development skills': 'My development skills include:\n• Frontend: React.js, JavaScript, HTML5, CSS3\n• Backend: Node.js basics, RESTful APIs\n• Scripting: Python, Shell scripting\n• Version Control: Git, GitHub\n• Build Tools: npm, webpack\n• Testing: Jest, React Testing Library',
            
            // Contact & Availability
            'how can i contact you': 'You can reach me through:\n• Email (provided in contact section)\n• LinkedIn profile\n• GitHub profile\nI typically respond within 24 hours.',
            'are you available for hire': 'Yes, I am available for:\n• Full-time positions\n• Contract work\n• Consulting projects\nPlease reach out through the contact form to discuss opportunities.',
            
            // Portfolio Navigation
            'how do i navigate': 'The portfolio is organized into several sections:\n• Projects - Detailed case studies of my work\n• Services - What I offer\n• About - My background and skills\n• Contact - How to reach me\nUse the navigation menu or scroll to explore.',
            'where are your projects': 'You can find my projects in the Projects section. They are categorized by cloud platform (AWS, Azure, GCP) and type of solution. Each project includes detailed information about the problem solved, technologies used, and outcomes achieved.',
            
            // Specific Technologies
            'tell me about terraform': 'I use Terraform for infrastructure as code, managing cloud resources across multiple providers. My experience includes:\n• Multi-cloud deployments\n• Custom provider development\n• Module creation and sharing\n• State management\n• Security and compliance automation',
            'explain your monitoring setup': 'My monitoring architecture typically includes:\n• Prometheus for metrics collection\n• Grafana for visualization\n• ELK Stack for log management\n• Custom alerting rules\n• SLO/SLI tracking\n• Automated incident response'
        };

        // Simple matching
        const key = Object.keys(responses).find(k => 
            query.toLowerCase().includes(k.toLowerCase())
        );

        return responses[key] || null;
    }

    async getGeminiResponse(query) {
        try {
            const response = await fetch(`${this.apiEndpoint}?key=${this.apiKey}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    contents: [{
                        parts: [{
                            text: query
                        }]
                    }]
                })
            });

            const data = await response.json();
            return data.candidates[0].content.parts[0].text;
        } catch (error) {
            console.error('Gemini API error:', error);
            return this.getLocalResponse(query) || 
                   "I'm having trouble connecting to my advanced features. Let me provide a basic response instead.";
        }
    }
}

// Export the configuration
export const aiConfig = new AIConfig();
