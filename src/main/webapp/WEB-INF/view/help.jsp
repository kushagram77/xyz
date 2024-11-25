<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html data-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Help & Support - Online Home Decor</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Root Theme Variables */
            :root[data-theme="light"] {
                --primary: #7C3AED;
                --primary-dark: #6D28D9;
                --bg-primary: #F8F7FF;
                --bg-secondary: #FFFFFF;
                --text-primary: #2D3748;
                --text-secondary: #4A5568;
                --accent: #F59E0B;
                --success: #10B981;
                --error: #EF4444;
                --border: #E2E8F0;
                --card-bg: rgba(255, 255, 255, 0.95);
                --header-bg: linear-gradient(to right, #7C3AED, #6D28D9);
                --input-bg: #FFFFFF;
                --shadow: rgba(0, 0, 0, 0.1);
            }

            :root[data-theme="dark"] {
                --primary: #9F7AEA;
                --primary-dark: #805AD5;
                --bg-primary: #1A202C;
                --bg-secondary: #2D3748;
                --text-primary: #F7FAFC;
                --text-secondary: #E2E8F0;
                --accent: #F6AD55;
                --success: #68D391;
                --error: #FC8181;
                --border: #4A5568;
                --card-bg: rgba(45, 55, 72, 0.95);
                --header-bg: linear-gradient(to right, #6B46C1, #553C9A);
                --input-bg: #2D3748;
                --shadow: rgba(0, 0, 0, 0.3);
            }

            /* Base Styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Inter', sans-serif;
            }

            body {
                background: var(--bg-primary);
                color: var(--text-primary);
                min-height: 100vh;
            }

            /* Header Styles */
            .header {
                background: var(--header-bg);
                padding: 1rem 2rem;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
                box-shadow: 0 2px 10px var(--shadow);
            }

            .header-content {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                color: white;
                font-family: 'Poppins', sans-serif;
                font-size: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                text-decoration: none;
            }

            .nav-buttons {
                display: flex;
                gap: 1rem;
                align-items: center;
            }

            /* Button Styles */
            .button {
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .login-btn {
                background: white;
                color: var(--primary);
            }

            .help-btn {
                background: var(--bg-secondary);
                color: var(--primary);
                border: 1px solid var(--primary);
            }

            .help-btn:hover {
                background: var(--primary);
                color: white;
                transform: translateY(-2px);
            }

            .register-btn {
                background: var(--accent);
                color: white;
            }

            /* Theme Toggle */
            .theme-toggle {
                width: 45px;
                height: 45px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                background: var(--card-bg);
                border: 1px solid var(--border);
                border-radius: 50%;
                box-shadow: 0 2px 8px var(--shadow);
                color: var(--text-primary);
                transition: all 0.3s ease;
            }

            /* Help Page Specific Styles */
            .help-container {
                max-width: 800px;
                margin: 100px auto 40px;
                padding: 2rem;
            }

            .section-title {
                font-family: 'Poppins', sans-serif;
                color: var(--primary);
                margin-bottom: 1.5rem;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid var(--primary);
            }

            .feedback-form {
                background: var(--card-bg);
                padding: 2rem;
                border-radius: 12px;
                box-shadow: 0 4px 12px var(--shadow);
                margin-bottom: 3rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                color: var(--text-primary);
                font-weight: 500;
                margin-bottom: 0.5rem;
            }

            .form-control {
                background: var(--input-bg);
                border: 1px solid var(--border);
                color: var(--text-primary);
                padding: 0.75rem;
                border-radius: 8px;
            }

            .form-control:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 2px rgba(124, 58, 237, 0.2);
            }

            .submit-btn {
                background: var(--primary);
                color: white;
                border: none;
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                transition: all 0.3s ease;
            }

            .submit-btn:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
            }

            /* FAQ Section Styles */
            .faq-section {
                background: var(--card-bg);
                padding: 2rem;
                border-radius: 12px;
                box-shadow: 0 4px 12px var(--shadow);
            }

            .accordion-item {
                background: var(--bg-secondary);
                border: 1px solid var(--border);
                margin-bottom: 1rem;
                border-radius: 8px;
                overflow: hidden;
            }

            .accordion-button {
                background: var(--bg-secondary);
                color: var(--text-primary);
                font-weight: 500;
                padding: 1rem 1.5rem;
            }

            .accordion-button:not(.collapsed) {
                background: var(--primary);
                color: white;
            }

            .accordion-body {
                background: var(--bg-secondary);
                color: var(--text-secondary);
                padding: 1.5rem;
            }

            /* Footer Styles */
            .footer {
                background: var(--bg-secondary);
                padding: 3rem 0 1rem;
                margin-top: 2rem;
                border-top: 1px solid var(--border);
            }

            .footer-content {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 2rem;
            }

            .footer-title {
                font-family: 'Poppins', sans-serif;
                font-size: 2rem;
                margin-bottom: 1.5rem;
                font-weight: 600;
                color: var(--text-primary);
            }

            .social-links {
                display: flex;
                gap: 1.5rem;
                justify-content: center;
                margin-bottom: 1.5rem;
            }

            .social-link {
                color: var(--text-primary);
                text-decoration: none;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 45px;
                height: 45px;
                border-radius: 50%;
                background: var(--bg-primary);
                border: 1px solid var(--border);
            }

            .social-link:hover {
                color: var(--primary);
                transform: translateY(-3px);
            }

            .footer-bottom {
                padding-top: 1rem;
                border-top: 1px solid var(--border);
                color: var(--text-secondary);
                font-size: 0.875rem;
                text-align: center;
            }

            /* Alert Styles */
            .alert {
                border-radius: 8px;
                margin-bottom: 1rem;
                padding: 1rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .alert-success {
                background: var(--success);
                color: white;
            }

            /* Responsive Styles */
            @media (max-width: 640px) {
                .help-container {
                    padding: 1rem;
                    margin-top: 80px;
                }

                .header {
                    padding: 1rem;
                }

                .nav-buttons {
                    gap: 0.5rem;
                }

                .button {
                    padding: 0.5rem 1rem;
                }

                .theme-toggle {
                    width: 35px;
                    height: 35px;
                }

                .footer {
                    padding: 2rem 0 1rem;
                }

                .social-links {
                    gap: 1rem;
                }

                .social-link {
                    width: 40px;
                    height: 40px;
                }
            }
        </style>
    </head>
    <body>
        <header class="header">
            <div class="header-content">
                <a href="<s:url value="/"/>" class="logo">
                    <span class="material-icons">home</span>
                    Online Home Decor
                </a>
                <nav class="nav-buttons">
                    <a href="<s:url value="/login"/>" class="button login-btn">
                        <span class="material-icons">login</span>
                        Login
                    </a>
                    <a href="<s:url value="/reg_form"/>" class="button register-btn">
                        <span class="material-icons">person_add</span>
                        Register
                    </a>
                    <a href="<s:url value="/"/>" class="button help-btn">
                        <span class="material-icons">home</span>
                        Home
                    </a>
                    <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
                        <span class="material-icons">dark_mode</span>
                    </button>
                </nav>
            </div>
        </header>

        <div class="help-container">
            <h1 class="section-title">Help & Support</h1>

            <!-- Success Message -->
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <span class="material-icons">check_circle</span>
                    ${message}
                </div>
            </c:if>

            <!-- Feedback Form Section -->
            <div class="feedback-form">
                <h2 class="mb-4">Send us your feedback</h2>
                <form action="<s:url value="/submit-feedback"/>" method="POST">
                    <div class="form-group">
                        <label class="form-label">Name</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Subject</label>
                        <select class="form-control" name="subject" required>
                            <option value="">Select a subject</option>
                            <option value="general">General Inquiry</option>
                            <option value="product">Product Related</option>
                            <option value="order">Order Related</option>
                            <option value="technical">Technical Issue</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Message</label>
                        <textarea class="form-control" name="message" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="submit-btn">
                        <span class="material-icons">send</span>
                        Submit Feedback
                    </button>
                </form>
            </div>

            <!-- FAQ Section -->
            <div class="faq-section">
                <h2 class="mb-4">Frequently Asked Questions</h2>
                <div class="accordion" id="faqAccordion">
                    <!-- FAQ Item 1 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                How do I place an order?
                            </button>
                        </h2>
                        <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                                                    <div class="accordion-body">
                                                        To place an order, first login to your account. Browse our products, add items to your cart, and proceed to checkout. Follow the simple steps to provide shipping information and complete your payment.
                                                    </div>
                                                </div>
                        </div>

                     <div class="accordion-item">
                                            <h2 class="accordion-header">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                                    What payment methods do you accept?
                                                </button>
                                            </h2>
                                            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                                <div class="accordion-body">
                                                    We accept all major credit cards, debit cards, UPI, and net banking. All payments are processed securely through our payment gateway.
                                                </div>
                                            </div>
                                        </div>

                                        <!-- FAQ Item 3 -->
                                        <div class="accordion-item">
                                            <h2 class="accordion-header">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                                                    What is your return policy?
                                                </button>
                                            </h2>
                                            <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                                <div class="accordion-body">
                                                    We offer a 30-day return policy for most items. Products must be in their original condition and packaging. Please contact our support team to initiate a return.
                                                </div>
                                            </div>
                                        </div>

                                        <!-- FAQ Item 4 -->
                                        <div class="accordion-item">
                                            <h2 class="accordion-header">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">
                                                    How can I track my order?
                                                </button>
                                            </h2>
                                            <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                                <div class="accordion-body">
                                                    Once your order is shipped, you will receive a tracking number via email. You can use this number to track your order through our website or the courier's website.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

        <script>
                     function toggleTheme() {
                                    const html = document.documentElement;
                                    const theme = html.getAttribute('data-theme');
                                    const newTheme = theme === 'light' ? 'dark' : 'light';
                                    html.setAttribute('data-theme', newTheme);

                                    const icon = document.querySelector('.theme-toggle .material-icons');
                                    icon.textContent = newTheme === 'light' ? 'dark_mode' : 'light_mode';

                                    localStorage.setItem('theme', newTheme);
                                }

                                document.addEventListener('DOMContentLoaded', () => {
                                    const savedTheme = localStorage.getItem('theme') || 'light';
                                    document.documentElement.setAttribute('data-theme', savedTheme);
                                    const icon = document.querySelector('.theme-toggle .material-icons');
                                    icon.textContent = savedTheme === 'light' ? 'dark_mode' : 'light_mode';
                                });



        </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
            </body>
        </html>