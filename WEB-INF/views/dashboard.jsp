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
                                black: '#09090b',
                                zinc: { 50: '#fafafa', 100: '#f4f4f5', 200: '#e4e4e7', 300: '#d4d4d8', 400: '#a1a1aa', 500: '#71717a', 600: '#52525b', 700: '#3f3f46', 800: '#27272a', 900: '#18181b' }
                            }
                        }
                    }
                }
            </script>
        </head>

        <body class="font-sans bg-zinc-50 text-zinc-900">
            <div id="root"></div>
            <script type="text/babel">
                    <%
                    List < Resume > resumes = (List < Resume >) request.getAttribute("resumes");
        String userName = (String) session.getAttribute("userName");
                if (userName == null) userName = "User";

        String searchVal = request.getAttribute("search") != null ? ((String)request.getAttribute("search")).replace("\\", "\\\\").replace("\"", "\\\"") : "";
        String dateVal = request.getAttribute("dateFilter") != null ? ((String)request.getAttribute("dateFilter")).replace("\"", "\\\"") : "";
        String timeFromVal = request.getAttribute("timeFrom") != null ? ((String)request.getAttribute("timeFrom")).replace("\"", "\\\"") : "";
        String timeToVal = request.getAttribute("timeTo") != null ? ((String)request.getAttribute("timeTo")).replace("\"", "\\\"") : "";
        boolean searchActive = request.getAttribute("searchActive") != null;

        StringBuilder json = new StringBuilder("[");
                if (resumes != null) {
                    for (int i = 0; i < resumes.size(); i++) {
                Resume r = resumes.get(i);
                        if (i > 0) json.append(",");
                        json.append("{\"id\":").append(r.getId())
                            .append(",\"title\":\"").append(r.getTitle() != null ? r.getTitle().replace("\\", "\\\\").replace("\"", "\\\"") : "Untitled")
                            .append("\",\"fullName\":\"").append(r.getFullName() != null ? r.getFullName().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                            .append("\",\"email\":\"").append(r.getEmail() != null ? r.getEmail().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                            .append("\",\"createdAt\":\"").append(r.getCreatedAt() != null ? r.getCreatedAt() : "")
                            .append("\",\"updatedAt\":\"").append(r.getUpdatedAt() != null ? r.getUpdatedAt() : "")
                            .append("\"}");
                    }
                }
                json.append("]");
        %>

                    function App() {
                        const ctx = "<%= request.getContextPath() %>";
                        const userName = "<%= userName.replace("\\","\\\\").replace("\"", "\\\"") %> ";
                        const resumes = <%= json.toString() %>;
                        const [showSearch, setShowSearch] = React.useState(<%= searchActive %>);

                        const [search, setSearch] = React.useState("<%= searchVal %>");
                        const [dateFilter, setDateFilter] = React.useState("<%= dateVal %>");
                        const [timeFrom, setTimeFrom] = React.useState("<%= timeFromVal %>");
                        const [timeTo, setTimeTo] = React.useState("<%= timeToVal %>");

                        const clearSearch = () => { window.location.href = ctx + "/dashboard"; };

                        const inputCls = "w-full px-4 py-2.5 bg-white border border-zinc-200 rounded-lg text-sm focus:outline-none focus:border-black focus:ring-1 focus:ring-black transition placeholder-zinc-400";
                        const labelCls = "block text-xs font-semibold text-zinc-500 mb-1 uppercase tracking-wide";

                        return (
                            <div className="min-h-screen">
                                {/* Navbar */}
                                <nav className="bg-white border-b border-zinc-200 sticky top-0 z-50">
                                    <div className="max-w-6xl mx-auto px-6 py-4 flex justify-between items-center">
                                        <a href={ctx + "/dashboard"} className="flex items-center gap-3 group">
                                            <div className="w-8 h-8 bg-black text-white rounded flex items-center justify-center font-bold text-sm">R</div>
                                            <span className="text-lg font-bold text-black">ResumeForge</span>
                                        </a>
                                        <div className="flex items-center gap-4">
                                            <span className="text-sm text-zinc-500">Hello, <strong className="text-black">{userName}</strong></span>
                                            <a href={ctx + "/logout"} className="text-sm font-medium text-zinc-500 hover:text-black transition">Logout</a>
                                        </div>
                                    </div>
                                </nav>

                                <div className="max-w-6xl mx-auto px-6 py-10">
                                    {/* Header */}
                                    <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8">
                                        <div>
                                            <h1 className="text-3xl font-bold tracking-tight text-black">Your Resumes</h1>
                                            <p className="text-zinc-500 mt-1">{resumes.length} resume{resumes.length !== 1 ? 's' : ''} saved</p>
                                        </div>
                                        <div className="flex gap-3">
                                            <button onClick={() => setShowSearch(!showSearch)}
                                                className={"px-4 py-2.5 text-sm font-medium rounded-lg border transition " + (showSearch ? "bg-black text-white border-black" : "bg-white text-zinc-700 border-zinc-200 hover:border-zinc-300")}>
                                                {showSearch ? "Hide Search" : "Search"}
                                            </button>
                                            <a href={ctx + "/resume-form"} className="px-5 py-2.5 text-sm font-medium bg-black text-white rounded-lg hover:bg-zinc-800 transition shadow-lg shadow-black/10">
                                                + New Resume
                                            </a>
                                        </div>
                                    </div>

                                    {/* Search Panel */}
                                    {showSearch && (
                                        <form method="GET" action={ctx + "/dashboard"} className="bg-white border border-zinc-200 rounded-xl p-6 mb-8 shadow-sm">
                                            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                                                <div>
                                                    <label className={labelCls}>Search Text</label>
                                                    <input type="text" name="search" value={search} onChange={e => setSearch(e.target.value)} className={inputCls} placeholder="Name, title, email..." />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>Date</label>
                                                    <input type="date" name="dateFilter" value={dateFilter} onChange={e => setDateFilter(e.target.value)} className={inputCls} />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>Time From</label>
                                                    <input type="time" name="timeFrom" value={timeFrom} onChange={e => setTimeFrom(e.target.value)} className={inputCls} />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>Time To</label>
                                                    <input type="time" name="timeTo" value={timeTo} onChange={e => setTimeTo(e.target.value)} className={inputCls} />
                                                </div>
                                            </div>
                                            <div className="flex gap-3 mt-4">
                                                <button type="submit" className="px-5 py-2 text-sm font-medium bg-black text-white rounded-lg hover:bg-zinc-800 transition">Apply Filters</button>
                                                <button type="button" onClick={clearSearch} className="px-5 py-2 text-sm font-medium bg-white text-zinc-600 border border-zinc-200 rounded-lg hover:bg-zinc-50 transition">Clear</button>
                                            </div>
                                        </form>
                                    )}

                                    {/* Resume Cards */}
                                    {resumes.length === 0 ? (
                                        <div className="text-center py-20">
                                            <div className="w-16 h-16 bg-zinc-100 rounded-2xl flex items-center justify-center mx-auto mb-4">
                                                <svg className="w-8 h-8 text-zinc-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" /></svg>
                                            </div>
                                            <h3 className="text-lg font-semibold text-zinc-700 mb-1">No resumes yet</h3>
                                            <p className="text-zinc-400 mb-6">Create your first professional resume.</p>
                                            <a href={ctx + "/resume-form"} className="px-6 py-3 bg-black text-white rounded-lg font-medium hover:bg-zinc-800 transition shadow-lg shadow-black/10">Create Resume</a>
                                        </div>
                                    ) : (
                                        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                                            {resumes.map(r => {
                                                // Relative time
                                                let timeAgo = '';
                                                if (r.updatedAt) {
                                                    const updated = new Date(r.updatedAt.replace(' ', 'T'));
                                                    const diff = Math.floor((Date.now() - updated.getTime()) / 1000);
                                                    if (diff < 60) timeAgo = 'just now';
                                                    else if (diff < 3600) timeAgo = Math.floor(diff / 60) + 'm ago';
                                                    else if (diff < 86400) timeAgo = Math.floor(diff / 3600) + 'h ago';
                                                    else if (diff < 604800) timeAgo = Math.floor(diff / 86400) + 'd ago';
                                                    else timeAgo = r.updatedAt.substring(0, 10);
                                                }
                                                return (
                                                    <div key={r.id} className="bg-white border border-zinc-200 rounded-xl p-6 hover:shadow-md hover:border-zinc-300 transition group">
                                                        <div className="flex items-start justify-between mb-3">
                                                            <div className="w-10 h-10 bg-zinc-100 rounded-lg flex items-center justify-center text-black font-bold text-sm group-hover:bg-black group-hover:text-white transition">
                                                                {r.fullName ? r.fullName.charAt(0).toUpperCase() : "R"}
                                                            </div>
                                                            <span className="text-[10px] font-medium text-zinc-400 uppercase tracking-wide">{timeAgo}</span>
                                                        </div>
                                                        <h3 className="font-bold text-black text-lg mb-1 truncate">{r.title}</h3>
                                                        <p className="text-sm text-zinc-500 mb-1 truncate">{r.fullName}</p>
                                                        <p className="text-xs text-zinc-400 mb-5 truncate">{r.email}</p>
                                                        <div className="flex gap-2">
                                                            <a href={ctx + "/resume-preview?id=" + r.id} className="flex-1 py-2 text-center text-xs font-medium bg-zinc-100 text-zinc-700 rounded-lg hover:bg-zinc-200 transition">View</a>
                                                            <a href={ctx + "/resume-form?id=" + r.id} className="flex-1 py-2 text-center text-xs font-medium bg-zinc-100 text-zinc-700 rounded-lg hover:bg-zinc-200 transition">Edit</a>
                                                            <a href={ctx + "/resume?action=duplicate&id=" + r.id} className="flex-1 py-2 text-center text-xs font-medium bg-zinc-100 text-zinc-700 rounded-lg hover:bg-zinc-200 transition" title="Duplicate">Clone</a>
                                                            <a href={ctx + "/resume?action=delete&id=" + r.id} onClick={e => { if (!confirm('Delete this resume?')) e.preventDefault(); }} className="flex-1 py-2 text-center text-xs font-medium bg-zinc-100 text-red-600 rounded-lg hover:bg-red-50 transition">Delete</a>
                                                        </div>
                                                    </div>
                                                );
                                            })}
                                        </div>

                                    )}

                                    {/* CRUD Legend */}
                                    <div className="mt-10 bg-white border border-zinc-200 rounded-xl p-4 flex flex-wrap gap-6 justify-center text-xs text-zinc-500">
                                        <span className="flex items-center gap-2"><span className="w-3 h-3 rounded bg-black"></span> <strong>C</strong>reate — New Resume</span>
                                        <span className="flex items-center gap-2"><span className="w-3 h-3 rounded bg-zinc-400"></span> <strong>R</strong>ead — View / Preview</span>
                                        <span className="flex items-center gap-2"><span className="w-3 h-3 rounded bg-zinc-600"></span> <strong>U</strong>pdate — Edit Resume</span>
                                        <span className="flex items-center gap-2"><span className="w-3 h-3 rounded bg-red-400"></span> <strong>D</strong>elete — Remove Resume</span>
                                    </div>
                                </div>
                            </div>
                        );
                    }
                const root = ReactDOM.createRoot(document.getElementById('root'));
                root.render(<App />);
            </script>
        </body>

        </html>