<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String ctx=request.getContextPath(); %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>ResumeForge - Professional Resume Builder</title>
            <meta name="description" content="Build stunning, professional resumes in minutes with ResumeForge.">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
                rel="stylesheet">
            <style>
                *,
                *::before,
                *::after {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    color: #18181b;
                    background: #ffffff;
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                    -webkit-font-smoothing: antialiased;
                }

                /* Navbar */
                .navbar {
                    position: sticky;
                    top: 0;
                    z-index: 50;
                    background: rgba(255, 255, 255, 0.85);
                    backdrop-filter: blur(12px);
                    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                }

                .navbar-inner {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 16px 24px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .logo {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    text-decoration: none;
                }

                .logo-icon {
                    width: 34px;
                    height: 34px;
                    background: #000;
                    color: #fff;
                    border-radius: 8px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: 700;
                    font-size: 14px;
                }

                .logo-text {
                    font-size: 18px;
                    font-weight: 700;
                    letter-spacing: -0.5px;
                    color: #000;
                }

                .nav-links {
                    display: flex;
                    gap: 12px;
                    align-items: center;
                }

                .nav-links a {
                    text-decoration: none;
                }

                .btn-login {
                    padding: 8px 18px;
                    font-size: 14px;
                    font-weight: 500;
                    color: #52525b;
                    background: transparent;
                    border: none;
                    border-radius: 8px;
                    cursor: pointer;
                    transition: color 0.2s;
                }

                .btn-login:hover {
                    color: #000;
                }

                .btn-signup {
                    padding: 8px 20px;
                    font-size: 14px;
                    font-weight: 600;
                    color: #fff;
                    background: #000;
                    border: none;
                    border-radius: 8px;
                    cursor: pointer;
                    transition: all 0.2s;
                    text-decoration: none;
                }

                .btn-signup:hover {
                    background: #27272a;
                    transform: translateY(-1px);
                }

                /* Hero */
                .hero {
                    padding: 100px 24px 80px;
                    text-align: center;
                    border-bottom: 1px solid #f4f4f5;
                    background-color: #ffffff;
                    background-image: radial-gradient(#e4e4e7 1px, transparent 1px);
                    background-size: 32px 32px;
                }

                .hero-inner {
                    max-width: 800px;
                    margin: 0 auto;
                }

                .hero-badge {
                    display: inline-block;
                    margin-bottom: 24px;
                    padding: 6px 14px;
                    background: #f4f4f5;
                    border: 1px solid #e4e4e7;
                    border-radius: 50px;
                    font-size: 11px;
                    font-weight: 600;
                    color: #52525b;
                    text-transform: uppercase;
                    letter-spacing: 0.08em;
                }

                .hero h1 {
                    font-size: clamp(42px, 7vw, 72px);
                    font-weight: 900;
                    letter-spacing: -2px;
                    line-height: 1.1;
                    margin-bottom: 28px;
                    color: #000;
                }

                .hero h1 span {
                    color: #a1a1aa;
                }

                .hero p {
                    font-size: 20px;
                    color: #71717a;
                    margin-bottom: 40px;
                    max-width: 600px;
                    margin-left: auto;
                    margin-right: auto;
                    font-weight: 300;
                    line-height: 1.7;
                }

                .hero-buttons {
                    display: flex;
                    gap: 16px;
                    justify-content: center;
                    flex-wrap: wrap;
                }

                .btn-primary {
                    padding: 16px 32px;
                    font-size: 18px;
                    font-weight: 600;
                    color: #fff;
                    background: #000;
                    border: none;
                    border-radius: 14px;
                    cursor: pointer;
                    text-decoration: none;
                    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
                    transition: all 0.2s;
                }

                .btn-primary:hover {
                    background: #27272a;
                    transform: translateY(-2px);
                    box-shadow: 0 12px 32px rgba(0, 0, 0, 0.15);
                }

                .btn-secondary {
                    padding: 16px 32px;
                    font-size: 18px;
                    font-weight: 600;
                    color: #000;
                    background: #fff;
                    border: 1px solid #e4e4e7;
                    border-radius: 14px;
                    cursor: pointer;
                    text-decoration: none;
                    transition: all 0.2s;
                }

                .btn-secondary:hover {
                    border-color: #000;
                }

                /* Features */
                .features {
                    padding: 96px 24px;
                    background: #fff;
                }

                .features-grid {
                    max-width: 1200px;
                    margin: 0 auto;
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                    gap: 48px;
                }

                .feature {
                    padding: 28px;
                    border-radius: 16px;
                    border: 1px solid transparent;
                    transition: all 0.3s;
                }

                .feature:hover {
                    border-color: #f4f4f5;
                    background: #fafafa;
                }

                .feature-icon {
                    width: 48px;
                    height: 48px;
                    background: #f4f4f5;
                    border-radius: 12px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin-bottom: 20px;
                    transition: all 0.3s;
                }

                .feature:hover .feature-icon {
                    background: #000;
                    color: #fff;
                }

                .feature-icon svg {
                    width: 24px;
                    height: 24px;
                }

                .feature h3 {
                    font-size: 20px;
                    font-weight: 700;
                    margin-bottom: 10px;
                    color: #000;
                }

                .feature p {
                    color: #71717a;
                    line-height: 1.6;
                }

                /* Footer */
                footer {
                    margin-top: auto;
                    border-top: 1px solid #f4f4f5;
                    padding: 48px 24px;
                    background: #fafafa;
                }

                .footer-inner {
                    max-width: 1200px;
                    margin: 0 auto;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    color: #a1a1aa;
                    font-size: 14px;
                }

                .footer-links {
                    display: flex;
                    gap: 24px;
                }

                .footer-links a {
                    color: #a1a1aa;
                    text-decoration: none;
                    transition: color 0.2s;
                }

                .footer-links a:hover {
                    color: #000;
                }

                @media (max-width: 640px) {
                    .hero {
                        padding: 64px 16px 48px;
                    }

                    .hero-buttons {
                        flex-direction: column;
                        align-items: center;
                    }

                    .footer-inner {
                        flex-direction: column;
                        gap: 16px;
                        text-align: center;
                    }
                }
            </style>
        </head>

        <body>

            <!-- Navbar -->
            <nav class="navbar">
                <div class="navbar-inner">
                    <a href="<%= ctx %>/" class="logo">
                        <div class="logo-icon">R</div>
                        <span class="logo-text">ResumeForge</span>
                    </a>
                    <div class="nav-links">
                        <a href="<%= ctx %>/login" class="btn-login">Log In</a>
                        <a href="<%= ctx %>/register" class="btn-signup">Sign Up</a>
                    </div>
                </div>
            </nav>

            <!-- Hero -->
            <section class="hero">
                <div class="hero-inner">
                    <span class="hero-badge">v1.0 Released</span>
                    <h1>Build your legacy<br><span>on one page.</span></h1>
                    <p>The minimalist resume builder for professionals. Focus on your content with our clean,
                        distraction-free environment.</p>
                    <div class="hero-buttons">
                        <a href="<%= ctx %>/register" class="btn-primary">Start Building</a>
                        <a href="<%= ctx %>/login" class="btn-secondary">Sign In</a>
                    </div>
                </div>
            </section>

            <!-- Features -->
            <section class="features">
                <div class="features-grid">
                    <div class="feature">
                        <div class="feature-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                    d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                            </svg>
                        </div>
                        <h3>Smart Templates</h3>
                        <p>Minimalist, executive-grade templates designed to make your resume stand out.</p>
                    </div>
                    <div class="feature">
                        <div class="feature-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                            </svg>
                        </div>
                        <h3>Live Edits</h3>
                        <p>Real-time updates as you type. See your changes reflected instantly.</p>
                    </div>
                    <div class="feature">
                        <div class="feature-icon">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                        </div>
                        <h3>Instant Search</h3>
                        <p>Retrieve documents quickly by date, content, or keywords.</p>
                    </div>
                </div>
            </section>

            <!-- Footer -->
            <footer>
                <div class="footer-inner">
                    <div>&copy; 2026 ResumeForge Inc.</div>
                    <div class="footer-links">
                        <a href="#">Privacy</a>
                        <a href="#">Terms</a>
                    </div>
                </div>
            </footer>

        </body>

        </html>