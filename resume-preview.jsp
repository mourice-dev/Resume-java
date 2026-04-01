<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.resumebuilder.model.*" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Resume Preview - ResumeForge</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <script src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
                <script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
                <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Outfit:wght@300;400;600;700;800&display=swap"
                    rel="stylesheet">
                <style>
                    @media print {
                        .no-print {
                            display: none !important;
                        }

                        body {
                            background: white !important;
                            padding: 0 !important;
                        }

                        main {
                            padding: 0 !important;
                        }
                    }

                    .font-sans {
                        font-family: 'Inter', sans-serif;
                    }

                    .font-display {
                        font-family: 'Outfit', sans-serif;
                    }
                </style>
            </head>

            <body class="font-sans">
                <div id="root"></div>
                <script type="text/babel">
        <%
                        Resume resume = (Resume) request.getAttribute("resume");
                    List < Education > eduList = (List < Education >) request.getAttribute("educationList");
                    List < Experience > expList = (List < Experience >) request.getAttribute("experienceList");
                    List < Skill > skillList = (List < Skill >) request.getAttribute("skillList");
                    List < Project > projList = (List < Project >) request.getAttribute("projectList");

                    if (resume == null) {
        %>
                            function App() {
                                return (
                                    <div className="min-h-screen bg-neutral-100 flex items-center justify-center">
                                        <div className="text-center p-8 bg-white rounded-xl shadow-lg border border-neutral-200">
                                            <h1 className="text-2xl font-bold text-neutral-800 mb-2">Resume Not Found</h1>
                                            <p className="text-neutral-500 mb-6">The resume you're looking for doesn't exist or you don't have access.</p>
                                            <a href="<%= request.getContextPath() %>/dashboard" className="px-6 py-2 bg-neutral-900 text-white rounded-lg hover:bg-neutral-800 transition-colors">Return to Dashboard</a>
                                        </div>
                                    </div>
                                );
                            }
                            <%
        } else {
            // Escape values for JS
            String rFullName = resume.getFullName() != null ? resume.getFullName().replace("\\", "\\\\").replace("\"", "\\\"") : "";
            String rEmail = resume.getEmail() != null ? resume.getEmail().replace("\\", "\\\\").replace("\"", "\\\"") : "";
            String rPhone = resume.getPhone() != null ? resume.getPhone().replace("\\", "\\\\").replace("\"", "\\\"") : "";
            String rAddress = resume.getAddress() != null ? resume.getAddress().replace("\\", "\\\\").replace("\"", "\\\"") : "";
            String rSummary = resume.getSummary() != null ? resume.getSummary().replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n") : "";
            String rLinkedin = resume.getLinkedin() != null ? resume.getLinkedin().replace("\\", "\\\\").replace("\"", "\\\"") : "";
            String rWebsite = resume.getWebsite() != null ? resume.getWebsite().replace("\\", "\\\\").replace("\"", "\\\"") : "";
            int rId = resume.getId();

            StringBuilder eduJson = new StringBuilder("[");
                        if (eduList != null) {
                            for (int i = 0; i < eduList.size(); i++) {
                    Education e = eduList.get(i);
                                if (i > 0) eduJson.append(",");
                                eduJson.append("{\"institution\":\"").append(e.getInstitution() != null ? e.getInstitution().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"degree\":\"").append(e.getDegree() != null ? e.getDegree().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"startDate\":\"").append(e.getStartDate() != null ? e.getStartDate() : "")
                                    .append("\",\"endDate\":\"").append(e.getEndDate() != null ? e.getEndDate() : "")
                                    .append("\",\"gpa\":\"").append(e.getGpa() != null ? e.getGpa() : "")
                                    .append("\"}");
                            }
                        }
                        eduJson.append("]");

            StringBuilder expJson = new StringBuilder("[");
                        if (expList != null) {
                            for (int i = 0; i < expList.size(); i++) {
                    Experience e = expList.get(i);
                                if (i > 0) expJson.append(",");
                                expJson.append("{\"company\":\"").append(e.getCompany() != null ? e.getCompany().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"position\":\"").append(e.getPosition() != null ? e.getPosition().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"startDate\":\"").append(e.getStartDate() != null ? e.getStartDate() : "")
                                    .append("\",\"endDate\":\"").append(e.getEndDate() != null ? e.getEndDate() : "")
                                    .append("\",\"description\":\"").append(e.getDescription() != null ? e.getDescription().replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n") : "")
                                    .append("\"}");
                            }
                        }
                        expJson.append("]");

            StringBuilder skillJson = new StringBuilder("[");
                        if (skillList != null) {
                            for (int i = 0; i < skillList.size(); i++) {
                    Skill s = skillList.get(i);
                                if (i > 0) skillJson.append(",");
                                skillJson.append("{\"skillName\":\"").append(s.getSkillName() != null ? s.getSkillName().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"proficiency\":\"").append(s.getProficiency() != null ? s.getProficiency() : "Intermediate")
                                    .append("\"}");
                            }
                        }
                        skillJson.append("]");

            StringBuilder projJson = new StringBuilder("[");
                        if (projList != null) {
                            for (int i = 0; i < projList.size(); i++) {
                    Project p = projList.get(i);
                                if (i > 0) projJson.append(",");
                                projJson.append("{\"projectName\":\"").append(p.getProjectName() != null ? p.getProjectName().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"description\":\"").append(p.getDescription() != null ? p.getDescription().replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n") : "")
                                    .append("\",\"technologies\":\"").append(p.getTechnologies() != null ? p.getTechnologies().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"url\":\"").append(p.getUrl() != null ? p.getUrl().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\"}");
                            }
                        }
                        projJson.append("]");
        %>

                            function App() {
                                const contextPath = "<%= request.getContextPath() %>";
                                const resume = {
                                    fullName: "<%= rFullName %>",
                                    email: "<%= rEmail %>",
                                    phone: "<%= rPhone %>",
                                    address: "<%= rAddress %>",
                                    summary: "<%= rSummary %>",
                                    linkedin: "<%= rLinkedin %>",
                                    website: "<%= rWebsite %>"
                                };
                                const education = <%= eduJson.toString() %>;
                                const experience = <%= expJson.toString() %>;
                                const skills = <%= skillJson.toString() %>;
                                const projects = <%= projJson.toString() %>;
                                const resumeId = <%= rId %>;

                                const Icons = {
                                    Mail: () => <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" /></svg>,
                                    Phone: () => <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" /></svg>,
                                    MapPin: () => <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" /><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" /></svg>,
                                    Linkedin: () => <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" /></svg>,
                                    Github: () => <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" /></svg>,
                                    Printer: () => <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z" /></svg>,
                                    Download: () => <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" /></svg>,
                                    Edit3: () => <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" /></svg>,
                                    LayoutDashboard: () => <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" /></svg>,
                                    ExternalLink: () => <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" /></svg>
                                };

                                return (
                                    <div className="min-h-screen bg-neutral-50 font-sans text-neutral-800 selection:bg-neutral-200">
                                        {/* Top Navigation Bar */}
                                        <nav className="bg-white/80 backdrop-blur-md border-b border-neutral-200 sticky top-0 z-50 px-4 md:px-8 py-3 flex flex-row justify-between items-center shadow-sm no-print">
                                            <a href={contextPath + "/dashboard"} className="flex items-center gap-2 hover:opacity-80 transition-opacity">
                                                <div className="bg-neutral-900 text-white w-8 h-8 flex items-center justify-center rounded-lg font-bold text-lg">R</div>
                                                <span className="font-bold text-lg tracking-tight text-neutral-900 hidden sm:inline-block">ResumeForge</span>
                                            </a>

                                            <div className="flex items-center gap-2">
                                                <a href={contextPath + "/resume-form?id=" + resumeId}
                                                    className="flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-neutral-600 bg-white border border-neutral-200 rounded-lg hover:bg-neutral-50 transition-colors">
                                                    <Icons.Edit3 /> <span className="hidden md:inline">Edit</span>
                                                </a>
                                                <button onClick={() => window.print()}
                                                    className="flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-white bg-neutral-900 rounded-lg hover:bg-neutral-800 transition-colors shadow-sm">
                                                    <Icons.Printer /> <span className="hidden md:inline">Print / PDF</span>
                                                </button>
                                                <div className="w-px h-6 bg-neutral-200 mx-1 hidden sm:block"></div>
                                                <a href={contextPath + "/dashboard"}
                                                    className="flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-neutral-500 hover:text-neutral-900 transition-colors">
                                                    <Icons.LayoutDashboard /> <span className="hidden md:inline">Dashboard</span>
                                                </a>
                                            </div>
                                        </nav>

                                        {/* Resume Canvas Area */}
                                        <main className="py-8 md:py-12 px-4 print:p-0">
                                            <div className="max-w-[850px] mx-auto bg-white shadow-xl border border-neutral-200 print:shadow-none print:border-none" style={{ minHeight: '1100px' }}>
                                                <div className="p-10 md:p-16 print:p-8">
                                                    {/* Header Section */}
                                                    <header className="border-b-2 border-neutral-900 pb-8 mb-8">
                                                        <h1 className="text-4xl md:text-5xl font-extrabold text-neutral-900 tracking-tight uppercase leading-tight mb-4">
                                                            {resume.fullName}
                                                        </h1>

                                                        <div className="flex flex-wrap items-center gap-x-6 gap-y-2 text-sm text-neutral-600 font-medium">
                                                            {resume.email && (
                                                                <div className="flex items-center gap-2">
                                                                    <Icons.Mail /> <a href={`mailto:${resume.email}`} className="hover:underline">{resume.email}</a>
                                                                </div>
                                                            )}
                                                            {resume.phone && (
                                                                <div className="flex items-center gap-2">
                                                                    <Icons.Phone /> <span>{resume.phone}</span>
                                                                </div>
                                                            )}
                                                            {resume.address && (
                                                                <div className="flex items-center gap-2">
                                                                    <Icons.MapPin /> <span>{resume.address}</span>
                                                                </div>
                                                            )}
                                                            {resume.linkedin && (
                                                                <div className="flex items-center gap-2">
                                                                    <Icons.Linkedin /> <a href={resume.linkedin} target="_blank" className="hover:underline">LinkedIn</a>
                                                                </div>
                                                            )}
                                                        </div>
                                                    </header>

                                                    {/* Professional Profile */}
                                                    {resume.summary && (
                                                        <section className="mb-10">
                                                            <h3 className="text-xs font-bold text-neutral-900 uppercase tracking-widest mb-4 border-l-4 border-neutral-900 pl-4">Professional Profile</h3>
                                                            <p className="text-neutral-700 leading-relaxed text-sm whitespace-pre-line">{resume.summary}</p>
                                                        </section>
                                                    )}

                                                    {/* Work Experience */}
                                                    {experience.length > 0 && experience[0].company && (
                                                        <section className="mb-10">
                                                            <h3 className="text-xs font-bold text-neutral-900 uppercase tracking-widest mb-6 border-l-4 border-neutral-900 pl-4">Experience</h3>
                                                            <div className="space-y-8">
                                                                {experience.map((exp, i) => exp.company && (
                                                                    <div key={i} className="relative">
                                                                        <div className="flex flex-col md:flex-row md:justify-between md:items-baseline mb-1">
                                                                            <h4 className="text-lg font-bold text-neutral-900">{exp.position}</h4>
                                                                            <span className="text-xs font-semibold text-neutral-500 uppercase tracking-wider">
                                                                                {exp.startDate} — {exp.endDate || 'Present'}
                                                                            </span>
                                                                        </div>
                                                                        <div className="text-neutral-600 font-bold mb-3 text-sm italic">{exp.company}</div>
                                                                        {exp.description && <p className="text-neutral-500 text-sm leading-relaxed whitespace-pre-line">{exp.description}</p>}
                                                                    </div>
                                                                ))}
                                                            </div>
                                                        </section>
                                                    )}

                                                    {/* Education */}
                                                    {education.length > 0 && education[0].institution && (
                                                        <section className="mb-10">
                                                            <h3 className="text-xs font-bold text-neutral-900 uppercase tracking-widest mb-6 border-l-4 border-neutral-900 pl-4">Education</h3>
                                                            <div className="space-y-6">
                                                                {education.map((edu, i) => edu.institution && (
                                                                    <div key={i} className="flex flex-col md:flex-row md:justify-between md:items-baseline">
                                                                        <div>
                                                                            <h4 className="text-base font-bold text-neutral-900">{edu.degree}</h4>
                                                                            <div className="text-neutral-600 text-sm">{edu.institution}</div>
                                                                        </div>
                                                                        <div className="text-right">
                                                                            <div className="text-xs font-semibold text-neutral-500 uppercase tracking-wider">{edu.startDate} — {edu.endDate || 'Present'}</div>
                                                                            {edu.gpa && <div className="text-xs text-neutral-400 font-bold">GPA: {edu.gpa}</div>}
                                                                        </div>
                                                                    </div>
                                                                ))}
                                                            </div>
                                                        </section>
                                                    )}

                                                    {/* Skills */}
                                                    {skills.length > 0 && skills[0].skillName && (
                                                        <section className="mb-10">
                                                            <h3 className="text-xs font-bold text-neutral-900 uppercase tracking-widest mb-4 border-l-4 border-neutral-900 pl-4">Expertise</h3>
                                                            <div className="flex flex-wrap gap-2">
                                                                {skills.map((skill, i) => skill.skillName && (
                                                                    <span key={i} className="px-3 py-1 bg-neutral-100 text-neutral-700 text-xs font-bold rounded uppercase tracking-tight">
                                                                        {skill.skillName} • <span className="text-neutral-400">{skill.proficiency}</span>
                                                                    </span>
                                                                ))}
                                                            </div>
                                                        </section>
                                                    )}

                                                    {/* Projects */}
                                                    {projects.length > 0 && projects[0].projectName && (
                                                        <section className="mb-10">
                                                            <h3 className="text-xs font-bold text-neutral-900 uppercase tracking-widest mb-6 border-l-4 border-neutral-900 pl-4">Projects</h3>
                                                            <div className="grid md:grid-cols-2 gap-6">
                                                                {projects.map((proj, i) => proj.projectName && (
                                                                    <div key={i} className="p-4 border border-neutral-100 bg-neutral-50/50 rounded-lg">
                                                                        <div className="flex justify-between items-start mb-2">
                                                                            <h4 className="font-bold text-neutral-900">{proj.projectName}</h4>
                                                                            {proj.url && <a href={proj.url} target="_blank" className="text-neutral-400 hover:text-neutral-900"><Icons.ExternalLink /></a>}
                                                                        </div>
                                                                        <div className="text-neutral-500 text-[10px] font-bold uppercase tracking-widest mb-2">{proj.technologies}</div>
                                                                        {proj.description && <p className="text-neutral-600 text-xs leading-relaxed">{proj.description}</p>}
                                                                    </div>
                                                                ))}
                                                            </div>
                                                        </section>
                                                    )}
                                                </div>

                                                <footer className="bg-neutral-50 p-6 border-t border-neutral-100 text-center">
                                                    <p className="text-[10px] text-neutral-400 uppercase tracking-[0.3em] font-bold">Generated via ResumeForge Digital High-Fidelity Ecosystem</p>
                                                </footer>
                                            </div>
                                        </main>
                                    </div>
                                );
                            }
                            <% } %>

        const root = ReactDOM.createRoot(document.getElementById('root'));
                    root.render(<App />);
                </script>
            </body>

            </html>