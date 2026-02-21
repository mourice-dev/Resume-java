<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List, com.resumebuilder.model.Resume" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Dashboard - ResumeForge</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
            <script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
            <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                rel="stylesheet">
            <script>
                tailwind.config = {
                    theme: {
                        extend: {
                            fontFamily: { sans: ['Inter', 'sans-serif'] },
                            colors: {
                                brand: { 50: '#eef2ff', 100: '#e0e7ff', 200: '#c7d2fe', 300: '#a5b4fc', 400: '#818cf8', 500: '#6366f1', 600: '#4f46e5', 700: '#4338ca', 800: '#3730a3', 900: '#312e81' },
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

                .glass-card {
                    background: rgba(255, 255, 255, 0.03);
                    backdrop-filter: blur(10px);
                    border: 1px solid rgba(255, 255, 255, 0.05);
                }
            </style>
        </head>

        <body class="font-sans">
            <div id="root"></div>
            <script type="text/babel">
                const { useState } = React;

                function Dashboard() {
                    const contextPath = "<%= request.getContextPath() %>";
                    const userName = "<%= session.getAttribute("userName") %>";
                    const serverError = "<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>";
            
            <%
                        List < Resume > resumes = (List < Resume >) request.getAttribute("resumes");
                StringBuilder resumeJson = new StringBuilder("[");
                    if (resumes != null) {
                        for (int i = 0; i < resumes.size(); i++) {
                        Resume r = resumes.get(i);
                            if (i > 0) resumeJson.append(",");
                            resumeJson.append("{\"id\":").append(r.getId())
                                .append(",\"title\":\"").append(r.getTitle() != null ? r.getTitle().replace("\"", "\\\"") : "")
                                .append("\",\"fullName\":\"").append(r.getFullName() != null ? r.getFullName().replace("\"", "\\\"") : "")
                                .append("\",\"email\":\"").append(r.getEmail() != null ? r.getEmail().replace("\"", "\\\"") : "")
                                .append("\",\"template\":\"").append(r.getTemplate() != null ? r.getTemplate().replace("\"", "\\\"") : "modern")
                                .append("\",\"updatedAt\":\"").append(r.getUpdatedAt() != null ? r.getUpdatedAt() : "")
                                .append("\"}");
                        }
                    }
                    resumeJson.append("]");
                
                String sText = request.getAttribute("search") != null ? (String)request.getAttribute("search") : "";
                String sDate = request.getAttribute("dateFilter") != null ? (String)request.getAttribute("dateFilter") : "";
                String sFrom = request.getAttribute("timeFrom") != null ? (String)request.getAttribute("timeFrom") : "";
                String sTo = request.getAttribute("timeTo") != null ? (String)request.getAttribute("timeTo") : "";
            %>

            const resumes = <%= resumeJson.toString() %>;
                    const [showFilters, setShowFilters] = useState(<%= request.getAttribute("searchActive") != null %>);

                    const handleDelete = (id) => {
                        if (confirm("Are you sure you want to delete this resume? This action cannot be undone.")) {
                            window.location.href = contextPath + "/resume?action=delete&id=" + id;
                        }
                    };

                    return (
                        <div className="min-h-screen gradient-bg text-white">
                            {/* Navigation */}
                            <nav className="glass sticky top-0 z-50">
                                <div className="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
                                    <a href={contextPath + "/"} className="flex items-center gap-3">
                                        <div className="w-10 h-10 bg-gradient-to-br from-brand-400 to-brand-600 rounded-xl flex items-center justify-center font-bold text-lg">R</div>
                                        <span className="text-xl font-bold bg-gradient-to-r from-brand-300 to-brand-500 bg-clip-text text-transparent">ResumeForge</span>
                                    </a>
                                    <div className="flex items-center gap-4">
                                        <span className="text-sm text-gray-400">Welcome, <span className="text-brand-300 font-medium">{userName}</span></span>
                                        <a href={contextPath + "/logout"} className="px-4 py-2 text-sm bg-red-500/20 text-red-300 rounded-xl hover:bg-red-500/30 transition">Logout</a>
                                    </div>
                                </div>
                            </nav>

                            <div className="max-w-7xl mx-auto px-6 py-10">
                                {/* Header */}
                                <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8">
                                    <div>
                                        <h1 className="text-3xl font-bold mb-1">My Resumes</h1>
                                        <p className="text-gray-400">{resumes.length} resume{resumes.length !== 1 ? 's' : ''} found</p>
                                    </div>
                                    <div className="flex gap-3 w-full sm:w-auto">
                                        <button onClick={() => setShowFilters(!showFilters)} className={`flex-1 sm:flex-none px-4 py-3 rounded-xl border transition-all ${showFilters ? 'bg-brand-500 border-brand-500' : 'bg-white/5 border-white/10 hover:bg-white/10'}`}>
                                            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z" /></svg>
                                        </button>
                                        <a href={contextPath + "/resume-form"} className="flex-[2] sm:flex-none inline-flex items-center justify-center gap-2 px-6 py-3 bg-gradient-to-r from-brand-500 to-brand-700 rounded-xl font-semibold hover:shadow-lg transition-all">
                                            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" /></svg>
                                            Create New
                                        </a>
                                    </div>
                                </div>

                                {/* Search & Filter Panel */}
                                <div className={`overflow-hidden transition-all duration-300 ${showFilters ? 'max-h-96 mb-8 opacity-100' : 'max-h-0 opacity-0'}`}>
                                    <div className="glass rounded-2xl p-6">
                                        <form action={contextPath + "/dashboard"} method="GET" className="grid grid-cols-1 md:grid-cols-4 gap-4 items-end">
                                            <div className="md:col-span-1">
                                                <label className="block text-xs font-medium text-gray-400 mb-2 uppercase tracking-wider">Search Text</label>
                                                <input type="text" name="search" defaultValue="<%= sText %>" placeholder="Title, Name, Email..." className="w-full px-4 py-2.5 bg-white/5 border border-white/10 rounded-xl text-white focus:outline-none focus:border-brand-500 transition" />
                                            </div>
                                            <div>
                                                <label className="block text-xs font-medium text-gray-400 mb-2 uppercase tracking-wider">Date</label>
                                                <input type="date" name="dateFilter" defaultValue="<%= sDate %>" className="w-full px-4 py-2.5 bg-white/5 border border-white/10 rounded-xl text-white focus:outline-none focus:border-brand-500 transition [color-scheme:dark]" />
                                            </div>
                                            <div>
                                                <label className="block text-xs font-medium text-gray-400 mb-2 uppercase tracking-wider">Time Range</label>
                                                <div className="flex gap-2">
                                                    <input type="time" name="timeFrom" defaultValue="<%= sFrom %>" className="flex-1 px-3 py-2.5 bg-white/5 border border-white/10 rounded-xl text-white text-sm focus:outline-none focus:border-brand-500 transition [color-scheme:dark]" />
                                                    <input type="time" name="timeTo" defaultValue="<%= sTo %>" className="flex-1 px-3 py-2.5 bg-white/5 border border-white/10 rounded-xl text-white text-sm focus:outline-none focus:border-brand-500 transition [color-scheme:dark]" />
                                                </div>
                                            </div>
                                            <div className="flex gap-2">
                                                <button type="submit" className="flex-1 px-6 py-2.5 bg-brand-500 text-white font-semibold rounded-xl hover:bg-brand-600 transition shadow-lg">Filter</button>
                                                <a href={contextPath + "/dashboard"} className="px-4 py-2.5 bg-white/5 text-gray-400 rounded-xl hover:bg-white/10 flex items-center justify-center">
                                                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" /></svg>
                                                </a>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                {serverError && (
                                    <div className="mb-6 p-4 bg-red-500/20 border border-red-500/30 rounded-xl text-red-300">{serverError}</div>
                                )}

                                {resumes.length === 0 ? (
                                    <div className="glass rounded-2xl p-16 text-center">
                                        <div className="w-20 h-20 bg-brand-500/20 rounded-2xl flex items-center justify-center mx-auto mb-6">
                                            <svg className="w-10 h-10 text-brand-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" /></svg>
                                        </div>
                                        <h3 className="text-xl font-bold mb-2">No resumes found</h3>
                                        <p className="text-gray-400 mb-6">Try adjusting your search criteria or create a new resume.</p>
                                        <a href={contextPath + "/resume-form"} className="inline-flex items-center gap-2 px-6 py-3 bg-brand-500 rounded-xl font-semibold hover:bg-brand-600 transition">Create New Resume</a>
                                    </div>
                                ) : (
                                    <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                                        {resumes.map((resume) => (
                                            <div key={resume.id} className="glass-card rounded-2xl p-6 hover:bg-white/5 transition-all duration-300 transform hover:-translate-y-1 group">
                                                <div className="flex items-start justify-between mb-4">
                                                    <div className="w-12 h-12 bg-gradient-to-br from-brand-500 to-purple-600 rounded-xl flex items-center justify-center shadow-lg">
                                                        <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" /></svg>
                                                    </div>
                                                    <span className="text-[10px] bg-brand-500/20 text-brand-300 px-3 py-1 rounded-full uppercase tracking-widest font-bold border border-brand-500/30">{resume.template}</span>
                                                </div>
                                                <h3 className="text-lg font-bold mb-1 truncate">{resume.title}</h3>
                                                <p className="text-sm text-gray-400 mb-1 truncate">{resume.fullName}</p>
                                                <p className="text-[10px] text-gray-500 mb-6 uppercase tracking-wider">Updated: {resume.updatedAt}</p>
                                                <div className="flex gap-2">
                                                    <a href={contextPath + "/resume-preview?id=" + resume.id} className="flex-1 text-center text-xs py-2 bg-brand-500/10 text-brand-300 rounded-lg hover:bg-brand-500/20 border border-brand-500/20 transition">Preview</a>
                                                    <a href={contextPath + "/resume-form?id=" + resume.id} className="flex-1 text-center text-xs py-2 bg-emerald-500/10 text-emerald-300 rounded-lg hover:bg-emerald-500/20 border border-emerald-500/20 transition">Edit</a>
                                                    <button onClick={() => handleDelete(resume.id)} className="px-3 py-2 bg-red-500/10 text-red-300 rounded-lg hover:bg-red-500/20 border border-red-500/20 transition">
                                                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" /></svg>
                                                    </button>
                                                </div>
                                            </div>
                                        ))}
                                    </div>
                                )}
                            </div>
                        </div>
                    );
                }

                const root = ReactDOM.createRoot(document.getElementById('root'));
                root.render(<Dashboard />);
            </script>
        </body>

        </html>