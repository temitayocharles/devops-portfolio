// Contact Form Backend - Netlify Functions
// File: netlify/functions/contact.js

const nodemailer = require('nodemailer');

exports.handler = async (event, context) => {
  // CORS headers
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'POST, OPTIONS'
  };
  
  // Handle preflight OPTIONS request
  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({ message: 'CORS preflight' })
    };
  }
  
  // Only allow POST requests
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      headers,
      body: JSON.stringify({ error: 'Method not allowed' })
    };
  }
  
  try {
    // Parse request body
    const { name, email, subject, message, company, projectType } = JSON.parse(event.body);
    
    // Validate required fields
    if (!name || !email || !message) {
      return {
        statusCode: 400,
        headers,
        body: JSON.stringify({ 
          error: 'Missing required fields: name, email, and message are required' 
        })
      };
    }
    
    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      return {
        statusCode: 400,
        headers,
        body: JSON.stringify({ error: 'Invalid email format' })
      };
    }
    
    // Rate limiting (simple in-memory cache, use Redis for production)
    const clientIP = event.headers['client-ip'] || event.headers['x-forwarded-for'];
    // Implement rate limiting logic here
    
    // Configure email transporter
    const transporter = nodemailer.createTransporter({
      service: 'gmail', // or your preferred email service
      auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
      }
    });
    
    // Email to portfolio owner
    const ownerEmailOptions = {
      from: `"Portfolio Contact Form" <${process.env.EMAIL_USER}>`,
      to: 'temitayo_charles@yahoo.com',
      subject: `Portfolio Contact: ${subject || 'New Contact Form Submission'}`,
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
          <h2 style="color: #66d9ef; border-bottom: 2px solid #66d9ef; padding-bottom: 10px;">
            New Portfolio Contact 📧
          </h2>
          
          <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;">
            <h3 style="color: #333; margin-top: 0;">Contact Details</h3>
            <p><strong>Name:</strong> ${name}</p>
            <p><strong>Email:</strong> <a href="mailto:${email}">${email}</a></p>
            ${company ? `<p><strong>Company:</strong> ${company}</p>` : ''}
            ${projectType ? `<p><strong>Project Type:</strong> ${projectType}</p>` : ''}
            <p><strong>Subject:</strong> ${subject || 'No subject provided'}</p>
          </div>
          
          <div style="background: #fff; padding: 20px; border: 1px solid #e9ecef; border-radius: 8px;">
            <h3 style="color: #333; margin-top: 0;">Message</h3>
            <p style="white-space: pre-wrap; line-height: 1.6;">${message}</p>
          </div>
          
          <div style="margin-top: 20px; padding: 15px; background: #e8f4fd; border-radius: 8px;">
            <p style="margin: 0; font-size: 14px; color: #666;">
              <strong>Submission Time:</strong> ${new Date().toLocaleString()}<br>
              <strong>User IP:</strong> ${clientIP}<br>
              <strong>Source:</strong> Portfolio Contact Form
            </p>
          </div>
          
          <div style="margin-top: 30px; text-align: center;">
            <a href="mailto:${email}?subject=Re: ${encodeURIComponent(subject || 'Your portfolio inquiry')}" 
               style="background: #66d9ef; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; display: inline-block;">
              Reply to ${name}
            </a>
          </div>
        </div>
      `
    };
    
    // Auto-reply email to sender
    const autoReplyOptions = {
      from: `"Temitayo Charles" <${process.env.EMAIL_USER}>`,
      to: email,
      subject: 'Thank you for contacting me! 🚀',
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
          <h2 style="color: #66d9ef; border-bottom: 2px solid #66d9ef; padding-bottom: 10px;">
            Thank You for Reaching Out! 🚀
          </h2>
          
          <p>Hi ${name},</p>
          
          <p>Thank you for your interest in my DevOps work! I've received your message and really appreciate you taking the time to reach out.</p>
          
          <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;">
            <h3 style="color: #333; margin-top: 0;">What happens next?</h3>
            <ul style="line-height: 1.8;">
              <li>📧 I'll review your message within 24 hours</li>
              <li>🤝 I'll respond with relevant information or next steps</li>
              <li>💬 We can schedule a call if needed</li>
              <li>🚀 Let's explore how we can work together!</li>
            </ul>
          </div>
          
          <div style="background: #e8f4fd; padding: 20px; border-radius: 8px; margin: 20px 0;">
            <h3 style="color: #333; margin-top: 0;">In the meantime...</h3>
            <p>Feel free to explore more of my work:</p>
            <ul style="line-height: 1.8;">
              <li>🐳 <a href="https://hub.docker.com/u/temitayocharles" style="color: #66d9ef;">Check out my Docker containers</a></li>
              <li>🐙 <a href="https://github.com/temitayocharles" style="color: #66d9ef;">Browse my GitHub projects</a></li>
              <li>💼 <a href="https://linkedin.com/in/temitayocharles" style="color: #66d9ef;">Connect on LinkedIn</a></li>
              <li>🌐 <a href="https://temitayocharles.github.io/devops-portfolio/" style="color: #66d9ef;">Explore my full portfolio</a></li>
            </ul>
          </div>
          
          <p>Best regards,<br>
          <strong>Temitayo Charles</strong><br>
          DevOps Engineer & Container Specialist</p>
          
          <div style="margin-top: 30px; padding: 15px; background: #f8f9fa; border-radius: 8px; font-size: 14px; color: #666;">
            <p style="margin: 0;"><strong>Your message summary:</strong></p>
            <p style="margin: 5px 0;"><strong>Subject:</strong> ${subject || 'No subject'}</p>
            <p style="margin: 5px 0;"><strong>Sent:</strong> ${new Date().toLocaleString()}</p>
          </div>
        </div>
      `
    };
    
    // Send both emails
    await Promise.all([
      transporter.sendMail(ownerEmailOptions),
      transporter.sendMail(autoReplyOptions)
    ]);
    
    // Log successful contact (could be sent to analytics service)
    console.log(`Contact form submission from ${name} (${email}) at ${new Date().toISOString()}`);
    
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        success: true,
        message: 'Thank you for your message! I\'ll get back to you within 24 hours.',
        timestamp: new Date().toISOString()
      })
    };
    
  } catch (error) {
    console.error('Contact form error:', error);
    
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({
        error: 'Failed to send message. Please try again or contact me directly at temitayo_charles@yahoo.com',
        timestamp: new Date().toISOString()
      })
    };
  }
};