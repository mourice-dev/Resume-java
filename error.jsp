<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Error - ResumeForge</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: { sans: ['Inter', 'sans-serif'] }, colors: {
                            brand: { 300: '#a5b4fc', 400: '#818cf8', 500: '#6366f1', 600: '#4f46e5', 700: '#4338ca' }
                        }
                    }
                }
            }
        </script>
        <style>
            @keyframes gradient {
                0% {
                    background-position: 0% 50%
                }

                50% {
                    background-position: 100% 50%
                }

                100% {
                    background-position: 0% 50%
                }
            }

            .gradient-bg {
                background: linear-gradient(-45deg, #0f0a2a, #1e1b4b, #312e81, #3730a3);
                background-size: 400% 400%;
                animation: gradient 15s ease infinite;
            }

            .glass {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
            }
        </style>
    </head>

    <body class="font-sans">
        <div class="min-h-screen gradient-bg text-white flex items-center justify-center px-6">
            <div class="text-center">
                <div class="glass rounded-3xl p-12 max-w-md mx-auto">
                    <div class="w-24 h-24 bg-red-500/20 rounded-2xl flex items-center justify-center mx-auto mb-6">
                        <svg class="w-12 h-12 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                    </div>
                    <% Integer statusCode=(Integer) request.getAttribute("jakarta.servlet.error.status_code"); String
                        errorMsg=(String) request.getAttribute("jakarta.servlet.error.message"); if (statusCode==null)
                        statusCode=500; if (errorMsg==null || errorMsg.isEmpty()) errorMsg="Something went wrong" ; %>
                        <h1
                            class="text-6xl font-black mb-4 bg-gradient-to-r from-red-400 to-orange-400 bg-clip-text text-transparent">
                            <%= statusCode %>
                        </h1>
                        <h2 class="text-xl font-bold mb-2">
                            <% if (statusCode==404) { %>Page Not Found<% } else { %>Server Error<% } %>
                        </h2>
                        <p class="text-gray-400 mb-8">
                            <% if (statusCode==404) { %>
                                The page you're looking for doesn't exist or has been moved.
                                <% } else { %>
                                    An unexpected error occurred. Please try again later.
                                    <% } %>
                        </p>
                        <div class="flex gap-4 justify-center">
                            <a href="<%= request.getContextPath() %>/"
                                class="px-6 py-3 bg-gradient-to-r from-brand-500 to-brand-700 rounded-xl font-semibold hover:shadow-lg hover:shadow-brand-500/25 transition-all">
                                Go Home
                            </a>
                            <a href="<%= request.getContextPath() %>/dashboard"
                                class="px-6 py-3 glass rounded-xl font-semibold hover:bg-white/10 transition-all">
                                Dashboard
                            </a>
                        </div>
                </div>
            </div>
        </div>
    </body>

    </html>