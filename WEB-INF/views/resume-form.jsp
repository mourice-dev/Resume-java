<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.resumebuilder.model.*" %>
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
                        Resume resume = (Resume) request.getAttribute("resume");
                    List < Education > eduList = (List < Education >) request.getAttribute("educationList");
                    List < Experience > expList = (List < Experience >) request.getAttribute("experienceList");
                    List < Skill > skillList = (List < Skill >) request.getAttribute("skillList");
                    List < Project > projList = (List < Project >) request.getAttribute("projectList");
        boolean isEdit = resume != null;

        String resumeJson = "null";
        String eduJson = "[]", expJson = "[]", skillJson = "[]", projJson = "[]";
                    if (isEdit) {
            StringBuilder sb = new StringBuilder("{");
                        sb.append("\"id\":").append(resume.getId());
                        sb.append(",\"title\":\"").append(resume.getTitle() != null ? resume.getTitle().replace("\\", "\\\\").replace("\"", "\\\"") : "");
                        sb.append("\",\"fullName\":\"").append(resume.getFullName() != null ? resume.getFullName().replace("\\", "\\\\").replace("\"", "\\\"") : "");
                        sb.append("\",\"email\":\"").append(resume.getEmail() != null ? resume.getEmail().replace("\\", "\\\\").replace("\"", "\\\"") : "");
                        sb.append("\",\"phone\":\"").append(resume.getPhone() != null ? resume.getPhone().replace("\\", "\\\\").replace("\"", "\\\"") : "");
                        sb.append("\",\"address\":\"").append(resume.getAddress() != null ? resume.getAddress().replace("\\", "\\\\").replace("\"", "\\\"") : "");
                        sb.append("\",\"summary\":\"").append(resume.getSummary() != null ? resume.getSummary().replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") : "");
                        sb.append("\",\"linkedin\":\"").append(resume.getLinkedin() != null ? resume.getLinkedin().replace("\\", "\\\\").replace("\"", "\\\"") : "");
                        sb.append("\",\"website\":\"").append(resume.getWebsite() != null ? resume.getWebsite().replace("\\", "\\\\").replace("\"", "\\\"") : "");
                        sb.append("\",\"template\":\"").append(resume.getTemplate() != null ? resume.getTemplate() : "modern");
                        sb.append("\"}");
                        resumeJson = sb.toString();

            StringBuilder esb = new StringBuilder("[");
                        if (eduList != null) {
                            for (int i = 0; i < eduList.size(); i++) { Education e = eduList.get(i); if (i > 0) esb.append(",");
                                esb.append("{\"institution\":\"").append(e.getInstitution() != null ? e.getInstitution().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"degree\":\"").append(e.getDegree() != null ? e.getDegree().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"fieldOfStudy\":\"").append(e.getFieldOfStudy() != null ? e.getFieldOfStudy().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"startDate\":\"").append(e.getStartDate() != null ? e.getStartDate() : "")
                                    .append("\",\"endDate\":\"").append(e.getEndDate() != null ? e.getEndDate() : "")
                                    .append("\",\"gpa\":\"").append(e.getGpa() != null ? e.getGpa() : "")
                                    .append("\",\"description\":\"").append(e.getDescription() != null ? e.getDescription().replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") : "").append("\"}");
                            }
                        } esb.append("]"); eduJson = esb.toString();

            StringBuilder xsb = new StringBuilder("[");
                        if (expList != null) {
                            for (int i = 0; i < expList.size(); i++) { Experience e = expList.get(i); if (i > 0) xsb.append(",");
                                xsb.append("{\"company\":\"").append(e.getCompany() != null ? e.getCompany().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"position\":\"").append(e.getPosition() != null ? e.getPosition().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"startDate\":\"").append(e.getStartDate() != null ? e.getStartDate() : "")
                                    .append("\",\"endDate\":\"").append(e.getEndDate() != null ? e.getEndDate() : "")
                                    .append("\",\"description\":\"").append(e.getDescription() != null ? e.getDescription().replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") : "").append("\"}");
                            }
                        } xsb.append("]"); expJson = xsb.toString();

            StringBuilder ssb = new StringBuilder("[");
                        if (skillList != null) {
                            for (int i = 0; i < skillList.size(); i++) { Skill s = skillList.get(i); if (i > 0) ssb.append(",");
                                ssb.append("{\"skillName\":\"").append(s.getSkillName() != null ? s.getSkillName().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"proficiency\":\"").append(s.getProficiency() != null ? s.getProficiency() : "Intermediate").append("\"}");
                            }
                        } ssb.append("]"); skillJson = ssb.toString();

            StringBuilder psb = new StringBuilder("[");
                        if (projList != null) {
                            for (int i = 0; i < projList.size(); i++) { Project p = projList.get(i); if (i > 0) psb.append(",");
                                psb.append("{\"projectName\":\"").append(p.getProjectName() != null ? p.getProjectName().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"description\":\"").append(p.getDescription() != null ? p.getDescription().replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "") : "")
                                    .append("\",\"technologies\":\"").append(p.getTechnologies() != null ? p.getTechnologies().replace("\\", "\\\\").replace("\"", "\\\"") : "")
                                    .append("\",\"url\":\"").append(p.getUrl() != null ? p.getUrl().replace("\\", "\\\\").replace("\"", "\\\"") : "").append("\"}");
                            }
                        } psb.append("]"); projJson = psb.toString();
                    }
        %>

                        // Cookie helper
                        function setCookie(name, value, days) {
                            const d = new Date(); d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
                            document.cookie = name + "=" + encodeURIComponent(value) + ";expires=" + d.toUTCString() + ";path=/";
                        }
                    function getCookie(name) {
                        const v = document.cookie.match('(^|;)\\s*' + name + '\\s*=\\s*([^;]+)');
                        return v ? decodeURIComponent(v.pop()) : '';
                    }

                    function App() {
                        const ctx = "<%= request.getContextPath() %>";
                        const isEdit = <%= isEdit %>;
                        const editResume = <%= resumeJson %>;

                        const [step, setStep] = React.useState(1);
                        const totalSteps = 6;
                        const stepLabels = ["Personal", "Education", "Experience", "Skills", "Projects", "Review"];

                        // Cookie hint state
                        const savedName = getCookie('rf_fullName');
                        const savedEmail = getCookie('rf_email');
                        const savedPhone = getCookie('rf_phone');
                        const savedAddress = getCookie('rf_address');
                        const savedLinkedin = getCookie('rf_linkedin');
                        const savedWebsite = getCookie('rf_website');
                        const hasSaved = !isEdit && (savedName || savedEmail || savedPhone);
                        const [showHint, setShowHint] = React.useState(hasSaved);
                        const [hintApplied, setHintApplied] = React.useState(false);

                        // Form state
                        const [title, setTitle] = React.useState(isEdit ? editResume.title : "");
                        const [fullName, setFullName] = React.useState(isEdit ? editResume.fullName : "");
                        const [email, setEmail] = React.useState(isEdit ? editResume.email : "");
                        const [phone, setPhone] = React.useState(isEdit ? editResume.phone : "");
                        const [address, setAddress] = React.useState(isEdit ? editResume.address : "");
                        const [summary, setSummary] = React.useState(isEdit ? editResume.summary : "");
                        const [linkedin, setLinkedin] = React.useState(isEdit ? editResume.linkedin : "");
                        const [website, setWebsite] = React.useState(isEdit ? editResume.website : "");
                        const [template, setTemplate] = React.useState(isEdit ? editResume.template : "modern");

                        const emptyEdu = { institution: '', degree: '', fieldOfStudy: '', startDate: '', endDate: '', gpa: '', description: '' };
                        const emptyExp = { company: '', position: '', startDate: '', endDate: '', description: '' };
                        const emptySkill = { skillName: '', proficiency: 'Intermediate' };
                        const emptyProj = { projectName: '', description: '', technologies: '', url: '' };

                        const [education, setEducation] = React.useState(isEdit && <%= eduJson %>.length > 0 ? <%= eduJson %> : [{ ...emptyEdu }]);
                        const [experience, setExperience] = React.useState(isEdit && <%= expJson %>.length > 0 ? <%= expJson %> : [{ ...emptyExp }]);
                        const [skills, setSkills] = React.useState(isEdit && <%= skillJson %>.length > 0 ? <%= skillJson %> : [{ ...emptySkill }]);
                        const [projects, setProjects] = React.useState(isEdit && <%= projJson %>.length > 0 ? <%= projJson %> : [{ ...emptyProj }]);

                        const [saving, setSaving] = React.useState(false);

                        const inputCls = "w-full px-4 py-2.5 bg-white border border-zinc-200 rounded-lg text-sm focus:outline-none focus:border-black focus:ring-1 focus:ring-black transition placeholder-zinc-400 text-zinc-900";
                        const labelCls = "block text-xs font-semibold text-zinc-600 mb-1.5 uppercase tracking-wide";
                        const btnSecondary = "px-6 py-3 bg-white border border-zinc-200 text-zinc-700 font-medium rounded-lg hover:bg-zinc-50 hover:border-zinc-300 transition shadow-sm text-sm";
                        const btnPrimary = "px-6 py-3 bg-black text-white font-medium rounded-lg hover:bg-zinc-800 transition shadow-lg shadow-black/10 text-sm";

                        const updateArr = (arr, setArr, i, field, value) => { const u = [...arr]; u[i] = { ...u[i], [field]: value }; setArr(u); };
                        const addItem = (arr, setArr, empty) => setArr([...arr, { ...empty }]);
                        const removeItem = (arr, setArr, i) => { if (arr.length > 1) { const u = [...arr]; u.splice(i, 1); setArr(u); } };

                        // Apply saved cookie data
                        const applySaved = () => {
                            if (savedName && !fullName) setFullName(savedName);
                            if (savedEmail && !email) setEmail(savedEmail);
                            if (savedPhone && !phone) setPhone(savedPhone);
                            if (savedAddress && !address) setAddress(savedAddress);
                            if (savedLinkedin && !linkedin) setLinkedin(savedLinkedin);
                            if (savedWebsite && !website) setWebsite(savedWebsite);
                            setHintApplied(true);
                            setShowHint(false);
                        };

                        // Auto-save to localStorage every 30s
                        React.useEffect(() => {
                            const key = 'rf_draft_' + (isEdit ? editResume.id : 'new');
                            // Restore draft on first load (only for new resumes)
                            if (!isEdit) {
                                try {
                                    const draft = JSON.parse(localStorage.getItem(key));
                                    if (draft && !title && !fullName) {
                                        setTitle(draft.title || ''); setFullName(draft.fullName || '');
                                        setEmail(draft.email || ''); setPhone(draft.phone || '');
                                        setAddress(draft.address || ''); setSummary(draft.summary || '');
                                    }
                                } catch (e) { }
                            }
                            const timer = setInterval(() => {
                                const draft = { title, fullName, email, phone, address, summary };
                                localStorage.setItem(key, JSON.stringify(draft));
                            }, 30000);
                            return () => clearInterval(timer);
                        }, [title, fullName, email, phone, address, summary]);

                        // Save cookies on submit
                        const handleSubmit = (e) => {
                            setSaving(true);
                            setCookie('rf_fullName', fullName, 90);
                            setCookie('rf_email', email, 90);
                            setCookie('rf_phone', phone, 90);
                            setCookie('rf_address', address, 90);
                            setCookie('rf_linkedin', linkedin, 90);
                            setCookie('rf_website', website, 90);
                            // Clear draft
                            localStorage.removeItem('rf_draft_' + (isEdit ? editResume.id : 'new'));
                        };

                        // Keyboard shortcuts
                        React.useEffect(() => {
                            const handler = (e) => {
                                if (e.ctrlKey && e.key === 'ArrowRight' && step < totalSteps) { e.preventDefault(); setStep(step + 1); }
                                if (e.ctrlKey && e.key === 'ArrowLeft' && step > 1) { e.preventDefault(); setStep(step - 1); }
                            };
                            window.addEventListener('keydown', handler);
                            return () => window.removeEventListener('keydown', handler);
                        }, [step]);

                        // Completion calculation
                        const calcCompletion = () => {
                            let filled = 0, total = 8;
                            if (title) filled++; if (fullName) filled++; if (email) filled++; if (phone) filled++;
                            if (address) filled++; if (summary) filled++;
                            if (education.some(e => e.institution)) filled++;
                            if (skills.some(s => s.skillName)) filled++;
                            return Math.round((filled / total) * 100);
                        };

                        // Review section component
                        const ReviewSection = ({ title: t, children }) => (
                            <div className="mb-5">
                                <h3 className="text-xs font-bold uppercase tracking-widest text-zinc-400 border-b border-zinc-200 pb-1 mb-2">{t}</h3>
                                {children}
                            </div>
                        );

                        return (
                            <div className="min-h-screen pb-20">
                                <nav className="bg-white border-b border-zinc-200 sticky top-0 z-50">
                                    <div className="max-w-4xl mx-auto px-6 py-4 flex justify-between items-center">
                                        <a href={ctx + "/dashboard"} className="flex items-center gap-3 group">
                                            <div className="w-8 h-8 bg-black text-white rounded flex items-center justify-center font-bold text-sm">R</div>
                                            <span className="text-lg font-bold text-black">ResumeForge</span>
                                        </a>
                                        <div className="flex items-center gap-3">
                                            <span className="text-xs text-zinc-400">Ctrl+← → to navigate</span>
                                            <a href={ctx + "/dashboard"} className="text-sm font-medium text-zinc-500 hover:text-black transition">Cancel</a>
                                        </div>
                                    </div>
                                </nav>

                                <div className="max-w-4xl mx-auto px-6 py-10">
                                    {/* Cookie Hint Banner */}
                                    {showHint && !hintApplied && (
                                        <div className="mb-6 bg-zinc-900 text-white rounded-xl p-4 flex justify-between items-center shadow-lg animate-fade-in">
                                            <div className="flex items-center gap-3">
                                                <span className="text-lg">💡</span>
                                                <div>
                                                    <p className="font-semibold text-sm">Welcome back, {savedName || 'there'}!</p>
                                                    <p className="text-zinc-400 text-xs">We have your saved info from a previous resume. Use it?</p>
                                                </div>
                                            </div>
                                            <div className="flex gap-2">
                                                <button onClick={applySaved} className="px-4 py-2 bg-white text-black text-xs font-bold rounded-lg hover:bg-zinc-100 transition">Auto-fill</button>
                                                <button onClick={() => setShowHint(false)} className="px-4 py-2 text-zinc-400 text-xs hover:text-white transition">No thanks</button>
                                            </div>
                                        </div>
                                    )}

                                    <div className="mb-8 text-center">
                                        <h1 className="text-3xl font-bold mb-2 tracking-tight text-black">{isEdit ? "Update Your Resume" : "Create New Resume"}</h1>
                                        <p className="text-zinc-500">{isEdit ? "Refine your credentials." : "Let's build your professional profile."}</p>
                                        <div className="mt-3 flex items-center justify-center gap-2">
                                            <div className="w-32 h-1.5 bg-zinc-200 rounded-full overflow-hidden">
                                                <div className="h-full bg-black rounded-full transition-all" style={{ width: calcCompletion() + '%' }}></div>
                                            </div>
                                            <span className="text-xs text-zinc-500 font-medium">{calcCompletion()}% complete</span>
                                        </div>
                                    </div>

                                    {/* Step Indicator */}
                                    <div className="flex justify-center mb-10 overflow-x-auto">
                                        <div className="flex items-center gap-2">
                                            {stepLabels.map((label, i) => (
                                                <React.Fragment key={i}>
                                                    <button onClick={() => setStep(i + 1)}
                                                        className={"flex items-center gap-1.5 px-2.5 py-1.5 rounded-full text-xs font-medium transition " +
                                                            (step === i + 1 ? "bg-black text-white" : step > i + 1 ? "bg-zinc-100 text-zinc-700" : "text-zinc-400 hover:text-zinc-600")}>
                                                        <span className={"w-5 h-5 rounded-full flex items-center justify-center text-[10px] font-bold " +
                                                            (step === i + 1 ? "bg-white text-black" : step > i + 1 ? "bg-zinc-300 text-white" : "bg-zinc-100 text-zinc-400")}>
                                                            {step > i + 1 ? "✓" : i + 1}
                                                        </span>
                                                        <span className="hidden sm:inline">{label}</span>
                                                    </button>
                                                    {i < 5 && <div className={"w-3 h-px " + (step > i + 1 ? "bg-zinc-300" : "bg-zinc-100")}></div>}
                                                </React.Fragment>
                                            ))}
                                        </div>
                                    </div>

                                    <form method="POST" action={ctx + "/resume-form"} onSubmit={handleSubmit}>
                                        {isEdit && <input type="hidden" name="resumeId" value={editResume.id} />}

                                        <div className="bg-white border border-zinc-200 rounded-xl shadow-sm p-8 min-h-[400px]">

                                            {/* Step 1: Personal Info */}
                                            <div style={{ display: step === 1 ? 'block' : 'none' }}>
                                                <h2 className="text-xl font-bold mb-6 flex items-center gap-2">
                                                    <span className="w-8 h-8 rounded-lg bg-zinc-100 text-black flex items-center justify-center text-sm font-bold">1</span>
                                                    Personal Information
                                                </h2>
                                                <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                                                    <div className="md:col-span-2"><label className={labelCls}>Resume Title</label><input type="text" name="title" value={title} onChange={e => setTitle(e.target.value)} className={inputCls} placeholder="e.g. Senior Software Engineer" required autoFocus /></div>
                                                    <div><label className={labelCls}>Full Name</label><input type="text" name="fullName" value={fullName} onChange={e => setFullName(e.target.value)} className={inputCls} placeholder="Jean Claude Mugabo" required /></div>
                                                    <div><label className={labelCls}>Email</label><input type="email" name="resumeEmail" value={email} onChange={e => setEmail(e.target.value)} className={inputCls} placeholder="jcmugabo@gmail.com" required /></div>
                                                    <div><label className={labelCls}>Phone</label><input type="text" name="phone" value={phone} onChange={e => setPhone(e.target.value)} className={inputCls} placeholder="+250 788 123 456" /></div>
                                                    <div><label className={labelCls}>Address</label><input type="text" name="address" value={address} onChange={e => setAddress(e.target.value)} className={inputCls} placeholder="Kigali, Rwanda" /></div>
                                                    <div><label className={labelCls}>LinkedIn</label><input type="text" name="linkedin" value={linkedin} onChange={e => setLinkedin(e.target.value)} className={inputCls} placeholder="linkedin.com/in/yourname" /></div>
                                                    <div><label className={labelCls}>Website</label><input type="text" name="website" value={website} onChange={e => setWebsite(e.target.value)} className={inputCls} placeholder="yourwebsite.com" /></div>
                                                    <div className="md:col-span-2"><label className={labelCls}>Professional Summary</label><textarea name="summary" value={summary} onChange={e => setSummary(e.target.value)} className={inputCls + " h-32 resize-none"} placeholder="Write a compelling summary of your professional background..." /></div>
                                                    <div><label className={labelCls}>Template Style</label>
                                                        <select name="template" value={template} onChange={e => setTemplate(e.target.value)} className={inputCls}>
                                                            <option value="modern">Modern Professional</option><option value="classic">Classic Serif</option><option value="minimal">Minimalist</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            {/* Step 2: Education */}
                                            <div style={{ display: step === 2 ? 'block' : 'none' }}>
                                                <div className="flex justify-between items-center mb-6">
                                                    <h2 className="text-xl font-bold flex items-center gap-2"><span className="w-8 h-8 rounded-lg bg-zinc-100 text-black flex items-center justify-center text-sm font-bold">2</span>Education</h2>
                                                    <button type="button" onClick={() => addItem(education, setEducation, emptyEdu)} className="text-xs font-bold uppercase tracking-wide text-black hover:text-zinc-600 border border-zinc-200 hover:border-zinc-300 px-3 py-1.5 rounded transition">+ Add</button>
                                                </div>
                                                {education.map((edu, i) => (
                                                    <div key={i} className="mb-6 p-6 bg-zinc-50 border border-zinc-200 rounded-xl relative">
                                                        {education.length > 1 && <button type="button" onClick={() => removeItem(education, setEducation, i)} className="absolute top-4 right-4 text-zinc-400 hover:text-red-500 transition"><svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg></button>}
                                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                                            <div><label className={labelCls}>Institution</label><input type="text" name="institution" value={edu.institution} onChange={e => updateArr(education, setEducation, i, 'institution', e.target.value)} className={inputCls} placeholder="University of Rwanda" /></div>
                                                            <div><label className={labelCls}>Degree</label><input type="text" name="degree" value={edu.degree} onChange={e => updateArr(education, setEducation, i, 'degree', e.target.value)} className={inputCls} placeholder="Bachelor of Science" /></div>
                                                            <div><label className={labelCls}>Field of Study</label><input type="text" name="fieldOfStudy" value={edu.fieldOfStudy} onChange={e => updateArr(education, setEducation, i, 'fieldOfStudy', e.target.value)} className={inputCls} placeholder="Computer Science" /></div>
                                                            <div><label className={labelCls}>GPA</label><input type="text" name="gpa" value={edu.gpa} onChange={e => updateArr(education, setEducation, i, 'gpa', e.target.value)} className={inputCls} placeholder="3.8" /></div>
                                                            <div><label className={labelCls}>Start Date</label><input type="text" name="eduStartDate" value={edu.startDate} onChange={e => updateArr(education, setEducation, i, 'startDate', e.target.value)} className={inputCls} placeholder="2016" /></div>
                                                            <div><label className={labelCls}>End Date</label><input type="text" name="eduEndDate" value={edu.endDate} onChange={e => updateArr(education, setEducation, i, 'endDate', e.target.value)} className={inputCls} placeholder="2020" /></div>
                                                        </div>
                                                    </div>
                                                ))}
                                            </div>

                                            {/* Step 3: Experience */}
                                            <div style={{ display: step === 3 ? 'block' : 'none' }}>
                                                <div className="flex justify-between items-center mb-6">
                                                    <h2 className="text-xl font-bold flex items-center gap-2"><span className="w-8 h-8 rounded-lg bg-zinc-100 text-black flex items-center justify-center text-sm font-bold">3</span>Work Experience</h2>
                                                    <button type="button" onClick={() => addItem(experience, setExperience, emptyExp)} className="text-xs font-bold uppercase tracking-wide text-black hover:text-zinc-600 border border-zinc-200 hover:border-zinc-300 px-3 py-1.5 rounded transition">+ Add</button>
                                                </div>
                                                {experience.map((exp, i) => (
                                                    <div key={i} className="mb-6 p-6 bg-zinc-50 border border-zinc-200 rounded-xl relative">
                                                        {experience.length > 1 && <button type="button" onClick={() => removeItem(experience, setExperience, i)} className="absolute top-4 right-4 text-zinc-400 hover:text-red-500 transition"><svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg></button>}
                                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                                            <div><label className={labelCls}>Company</label><input type="text" name="company" value={exp.company} onChange={e => updateArr(experience, setExperience, i, 'company', e.target.value)} className={inputCls} placeholder="Irembo Ltd" /></div>
                                                            <div><label className={labelCls}>Position</label><input type="text" name="position" value={exp.position} onChange={e => updateArr(experience, setExperience, i, 'position', e.target.value)} className={inputCls} placeholder="Software Engineer" /></div>
                                                            <div><label className={labelCls}>Start Date</label><input type="text" name="expStartDate" value={exp.startDate} onChange={e => updateArr(experience, setExperience, i, 'startDate', e.target.value)} className={inputCls} placeholder="2022" /></div>
                                                            <div><label className={labelCls}>End Date</label><input type="text" name="expEndDate" value={exp.endDate} onChange={e => updateArr(experience, setExperience, i, 'endDate', e.target.value)} className={inputCls} placeholder="Present" /></div>
                                                            <div className="md:col-span-2"><label className={labelCls}>Description</label><textarea name="expDescription" value={exp.description} onChange={e => updateArr(experience, setExperience, i, 'description', e.target.value)} className={inputCls + " h-24 resize-none"} placeholder="Describe your responsibilities..." /></div>
                                                        </div>
                                                    </div>
                                                ))}
                                            </div>

                                            {/* Step 4: Skills */}
                                            <div style={{ display: step === 4 ? 'block' : 'none' }}>
                                                <div className="flex justify-between items-center mb-6">
                                                    <h2 className="text-xl font-bold flex items-center gap-2"><span className="w-8 h-8 rounded-lg bg-zinc-100 text-black flex items-center justify-center text-sm font-bold">4</span>Skills</h2>
                                                    <button type="button" onClick={() => addItem(skills, setSkills, emptySkill)} className="text-xs font-bold uppercase tracking-wide text-black hover:text-zinc-600 border border-zinc-200 hover:border-zinc-300 px-3 py-1.5 rounded transition">+ Add</button>
                                                </div>
                                                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                                    {skills.map((s, i) => (
                                                        <div key={i} className="p-4 bg-zinc-50 border border-zinc-200 rounded-xl relative flex flex-col gap-2">
                                                            {skills.length > 1 && <button type="button" onClick={() => removeItem(skills, setSkills, i)} className="absolute top-3 right-3 text-zinc-400 hover:text-red-500 transition"><svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg></button>}
                                                            <div><label className={labelCls}>Skill Name</label><input type="text" name="skillName" value={s.skillName} onChange={e => updateArr(skills, setSkills, i, 'skillName', e.target.value)} className={inputCls} placeholder="Java" /></div>
                                                            <div><label className={labelCls}>Proficiency</label>
                                                                <select name="proficiency" value={s.proficiency} onChange={e => updateArr(skills, setSkills, i, 'proficiency', e.target.value)} className={inputCls}>
                                                                    <option>Beginner</option><option>Intermediate</option><option>Advanced</option><option>Expert</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    ))}
                                                </div>
                                            </div>

                                            {/* Step 5: Projects */}
                                            <div style={{ display: step === 5 ? 'block' : 'none' }}>
                                                <div className="flex justify-between items-center mb-6">
                                                    <h2 className="text-xl font-bold flex items-center gap-2"><span className="w-8 h-8 rounded-lg bg-zinc-100 text-black flex items-center justify-center text-sm font-bold">5</span>Key Projects</h2>
                                                    <button type="button" onClick={() => addItem(projects, setProjects, emptyProj)} className="text-xs font-bold uppercase tracking-wide text-black hover:text-zinc-600 border border-zinc-200 hover:border-zinc-300 px-3 py-1.5 rounded transition">+ Add</button>
                                                </div>
                                                {projects.map((p, i) => (
                                                    <div key={i} className="mb-6 p-6 bg-zinc-50 border border-zinc-200 rounded-xl relative">
                                                        {projects.length > 1 && <button type="button" onClick={() => removeItem(projects, setProjects, i)} className="absolute top-4 right-4 text-zinc-400 hover:text-red-500 transition"><svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg></button>}
                                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                                            <div><label className={labelCls}>Project Name</label><input type="text" name="projectName" value={p.projectName} onChange={e => updateArr(projects, setProjects, i, 'projectName', e.target.value)} className={inputCls} placeholder="Irembo Portal" /></div>
                                                            <div><label className={labelCls}>Technologies</label><input type="text" name="technologies" value={p.technologies} onChange={e => updateArr(projects, setProjects, i, 'technologies', e.target.value)} className={inputCls} placeholder="Spring Boot, React" /></div>
                                                            <div className="md:col-span-2"><label className={labelCls}>URL</label><input type="text" name="projectUrl" value={p.url} onChange={e => updateArr(projects, setProjects, i, 'url', e.target.value)} className={inputCls} placeholder="https://github.com/..." /></div>
                                                            <div className="md:col-span-2"><label className={labelCls}>Description</label><textarea name="projectDescription" value={p.description} onChange={e => updateArr(projects, setProjects, i, 'description', e.target.value)} className={inputCls + " h-20 resize-none"} placeholder="What did you build?" /></div>
                                                        </div>
                                                    </div>
                                                ))}
                                            </div>

                                            {/* Step 6: Review */}
                                            <div style={{ display: step === 6 ? 'block' : 'none' }}>
                                                <h2 className="text-xl font-bold mb-6 flex items-center gap-2">
                                                    <span className="w-8 h-8 rounded-lg bg-black text-white flex items-center justify-center text-sm font-bold">✓</span>
                                                    Review Your Resume
                                                </h2>
                                                <div className="border border-zinc-200 rounded-xl overflow-hidden">
                                                    {/* Mini Preview Header */}
                                                    <div className="bg-black text-white p-6">
                                                        <h3 className="text-2xl font-bold">{fullName || "Your Name"}</h3>
                                                        <p className="text-zinc-400 mt-0.5">{title || "Job Title"}</p>
                                                        <div className="flex flex-wrap gap-3 mt-3 text-xs text-zinc-400">
                                                            {email && <span>{email}</span>}
                                                            {phone && <span>• {phone}</span>}
                                                            {address && <span>• {address}</span>}
                                                        </div>
                                                    </div>
                                                    <div className="p-6 space-y-5">
                                                        {summary && <ReviewSection title="Summary"><p className="text-sm text-zinc-600">{summary}</p></ReviewSection>}

                                                        {experience.some(e => e.company) && (
                                                            <ReviewSection title="Experience">
                                                                {experience.filter(e => e.company).map((e, i) => (
                                                                    <div key={i} className="mb-3">
                                                                        <p className="font-semibold text-sm text-black">{e.position} <span className="font-normal text-zinc-500">at {e.company}</span></p>
                                                                        <p className="text-xs text-zinc-400">{e.startDate} – {e.endDate || 'Present'}</p>
                                                                    </div>
                                                                ))}
                                                            </ReviewSection>
                                                        )}

                                                        {education.some(e => e.institution) && (
                                                            <ReviewSection title="Education">
                                                                {education.filter(e => e.institution).map((e, i) => (
                                                                    <div key={i} className="mb-3">
                                                                        <p className="font-semibold text-sm text-black">{e.degree} {e.fieldOfStudy && "in " + e.fieldOfStudy}</p>
                                                                        <p className="text-xs text-zinc-500">{e.institution} • {e.startDate} – {e.endDate}</p>
                                                                    </div>
                                                                ))}
                                                            </ReviewSection>
                                                        )}

                                                        {skills.some(s => s.skillName) && (
                                                            <ReviewSection title="Skills">
                                                                <div className="flex flex-wrap gap-2">
                                                                    {skills.filter(s => s.skillName).map((s, i) => (
                                                                        <span key={i} className="px-2.5 py-1 bg-zinc-100 text-zinc-700 rounded text-xs font-medium">{s.skillName} ({s.proficiency})</span>
                                                                    ))}
                                                                </div>
                                                            </ReviewSection>
                                                        )}

                                                        {projects.some(p => p.projectName) && (
                                                            <ReviewSection title="Projects">
                                                                {projects.filter(p => p.projectName).map((p, i) => (
                                                                    <div key={i} className="mb-3">
                                                                        <p className="font-semibold text-sm text-black">{p.projectName}</p>
                                                                        {p.technologies && <p className="text-xs text-zinc-400">{p.technologies}</p>}
                                                                    </div>
                                                                ))}
                                                            </ReviewSection>
                                                        )}
                                                    </div>
                                                </div>
                                                <div className="mt-4 p-4 bg-zinc-50 rounded-xl border border-zinc-200 text-center">
                                                    <p className="text-sm text-zinc-600">Everything look good? Click <strong>"{isEdit ? "Save Changes" : "Create Resume"}"</strong> below to submit.</p>
                                                    <p className="text-xs text-zinc-400 mt-1">You'll be redirected to the full preview where you can download PDF or DOCX.</p>
                                                </div>
                                            </div>

                                        </div>

                                        {/* Navigation */}
                                        <div className="flex justify-between mt-8">
                                            <button type="button" onClick={() => setStep(Math.max(1, step - 1))} disabled={step === 1}
                                                className={"transition " + (step === 1 ? "opacity-0 pointer-events-none" : "opacity-100") + " " + btnSecondary}>
                                                ← Previous
                                            </button>

                                            {step < totalSteps ? (
                                                <button type="button" onClick={() => setStep(step + 1)} className={btnPrimary}>
                                                    Next →
                                                </button>
                                            ) : (
                                                <button type="submit" disabled={saving} className={btnPrimary + " bg-zinc-900 min-w-[180px]"}>
                                                    {saving ? "Saving..." : (isEdit ? "Save Changes" : "Create Resume")}
                                                </button>
                                            )}
                                        </div>
                                    </form>
                                </div>
                            </div>
                        );
                    }
                    const root = ReactDOM.createRoot(document.getElementById('root'));
                    root.render(<App />);
                </script>
            </body>

            </html>