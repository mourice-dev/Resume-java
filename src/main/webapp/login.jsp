<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String ctx=request.getContextPath(); String error=(String) request.getAttribute("error"); String
        successParam=request.getParameter("success"); String success=(successParam !=null)
        ? "Registration successful! Please login." : "" ; String emailVal=(String) request.getAttribute("email"); if
        (emailVal==null) emailVal="" ; if (error==null) error="" ; %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Login - ResumeForge</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
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
                    background: #fafafa;
                    color: #18181b;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    min-height: 100vh;
                    -webkit-font-smoothing: antialiased;
                }

                .container {
                    width: 100%;
                    max-width: 420px;
                    padding: 24px;
                }

                .header {
                    text-align: center;
                    margin-bottom: 32px;
                }

                .logo {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    text-decoration: none;
                    margin-bottom: 32px;
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
                    font-size: 20px;
                    font-weight: 700;
                    letter-spacing: -0.5px;
                    color: #000;
                }

                .header h1 {
                    font-size: 24px;
                    font-weight: 700;
                    letter-spacing: -0.5px;
                    margin-bottom: 8px;
                }

                .header p {
                    color: #71717a;
                    font-size: 14px;
                }

                .card {
                    background: #fff;
                    border-radius: 14px;
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
                    border: 1px solid #e4e4e7;
                    padding: 32px;
                }

                .alert {
                    margin-bottom: 24px;
                    padding: 12px 16px;
                    border-radius: 10px;
                    font-size: 14px;
                    font-weight: 500;
                }

                .alert-error {
                    background: #fef2f2;
                    border: 1px solid #fecaca;
                    color: #dc2626;
                }

                .alert-success {
                    background: #ecfdf5;
                    border: 1px solid #a7f3d0;
                    color: #059669;
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-group label {
                    display: block;
                    font-size: 14px;
                    font-weight: 500;
                    color: #3f3f46;
                    margin-bottom: 6px;
                }

                .form-group input {
                    width: 100%;
                    padding: 10px 14px;
                    background: #fff;
                    border: 1px solid #d4d4d8;
                    border-radius: 10px;
                    font-size: 14px;
                    font-family: 'Inter', sans-serif;
                    color: #18181b;
                    transition: all 0.2s;
                    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
                }

                .form-group input::placeholder {
                    color: #a1a1aa;
                }

                .form-group input:focus {
                    outline: none;
                    border-color: transparent;
                    box-shadow: 0 0 0 2px #000;
                }

                .btn-submit {
                    width: 100%;
                    padding: 12px;
                    background: #000;
                    color: #fff;
                    border: none;
                    border-radius: 10px;
                    font-size: 15px;
                    font-weight: 600;
                    cursor: pointer;
                    font-family: 'Inter', sans-serif;
                    transition: all 0.2s;
                    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
                }

                .btn-submit:hover {
                    background: #27272a;
                }

                .btn-submit:disabled {
                    opacity: 0.5;
                    cursor: not-allowed;
                }

                .signup-link {
                    text-align: center;
                    color: #71717a;
                    font-size: 14px;
                    margin-top: 24px;
                }

                .signup-link a {
                    color: #000;
                    font-weight: 600;
                    text-decoration: none;
                }

                .signup-link a:hover {
                    text-decoration: underline;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="header">
                    <a href="<%= ctx %>/" class="logo">
                        <div class="logo-icon">R</div>
                        <span class="logo-text">ResumeForge</span>
                    </a>
                    <h1>Welcome back</h1>
                    <p>Enter your credentials to access your account</p>
                </div>
                <div class="card">
                    <% if (!error.isEmpty()) { %>
                        <div class="alert alert-error">
                            <%= error %>
                        </div>
                        <% } %>
                            <% if (!success.isEmpty()) { %>
                                <div class="alert alert-success">
                                    <%= success %>
                                </div>
                                <% } %>
                                    <form method="POST" action="<%= ctx %>/login">
                                        <div class="form-group">
                                            <label for="email">Email</label>
                                            <input type="email" id="email" name="email" value="<%= emailVal %>" required
                                                placeholder="name@example.com">
                                        </div>
                                        <div class="form-group">
                                            <label for="password">Password</label>
                                            <input type="password" id="password" name="password" required
                                                placeholder="••••••••">
                                        </div>
                                        <button type="submit" class="btn-submit">Sign In</button>
                                    </form>
                                    <p class="signup-link">No account? <a href="<%= ctx %>/register">Create one</a></p>
                </div>
            </div>
        </body>

        </html>