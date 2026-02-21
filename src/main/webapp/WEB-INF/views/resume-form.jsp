<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.resumebuilder.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resume Builder - ResumeForge</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
        @keyframes gradient { 0% { background-position: 0% 50% } 50% { background-position: 100% 50% } 100% { background-position: 0% 50% } }
        .gradient-bg { background: linear-gradient(-45deg, #0f0a2a, #1e1b4b, #312e81, #3730a3); background-size: 400% 400%; animation: gradient 15s ease infinite; }
        .glass { background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(20px); border: 1px solid rgba(255, 255, 255, 0.1); }
        .glass-input { background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.1); }
        .glass-input:focus { border-color: #6366f1; background: rgba(255, 255, 255, 0.05); }
    </style>
</head>
<body class="font-sans">
    <div id="root"></div>
    <script type="text/babel">
        const { useState, useEffect } = React;

        function ResumeForm() {
            const contextPath = "<%= request.getContextPath() %>";
            <%
                Resume resume = (Resume) request.getAttribute("resume");
                List<Education> eduList = (List<Education>) request.getAttribute("educationList");
                List<Experience> expList = (List<Experience>) request.getAttribute("experienceList");
                List<Skill> skillList = (List<Skill>) request.getAttribute("skillList");
                List<Project> projList = (List<Project>) request.getAttribute("projectList");
                boolean isEdit = resume != null;
                
                String rJson = "null";
                String eJson = "[]", xJson = "[]", sJson = "[]", pJson = "[]";
                if (isEdit) {
                    rJson = "{\"id\":" + resume.getId() + ",\"title\":\"" + (resume.getTitle() != null ? resume.getTitle().replace("\"", "\\\"") : "") + "\",\"fullName\":\"" + (resume.getFullName() != null ? resume.getFullName().replace("\"", "\\\"") : "") + "\",\"email\":\"" + (resume.getEmail() != null ? resume.getEmail().replace("\"", "\\\"") : "") + "\",\"phone\":\"" + (resume.getPhone() != null ? resume.getPhone().replace("\"", "\\\"") : "") + "\",\"address\":\"" + (resume.getAddress() != null ? resume.getAddress().replace("\"", "\\\"") : "") + "\",\"summary\":\"" + (resume.getSummary() != null ? resume.getSummary().replace("\"", "\\\"").replace("\n", "\\n") : "") + "\",\"linkedin\":\"" + (resume.getLinkedin() != null ? resume.getLinkedin().replace("\"", "\\\"") : "") + "\",\"website\":\"" + (resume.getWebsite() != null ? resume.getWebsite().replace("\"", "\\\"") : "") + "\",\"template\":\"" + (resume.getTemplate() != null ? resume.getTemplate() : "modern") + "\"}";
                    
                    StringBuilder eb = new StringBuilder("[");
                    if (eduList != null) for (int i=0; i<eduList.size(); i++) {
                        Education ed = eduList.get(i); if (i>0) eb.append(",");
                        eb.append("{\"institution\":\"").append(ed.getInstitution() != null ? ed.getInstitution().replace("\"", "\\\"") : "").append("\",\"degree\":\"").append(ed.getDegree() != null ? ed.getDegree().replace("\"", "\\\"") : "").append("\",\"fieldOfStudy\":\"").append(ed.getFieldOfStudy() != null ? ed.getFieldOfStudy().replace("\"", "\\\"") : "").append("\",\"startDate\":\"").append(ed.getStartDate()).append("\",\"endDate\":\"").append(ed.getEndDate()).append("\",\"gpa\":\"").append(ed.getGpa()).append("\",\"description\":\"").append(ed.getDescription() != null ? ed.getDescription().replace("\"", "\\\"").replace("\n", "\\n") : "").append("\"}");
                    }
                    eb.append("]"); eJson = eb.toString();

                    StringBuilder xb = new StringBuilder("[");
                    if (expList != null) for (int i=0; i<expList.size(); i++) {
                        Experience ex = expList.get(i); if (i>0) xb.append(",");
                        xb.append("{\"company\":\"").append(ex.getCompany() != null ? ex.getCompany().replace("\"", "\\\"") : "").append("\",\"position\":\"").append(ex.getPosition() != null ? ex.getPosition().replace("\"", "\\\"") : "").append("\",\"startDate\":\"").append(ex.getStartDate()).append("\",\"endDate\":\"").append(ex.getEndDate()).append("\",\"description\":\"").append(ex.getDescription() != null ? ex.getDescription().replace("\"", "\\\"").replace("\n", "\\n") : "").append("\"}");
                    }
                    xb.append("]"); xJson = xb.toString();

                    StringBuilder sb = new StringBuilder("[");
                    if (skillList != null) for (int i=0; i<skillList.size(); i++) {
                        Skill sk = skillList.get(i); if (i>0) sb.append(",");
                        sb.append("{\"skillName\":\"").append(sk.getSkillName() != null ? sk.getSkillName().replace("\"", "\\\"") : "").append("\",\"proficiency\":\"").append(sk.getProficiency()).append("\"}");
                    }
                    sb.append("]"); sJson = sb.toString();

                    StringBuilder pb = new StringBuilder("[");
                    if (projList != null) for (int i=0; i<projList.size(); i++) {
                        Project pr = projList.get(i); if (i>0) pb.append(",");
                        pb.append("{\"projectName\":\"").append(pr.getProjectName() != null ? pr.getProjectName().replace("\"", "\\\"") : "").append("\",\"description\":\"").append(pr.getDescription() != null ? pr.getDescription().replace("\"", "\\\"").replace("\n", "\\n") : "").append("\",\"technologies\":\"").append(pr.getTechnologies() != null ? pr.getTechnologies().replace("\"", "\\\"") : "").append("\",\"url\":\"").append(pr.getUrl()).append("\"}");
                    }
                    pb.append("]"); pJson = pb.toString();
                }
            %>

            const isEdit = <%= isEdit %>;
            const initialData = <%= rJson %>;
            const [step, setStep] = useState(0);
            const steps = ['Personal', 'Education', 'Experience', 'Skills', 'Projects', 'Review'];

            // Form States
            const [title, setTitle] = useState(initialData?.title || '');
            const [fullName, setFullName] = useState(initialData?.fullName || '');
            const [email, setEmail] = useState(initialData?.email || '');
            const [phone, setPhone] = useState(initialData?.phone || '');
            const [address, setAddress] = useState(initialData?.address || '');
            const [summary, setSummary] = useState(initialData?.summary || '');
            const [linkedin, setLinkedin] = useState(initialData?.linkedin || '');
            const [website, setWebsite] = useState(initialData?.website || '');
            const [template, setTemplate] = useState(initialData?.template || 'modern');

            const [education, setEducation] = useState(isEdit ? <%= eJson %> : [{ institution: '', degree: '', fieldOfStudy: '', startDate: '', endDate: '', gpa: '', description: '' }]);
            const [experience, setExperience] = useState(isEdit ? <%= xJson %> : [{ company: '', position: '', startDate: '', endDate: '', description: '' }]);
            const [skills, setSkills] = useState(isEdit ? <%= sJson %> : [{ skillName: '', proficiency: 'Intermediate' }]);
            const [projects, setProjects] = useState(isEdit ? <%= pJson %> : [{ projectName: '', description: '', technologies: '', url: '' }]);

            const [loading, setLoading] = useState(false);

            const inputCls = "w-full px-4 py-3 glass-input rounded-xl text-white placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 transition";
            const labelCls = "block text-xs font-semibold text-gray-400 mb-2 uppercase tracking-widest";

            const addArr = (set) => set(prev => [...prev, {}]);
            const updateArr = (set, i, field, val) => set(prev => {
                const n = [...prev]; n[i] = { ...n[i], [field]: val }; return n;
            });
            const removeArr = (set, i) => set(prev => prev.filter((_, idx) => idx !== i));

            return (
                <div className="min-h-screen gradient-bg text-white pb-20">
                    <nav className="glass sticky top-0 z-50">
                        <div className="max-w-5xl mx-auto px-6 py-4 flex justify-between items-center">
                            <a href={contextPath + "/dashboard"} className="flex items-center gap-3">
                                <div className="w-8 h-8 bg-gradient-to-br from-brand-400 to-brand-600 rounded-lg flex items-center justify-center font-bold">R</div>
                                <span className="text-lg font-bold">ResumeForge</span>
                            </a>
                            <a href={contextPath + "/dashboard"} className="text-sm text-gray-400 hover:text-white transition">Exit Editor</a>
                        </div>
                    </nav>

                    <div className="max-w-4xl mx-auto px-6 py-10">
                        {/* Title Section */}
                        <div className="text-center mb-10">
                            <h1 className="text-3xl font-bold mb-2">{isEdit ? 'Update Resume' : 'Create New Resume'}</h1>
                            <p className="text-gray-400">Step {step + 1} of {steps.length}: {steps[step]}</p>
                        </div>

                        {/* Progress Bar */}
                        <div className="flex gap-2 mb-12">
                            {steps.map((s, i) => (
                                <div key={i} className={`h-1.5 flex-1 rounded-full transition-all duration-500 ${i <= step ? 'bg-brand-500 shadow-[0_0_10px_rgba(99,102,241,0.5)]' : 'bg-white/10'}`}></div>
                            ))}
                        </div>

                        <form method="POST" action={contextPath + "/resume-form"} className="glass rounded-3xl p-8 shadow-2xl">
                            {isEdit && <input type="hidden" name="resumeId" value={initialData.id} />}

                            {/* Step 0: Personal Info */}
                            {step === 0 && (
                                <div className="space-y-6 animate-fade-in">
                                    <div className="grid md:grid-cols-2 gap-6">
                                        <div className="md:col-span-2">
                                            <label className={labelCls}>Resume Title</label>
                                            <input type="text" name="title" value={title} onChange={e => setTitle(e.target.value)} className={inputCls} placeholder="e.g., Software Engineer - 2024" required />
                                        </div>
                                        <div>
                                            <label className={labelCls}>Full Name</label>
                                            <input type="text" name="fullName" value={fullName} onChange={e => setFullName(e.target.value)} className={inputCls} placeholder="John Doe" required />
                                        </div>
                                        <div>
                                            <label className={labelCls}>Email Address</label>
                                            <input type="email" name="resumeEmail" value={email} onChange={e => setEmail(e.target.value)} className={inputCls} placeholder="john@example.com" required />
                                        </div>
                                        <div>
                                            <label className={labelCls}>Phone Number</label>
                                            <input type="text" name="phone" value={phone} onChange={e => setPhone(e.target.value)} className={inputCls} placeholder="+250..." />
                                        </div>
                                        <div>
                                            <label className={labelCls}>Location</label>
                                            <input type="text" name="address" value={address} onChange={e => setAddress(e.target.value)} className={inputCls} placeholder="Kigali, Rwanda" />
                                        </div>
                                        <div>
                                            <label className={labelCls}>LinkedIn URL</label>
                                            <input type="text" name="linkedin" value={linkedin} onChange={e => setLinkedin(e.target.value)} className={inputCls} placeholder="linkedin.com/in/..." />
                                        </div>
                                        <div>
                                            <label className={labelCls}>Portfolio/Website</label>
                                            <input type="text" name="website" value={website} onChange={e => setWebsite(e.target.value)} className={inputCls} placeholder="yourportfolio.com" />
                                        </div>
                                        <div className="md:col-span-2">
                                            <label className={labelCls}>Professional Summary</label>
                                            <textarea name="summary" value={summary} onChange={e => setSummary(e.target.value)} rows="4" className={inputCls + " resize-none"} placeholder="Describe yourself..."></textarea>
                                        </div>
                                        <div>
                                            <label className={labelCls}>Choose Template</label>
                                            <select name="template" value={template} onChange={e => setTemplate(e.target.value)} className={inputCls}>
                                                <option value="modern">Modern</option>
                                                <option value="classic">Classic</option>
                                                <option value="minimal">Minimal</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            )}

                            {/* Step 1: Education */}
                            {step === 1 && (
                                <div className="space-y-6">
                                    <div className="flex justify-between items-center mb-4">
                                        <h3 className="text-xl font-bold">Education</h3>
                                        <button type="button" onClick={() => addArr(setEducation)} className="px-4 py-2 bg-brand-500 text-sm font-bold rounded-xl hover:bg-brand-600 transition">Add More</button>
                                    </div>
                                    {education.map((edu, i) => (
                                        <div key={i} className="p-6 bg-white/5 rounded-2xl border border-white/10 relative">
                                            {education.length > 1 && <button type="button" onClick={() => removeArr(setEducation, i)} className="absolute top-4 right-4 text-red-400 hover:text-red-300">Remove</button>}
                                            <div className="grid md:grid-cols-2 gap-4">
                                                <div className="md:col-span-2">
                                                    <label className={labelCls}>Institution</label>
                                                    <input type="text" name="institution" value={edu.institution || ''} onChange={e => updateArr(setEducation, i, 'institution', e.target.value)} className={inputCls} placeholder="University Name" />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>Degree</label>
                                                    <input type="text" name="degree" value={edu.degree || ''} onChange={e => updateArr(setEducation, i, 'degree', e.target.value)} className={inputCls} placeholder="e.g. Bachelor of Science" />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>Field of Study</label>
                                                    <input type="text" name="fieldOfStudy" value={edu.fieldOfStudy || ''} onChange={e => updateArr(setEducation, i, 'fieldOfStudy', e.target.value)} className={inputCls} placeholder="Computer Science" />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>Start Year</label>
                                                    <input type="text" name="eduStartDate" value={edu.startDate || ''} onChange={e => updateArr(setEducation, i, 'startDate', e.target.value)} className={inputCls} placeholder="2020" />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>End Year (or Present)</label>
                                                    <input type="text" name="eduEndDate" value={edu.endDate || ''} onChange={e => updateArr(setEducation, i, 'endDate', e.target.value)} className={inputCls} placeholder="2024" />
                                                </div>
                                                <div className="hidden">
                                                    <input type="hidden" name="gpa" value={edu.gpa || ''} />
                                                    <input type="hidden" name="eduDescription" value={edu.description || ''} />
                                                </div>
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            )}

                            {/* Step 2: Experience */}
                            {step === 2 && (
                                <div className="space-y-6">
                                    <div className="flex justify-between items-center mb-4">
                                        <h3 className="text-xl font-bold">Experience</h3>
                                        <button type="button" onClick={() => addArr(setExperience)} className="px-4 py-2 bg-brand-500 text-sm font-bold rounded-xl hover:bg-brand-600 transition">Add More</button>
                                    </div>
                                    {experience.map((exp, i) => (
                                        <div key={i} className="p-6 bg-white/5 rounded-2xl border border-white/10 relative">
                                            {experience.length > 1 && <button type="button" onClick={() => removeArr(setExperience, i)} className="absolute top-4 right-4 text-red-400 hover:text-red-300">Remove</button>}
                                            <div className="grid md:grid-cols-2 gap-4">
                                                <div>
                                                    <label className={labelCls}>Company</label>
                                                    <input type="text" name="company" value={exp.company || ''} onChange={e => updateArr(setExperience, i, 'company', e.target.value)} className={inputCls} placeholder="Company Name" />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>Position</label>
                                                    <input type="text" name="position" value={exp.position || ''} onChange={e => updateArr(setExperience, i, 'position', e.target.value)} className={inputCls} placeholder="Software Engineer" />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>Start Date</label>
                                                    <input type="text" name="expStartDate" value={exp.startDate || ''} onChange={e => updateArr(setExperience, i, 'startDate', e.target.value)} className={inputCls} placeholder="Jan 2022" />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>End Date</label>
                                                    <input type="text" name="expEndDate" value={exp.endDate || ''} onChange={e => updateArr(setExperience, i, 'endDate', e.target.value)} className={inputCls} placeholder="Present" />
                                                </div>
                                                <div className="md:col-span-2">
                                                    <label className={labelCls}>Description</label>
                                                    <textarea name="expDescription" value={exp.description || ''} onChange={e => updateArr(setExperience, i, 'description', e.target.value)} rows="3" className={inputCls + " resize-none"} placeholder="What did you do there?"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            )}

                            {/* Step 3: Skills */}
                            {step === 3 && (
                                <div className="space-y-6">
                                    <div className="flex justify-between items-center mb-4">
                                        <h3 className="text-xl font-bold">Skills</h3>
                                        <button type="button" onClick={() => addArr(setSkills)} className="px-4 py-2 bg-brand-500 text-sm font-bold rounded-xl hover:bg-brand-600 transition">Add More</button>
                                    </div>
                                    <div className="grid md:grid-cols-2 gap-4">
                                        {skills.map((sk, i) => (
                                            <div key={i} className="p-4 bg-white/5 rounded-2xl border border-white/10 relative flex gap-3">
                                                {skills.length > 1 && <button type="button" onClick={() => removeArr(setSkills, i)} className="text-red-400 hover:text-red-300">×</button>}
                                                <div className="flex-1">
                                                    <label className={labelCls}>Skill</label>
                                                    <input type="text" name="skillName" value={sk.skillName || ''} onChange={e => updateArr(setSkills, i, 'skillName', e.target.value)} className={inputCls} placeholder="Java" />
                                                </div>
                                                <div className="w-1/3">
                                                    <label className={labelCls}>Level</label>
                                                    <select name="proficiency" value={sk.proficiency || 'Intermediate'} onChange={e => updateArr(setSkills, i, 'proficiency', e.target.value)} className={inputCls}>
                                                        <option>Beginner</option>
                                                        <option>Intermediate</option>
                                                        <option>Advanced</option>
                                                        <option>Expert</option>
                                                    </select>
                                                </div>
                                            </div>
                                        ))}
                                    </div>
                                </div>
                            )}

                            {/* Step 4: Projects */}
                            {step === 4 && (
                                <div className="space-y-6">
                                    <div className="flex justify-between items-center mb-4">
                                        <h3 className="text-xl font-bold">Projects</h3>
                                        <button type="button" onClick={() => addArr(setProjects)} className="px-4 py-2 bg-brand-500 text-sm font-bold rounded-xl hover:bg-brand-600 transition">Add More</button>
                                    </div>
                                    {projects.map((pr, i) => (
                                        <div key={i} className="p-6 bg-white/5 rounded-2xl border border-white/10 relative">
                                            {projects.length > 1 && <button type="button" onClick={() => removeArr(setProjects, i)} className="absolute top-4 right-4 text-red-400 hover:text-red-300">Remove</button>}
                                            <div className="grid md:grid-cols-2 gap-4">
                                                <div>
                                                    <label className={labelCls}>Project Name</label>
                                                    <input type="text" name="projectName" value={pr.projectName || ''} onChange={e => updateArr(setProjects, i, 'projectName', e.target.value)} className={inputCls} placeholder="E-commerce App" />
                                                </div>
                                                <div>
                                                    <label className={labelCls}>Technologies</label>
                                                    <input type="text" name="technologies" value={pr.technologies || ''} onChange={e => updateArr(setProjects, i, 'technologies', e.target.value)} className={inputCls} placeholder="React, Node.js" />
                                                </div>
                                                <div className="md:col-span-2">
                                                    <label className={labelCls}>Project Link</label>
                                                    <input type="text" name="projectUrl" value={pr.url || ''} onChange={e => updateArr(setProjects, i, 'url', e.target.value)} className={inputCls} placeholder="github.com/..." />
                                                </div>
                                                <div className="md:col-span-2">
                                                    <label className={labelCls}>Description</label>
                                                    <textarea name="projectDescription" value={pr.description || ''} onChange={e => updateArr(setProjects, i, 'description', e.target.value)} rows="3" className={inputCls + " resize-none"} placeholder="What makes this project special?"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            )}

                            {/* Step 5: Review */}
                            {step === 5 && (
                                <div className="space-y-8 animate-fade-in">
                                    <div className="p-6 bg-emerald-500/10 border border-emerald-500/20 rounded-2xl text-center">
                                        <div className="w-16 h-16 bg-emerald-500/20 rounded-full flex items-center justify-center mx-auto mb-4">
                                            <svg className="w-8 h-8 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                                        </div>
                                        <h3 className="text-xl font-bold text-emerald-300">Ready to save!</h3>
                                        <p className="text-emerald-300/60 text-sm mt-1">Please review your information one last time. You can go back to any step by clicking the "Previous" button or the progress markers above.</p>
                                    </div>

                                    <div className="space-y-4">
                                        <div className="flex justify-between items-center py-3 border-b border-white/5">
                                            <span className="text-gray-400 text-sm">Resume Title</span>
                                            <span className="font-medium">{title}</span>
                                        </div>
                                        <div className="flex justify-between items-center py-3 border-b border-white/5">
                                            <span className="text-gray-400 text-sm">Full Name</span>
                                            <span className="font-medium">{fullName}</span>
                                        </div>
                                        <div className="flex justify-between items-center py-3 border-b border-white/5">
                                            <span className="text-gray-400 text-sm">Template</span>
                                            <span className="font-medium capitalize">{template}</span>
                                        </div>
                                        <div className="flex justify-between items-center py-3 border-b border-white/5">
                                            <span className="text-gray-400 text-sm">Sections</span>
                                            <span className="font-medium">{education.length} Edu, {experience.length} Exp, {skills.length} Skill</span>
                                        </div>
                                    </div>

                                    <div className="p-4 bg-brand-500/5 rounded-xl border border-brand-500/10 text-xs text-brand-300/80 leading-relaxed italic">
                                        Tip: Clicking "{isEdit ? 'Update' : 'Create'}" will finalize your data and generate your professional resume. You can still edit it later from your dashboard.
                                    </div>
                                </div>
                            )}

                            {/* Footer Navigation */}
                            <div className="mt-12 flex justify-between items-center">
                                <div className="flex gap-4">
                                    <button type="button" onClick={() => setStep(prev => Math.max(0, prev - 1))} className={`px-6 py-3 bg-white/5 border border-white/10 rounded-xl font-semibold hover:bg-white/10 transition-all ${step === 0 ? 'hidden' : ''}`}>
                                        Previous
                                    </button>
                                    <a href={contextPath + "/dashboard"} className="px-6 py-3 bg-red-500/10 text-red-400 border border-red-500/20 rounded-xl font-semibold hover:bg-red-500/20 transition-all">
                                        Cancel
                                    </a>
                                </div>

                                {step < steps.length - 1 ? (
                                    <button type="button" onClick={() => setStep(prev => prev + 1)} className="px-8 py-3 bg-brand-500 rounded-xl font-bold hover:bg-brand-600 transition-all shadow-lg shadow-brand-500/20">
                                        Next
                                    </button>
                                ) : (
                                    <button type="submit" onClick={() => setLoading(true)} className="px-10 py-3 bg-emerald-500 rounded-xl font-black hover:bg-emerald-600 transition-all shadow-lg shadow-emerald-500/20 uppercase tracking-widest">
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