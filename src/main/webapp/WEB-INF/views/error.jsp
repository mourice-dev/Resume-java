<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Error - ResumeForge</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: { sans: ['Inter', 'sans-serif'] },
                        colors: {
                            black: '#09090b',
                            zinc: { 50: '#fafafa', 100: '#f4f4f5', 500: '#71717a', 600: '#52525b' }
                        }
                    }
                }
            }
        </script>
    </head>

    <body class="font-sans min-h-screen bg-zinc-50 text-zinc-900 flex items-center justify-center p-6">
        <% Integer statusCode=(Integer) request.getAttribute("jakarta.servlet.error.status_code"); if (statusCode==null)
            statusCode=500; %>
            <div class="text-center max-w-md w-full">
                <div class="w-16 h-16 bg-zinc-100 rounded-2xl flex items-center justify-center mx-auto mb-6">
                    <span class="text-2xl font-bold font-mono">
                        <%= statusCode %>
                    </span>
                </div>

                <h1 class="text-2xl font-bold mb-3 text-black">
                    <%= statusCode==404 ? "Page Not Found" : "Server Error" %>
                </h1>

                <p class="text-zinc-600 mb-8 leading-relaxed">
                    <%= statusCode==404
                        ? "Sorry, we couldn't find the page you're looking for. It might have been moved or deleted."
                        : "Something went wrong on our end. Please try again later or contact support." %>
                </p>

                <div class="flex gap-3 justify-center">
                    <a href="javascript:history.back()"
                        class="px-5 py-2.5 bg-white border border-zinc-200 text-zinc-700 font-medium rounded-xl hover:bg-zinc-50 hover:border-zinc-300 transition shadow-sm">
                        Go Back
                    </a>
                    <a href="<%= request.getContextPath() %>/"
                        class="px-5 py-2.5 bg-black text-white font-medium rounded-xl hover:bg-zinc-800 transition shadow-lg shadow-black/10">
                        Back to Home
                    </a>
                </div>
            </div>
    </body>

    </html>