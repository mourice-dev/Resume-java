<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resume Preview - ResumeForge</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Outfit:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                        outfit: ['Outfit', 'sans-serif']
                    },
                    colors: {
                        black: '#09090b',
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
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .resume-shadow {
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        @media print {
            body {
                background: white !important;
                color: black !important;
            }

            .no-print {
                display: none !important;
            }

            .print-area {
                box-shadow: none !important;
                border: none !important;
                max-width: 100% !important;
                margin: 0 !important;
                width: 100% !important;
                border-radius: 0 !important;
            }

            .print-area * {
                color-adjust: exact;
                -webkit-print-color-adjust: exact;
            }
        }

        .section-title {
            position: relative;
            display: inline-block;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 0;
            width: 40px;
            height: 3px;
            background: #6366f1;
            border-radius: 2px;
        }
    </style>
</head>

<body class="font-sans gradient-bg min-h-screen text-white/90">
    <% String ctx=request.getContextPath(); Resume resume=(Resume) request.getAttribute("resume"); List<Education>
        eduList = (List<Education>) request.getAttribute("educationList");
            List<Experience> expList = (List<Experience>) request.getAttribute("experienceList");
                    List<Skill> skillList = (List<Skill>) request.getAttribute("skillList");
                            List<Project> projList = (List<Project>) request.getAttribute("projectList");
                                    if (resume == null) { response.sendRedirect(ctx + "/dashboard"); return; }
                                    %>

                                    <!-- Premium Toolbar -->
                                    <nav class="no-print glass sticky top-0 z-50 border-b border-white/10">
                                        <div
                                            class="max-w-5xl mx-auto px-6 py-4 flex flex-wrap justify-between items-center gap-4">
                                            <a href="<%= ctx %>/dashboard" class="flex items-center gap-3 group">
                                                <div
                                                    class="w-9 h-9 bg-gradient-to-br from-brand-400 to-brand-600 rounded-xl flex items-center justify-center font-bold text-white shadow-lg shadow-brand-500/20">
                                                    R</div>
                                                <span
                                                    class="text-xl font-outfit font-black tracking-tight text-white hover:text-brand-300 transition-colors">ResumeForge</span>
                                            </a>
                                            <div class="flex flex-wrap gap-2">
                                                <a href="<%= ctx %>/resume-form?id=<%= resume.getId() %>"
                                                    class="px-5 py-2.5 text-sm font-bold bg-white/5 text-white rounded-xl hover:bg-white/10 border border-white/10 transition-all flex items-center gap-2">
                                                    <svg class="w-4 h-4" fill="none" stroke="currentColor"
                                                        viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                                    </svg>
                                                    Edit
                                                </a>
                                                <button onclick="window.print()"
                                                    class="px-5 py-2.5 text-sm font-bold bg-white/5 text-white rounded-xl hover:bg-white/10 border border-white/10 transition-all">Print</button>
                                                <button onclick="downloadPDF()"
                                                    class="px-5 py-2.5 text-sm font-bold bg-brand-500 text-white rounded-xl hover:bg-brand-600 transition-all shadow-lg shadow-brand-500/25 flex items-center gap-2">
                                                    <svg class="w-4 h-4" fill="none" stroke="currentColor"
                                                        viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                                    </svg>
                                                    PDF
                                                </button>
                                                <button onclick="downloadDOCX()"
                                                    class="px-5 py-2.5 text-sm font-bold bg-zinc-800 text-white rounded-xl hover:bg-zinc-700 transition-all shadow-lg flex items-center gap-2">
                                                    DOCX
                                                </button>
                                                <div class="w-px h-8 bg-white/10 mx-2"></div>
                                                <a href="<%= ctx %>/dashboard"
                                                    class="px-4 py-2.5 text-sm font-bold text-zinc-400 hover:text-white transition">Dashboard</a>
                                            </div>
                                        </div>
                                    </nav>

                                    <!-- Resume Canvas -->
                                    <div class="max-w-4xl mx-auto px-6 py-12">
                                        <div id="resume-content"
                                            class="print-area bg-white text-zinc-900 rounded-3xl overflow-hidden resume-shadow animate-fade-in-up">

                                            <!-- Modern Header -->
                                            <header class="bg-zinc-900 text-white p-12 relative overflow-hidden">
                                                <div
                                                    class="absolute top-0 right-0 w-64 h-64 bg-brand-500/10 rounded-full -mr-32 -mt-32 blur-3xl">
                                                </div>
                                                <div class="relative z-10">
                                                    <h1
                                                        class="text-5xl font-outfit font-black tracking-tighter leading-none mb-4 uppercase">
                                                        <%= resume.getFullName() !=null ? resume.getFullName()
                                                            : "Full Name" %>
                                                    </h1>
                                                    <p class="text-brand-400 font-bold text-xl tracking-wide uppercase">
                                                        <%= resume.getTitle() !=null ? resume.getTitle()
                                                            : "Professional Title" %>
                                                    </p>

                                                    <div
                                                        class="grid grid-cols-1 md:grid-cols-2 gap-y-3 gap-x-8 mt-8 text-sm text-zinc-400">
                                                        <% if (resume.getEmail() !=null && !resume.getEmail().isEmpty())
                                                            { %>
                                                            <div class="flex items-center gap-3">
                                                                <div
                                                                    class="w-8 h-8 rounded-full bg-zinc-800 flex items-center justify-center">
                                                                    <svg class="w-4 h-4 text-brand-400" fill="none"
                                                                        stroke="currentColor" viewBox="0 0 24 24">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                                                    </svg>
                                                                </div>
                                                                <span
                                                                    class="hover:text-white transition cursor-pointer">
                                                                    <%= resume.getEmail() %>
                                                                </span>
                                                            </div>
                                                            <% } %>
                                                                <% if (resume.getPhone() !=null &&
                                                                    !resume.getPhone().isEmpty()) { %>
                                                                    <div class="flex items-center gap-3">
                                                                        <div
                                                                            class="w-8 h-8 rounded-full bg-zinc-800 flex items-center justify-center">
                                                                            <svg class="w-4 h-4 text-brand-400"
                                                                                fill="none" stroke="currentColor"
                                                                                viewBox="0 0 24 24">
                                                                                <path stroke-linecap="round"
                                                                                    stroke-linejoin="round"
                                                                                    stroke-width="2"
                                                                                    d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                                                            </svg>
                                                                        </div>
                                                                        <span
                                                                            class="hover:text-white transition cursor-pointer">
                                                                            <%= resume.getPhone() %>
                                                                        </span>
                                                                    </div>
                                                                    <% } %>
                                                                        <% if (resume.getAddress() !=null &&
                                                                            !resume.getAddress().isEmpty()) { %>
                                                                            <div class="flex items-center gap-3">
                                                                                <div
                                                                                    class="w-8 h-8 rounded-full bg-zinc-800 flex items-center justify-center">
                                                                                    <svg class="w-4 h-4 text-brand-400"
                                                                                        fill="none"
                                                                                        stroke="currentColor"
                                                                                        viewBox="0 0 24 24">
                                                                                        <path stroke-linecap="round"
                                                                                            stroke-linejoin="round"
                                                                                            stroke-width="2"
                                                                                            d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                                                                    </svg>
                                                                                </div>
                                                                                <span
                                                                                    class="hover:text-white transition cursor-pointer">
                                                                                    <%= resume.getAddress() %>
                                                                                </span>
                                                                            </div>
                                                                            <% } %>
                                                                                <% if (resume.getLinkedin() !=null &&
                                                                                    !resume.getLinkedin().isEmpty()) {
                                                                                    %>
                                                                                    <div
                                                                                        class="flex items-center gap-3">
                                                                                        <div
                                                                                            class="w-8 h-8 rounded-full bg-zinc-800 flex items-center justify-center">
                                                                                            <svg class="w-4 h-4 text-brand-400"
                                                                                                fill="currentColor"
                                                                                                viewBox="0 0 24 24">
                                                                                                <path
                                                                                                    d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z" />
                                                                                            </svg>
                                                                                        </div>
                                                                                        <span
                                                                                            class="hover:text-white transition cursor-pointer">
                                                                                            <%= resume.getLinkedin() %>
                                                                                        </span>
                                                                                    </div>
                                                                                    <% } %>
                                                    </div>
                                                </div>
                                            </header>

                                            <div class="p-12 space-y-12">
                                                <!-- Summary -->
                                                <% if (resume.getSummary() !=null && !resume.getSummary().isEmpty()) {
                                                    %>
                                                    <section>
                                                        <h2
                                                            class="section-title text-sm font-black uppercase tracking-[0.2em] text-zinc-900 mb-6 font-outfit">
                                                            Professional Summary</h2>
                                                        <p
                                                            class="text-zinc-600 leading-relaxed text-lg font-medium italic">
                                                            &ldquo;<%= resume.getSummary() %>&rdquo;
                                                        </p>
                                                    </section>
                                                    <% } %>

                                                        <!-- Experience -->
                                                        <% if (expList !=null && !expList.isEmpty()) { %>
                                                            <section>
                                                                <h2
                                                                    class="section-title text-sm font-black uppercase tracking-[0.2em] text-zinc-900 mb-8 font-outfit">
                                                                    Work Experience</h2>
                                                                <div
                                                                    class="space-y-10 border-l-2 border-zinc-100 ml-2 pl-8">
                                                                    <% for (Experience exp : expList) { %>
                                                                        <div class="relative">
                                                                            <div
                                                                                class="absolute -left-[41px] top-1 w-4 h-4 rounded-full bg-white border-4 border-brand-500 shadow-sm">
                                                                            </div>
                                                                            <div
                                                                                class="flex justify-between items-baseline mb-2">
                                                                                <h3
                                                                                    class="text-xl font-black text-zinc-800 leading-tight">
                                                                                    <%= exp.getPosition() %>
                                                                                </h3>
                                                                                <span
                                                                                    class="text-zinc-400 text-sm font-bold bg-zinc-50 px-3 py-1 rounded-full">
                                                                                    <%= exp.getStartDate() %> &mdash;
                                                                                        <%= exp.getEndDate() !=null &&
                                                                                            !exp.getEndDate().isEmpty()
                                                                                            ? exp.getEndDate()
                                                                                            : "Present" %>
                                                                                </span>
                                                                            </div>
                                                                            <p
                                                                                class="text-brand-600 font-black text-xs uppercase tracking-wider mb-3">
                                                                                <%= exp.getCompany() %>
                                                                            </p>
                                                                            <% if (exp.getDescription() !=null &&
                                                                                !exp.getDescription().isEmpty()) { %>
                                                                                <p
                                                                                    class="text-zinc-500 text-sm leading-relaxed whitespace-pre-line max-w-2xl">
                                                                                    <%= exp.getDescription() %>
                                                                                </p>
                                                                                <% } %>
                                                                        </div>
                                                                        <% } %>
                                                                </div>
                                                            </section>
                                                            <% } %>

                                                                <!-- Education -->
                                                                <% if (eduList !=null && !eduList.isEmpty()) { %>
                                                                    <section>
                                                                        <h2
                                                                            class="section-title text-sm font-black uppercase tracking-[0.2em] text-zinc-900 mb-8 font-outfit">
                                                                            Education</h2>
                                                                        <div class="grid md:grid-cols-2 gap-8">
                                                                            <% for (Education edu : eduList) { %>
                                                                                <div
                                                                                    class="p-6 bg-zinc-50 border border-zinc-100 rounded-2xl hover:border-brand-200 transition-colors duration-300">
                                                                                    <div
                                                                                        class="flex justify-between mb-4">
                                                                                        <div
                                                                                            class="w-10 h-10 rounded-xl bg-white flex items-center justify-center shadow-sm text-brand-500">
                                                                                            <svg class="w-6 h-6"
                                                                                                fill="none"
                                                                                                stroke="currentColor"
                                                                                                viewBox="0 0 24 24">
                                                                                                <path
                                                                                                    d="M12 14l9-5-9-5-9 5 9 5z" />
                                                                                                <path
                                                                                                    d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
                                                                                                <path
                                                                                                    stroke-linecap="round"
                                                                                                    stroke-linejoin="round"
                                                                                                    stroke-width="2"
                                                                                                    d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222" />
                                                                                            </svg>
                                                                                        </div>
                                                                                        <span
                                                                                            class="text-zinc-400 text-xs font-bold">
                                                                                            <%= edu.getStartDate() %>
                                                                                                &mdash; <%=
                                                                                                    edu.getEndDate() %>
                                                                                        </span>
                                                                                    </div>
                                                                                    <h3
                                                                                        class="font-black text-zinc-800 mb-1">
                                                                                        <%= edu.getDegree() %>
                                                                                    </h3>
                                                                                    <p
                                                                                        class="text-zinc-500 text-sm font-bold mb-3">
                                                                                        <%= edu.getInstitution() %>
                                                                                    </p>
                                                                                    <% if (edu.getGpa() !=null &&
                                                                                        !edu.getGpa().isEmpty()) { %>
                                                                                        <div
                                                                                            class="inline-block px-2 py-1 bg-brand-50 text-brand-600 rounded text-xs font-black">
                                                                                            GPA: <%= edu.getGpa() %>
                                                                                        </div>
                                                                                        <% } %>
                                                                                </div>
                                                                                <% } %>
                                                                        </div>
                                                                    </section>
                                                                    <% } %>

                                                                        <!-- Skills -->
                                                                        <% if (skillList !=null && !skillList.isEmpty())
                                                                            { %>
                                                                            <section>
                                                                                <h2
                                                                                    class="section-title text-sm font-black uppercase tracking-[0.2em] text-zinc-900 mb-6 font-outfit">
                                                                                    Expertise & Skills</h2>
                                                                                <div class="flex flex-wrap gap-3">
                                                                                    <% for (Skill s : skillList) { %>
                                                                                        <div
                                                                                            class="px-5 py-3 group cursor-default">
                                                                                            <div
                                                                                                class="text-zinc-800 font-bold text-sm mb-1">
                                                                                                <%= s.getSkillName() %>
                                                                                            </div>
                                                                                            <div class="flex gap-1">
                                                                                                <% String
                                                                                                    prof=s.getProficiency().toLowerCase();
                                                                                                    int
                                                                                                    dots=prof.contains("expert")
                                                                                                    ? 5 :
                                                                                                    prof.contains("advanced")
                                                                                                    ? 4 :
                                                                                                    prof.contains("intermediate")
                                                                                                    ? 3 : 2; for (int
                                                                                                    i=1; i<=5; i++) { %>
                                                                                                    <div class="w-1.5 h-1.5 rounded-full <%= i <= dots ? "
                                                                                                        bg-brand-500"
                                                                                                        : "bg-zinc-200"
                                                                                                        %>"></div>
                                                                                                    <% } %>
                                                                                            </div>
                                                                                        </div>
                                                                                        <% } %>
                                                                                </div>
                                                                            </section>
                                                                            <% } %>

                                                                                <!-- Projects -->
                                                                                <% if (projList !=null &&
                                                                                    !projList.isEmpty()) { %>
                                                                                    <section>
                                                                                        <h2
                                                                                            class="section-title text-sm font-black uppercase tracking-[0.2em] text-zinc-900 mb-6 font-outfit">
                                                                                            Notable Projects</h2>
                                                                                        <div class="space-y-6">
                                                                                            <% for (Project p :
                                                                                                projList) { %>
                                                                                                <div class="group">
                                                                                                    <div
                                                                                                        class="flex items-center gap-3 mb-2">
                                                                                                        <h3
                                                                                                            class="font-black text-lg text-zinc-800 group-hover:text-brand-600 transition-colors">
                                                                                                            <%= p.getProjectName()
                                                                                                                %>
                                                                                                        </h3>
                                                                                                        <span
                                                                                                            class="text-[10px] font-black uppercase tracking-widest text-zinc-400 bg-zinc-100 px-2 py-0.5 rounded">
                                                                                                            <%= p.getTechnologies()
                                                                                                                %>
                                                                                                        </span>
                                                                                                    </div>
                                                                                                    <p
                                                                                                        class="text-zinc-500 text-sm leading-relaxed mb-1">
                                                                                                        <%= p.getDescription()
                                                                                                            %>
                                                                                                    </p>
                                                                                                    <% if (p.getUrl()
                                                                                                        !=null &&
                                                                                                        !p.getUrl().isEmpty())
                                                                                                        { %>
                                                                                                        <a href="<%= p.getUrl() %>"
                                                                                                            class="text-brand-500 text-xs font-bold hover:underline">View
                                                                                                            Project
                                                                                                            &rarr;</a>
                                                                                                        <% } %>
                                                                                                </div>
                                                                                                <% } %>
                                                                                        </div>
                                                                                    </section>
                                                                                    <% } %>
                                            </div>

                                            <footer
                                                class="bg-zinc-50 border-t border-zinc-100 p-8 text-center text-[10px] text-zinc-400 font-bold uppercase tracking-widest">
                                                Generated via ResumeForge &bull; Professional Edition
                                            </footer>
                                        </div>
                                    </div>

                                    <!-- Export Logic -->
                                    <script>
                                        function downloadPDF() {
                                            const element = document.getElementById('resume-content');
                                            const name = '<%= resume.getFullName() != null ? resume.getFullName().replace("'", "\\'") : "Resume" %>';
                                            const opt = {
                                                margin: 0,
                                                filename: name + '_Resume.pdf',
                                                image: { type: 'jpeg', quality: 1.0 },
                                                html2canvas: { scale: 3, useCORS: true, letterRendering: true, logging: false },
                                                jsPDF: { unit: 'in', format: 'a4', orientation: 'portrait' }
                                            };
                                            html2pdf().set(opt).from(element).save();
                                        }

                                        function downloadDOCX() {
                                            const element = document.getElementById('resume-content');
                                            const name = '<%= resume.getFullName() != null ? resume.getFullName().replace("'", "\\'") : "Resume" %>';
                                            const html = document.documentElement.outerHTML; // Simplified for demo, usually requires specific library or formatting
                                            const blob = new Blob(['\ufeff', html], { type: 'application/msword' });
                                            const url = URL.createObjectURL(blob);
                                            const a = document.createElement('a');
                                            a.href = url;
                                            a.download = name + '_Resume.doc';
                                            a.click();
                                            URL.revokeObjectURL(url);
                                        }
                                    </script>
</body>

</html>