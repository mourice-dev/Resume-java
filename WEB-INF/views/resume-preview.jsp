<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List, com.resumebuilder.model.*" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Resume Preview - ResumeForge</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
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
            <style>
                @media print {
                    body {
                        background: white !important;
                    }

                    .no-print {
                        display: none !important;
                    }

                    .print-area {
                        box-shadow: none !important;
                        border: none !important;
                        max-width: 100% !important;
                        margin: 0 !important;
                        padding: 1.5rem !important;
                    }
                }
            </style>
        </head>

        <body class="font-sans bg-zinc-50 text-zinc-900">
            <% String ctx=request.getContextPath(); Resume resume=(Resume) request.getAttribute("resume");
                List<Education> eduList = (List<Education>) request.getAttribute("educationList");
                    List<Experience> expList = (List<Experience>) request.getAttribute("experienceList");
                            List<Skill> skillList = (List<Skill>) request.getAttribute("skillList");
                                    List<Project> projList = (List<Project>) request.getAttribute("projectList");
                                            if (resume == null) { response.sendRedirect(ctx + "/dashboard"); return; }
                                            %>

                                            <!-- Toolbar -->
                                            <nav class="no-print bg-white border-b border-zinc-200 sticky top-0 z-50">
                                                <div
                                                    class="max-w-4xl mx-auto px-6 py-4 flex flex-wrap justify-between items-center gap-3">
                                                    <a href="<%= ctx %>/dashboard"
                                                        class="flex items-center gap-3 group">
                                                        <div
                                                            class="w-8 h-8 bg-black text-white rounded flex items-center justify-center font-bold text-sm">
                                                            R</div>
                                                        <span class="text-lg font-bold text-black">ResumeForge</span>
                                                    </a>
                                                    <div class="flex flex-wrap gap-2">
                                                        <a href="<%= ctx %>/resume-form?id=<%= resume.getId() %>"
                                                            class="px-4 py-2 text-sm font-medium bg-zinc-100 text-zinc-700 rounded-lg hover:bg-zinc-200 border border-zinc-200 transition">Edit</a>
                                                        <button onclick="window.print()"
                                                            class="px-4 py-2 text-sm font-medium bg-zinc-100 text-zinc-700 rounded-lg hover:bg-zinc-200 border border-zinc-200 transition">Print</button>
                                                        <button onclick="downloadPDF()"
                                                            class="px-4 py-2 text-sm font-medium bg-black text-white rounded-lg hover:bg-zinc-800 transition shadow-sm">Download
                                                            PDF</button>
                                                        <button onclick="downloadDOCX()"
                                                            class="px-4 py-2 text-sm font-medium bg-zinc-800 text-white rounded-lg hover:bg-zinc-700 transition shadow-sm">Download
                                                            DOCX</button>
                                                        <a href="<%= ctx %>/dashboard"
                                                            class="px-4 py-2 text-sm font-medium text-zinc-500 hover:text-black transition">Dashboard</a>
                                                    </div>
                                                </div>
                                            </nav>

                                            <!-- Resume Content -->
                                            <div class="max-w-4xl mx-auto px-6 py-10">
                                                <div id="resume-content"
                                                    class="print-area bg-white border border-zinc-200 rounded-xl shadow-sm overflow-hidden">

                                                    <!-- Header -->
                                                    <div class="bg-black text-white p-8">
                                                        <h1 class="text-3xl font-bold tracking-tight">
                                                            <%= resume.getFullName() !=null ? resume.getFullName()
                                                                : "Name" %>
                                                        </h1>
                                                        <p class="text-zinc-300 mt-1 text-lg">
                                                            <%= resume.getTitle() !=null ? resume.getTitle() : "" %>
                                                        </p>
                                                        <div class="flex flex-wrap gap-4 mt-4 text-sm text-zinc-400">
                                                            <% if (resume.getEmail() !=null &&
                                                                !resume.getEmail().isEmpty()) { %>
                                                                <span class="flex items-center gap-1.5">
                                                                    <svg class="w-4 h-4" fill="none"
                                                                        stroke="currentColor" viewBox="0 0 24 24">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="1.5"
                                                                            d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                                                    </svg>
                                                                    <%= resume.getEmail() %>
                                                                </span>
                                                                <% } %>
                                                                    <% if (resume.getPhone() !=null &&
                                                                        !resume.getPhone().isEmpty()) { %>
                                                                        <span class="flex items-center gap-1.5">
                                                                            <svg class="w-4 h-4" fill="none"
                                                                                stroke="currentColor"
                                                                                viewBox="0 0 24 24">
                                                                                <path stroke-linecap="round"
                                                                                    stroke-linejoin="round"
                                                                                    stroke-width="1.5"
                                                                                    d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                                                            </svg>
                                                                            <%= resume.getPhone() %>
                                                                        </span>
                                                                        <% } %>
                                                                            <% if (resume.getAddress() !=null &&
                                                                                !resume.getAddress().isEmpty()) { %>
                                                                                <span class="flex items-center gap-1.5">
                                                                                    <svg class="w-4 h-4" fill="none"
                                                                                        stroke="currentColor"
                                                                                        viewBox="0 0 24 24">
                                                                                        <path stroke-linecap="round"
                                                                                            stroke-linejoin="round"
                                                                                            stroke-width="1.5"
                                                                                            d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                                                                        <path stroke-linecap="round"
                                                                                            stroke-linejoin="round"
                                                                                            stroke-width="1.5"
                                                                                            d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                                                                                    </svg>
                                                                                    <%= resume.getAddress() %>
                                                                                </span>
                                                                                <% } %>
                                                                                    <% if (resume.getLinkedin() !=null
                                                                                        &&
                                                                                        !resume.getLinkedin().isEmpty())
                                                                                        { %>
                                                                                        <span
                                                                                            class="flex items-center gap-1.5">
                                                                                            <svg class="w-4 h-4"
                                                                                                fill="currentColor"
                                                                                                viewBox="0 0 24 24">
                                                                                                <path
                                                                                                    d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z" />
                                                                                            </svg>
                                                                                            <%= resume.getLinkedin() %>
                                                                                        </span>
                                                                                        <% } %>
                                                                                            <% if (resume.getWebsite()
                                                                                                !=null &&
                                                                                                !resume.getWebsite().isEmpty())
                                                                                                { %>
                                                                                                <span
                                                                                                    class="flex items-center gap-1.5">
                                                                                                    <svg class="w-4 h-4"
                                                                                                        fill="none"
                                                                                                        stroke="currentColor"
                                                                                                        viewBox="0 0 24 24">
                                                                                                        <path
                                                                                                            stroke-linecap="round"
                                                                                                            stroke-linejoin="round"
                                                                                                            stroke-width="1.5"
                                                                                                            d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9" />
                                                                                                    </svg>
                                                                                                    <%= resume.getWebsite()
                                                                                                        %>
                                                                                                </span>
                                                                                                <% } %>
                                                        </div>
                                                    </div>

                                                    <div class="p-8 space-y-8">

                                                        <!-- Summary -->
                                                        <% if (resume.getSummary() !=null &&
                                                            !resume.getSummary().isEmpty()) { %>
                                                            <div>
                                                                <h2
                                                                    class="text-sm font-bold uppercase tracking-widest text-black border-b-2 border-black pb-2 mb-3">
                                                                    Professional Summary</h2>
                                                                <p
                                                                    class="text-zinc-600 leading-relaxed whitespace-pre-line">
                                                                    <%= resume.getSummary() %>
                                                                </p>
                                                            </div>
                                                            <% } %>

                                                                <!-- Experience -->
                                                                <% if (expList !=null && !expList.isEmpty()) { %>
                                                                    <div>
                                                                        <h2
                                                                            class="text-sm font-bold uppercase tracking-widest text-black border-b-2 border-black pb-2 mb-3">
                                                                            Work Experience</h2>
                                                                        <% for (Experience exp : expList) { %>
                                                                            <div class="mb-5">
                                                                                <div
                                                                                    class="flex justify-between items-start">
                                                                                    <div>
                                                                                        <h3
                                                                                            class="font-bold text-black">
                                                                                            <%= exp.getPosition() !=null
                                                                                                ? exp.getPosition() : ""
                                                                                                %>
                                                                                        </h3>
                                                                                        <p
                                                                                            class="text-zinc-500 text-sm font-medium">
                                                                                            <%= exp.getCompany() !=null
                                                                                                ? exp.getCompany() : ""
                                                                                                %>
                                                                                        </p>
                                                                                    </div>
                                                                                    <span
                                                                                        class="text-zinc-400 text-xs font-medium bg-zinc-100 px-2 py-1 rounded">
                                                                                        <%= exp.getStartDate() !=null ?
                                                                                            exp.getStartDate() : "" %>
                                                                                            &ndash; <%= exp.getEndDate()
                                                                                                !=null &&
                                                                                                !exp.getEndDate().isEmpty()
                                                                                                ? exp.getEndDate()
                                                                                                : "Present" %>
                                                                                    </span>
                                                                                </div>
                                                                                <% if (exp.getDescription() !=null &&
                                                                                    !exp.getDescription().isEmpty()) {
                                                                                    %>
                                                                                    <p
                                                                                        class="text-zinc-600 text-sm mt-2 leading-relaxed whitespace-pre-line">
                                                                                        <%= exp.getDescription() %>
                                                                                    </p>
                                                                                    <% } %>
                                                                            </div>
                                                                            <% } %>
                                                                    </div>
                                                                    <% } %>

                                                                        <!-- Education -->
                                                                        <% if (eduList !=null && !eduList.isEmpty()) {
                                                                            %>
                                                                            <div>
                                                                                <h2
                                                                                    class="text-sm font-bold uppercase tracking-widest text-black border-b-2 border-black pb-2 mb-3">
                                                                                    Education</h2>
                                                                                <% for (Education edu : eduList) { %>
                                                                                    <div class="mb-5">
                                                                                        <div
                                                                                            class="flex justify-between items-start">
                                                                                            <div>
                                                                                                <h3
                                                                                                    class="font-bold text-black">
                                                                                                    <%= edu.getDegree()
                                                                                                        !=null ?
                                                                                                        edu.getDegree()
                                                                                                        : "" %>
                                                                                                        <% if
                                                                                                            (edu.getFieldOfStudy()
                                                                                                            !=null &&
                                                                                                            !edu.getFieldOfStudy().isEmpty())
                                                                                                            { %> in <%=
                                                                                                                edu.getFieldOfStudy()
                                                                                                                %>
                                                                                                                <% } %>
                                                                                                </h3>
                                                                                                <p
                                                                                                    class="text-zinc-500 text-sm font-medium">
                                                                                                    <%= edu.getInstitution()
                                                                                                        !=null ?
                                                                                                        edu.getInstitution()
                                                                                                        : "" %>
                                                                                                </p>
                                                                                            </div>
                                                                                            <div class="text-right">
                                                                                                <span
                                                                                                    class="text-zinc-400 text-xs font-medium bg-zinc-100 px-2 py-1 rounded">
                                                                                                    <%= edu.getStartDate()
                                                                                                        !=null ?
                                                                                                        edu.getStartDate()
                                                                                                        : "" %> &ndash;
                                                                                                        <%= edu.getEndDate()
                                                                                                            !=null ?
                                                                                                            edu.getEndDate()
                                                                                                            : "" %>
                                                                                                </span>
                                                                                                <% if (edu.getGpa()
                                                                                                    !=null &&
                                                                                                    !edu.getGpa().isEmpty())
                                                                                                    { %>
                                                                                                    <p
                                                                                                        class="text-zinc-500 text-xs mt-1">
                                                                                                        GPA: <strong>
                                                                                                            <%= edu.getGpa()
                                                                                                                %>
                                                                                                        </strong></p>
                                                                                                    <% } %>
                                                                                            </div>
                                                                                        </div>
                                                                                        <% if (edu.getDescription()
                                                                                            !=null &&
                                                                                            !edu.getDescription().isEmpty())
                                                                                            { %>
                                                                                            <p
                                                                                                class="text-zinc-600 text-sm mt-2 leading-relaxed whitespace-pre-line">
                                                                                                <%= edu.getDescription()
                                                                                                    %>
                                                                                            </p>
                                                                                            <% } %>
                                                                                    </div>
                                                                                    <% } %>
                                                                            </div>
                                                                            <% } %>

                                                                                <!-- Skills -->
                                                                                <% if (skillList !=null &&
                                                                                    !skillList.isEmpty()) { %>
                                                                                    <div>
                                                                                        <h2
                                                                                            class="text-sm font-bold uppercase tracking-widest text-black border-b-2 border-black pb-2 mb-3">
                                                                                            Skills</h2>
                                                                                        <div
                                                                                            class="flex flex-wrap gap-2">
                                                                                            <% for (Skill s : skillList)
                                                                                                { %>
                                                                                                <span
                                                                                                    class="px-3 py-1.5 bg-zinc-100 text-zinc-700 rounded-lg text-sm font-medium border border-zinc-200">
                                                                                                    <%= s.getSkillName()
                                                                                                        %> <span
                                                                                                            class="text-xs text-zinc-400">(
                                                                                                            <%= s.getProficiency()
                                                                                                                %>
                                                                                                                )</span>
                                                                                                </span>
                                                                                                <% } %>
                                                                                        </div>
                                                                                    </div>
                                                                                    <% } %>

                                                                                        <!-- Projects -->
                                                                                        <% if (projList !=null &&
                                                                                            !projList.isEmpty()) { %>
                                                                                            <div>
                                                                                                <h2
                                                                                                    class="text-sm font-bold uppercase tracking-widest text-black border-b-2 border-black pb-2 mb-3">
                                                                                                    Projects</h2>
                                                                                                <% for (Project p :
                                                                                                    projList) { %>
                                                                                                    <div class="mb-5">
                                                                                                        <h3
                                                                                                            class="font-bold text-black">
                                                                                                            <%= p.getProjectName()
                                                                                                                !=null ?
                                                                                                                p.getProjectName()
                                                                                                                : "" %>
                                                                                                        </h3>
                                                                                                        <% if
                                                                                                            (p.getTechnologies()
                                                                                                            !=null &&
                                                                                                            !p.getTechnologies().isEmpty())
                                                                                                            { %>
                                                                                                            <p
                                                                                                                class="text-zinc-500 text-xs mt-1 font-medium">
                                                                                                                <%= p.getTechnologies()
                                                                                                                    %>
                                                                                                            </p>
                                                                                                            <% } %>
                                                                                                                <% if
                                                                                                                    (p.getDescription()
                                                                                                                    !=null
                                                                                                                    &&
                                                                                                                    !p.getDescription().isEmpty())
                                                                                                                    { %>
                                                                                                                    <p
                                                                                                                        class="text-zinc-600 text-sm mt-2 leading-relaxed whitespace-pre-line">
                                                                                                                        <%= p.getDescription()
                                                                                                                            %>
                                                                                                                    </p>
                                                                                                                    <% }
                                                                                                                        %>
                                                                                                                        <% if
                                                                                                                            (p.getUrl()
                                                                                                                            !=null
                                                                                                                            &&
                                                                                                                            !p.getUrl().isEmpty())
                                                                                                                            {
                                                                                                                            %>
                                                                                                                            <a href="<%= p.getUrl() %>"
                                                                                                                                class="text-black text-xs hover:underline mt-1 inline-block font-medium">
                                                                                                                                <%= p.getUrl()
                                                                                                                                    %>
                                                                                                                            </a>
                                                                                                                            <% }
                                                                                                                                %>
                                                                                                    </div>
                                                                                                    <% } %>
                                                                                            </div>
                                                                                            <% } %>

                                                                                                <!-- Metadata -->
                                                                                                <div
                                                                                                    class="pt-6 border-t border-zinc-200 text-xs text-zinc-400">
                                                                                                    Created: <%=
                                                                                                        resume.getCreatedAt()
                                                                                                        %> &bull; Last
                                                                                                        Updated: <%=
                                                                                                            resume.getUpdatedAt()
                                                                                                            %>
                                                                                                </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- PDF & DOCX Download Scripts -->
                                            <script>
                                                function downloadPDF() {
                                                    const element = document.getElementById('resume-content');
                                                    const name = '<%= resume.getFullName() != null ? resume.getFullName().replace("'", "\\'") : "Resume" %>';
                                                    const opt = {
                                                        margin: 0.3,
                                                        filename: name + '_Resume.pdf',
                                                        image: { type: 'jpeg', quality: 0.98 },
                                                        html2canvas: { scale: 2, useCORS: true },
                                                        jsPDF: { unit: 'in', format: 'a4', orientation: 'portrait' }
                                                    };
                                                    html2pdf().set(opt).from(element).save();
                                                }

                                                function downloadDOCX() {
                                                    const element = document.getElementById('resume-content');
                                                    const name = '<%= resume.getFullName() != null ? resume.getFullName().replace("'", "\\'") : "Resume" %>';
                                                    const styles = `
                <style>
                    body { font-family: 'Calibri', sans-serif; color: #18181b; }
                    h1 { font-size: 24pt; margin-bottom: 4pt; }
                    h2 { font-size: 12pt; border-bottom: 2px solid #000; padding-bottom: 4pt; margin-top: 16pt; text-transform: uppercase; letter-spacing: 2px; }
                    h3 { font-size: 11pt; font-weight: bold; }
                    p { font-size: 10pt; line-height: 1.5; }
                    span { font-size: 9pt; }
                </style>
            `;
                                                    const html = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns="http://www.w3.org/TR/REC-html40"><head><meta charset="utf-8">' + styles + '</head><body>' + element.innerHTML + '</body></html>';
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