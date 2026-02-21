<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.resumebuilder.model.Resume" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Admin Dashboard - ResumeForge</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <script src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
                <script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
                <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Outfit:wght@400;600;800&display=swap"
                    rel="stylesheet">
                <script>
                    tailwind.config = {
                        theme: {
                            extend: {
                                fontFamily: {
                                    sans: ['Inter', 'sans-serif'],
                                    display: ['Outfit', 'sans-serif']
                                },
                                colors: {
                                    brand: { 50: '#eef2ff', 100: '#e0e7ff', 200: '#c7d2fe', 300: '#a5b4fc', 400: '#818cf8', 500: '#6366f1', 600: '#4f46e5', 700: '#4338ca', 800: '#3730a3', 900: '#312e81' },
                                    dark: { 800: '#1e1b4b', 900: '#0f0a2a' }
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
                        background: linear-gradient(-45deg, #0f0a2a, #110c36, #1e1b4b, #312e81);
                        background-size: 400% 400%;
                        animation: gradient 15s ease infinite;
                    }

                    .glass {
                        background: rgba(255, 255, 255, 0.03);
                        backdrop-filter: blur(20px);
                        border: 1px solid rgba(255, 255, 255, 0.08);
                    }

                    .glass-card {
                        background: rgba(255, 255, 255, 0.05);
                        backdrop-filter: blur(10px);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                    }
                </style>
            </head>

            <body class="font-sans">
                <div id="root"></div>

                <script type="text/babel">
                    const { useState } = React;

                    function AdminDashboard() {
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
                                resumeJson.append("{");
                                resumeJson.append("\"id\":").append(r.getId());
                                resumeJson.append(",\"userId\":").append(r.getUserId());
                                resumeJson.append(",\"title\":\"").append(r.getTitle() != null ? r.getTitle().replace("\"", "\\\"") : "").append("\"");
                                resumeJson.append(",\"fullName\":\"").append(r.getFullName() != null ? r.getFullName().replace("\"", "\\\"") : "").append("\"");
                                resumeJson.append(",\"status\":\"").append(r.getStatus() != null ? r.getStatus() : "DRAFT").append("\"");
                                resumeJson.append(",\"updatedAt\":\"").append(r.getUpdatedAt() != null ? r.getUpdatedAt() : "").append("\"");
                                resumeJson.append("}");
                            }
                        }
                        resumeJson.append("]");
            %>

            const resumesData = <%= resumeJson.toString() %>;
                        const [searchTerm, setSearchTerm] = useState("<%= request.getAttribute("search") != null ? request.getAttribute("search") : "" %>");

                        const handleDelete = (id) => {
                            if (confirm("ADMIN WARNING: Are you sure you want to delete this user's resume? This action is permanent.")) {
                                window.location.href = contextPath + "/resume?action=delete&id=" + id;
                            }
                        };

                        return (
                            <div className="min-h-screen gradient-bg text-gray-100 flex flex-col">
                                {/* Navigation */}
                                <nav className="glass sticky top-0 z-50">
                                    <div className="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
                                        <div className="flex items-center gap-8">
                                            <a href={contextPath + "/"} className="flex items-center gap-3">
                                                <div className="w-10 h-10 bg-gradient-to-br from-red-500 to-brand-600 rounded-xl flex items-center justify-center font-bold text-lg shadow-lg shadow-red-500/20">A</div>
                                                <span className="text-xl font-display font-black tracking-tight text-white">ADMIN <span className="font-normal text-brand-400">PORTAL</span></span>
                                            </a>
                                            <div className="hidden md:flex items-center gap-4 border-l border-white/10 pl-8">
                                                <a href={contextPath + "/dashboard"} className="text-sm font-medium text-gray-400 hover:text-white transition">User View</a>
                                                <span className="text-sm font-bold text-red-400">System Oversight</span>
                                            </div>
                                        </div>
                                        <div className="flex items-center gap-6">
                                            <div className="flex flex-col items-end">
                                                <span className="text-sm text-gray-400">Administrator</span>
                                                <span className="text-xs font-bold text-brand-300">{userName}</span>
                                            </div>
                                            <a href={contextPath + "/logout"} className="px-4 py-2 text-xs font-bold bg-red-500/10 text-red-400 border border-red-500/20 rounded-xl hover:bg-red-500/20 transition">Emergency Logout</a>
                                        </div>
                                    </div>
                                </nav>

                                {/* Main Content */}
                                <main className="max-w-7xl mx-auto px-6 py-12 flex-1 w-full">
                                    <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-6 mb-12">
                                        <div>
                                            <h1 className="text-4xl font-display font-black text-white mb-2 tracking-tight">System-Wide Records</h1>
                                            <p className="text-gray-400">Overview of all resumes currently stored in the system</p>
                                        </div>

                                        <div className="w-full md:w-auto flex gap-4">
                                            <form action={contextPath + "/admin/dashboard"} className="relative group flex-1 md:w-72">
                                                <input
                                                    type="text"
                                                    name="search"
                                                    placeholder="Search across all users..."
                                                    value={searchTerm}
                                                    onChange={(e) => setSearchTerm(e.target.value)}
                                                    className="w-full bg-white/5 border border-white/10 rounded-2xl py-3 pl-12 pr-4 outline-none focus:border-brand-500/50 focus:bg-white/10 transition-all text-sm"
                                                />
                                                <svg className="w-5 h-5 absolute left-4 top-3.5 text-gray-500 group-focus-within:text-brand-400 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                                </svg>
                                            </form>
                                        </div>
                                    </div>

                                    {serverError && (
                                        <div className="mb-8 p-4 bg-red-500/20 border border-red-500/30 rounded-2xl text-red-300 animate-pulse">{serverError}</div>
                                    )}

                                    {/* System Metrics */}
                                    <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-12">
                                        <div className="glass-card rounded-2xl p-6">
                                            <p className="text-xs font-bold text-gray-500 uppercase tracking-widest mb-1">Total Resumes</p>
                                            <p className="text-3xl font-display font-black text-white">{resumesData.length}</p>
                                        </div>
                                        <div className="glass-card rounded-2xl p-6 border-l-4 border-l-brand-500">
                                            <p className="text-xs font-bold text-gray-500 uppercase tracking-widest mb-1">Active Users</p>
                                            <p className="text-3xl font-display font-black text-white">
                                                {[...new Set(resumesData.map(r => r.userId))].length}
                                            </p>
                                        </div>
                                        <div className="glass-card rounded-2xl p-6">
                                            <p className="text-xs font-bold text-gray-500 uppercase tracking-widest mb-1">Approval Pending</p>
                                            <p className="text-3xl font-display font-black text-white">
                                                {resumesData.filter(r => r.status === 'SUBMITTED').length}
                                            </p>
                                        </div>
                                        <div className="glass-card rounded-2xl p-6">
                                            <p className="text-xs font-bold text-gray-500 uppercase tracking-widest mb-1">System Load</p>
                                            <p className="text-3xl font-display font-black text-green-400">OPTIMAL</p>
                                        </div>
                                    </div>

                                    {/* Table */}
                                    <div className="glass rounded-3xl overflow-hidden shadow-2xl">
                                        <table className="w-full text-left border-collapse">
                                            <thead>
                                                <tr className="border-b border-white/5 bg-white/5">
                                                    <th className="px-6 py-5 text-xs font-bold text-gray-400 uppercase tracking-wider">ID</th>
                                                    <th className="px-6 py-5 text-xs font-bold text-gray-400 uppercase tracking-wider">Resume Title</th>
                                                    <th className="px-6 py-5 text-xs font-bold text-gray-400 uppercase tracking-wider">Owner / User ID</th>
                                                    <th className="px-6 py-5 text-xs font-bold text-gray-400 uppercase tracking-wider">Status</th>
                                                    <th className="px-6 py-5 text-xs font-bold text-gray-400 uppercase tracking-wider">Last Modified</th>
                                                    <th className="px-6 py-5 text-xs font-bold text-gray-400 uppercase tracking-wider text-right">Administrative Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {resumesData.length === 0 ? (
                                                    <tr>
                                                        <td colSpan="6" className="px-6 py-20 text-center text-gray-500 italic">No records found matching system parameters</td>
                                                    </tr>
                                                ) : (
                                                    resumesData.map((resume) => (
                                                        <tr key={resume.id} className="border-b border-white/5 hover:bg-white/[0.02] transition">
                                                            <td className="px-6 py-5 text-sm font-mono text-gray-500">#{resume.id}</td>
                                                            <td className="px-6 py-5">
                                                                <div className="font-bold text-white mb-0.5">{resume.title}</div>
                                                                <div className="text-xs text-gray-500">{resume.fullName}</div>
                                                            </td>
                                                            <td className="px-6 py-5">
                                                                <div className="flex items-center gap-2">
                                                                    <div className="w-6 h-6 bg-brand-500/20 text-brand-400 rounded-full flex items-center justify-center text-[10px] font-bold">{resume.userId}</div>
                                                                    <span className="text-sm font-medium text-gray-300">User Sequence {resume.userId}</span>
                                                                </div>
                                                            </td>
                                                            <td className="px-6 py-5">
                                                                <span className={`text-[10px] font-black tracking-widest uppercase px-3 py-1 rounded-full border ${resume.status === 'APPROVED' ? 'bg-green-500/10 text-green-400 border-green-500/20' :
                                                                        resume.status === 'SUBMITTED' ? 'bg-amber-500/10 text-amber-400 border-amber-500/20' :
                                                                            'bg-brand-500/10 text-brand-300 border-brand-500/20'
                                                                    }`}>
                                                                    {resume.status}
                                                                </span>
                                                            </td>
                                                            <td className="px-6 py-5 text-sm text-gray-400">{resume.updatedAt}</td>
                                                            <td className="px-6 py-5">
                                                                <div className="flex justify-end gap-2">
                                                                    <a href={contextPath + "/resume-preview?id=" + resume.id} className="p-2 bg-brand-500/20 text-brand-400 rounded-lg hover:bg-brand-500/30 transition shadow-lg group relative">
                                                                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                                                                    </a>
                                                                    <a href={contextPath + "/resume-form?id=" + resume.id} className="p-2 bg-emerald-500/20 text-emerald-400 rounded-lg hover:bg-emerald-500/30 transition shadow-lg">
                                                                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" /></svg>
                                                                    </a>
                                                                    <button onClick={() => handleDelete(resume.id)} className="p-2 bg-red-500/20 text-red-400 rounded-lg hover:bg-red-500/30 transition shadow-lg">
                                                                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" /></svg>
                                                                    </button>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    ))
                                                )}
                                            </tbody>
                                        </table>
                                    </div>
                                </main>

                                {/* Footer */}
                                <footer className="glass py-8 mt-12">
                                    <div className="max-w-7xl mx-auto px-6 flex flex-col md:flex-row justify-between items-center gap-4 text-sm text-gray-500">
                                        <p>© 2026 ResumeForge High-Performance Infrastructure</p>
                                        <div className="flex gap-6">
                                            <span className="text-gray-400 font-bold">Node: ACTIVE</span>
                                            <span className="text-gray-400 font-bold">DB: CONNECTED</span>
                                            <span className="text-gray-400 font-bold">Latency: 24ms</span>
                                        </div>
                                    </div>
                                </footer>
                            </div>
                        );
                    }

                    const root = ReactDOM.createRoot(document.getElementById('root'));
                    root.render(<AdminDashboard />);
                </script>
            </body>

            </html>