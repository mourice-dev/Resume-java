package com.resumebuilder.controller;

import com.resumebuilder.dao.*;
import com.resumebuilder.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ResumeFormController extends HttpServlet {
    private ResumeDAO resumeDAO = new ResumeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int resumeId = Integer.parseInt(idParam);
                HttpSession session = request.getSession(false);
                User user = (User) session.getAttribute("user");

                Resume resume = resumeDAO.getResumeById(resumeId);
                if (resume != null && resume.getUserId() == user.getId()) {
                    request.setAttribute("resume", resume);

                    EducationDAO eduDAO = new EducationDAO();
                    ExperienceDAO expDAO = new ExperienceDAO();
                    SkillDAO skillDAO = new SkillDAO();
                    ProjectDAO projDAO = new ProjectDAO();

                    request.setAttribute("educationList", eduDAO.getByResumeId(resumeId));
                    request.setAttribute("experienceList", expDAO.getByResumeId(resumeId));
                    request.setAttribute("skillList", skillDAO.getByResumeId(resumeId));
                    request.setAttribute("projectList", projDAO.getByResumeId(resumeId));
                }
            } catch (Exception e) {
                request.setAttribute("error", "Error loading resume: " + e.getMessage());
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/resume-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        try {
            Resume resume = new Resume();
            resume.setUserId(user.getId());
            resume.setTitle(request.getParameter("title"));
            resume.setFullName(request.getParameter("fullName"));
            resume.setEmail(request.getParameter("resumeEmail"));
            resume.setPhone(request.getParameter("phone"));
            resume.setAddress(request.getParameter("address"));
            resume.setSummary(request.getParameter("summary"));
            resume.setLinkedin(request.getParameter("linkedin"));
            resume.setWebsite(request.getParameter("website"));
            resume.setTemplate(request.getParameter("template"));

            String resumeIdParam = request.getParameter("resumeId");
            int resumeId;

            if (resumeIdParam != null && !resumeIdParam.isEmpty()) {
                // UPDATE existing resume
                resumeId = Integer.parseInt(resumeIdParam);
                resume.setId(resumeId);
                resumeDAO.updateResume(resume);
            } else {
                // CREATE new resume
                resumeId = resumeDAO.createResume(resume);
            }

            if (resumeId > 0) {
                saveEducation(request, resumeId);
                saveExperience(request, resumeId);
                saveSkills(request, resumeId);
                saveProjects(request, resumeId);

                response.sendRedirect(request.getContextPath() + "/resume-preview?id=" + resumeId);
            } else {
                request.setAttribute("error", "Error saving resume");
                request.getRequestDispatcher("/WEB-INF/views/resume-form.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/resume-form.jsp").forward(request, response);
        }
    }

    private void saveEducation(HttpServletRequest request, int resumeId) throws Exception {
        EducationDAO dao = new EducationDAO();
        dao.deleteByResumeId(resumeId);
        String[] institutions = request.getParameterValues("institution");
        String[] degrees = request.getParameterValues("degree");
        String[] fields = request.getParameterValues("fieldOfStudy");
        String[] startDates = request.getParameterValues("eduStartDate");
        String[] endDates = request.getParameterValues("eduEndDate");
        String[] gpas = request.getParameterValues("gpa");
        String[] descriptions = request.getParameterValues("eduDescription");

        if (institutions != null) {
            for (int i = 0; i < institutions.length; i++) {
                if (institutions[i] != null && !institutions[i].trim().isEmpty()) {
                    Education edu = new Education();
                    edu.setResumeId(resumeId);
                    edu.setInstitution(institutions[i].trim());
                    edu.setDegree(degrees != null && i < degrees.length ? degrees[i] : "");
                    edu.setFieldOfStudy(fields != null && i < fields.length ? fields[i] : "");
                    edu.setStartDate(startDates != null && i < startDates.length ? startDates[i] : "");
                    edu.setEndDate(endDates != null && i < endDates.length ? endDates[i] : "");
                    edu.setGpa(gpas != null && i < gpas.length ? gpas[i] : "");
                    edu.setDescription(descriptions != null && i < descriptions.length ? descriptions[i] : "");
                    dao.addEducation(edu);
                }
            }
        }
    }

    private void saveExperience(HttpServletRequest request, int resumeId) throws Exception {
        ExperienceDAO dao = new ExperienceDAO();
        dao.deleteByResumeId(resumeId);
        String[] companies = request.getParameterValues("company");
        String[] positions = request.getParameterValues("position");
        String[] startDates = request.getParameterValues("expStartDate");
        String[] endDates = request.getParameterValues("expEndDate");
        String[] descriptions = request.getParameterValues("expDescription");

        if (companies != null) {
            for (int i = 0; i < companies.length; i++) {
                if (companies[i] != null && !companies[i].trim().isEmpty()) {
                    Experience exp = new Experience();
                    exp.setResumeId(resumeId);
                    exp.setCompany(companies[i].trim());
                    exp.setPosition(positions != null && i < positions.length ? positions[i] : "");
                    exp.setStartDate(startDates != null && i < startDates.length ? startDates[i] : "");
                    exp.setEndDate(endDates != null && i < endDates.length ? endDates[i] : "");
                    exp.setDescription(descriptions != null && i < descriptions.length ? descriptions[i] : "");
                    dao.addExperience(exp);
                }
            }
        }
    }

    private void saveSkills(HttpServletRequest request, int resumeId) throws Exception {
        SkillDAO dao = new SkillDAO();
        dao.deleteByResumeId(resumeId);
        String[] names = request.getParameterValues("skillName");
        String[] levels = request.getParameterValues("proficiency");

        if (names != null) {
            for (int i = 0; i < names.length; i++) {
                if (names[i] != null && !names[i].trim().isEmpty()) {
                    Skill skill = new Skill();
                    skill.setResumeId(resumeId);
                    skill.setSkillName(names[i].trim());
                    skill.setProficiency(levels != null && i < levels.length ? levels[i] : "Intermediate");
                    dao.addSkill(skill);
                }
            }
        }
    }

    private void saveProjects(HttpServletRequest request, int resumeId) throws Exception {
        ProjectDAO dao = new ProjectDAO();
        dao.deleteByResumeId(resumeId);
        String[] names = request.getParameterValues("projectName");
        String[] descriptions = request.getParameterValues("projectDescription");
        String[] technologies = request.getParameterValues("technologies");
        String[] urls = request.getParameterValues("projectUrl");

        if (names != null) {
            for (int i = 0; i < names.length; i++) {
                if (names[i] != null && !names[i].trim().isEmpty()) {
                    Project proj = new Project();
                    proj.setResumeId(resumeId);
                    proj.setProjectName(names[i].trim());
                    proj.setDescription(descriptions != null && i < descriptions.length ? descriptions[i] : "");
                    proj.setTechnologies(technologies != null && i < technologies.length ? technologies[i] : "");
                    proj.setUrl(urls != null && i < urls.length ? urls[i] : "");
                    dao.addProject(proj);
                }
            }
        }
    }
}
