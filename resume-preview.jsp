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
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Merriweather:wght@300;400;700&display=swap"
                    rel="stylesheet">
                <script>
                    tailwind.config = {
                        theme: {
                            extend: {
                                fontFamily: { sans: ['Inter', 'sans-serif'], serif: ['Merriweather', 'serif'] }, colors: {
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
                        background: linear-gradient(-45deg, #0f0a2a, #1e1b4b, #312e81, #3730a3);
                        background-size: 400% 400%;
                        animation: gradient 15s ease infinite;
                    }

                    .glass {
                        background: rgba(255, 255, 255, 0.05);
                        backdrop-filter: blur(20px);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                    }

                    @media print {
                        body {
                            background: white !important;
                        }

                        .no-print {
                            display: none !important;
                        }

                        .print-area {
                            box-shadow: none !important;
                            margin: 0 !important;
                            padding: 40px !important;
                            max-width: 100% !important;
                        }
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
                                return <div className="min-h-screen gradient-bg text-white flex items-center justify-center"><p>Resume not found.</p></div>;
                            }
                            <%
    } else {
        // Escape for JS
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
                                    .append("\",\"fieldOfStudy\":\"").append(e.getFieldOfStudy() != null ? e.getFieldOfStudy().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"startDate\":\"").append(e.getStartDate() != null ? e.getStartDate() : "")
                                    .append("\",\"endDate\":\"").append(e.getEndDate() != null ? e.getEndDate() : "")
                                    .append("\",\"gpa\":\"").append(e.getGpa() != null ? e.getGpa() : "")
                                    .append("\",\"description\":\"").append(e.getDescription() != null ? e.getDescription().replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n") : "")
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

                                const proficiencyWidth = { 'Beginner': '25%', 'Intermediate': '50%', 'Advanced': '75%', 'Expert': '100%' };
                                const proficiencyColor = { 'Beginner': 'bg-blue-400', 'Intermediate': 'bg-brand-500', 'Advanced': 'bg-purple-500', 'Expert': 'bg-emerald-500' };

                                return (
                                    <div className="min-h-screen gradient-bg text-white">
                                        {/* Action Bar */}
                                        <div className="no-print glass sticky top-0 z-50">
                                            <div className="max-w-5xl mx-auto px-6 py-4 flex justify-between items-center">
                                                <a href={contextPath + "/dashboard"} className="flex items-center gap-3">
                                                    <div className="w-10 h-10 bg-gradient-to-br from-brand-400 to-brand-600 rounded-xl flex items-center justify-center font-bold text-lg">R</div>
                                                    <span className="text-xl font-bold bg-gradient-to-r from-brand-300 to-brand-500 bg-clip-text text-transparent">ResumeForge</span>
                                                </a>
                                                <div className="flex items-center gap-3">
                                                    <a href={contextPath + "/resume-form?id=" + resumeId}
                                                        className="px-4 py-2 text-sm bg-emerald-500/20 text-emerald-300 rounded-xl hover:bg-emerald-500/30 transition flex items-center gap-2">
                                                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" /></svg>
                                                        Edit
                                                    </a>
                                                    <button onClick={() => window.print()}
                                                        className="px-4 py-2 text-sm bg-gradient-to-r from-brand-500 to-brand-700 rounded-xl hover:shadow-lg transition flex items-center gap-2">
                                                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z" /></svg>
                                                        Print / Download PDF
                                                    </button>
                                                    <a href={contextPath + "/dashboard"} className="px-4 py-2 text-sm text-gray-400 hover:text-white transition">Back</a>
                                                </div>
                                            </div>
                                        </div>

                                        {/* Resume Preview */}
                                        <div className="max-w-4xl mx-auto px-6 py-10">
                                            <div className="print-area bg-white text-gray-900 rounded-2xl shadow-2xl overflow-hidden">
                                                {/* Header */}
                                                <div className="bg-gradient-to-r from-slate-800 to-slate-900 text-white p-10">
                                                    <h1 className="text-4xl font-bold mb-2 font-serif">{resume.fullName}</h1>
                                                    <div className="flex flex-wrap gap-4 text-sm text-slate-300 mt-4">
                                                        {resume.email && (
                                                            <span className="flex items-center gap-1.5">
                                                                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" /></svg>
                                                                {resume.email}
                                                            </span>
                                                        )}
                                                        {resume.phone && (
                                                            <span className="flex items-center gap-1.5">
                                                                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" /></svg>
                                                                {resume.phone}
                                                            </span>
                                                        )}
                                                        {resume.address && (
                                                            <span className="flex items-center gap-1.5">
                                                                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" /><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" /></svg>
                                                                {resume.address}
                                                            </span>
                                                        )}
                                                        {resume.linkedin && (
                                                            <span className="flex items-center gap-1.5">
                                                                <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z" /></svg>
                                                                LinkedIn
                                                            </span>
                                                        )}
                                                        {resume.website && (
                                                            <span className="flex items-center gap-1.5">
                                                                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9" /></svg>
                                                                Website
                                                            </span>
                                                        )}
                                                    </div>
                                                </div>

                                                <div className="p-10">
                                                    {/* Summary */}
                                                    {resume.summary && (
                                                        <div className="mb-8">
                                                            <h2 className="text-lg font-bold text-slate-800 uppercase tracking-wider border-b-2 border-slate-200 pb-2 mb-4">Professional Summary</h2>
                                                            <p className="text-gray-600 leading-relaxed whitespace-pre-line">{resume.summary}</p>
                                                        </div>
                                                    )}

                                                    {/* Experience */}
                                                    {experience.length > 0 && experience[0].company && (
                                                        <div className="mb-8">
                                                            <h2 className="text-lg font-bold text-slate-800 uppercase tracking-wider border-b-2 border-slate-200 pb-2 mb-4">Work Experience</h2>
                                                            {experience.map((exp, i) => exp.company && (
                                                                <div key={i} className="mb-5 last:mb-0">
                                                                    <div className="flex justify-between items-start mb-1">
                                                                        <div>
                                                                            <h3 className="text-base font-bold text-slate-800">{exp.position}</h3>
                                                                            <p className="text-brand-600 font-medium">{exp.company}</p>
                                                                        </div>
                                                                        <span className="text-sm text-gray-500 whitespace-nowrap ml-4">{exp.startDate} - {exp.endDate || 'Present'}</span>
                                                                    </div>
                                                                    {exp.description && <p className="text-gray-600 text-sm mt-2 leading-relaxed whitespace-pre-line">{exp.description}</p>}
                                                                </div>
                                                            ))}
                                                        </div>
                                                    )}

                                                    {/* Education */}
                                                    {education.length > 0 && education[0].institution && (
                                                        <div className="mb-8">
                                                            <h2 className="text-lg font-bold text-slate-800 uppercase tracking-wider border-b-2 border-slate-200 pb-2 mb-4">Education</h2>
                                                            {education.map((edu, i) => edu.institution && (
                                                                <div key={i} className="mb-5 last:mb-0">
                                                                    <div className="flex justify-between items-start mb-1">
                                                                        <div>
                                                                            <h3 className="text-base font-bold text-slate-800">{edu.degree}{edu.fieldOfStudy ? ` in ${edu.fieldOfStudy}` : ''}</h3>
                                                                            <p className="text-brand-600 font-medium">{edu.institution}</p>
                                                                        </div>
                                                                        <div className="text-right ml-4">
                                                                            <span className="text-sm text-gray-500 whitespace-nowrap">{edu.startDate} - {edu.endDate || 'Present'}</span>
                                                                            {edu.gpa && <p className="text-sm text-gray-500">GPA: {edu.gpa}</p>}
                                                                        </div>
                                                                    </div>
                                                                    {edu.description && <p className="text-gray-600 text-sm mt-2 leading-relaxed whitespace-pre-line">{edu.description}</p>}
                                                                </div>
                                                            ))}
                                                        </div>
                                                    )}

                                                    {/* Skills */}
                                                    {skills.length > 0 && skills[0].skillName && (
                                                        <div className="mb-8">
                                                            <h2 className="text-lg font-bold text-slate-800 uppercase tracking-wider border-b-2 border-slate-200 pb-2 mb-4">Skills</h2>
                                                            <div className="grid grid-cols-2 gap-3">
                                                                {skills.map((skill, i) => skill.skillName && (
                                                                    <div key={i} className="flex items-center gap-3">
                                                                        <span className="text-sm font-medium text-gray-700 w-32 truncate">{skill.skillName}</span>
                                                                        <div className="flex-1 bg-gray-200 rounded-full h-2">
                                                                            <div className={`h-2 rounded-full ${proficiencyColor[skill.proficiency] || 'bg-brand-500'}`}
                                                                                style={{ width: proficiencyWidth[skill.proficiency] || '50%' }}></div>
                                                                        </div>
                                                                        <span className="text-xs text-gray-500 w-20">{skill.proficiency}</span>
                                                                    </div>
                                                                ))}
                                                            </div>
                                                        </div>
                                                    )}

                                                    {/* Projects */}
                                                    {projects.length > 0 && projects[0].projectName && (
                                                        <div className="mb-8">
                                                            <h2 className="text-lg font-bold text-slate-800 uppercase tracking-wider border-b-2 border-slate-200 pb-2 mb-4">Projects</h2>
                                                            {projects.map((proj, i) => proj.projectName && (
                                                                <div key={i} className="mb-5 last:mb-0">
                                                                    <div className="flex justify-between items-start mb-1">
                                                                        <h3 className="text-base font-bold text-slate-800">{proj.projectName}</h3>
                                                                        {proj.url && <a href={proj.url} className="text-brand-600 text-sm hover:underline ml-4" target="_blank">View Project</a>}
                                                                    </div>
                                                                    {proj.technologies && <p className="text-sm text-brand-600 mb-1">{proj.technologies}</p>}
                                                                    {proj.description && <p className="text-gray-600 text-sm leading-relaxed whitespace-pre-line">{proj.description}</p>}
                                                                </div>
                                                            ))}
                                                        </div>
                                                    )}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                );
                            }

                            <% } %>

const root = ReactDOM.createRoot(document.getElementById('root'));
                    root.render(<App />);
                </script>
            </body>

            </html>