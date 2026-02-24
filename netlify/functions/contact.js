// Contact Form Backend - Express Handler
// Adapted from Netlify Functions for Express

const nodemailer = require('nodemailer');

function escapeHtml(value = '') {
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function sanitizeHeader(value = '') {
  return String(value).replace(/[\r\n]+/g, ' ').trim();
}

const handler = async (req, res) => {
  const allowedOrigins = (process.env.ALLOWED_ORIGINS || process.env.ALLOWED_ORIGIN || '')
    .split(',')
    .map((o) => o.trim())
    .filter(Boolean);
  const requestOrigin = req.headers.origin || '';
  const corsOrigin = allowedOrigins.length === 0
    ? '*'
    : (allowedOrigins.includes(requestOrigin) ? requestOrigin : allowedOrigins[0]);

  // CORS headers
  const headers = {
    'Access-Control-Allow-Origin': corsOrigin,
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'POST, OPTIONS'
  };

  // Handle preflight OPTIONS request
  if (req.method === 'OPTIONS') {
    res.set(headers);
    return res.status(200).json({ message: 'CORS preflight' });
  }

  // Only allow POST requests
  if (req.method !== 'POST') {
    res.set(headers);
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    // Parse request body
    const { name, email, subject, message, company, projectType } = req.body;

    // Validate required fields
    if (!name || !email || !message) {
      res.set(headers);
      return res.status(400).json({
        error: 'Missing required fields: name, email, and message are required'
      });
    }

    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      res.set(headers);
      return res.status(400).json({ error: 'Invalid email format' });
    }

    if (String(message).length > 2000) {
      res.set(headers);
      return res.status(400).json({ error: 'Message is too long (max 2000 characters)' });
    }

    // Rate limiting (simple in-memory cache, use Redis for production)
    const clientIP = req.ip || req.connection.remoteAddress;
    // Implement rate limiting logic here

    // Configure email transporter
    const transporter = nodemailer.createTransport({
      service: 'gmail', // or your preferred email service
      auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
      }
    });

    const safeName = escapeHtml(name);
    const safeEmail = escapeHtml(email);
    const safeSubject = escapeHtml(subject || 'No subject provided');
    const headerSubject = sanitizeHeader(subject || 'New Contact Form Submission');
    const safeMessage = escapeHtml(message);
    const safeCompany = company ? escapeHtml(company) : '';
    const safeProjectType = projectType ? escapeHtml(projectType) : '';

    // Email to portfolio owner
    const ownerEmailOptions = {
      from: `"Portfolio Contact Form" <${process.env.EMAIL_USER}>`,
      to: 'temitayo_charles@yahoo.com',
      subject: `Portfolio Contact: ${headerSubject}`,
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
          <h2 style="color: #66d9ef; border-bottom: 2px solid #66d9ef; padding-bottom: 10px;">
            New Portfolio Contact 📧
          </h2>

          <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;">
            <h3 style="color: #333; margin-top: 0;">Contact Details</h3>
            <p><strong>Name:</strong> ${safeName}</p>
            <p><strong>Email:</strong> <a href="mailto:${safeEmail}">${safeEmail}</a></p>
            ${safeCompany ? `<p><strong>Company:</strong> ${safeCompany}</p>` : ''}
            ${safeProjectType ? `<p><strong>Project Type:</strong> ${safeProjectType}</p>` : ''}
            <p><strong>Subject:</strong> ${safeSubject}</p>
          </div>

          <div style="background: #fff; padding: 20px; border: 1px solid #e9ecef; border-radius: 8px;">
            <h3 style="color: #333; margin-top: 0;">Message</h3>
            <p style="white-space: pre-wrap; line-height: 1.6;">${safeMessage}</p>
          </div>

          <div style="margin-top: 20px; padding: 15px; background: #e8f4fd; border-radius: 8px;">
            <p style="margin: 0; font-size: 14px; color: #666;">
              <strong>Submission Time:</strong> ${new Date().toLocaleString()}<br>
              <strong>User IP:</strong> ${clientIP}<br>
              <strong>Source:</strong> Portfolio Contact Form
            </p>
          </div>

          <div style="margin-top: 30px; text-align: center;">
            <a href="mailto:${safeEmail}?subject=Re: ${encodeURIComponent(subject || 'Your portfolio inquiry')}"
               style="background: #66d9ef; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; display: inline-block;">
              Reply to ${safeName}
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

          <p>Hi ${safeName},</p>

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
            <p style="margin: 5px 0;"><strong>Subject:</strong> ${safeSubject}</p>
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

    res.set(headers);
    return res.status(200).json({
      success: true,
      message: 'Thank you for your message! I\'ll get back to you within 24 hours.',
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Contact form error:', error);

    res.set(headers);
    return res.status(500).json({
      error: 'Failed to send message. Please try again or contact me directly at temitayo_charles@yahoo.com',
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = { handler };
