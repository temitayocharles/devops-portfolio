// Enhanced Contact Form JavaScript
// File: js/contact-form.js

class ContactForm {
    constructor() {
        this.form = document.getElementById('contact-form');
        this.submitBtn = document.querySelector('.submit-btn');
        this.messageDiv = document.getElementById('form-message');
        this.isSubmitting = false;
        
        this.init();
    }
    
    init() {
        if (!this.form) return;
        
        this.form.addEventListener('submit', this.handleSubmit.bind(this));
        
        // Real-time validation
        this.form.querySelectorAll('input, textarea, select').forEach(field => {
            field.addEventListener('blur', () => this.validateField(field));
            field.addEventListener('input', () => this.clearFieldError(field));
        });
        
        // Character counter for message
        const messageField = this.form.querySelector('#message');
        if (messageField) {
            this.addCharacterCounter(messageField);
        }
    }
    
    async handleSubmit(e) {
        e.preventDefault();
        
        if (this.isSubmitting) return;
        
        // Validate all fields
        if (!this.validateForm()) return;
        
        this.isSubmitting = true;
        this.setSubmitState(true);
        
        try {
            const formData = new FormData(this.form);
            const data = Object.fromEntries(formData.entries());
            
            // Track form submission attempt
            if (typeof gtag !== 'undefined') {
                gtag('event', 'form_submit_attempt', {
                    event_category: 'Contact',
                    event_label: 'Contact Form'
                });
            }
            
            const response = await fetch('/.netlify/functions/contact', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            });
            
            const result = await response.json();
            
            if (response.ok) {
                this.showSuccess(result.message);
                this.form.reset();
                
                // Track successful submission
                if (typeof gtag !== 'undefined') {
                    gtag('event', 'form_submit_success', {
                        event_category: 'Contact',
                        event_label: 'Contact Form',
                        value: 1
                    });
                }
                
                // Optional: Auto-hide success message after 10 seconds
                setTimeout(() => {
                    this.hideMessage();
                }, 10000);
                
            } else {
                throw new Error(result.error || 'Failed to send message');
            }
            
        } catch (error) {
            console.error('Contact form error:', error);
            this.showError(error.message || 'Failed to send message. Please try again.');
            
            // Track form submission error
            if (typeof gtag !== 'undefined') {
                gtag('event', 'form_submit_error', {
                    event_category: 'Contact',
                    event_label: 'Contact Form',
                    error_message: error.message
                });
            }
        } finally {
            this.isSubmitting = false;
            this.setSubmitState(false);
        }
    }
    
    validateForm() {
        let isValid = true;
        const requiredFields = this.form.querySelectorAll('[required]');
        
        requiredFields.forEach(field => {
            if (!this.validateField(field)) {
                isValid = false;
            }
        });
        
        return isValid;
    }
    
    validateField(field) {
        const value = field.value.trim();
        const fieldName = field.name;
        
        // Clear previous errors
        this.clearFieldError(field);
        
        // Required field validation
        if (field.hasAttribute('required') && !value) {
            this.showFieldError(field, `${this.getFieldLabel(field)} is required`);
            return false;
        }
        
        // Email validation
        if (fieldName === 'email' && value) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(value)) {
                this.showFieldError(field, 'Please enter a valid email address');
                return false;
            }
        }
        
        // Name validation (no numbers)
        if (fieldName === 'name' && value) {
            const nameRegex = /^[a-zA-Z\s\-'\.]+$/;
            if (!nameRegex.test(value)) {
                this.showFieldError(field, 'Name should only contain letters, spaces, hyphens, and apostrophes');
                return false;
            }
        }
        
        // Message length validation
        if (fieldName === 'message' && value) {
            if (value.length < 10) {
                this.showFieldError(field, 'Message should be at least 10 characters long');
                return false;
            }
            if (value.length > 2000) {
                this.showFieldError(field, 'Message should not exceed 2000 characters');
                return false;
            }
        }
        
        return true;
    }
    
    showFieldError(field, message) {
        field.classList.add('error');
        
        // Remove existing error message
        const existingError = field.parentNode.querySelector('.field-error');
        if (existingError) {
            existingError.remove();
        }
        
        // Add new error message
        const errorDiv = document.createElement('div');
        errorDiv.className = 'field-error';
        errorDiv.textContent = message;
        field.parentNode.appendChild(errorDiv);
    }
    
    clearFieldError(field) {
        field.classList.remove('error');
        const errorDiv = field.parentNode.querySelector('.field-error');
        if (errorDiv) {
            errorDiv.remove();
        }
    }
    
    getFieldLabel(field) {
        const label = this.form.querySelector(`label[for="${field.id}"]`);
        return label ? label.textContent.replace('*', '').trim() : field.name;
    }
    
    addCharacterCounter(field) {
        const maxLength = 2000;
        const counter = document.createElement('div');
        counter.className = 'character-counter';
        counter.textContent = `0 / ${maxLength}`;
        field.parentNode.appendChild(counter);
        
        field.addEventListener('input', () => {
            const length = field.value.length;
            counter.textContent = `${length} / ${maxLength}`;
            
            if (length > maxLength * 0.9) {
                counter.classList.add('warning');
            } else {
                counter.classList.remove('warning');
            }
            
            if (length > maxLength) {
                counter.classList.add('error');
            } else {
                counter.classList.remove('error');
            }
        });
    }
    
    setSubmitState(isSubmitting) {
        if (isSubmitting) {
            this.submitBtn.disabled = true;
            this.submitBtn.innerHTML = `
                <span class="spinner"></span>
                Sending...
            `;
        } else {
            this.submitBtn.disabled = false;
            this.submitBtn.innerHTML = `
                <i class="fas fa-paper-plane"></i>
                Send Message
            `;
        }
    }
    
    showSuccess(message) {
        this.messageDiv.innerHTML = `
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${message}
            </div>
        `;
        this.messageDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
    
    showError(message) {
        this.messageDiv.innerHTML = `
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                ${message}
            </div>
        `;
        this.messageDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
    
    hideMessage() {
        this.messageDiv.innerHTML = '';
    }
}

// Auto-initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    new ContactForm();
});

// Export for module usage
if (typeof module !== 'undefined' && module.exports) {
    module.exports = ContactForm;
}