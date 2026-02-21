<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.resumebuilder.model.*" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Build Resume - ResumeForge</title>
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
                                fontFamily: { sans: ['Inter', 'sans-serif'] }, colors: {
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
                </style>
            </head>

            <body class="font-sans">
                <div id="root"></div>
                <script type="text/babel">
                    const { useState } = React;

<%
                        Resume editResume = (Resume) request.getAttribute("resume");
                    List < Education > eduList = (List < Education >) request.getAttribute("educationList");
                    List < Experience > expList = (List < Experience >) request.getAttribute("experienceList");
                    List < Skill > skillList = (List < Skill >) request.getAttribute("skillList");
                    List < Project > projList = (List < Project >) request.getAttribute("projectList");

    String resumeId = editResume != null ? String.valueOf(editResume.getId()) : "";
    String rTitle = editResume != null && editResume.getTitle() != null ? editResume.getTitle().replace("\"", "\\\"") : "";
    String rFullName = editResume != null && editResume.getFullName() != null ? editResume.getFullName().replace("\"", "\\\"") : "";
    String rEmail = editResume != null && editResume.getEmail() != null ? editResume.getEmail().replace("\"", "\\\"") : "";
    String rPhone = editResume != null && editResume.getPhone() != null ? editResume.getPhone().replace("\"", "\\\"") : "";
    String rAddress = editResume != null && editResume.getAddress() != null ? editResume.getAddress().replace("\"", "\\\"") : "";
    String rSummary = editResume != null && editResume.getSummary() != null ? editResume.getSummary().replace("\"", "\\\"").replace("\n", "\\n") : "";
    String rLinkedin = editResume != null && editResume.getLinkedin() != null ? editResume.getLinkedin().replace("\"", "\\\"") : "";
    String rWebsite = editResume != null && editResume.getWebsite() != null ? editResume.getWebsite().replace("\"", "\\\"") : "";
    String rTemplate = editResume != null && editResume.getTemplate() != null ? editResume.getTemplate() : "modern";

    // Build education JSON
    StringBuilder eduJson = new StringBuilder("[");
                    if (eduList != null) {
                        for (int i = 0; i < eduList.size(); i++) {
            Education e = eduList.get(i);
                            if (i > 0) eduJson.append(",");
                            eduJson.append("{\"institution\":\"").append(e.getInstitution() != null ? e.getInstitution().replace("\"", "\\\"") : "")
                                .append("\",\"degree\":\"").append(e.getDegree() != null ? e.getDegree().replace("\"", "\\\"") : "")
                                .append("\",\"fieldOfStudy\":\"").append(e.getFieldOfStudy() != null ? e.getFieldOfStudy().replace("\"", "\\\"") : "")
                                .append("\",\"startDate\":\"").append(e.getStartDate() != null ? e.getStartDate() : "")
                                .append("\",\"endDate\":\"").append(e.getEndDate() != null ? e.getEndDate() : "")
                                .append("\",\"gpa\":\"").append(e.getGpa() != null ? e.getGpa() : "")
                                .append("\",\"description\":\"").append(e.getDescription() != null ? e.getDescription().replace("\"", "\\\"").replace("\n", "\\n") : "")
                                .append("\"}");
                        }
                    }
                    eduJson.append("]");

    // Build experience JSON
    StringBuilder expJson = new StringBuilder("[");
                    if (expList != null) {
                        for (int i = 0; i < expList.size(); i++) {
            Experience e = expList.get(i);
                            if (i > 0) expJson.append(",");
                            expJson.append("{\"company\":\"").append(e.getCompany() != null ? e.getCompany().replace("\"", "\\\"") : "")
                                .append("\",\"position\":\"").append(e.getPosition() != null ? e.getPosition().replace("\"", "\\\"") : "")
                                .append("\",\"startDate\":\"").append(e.getStartDate() != null ? e.getStartDate() : "")
                                .append("\",\"endDate\":\"").append(e.getEndDate() != null ? e.getEndDate() : "")
                                .append("\",\"description\":\"").append(e.getDescription() != null ? e.getDescription().replace("\"", "\\\"").replace("\n", "\\n") : "")
                                .append("\"}");
                        }
                    }
                    expJson.append("]");

    // Build skill JSON
    StringBuilder skillJson = new StringBuilder("[");
                    if (skillList != null) {
                        for (int i = 0; i < skillList.size(); i++) {
            Skill s = skillList.get(i);
                            if (i > 0) skillJson.append(",");
                            skillJson.append("{\"skillName\":\"").append(s.getSkillName() != null ? s.getSkillName().replace("\"", "\\\"") : "")
                                .append("\",\"proficiency\":\"").append(s.getProficiency() != null ? s.getProficiency() : "Intermediate")
                                .append("\"}");
                        }
                    }
                    skillJson.append("]");

    // Build project JSON
    StringBuilder projJson = new StringBuilder("[");
                    if (projList != null) {
                        for (int i = 0; i < projList.size(); i++) {
            Project p = projList.get(i);
                            if (i > 0) projJson.append(",");
                            projJson.append("{\"projectName\":\"").append(p.getProjectName() != null ? p.getProjectName().replace("\"", "\\\"") : "")
                                .append("\",\"description\":\"").append(p.getDescription() != null ? p.getDescription().replace("\"", "\\\"").replace("\n", "\\n") : "")
                                .append("\",\"technologies\":\"").append(p.getTechnologies() != null ? p.getTechnologies().replace("\"", "\\\"") : "")
                                .append("\",\"url\":\"").append(p.getUrl() != null ? p.getUrl().replace("\"", "\\\"") : "")
                                .append("\"}");
                        }
                    }
                    projJson.append("]");
%>

                        function ResumeForm() {
                            const contextPath = "<%= request.getContextPath() %>";
                            const isEdit = "<%= resumeId %>" !== "";
                            const [step, setStep] = useState(0);
                            const [loading, setLoading] = useState(false);

                            const existingEdu = <%= eduJson.toString() %>;
                            const existingExp = <%= expJson.toString() %>;
                            const existingSkills = <%= skillJson.toString() %>;
                            const existingProjects = <%= projJson.toString() %>;

                            const [education, setEducation] = useState(existingEdu.length > 0 ? existingEdu : [{ institution: '', degree: '', fieldOfStudy: '', startDate: '', endDate: '', gpa: '', description: '' }]);
                            const [experience, setExperience] = useState(existingExp.length > 0 ? existingExp : [{ company: '', position: '', startDate: '', endDate: '', description: '' }]);
                            const [skills, setSkills] = useState(existingSkills.length > 0 ? existingSkills : [{ skillName: '', proficiency: 'Intermediate' }]);
                            const [projects, setProjects] = useState(existingProjects.length > 0 ? existingProjects : [{ projectName: '', description: '', technologies: '', url: '' }]);

                            const steps = ['Personal Info', 'Education', 'Experience', 'Skills', 'Projects'];
                            const inputClass = "w-full px-4 py-3 bg-white/5 border border-white/10 rounded-xl text-white placeholder-gray-500 focus:outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 transition";
                            const labelClass = "block text-sm font-medium text-gray-300 mb-2";

                            const addItem = (setter, template) => setter(prev => [...prev, { ...template }]);
                            const removeItem = (setter, index) => setter(prev => prev.filter((_, i) => i !== index));
                            const updateItem = (setter, index, field, value) => setter(prev => { const arr = [...prev]; arr[index] = { ...arr[index], [field]: value }; return arr; });

                            const handleSubmit = (e) => { setLoading(true); };

                            return (
                                <div className="min-h-screen gradient-bg text-white">
                                    {/* Nav */}
                                    <nav className="glass sticky top-0 z-50">
                                        <div className="max-w-5xl mx-auto px-6 py-4 flex justify-between items-center">
                                            <a href={contextPath + "/dashboard"} className="flex items-center gap-3">
                                                <div className="w-10 h-10 bg-gradient-to-br from-brand-400 to-brand-600 rounded-xl flex items-center justify-center font-bold text-lg">R</div>
                                                <span className="text-xl font-bold bg-gradient-to-r from-brand-300 to-brand-500 bg-clip-text text-transparent">ResumeForge</span>
                                            </a>
                                            <a href={contextPath + "/dashboard"} className="text-sm text-gray-400 hover:text-white transition">Back to Dashboard</a>
                                        </div>
                                    </nav>

                                    <div className="max-w-4xl mx-auto px-6 py-10">
                                        <h1 className="text-3xl font-bold mb-2">{isEdit ? 'Edit Resume' : 'Create New Resume'}</h1>
                                        <p className="text-gray-400 mb-8">Fill in your details step by step</p>

                                        {/* Step Indicator */}
                                        <div className="flex items-center gap-2 mb-10 overflow-x-auto pb-2">
                                            {steps.map((s, i) => (
                                                <button key={i} onClick={() => setStep(i)}
                                                    className={`flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-medium transition-all whitespace-nowrap ${i === step ? 'bg-brand-500 text-white' : i < step ? 'bg-brand-500/20 text-brand-300' : 'bg-white/5 text-gray-500'}`}>
                                                    <span className={`w-6 h-6 rounded-full flex items-center justify-center text-xs ${i === step ? 'bg-white/20' : i < step ? 'bg-brand-500/30' : 'bg-white/10'}`}>{i + 1}</span>
                                                    {s}
                                                </button>
                                            ))}
                                        </div>

                                        <form action={contextPath + "/resume-form"} method="POST" onSubmit={handleSubmit}>
                                            <input type="hidden" name="resumeId" value="<%= resumeId %>" />

                                            {/* Step 0: Personal Info */}
                                            <div style={{ display: step === 0 ? 'block' : 'none' }}>
                                                <div className="glass rounded-2xl p-8">
                                                    <h2 className="text-xl font-bold mb-6 flex items-center gap-2">
                                                        <svg className="w-6 h-6 text-brand-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
                                                        Personal Information
                                                    </h2>
                                                    <div className="grid md:grid-cols-2 gap-5">
                                                        <div>
                                                            <label className={labelClass}>Resume Title *</label>
                                                            <input type="text" name="title" defaultValue="<%= rTitle %>" required className={inputClass} placeholder="e.g. Software Engineer Resume" />
                                                        </div>
                                                        <div>
                                                            <label className={labelClass}>Template</label>
                                                            <select name="template" defaultValue="<%= rTemplate %>" className={inputClass}>
                                                                <option value="modern">Modern</option>
                                                                <option value="classic">Classic</option>
                                                                <option value="minimal">Minimal</option>
                                                            </select>
                                                        </div>
                                                        <div>
                                                            <label className={labelClass}>Full Name *</label>
                                                            <input type="text" name="fullName" defaultValue="<%= rFullName %>" required className={inputClass} placeholder="John Doe" />
                                                        </div>
                                                        <div>
                                                            <label className={labelClass}>Email</label>
                                                            <input type="email" name="resumeEmail" defaultValue="<%= rEmail %>" className={inputClass} placeholder="john@example.com" />
                                                        </div>
                                                        <div>
                                                            <label className={labelClass}>Phone</label>
                                                            <input type="tel" name="phone" defaultValue="<%= rPhone %>" className={inputClass} placeholder="+1 (555) 000-0000" />
                                                        </div>
                                                        <div>
                                                            <label className={labelClass}>Address</label>
                                                            <input type="text" name="address" defaultValue="<%= rAddress %>" className={inputClass} placeholder="City, State, Country" />
                                                        </div>
                                                        <div>
                                                            <label className={labelClass}>LinkedIn</label>
                                                            <input type="url" name="linkedin" defaultValue="<%= rLinkedin %>" className={inputClass} placeholder="https://linkedin.com/in/johndoe" />
                                                        </div>
                                                        <div>
                                                            <label className={labelClass}>Website</label>
                                                            <input type="url" name="website" defaultValue="<%= rWebsite %>" className={inputClass} placeholder="https://johndoe.com" />
                                                        </div>
                                                    </div>
                                                    <div className="mt-5">
                                                        <label className={labelClass}>Professional Summary</label>
                                                        <textarea name="summary" rows="4" defaultValue={"<%= rSummary %>"} className={inputClass} placeholder="Brief professional summary highlighting your key achievements and expertise..."></textarea>
                                                    </div>
                                                </div>
                                            </div>

                                            {/* Step 1: Education */}
                                            <div style={{ display: step === 1 ? 'block' : 'none' }}>
                                                <div className="glass rounded-2xl p-8">
                                                    <div className="flex justify-between items-center mb-6">
                                                        <h2 className="text-xl font-bold flex items-center gap-2">
                                                            <svg className="w-6 h-6 text-brand-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 14l9-5-9-5-9 5 9 5z" /><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" /></svg>
                                                            Education
                                                        </h2>
                                                        <button type="button" onClick={() => addItem(setEducation, { institution: '', degree: '', fieldOfStudy: '', startDate: '', endDate: '', gpa: '', description: '' })}
                                                            className="text-sm px-4 py-2 bg-brand-500/20 text-brand-300 rounded-lg hover:bg-brand-500/30 transition flex items-center gap-1">
                                                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" /></svg> Add
                                                        </button>
                                                    </div>
                                                    {education.map((edu, i) => (
                                                        <div key={i} className="mb-6 p-5 bg-white/5 rounded-xl border border-white/5 relative">
                                                            {education.length > 1 && (
                                                                <button type="button" onClick={() => removeItem(setEducation, i)} className="absolute top-3 right-3 text-red-400 hover:text-red-300">
                                                                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>
                                                                </button>
                                                            )}
                                                            <div className="grid md:grid-cols-2 gap-4">
                                                                <div><label className={labelClass}>Institution *</label><input type="text" name="institution" value={edu.institution} onChange={e => updateItem(setEducation, i, 'institution', e.target.value)} className={inputClass} placeholder="University Name" /></div>
                                                                <div><label className={labelClass}>Degree *</label><input type="text" name="degree" value={edu.degree} onChange={e => updateItem(setEducation, i, 'degree', e.target.value)} className={inputClass} placeholder="Bachelor's, Master's, etc." /></div>
                                                                <div><label className={labelClass}>Field of Study</label><input type="text" name="fieldOfStudy" value={edu.fieldOfStudy} onChange={e => updateItem(setEducation, i, 'fieldOfStudy', e.target.value)} className={inputClass} placeholder="Computer Science" /></div>
                                                                <div><label className={labelClass}>GPA</label><input type="text" name="gpa" value={edu.gpa} onChange={e => updateItem(setEducation, i, 'gpa', e.target.value)} className={inputClass} placeholder="3.8/4.0" /></div>
                                                                <div><label className={labelClass}>Start Date</label><input type="text" name="eduStartDate" value={edu.startDate} onChange={e => updateItem(setEducation, i, 'startDate', e.target.value)} className={inputClass} placeholder="Sep 2020" /></div>
                                                                <div><label className={labelClass}>End Date</label><input type="text" name="eduEndDate" value={edu.endDate} onChange={e => updateItem(setEducation, i, 'endDate', e.target.value)} className={inputClass} placeholder="Jun 2024 or Present" /></div>
                                                            </div>
                                                            <div className="mt-4"><label className={labelClass}>Description</label><textarea name="eduDescription" rows="2" value={edu.description} onChange={e => updateItem(setEducation, i, 'description', e.target.value)} className={inputClass} placeholder="Relevant coursework, achievements..."></textarea></div>
                                                        </div>
                                                    ))}
                                                </div>
                                            </div>

                                            {/* Step 2: Experience */}
                                            <div style={{ display: step === 2 ? 'block' : 'none' }}>
                                                <div className="glass rounded-2xl p-8">
                                                    <div className="flex justify-between items-center mb-6">
                                                        <h2 className="text-xl font-bold flex items-center gap-2">
                                                            <svg className="w-6 h-6 text-brand-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" /></svg>
                                                            Work Experience
                                                        </h2>
                                                        <button type="button" onClick={() => addItem(setExperience, { company: '', position: '', startDate: '', endDate: '', description: '' })}
                                                            className="text-sm px-4 py-2 bg-brand-500/20 text-brand-300 rounded-lg hover:bg-brand-500/30 transition flex items-center gap-1">
                                                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" /></svg> Add
                                                        </button>
                                                    </div>
                                                    {experience.map((exp, i) => (
                                                        <div key={i} className="mb-6 p-5 bg-white/5 rounded-xl border border-white/5 relative">
                                                            {experience.length > 1 && (
                                                                <button type="button" onClick={() => removeItem(setExperience, i)} className="absolute top-3 right-3 text-red-400 hover:text-red-300">
                                                                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>
                                                                </button>
                                                            )}
                                                            <div className="grid md:grid-cols-2 gap-4">
                                                                <div><label className={labelClass}>Company *</label><input type="text" name="company" value={exp.company} onChange={e => updateItem(setExperience, i, 'company', e.target.value)} className={inputClass} placeholder="Company Name" /></div>
                                                                <div><label className={labelClass}>Position *</label><input type="text" name="position" value={exp.position} onChange={e => updateItem(setExperience, i, 'position', e.target.value)} className={inputClass} placeholder="Job Title" /></div>
                                                                <div><label className={labelClass}>Start Date</label><input type="text" name="expStartDate" value={exp.startDate} onChange={e => updateItem(setExperience, i, 'startDate', e.target.value)} className={inputClass} placeholder="Jan 2022" /></div>
                                                                <div><label className={labelClass}>End Date</label><input type="text" name="expEndDate" value={exp.endDate} onChange={e => updateItem(setExperience, i, 'endDate', e.target.value)} className={inputClass} placeholder="Present" /></div>
                                                            </div>
                                                            <div className="mt-4"><label className={labelClass}>Description</label><textarea name="expDescription" rows="3" value={exp.description} onChange={e => updateItem(setExperience, i, 'description', e.target.value)} className={inputClass} placeholder="Describe your responsibilities and achievements..."></textarea></div>
                                                        </div>
                                                    ))}
                                                </div>
                                            </div>

                                            {/* Step 3: Skills */}
                                            <div style={{ display: step === 3 ? 'block' : 'none' }}>
                                                <div className="glass rounded-2xl p-8">
                                                    <div className="flex justify-between items-center mb-6">
                                                        <h2 className="text-xl font-bold flex items-center gap-2">
                                                            <svg className="w-6 h-6 text-brand-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" /></svg>
                                                            Skills
                                                        </h2>
                                                        <button type="button" onClick={() => addItem(setSkills, { skillName: '', proficiency: 'Intermediate' })}
                                                            className="text-sm px-4 py-2 bg-brand-500/20 text-brand-300 rounded-lg hover:bg-brand-500/30 transition flex items-center gap-1">
                                                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" /></svg> Add
                                                        </button>
                                                    </div>
                                                    {skills.map((skill, i) => (
                                                        <div key={i} className="mb-4 flex items-end gap-4">
                                                            <div className="flex-1">
                                                                <label className={labelClass}>Skill Name</label>
                                                                <input type="text" name="skillName" value={skill.skillName} onChange={e => updateItem(setSkills, i, 'skillName', e.target.value)} className={inputClass} placeholder="JavaScript, Python, etc." />
                                                            </div>
                                                            <div className="w-40">
                                                                <label className={labelClass}>Level</label>
                                                                <select name="proficiency" value={skill.proficiency} onChange={e => updateItem(setSkills, i, 'proficiency', e.target.value)} className={inputClass}>
                                                                    <option value="Beginner">Beginner</option>
                                                                    <option value="Intermediate">Intermediate</option>
                                                                    <option value="Advanced">Advanced</option>
                                                                    <option value="Expert">Expert</option>
                                                                </select>
                                                            </div>
                                                            {skills.length > 1 && (
                                                                <button type="button" onClick={() => removeItem(setSkills, i)} className="pb-3 text-red-400 hover:text-red-300">
                                                                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>
                                                                </button>
                                                            )}
                                                        </div>
                                                    ))}
                                                </div>
                                            </div>

                                            {/* Step 4: Projects */}
                                            <div style={{ display: step === 4 ? 'block' : 'none' }}>
                                                <div className="glass rounded-2xl p-8">
                                                    <div className="flex justify-between items-center mb-6">
                                                        <h2 className="text-xl font-bold flex items-center gap-2">
                                                            <svg className="w-6 h-6 text-brand-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" /></svg>
                                                            Projects
                                                        </h2>
                                                        <button type="button" onClick={() => addItem(setProjects, { projectName: '', description: '', technologies: '', url: '' })}
                                                            className="text-sm px-4 py-2 bg-brand-500/20 text-brand-300 rounded-lg hover:bg-brand-500/30 transition flex items-center gap-1">
                                                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" /></svg> Add
                                                        </button>
                                                    </div>
                                                    {projects.map((proj, i) => (
                                                        <div key={i} className="mb-6 p-5 bg-white/5 rounded-xl border border-white/5 relative">
                                                            {projects.length > 1 && (
                                                                <button type="button" onClick={() => removeItem(setProjects, i)} className="absolute top-3 right-3 text-red-400 hover:text-red-300">
                                                                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>
                                                                </button>
                                                            )}
                                                            <div className="grid md:grid-cols-2 gap-4">
                                                                <div><label className={labelClass}>Project Name *</label><input type="text" name="projectName" value={proj.projectName} onChange={e => updateItem(setProjects, i, 'projectName', e.target.value)} className={inputClass} placeholder="Project Name" /></div>
                                                                <div><label className={labelClass}>Technologies</label><input type="text" name="technologies" value={proj.technologies} onChange={e => updateItem(setProjects, i, 'technologies', e.target.value)} className={inputClass} placeholder="React, Node.js, etc." /></div>
                                                            </div>
                                                            <div className="mt-4"><label className={labelClass}>Description</label><textarea name="projDescription" rows="2" value={proj.description} onChange={e => updateItem(setProjects, i, 'description', e.target.value)} className={inputClass} placeholder="What this project does..."></textarea></div>
                                                            <div className="mt-4"><label className={labelClass}>URL</label><input type="url" name="projectUrl" value={proj.url} onChange={e => updateItem(setProjects, i, 'url', e.target.value)} className={inputClass} placeholder="https://github.com/..." /></div>
                                                        </div>
                                                    ))}
                                                </div>
                                            </div>

                                            {/* Navigation Buttons */}
                                            <div className="flex justify-between mt-8">
                                                <button type="button" onClick={() => setStep(Math.max(0, step - 1))}
                                                    className={`px-6 py-3 rounded-xl font-medium transition-all ${step === 0 ? 'invisible' : 'glass hover:bg-white/10'}`}>
                                                    Previous
                                                </button>
                                                {step < steps.length - 1 ? (
                                                    <button type="button" onClick={() => setStep(step + 1)}
                                                        className="px-6 py-3 bg-gradient-to-r from-brand-500 to-brand-700 rounded-xl font-medium hover:shadow-lg hover:shadow-brand-500/25 transition-all">
                                                        Next Step
                                                    </button>
                                                ) : (
                                                    <button type="submit" disabled={loading}
                                                        className="px-8 py-3 bg-gradient-to-r from-emerald-500 to-emerald-700 rounded-xl font-semibold hover:shadow-lg hover:shadow-emerald-500/25 transition-all disabled:opacity-50 flex items-center gap-2">
                                                        {loading ? 'Saving...' : (isEdit ? 'Update Resume' : 'Create Resume')}
                                                    </button>
                                                )}
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            );
                        }

                    const root = ReactDOM.createRoot(document.getElementById('root'));
                    root.render(<ResumeForm />);
                </script>
            </body>

            </html>