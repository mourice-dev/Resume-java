package com.resumebuilder.controller;

import com.resumebuilder.dao.*;
import com.resumebuilder.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ResumeController extends HttpServlet {
    private ResumeDAO resumeDAO = new ResumeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if ("delete".equals(action) && idParam != null) {
            try {
                int resumeId = Integer.parseInt(idParam);
                Resume resume = resumeDAO.getResumeById(resumeId);
                if (resume != null && resume.getUserId() == user.getId()) {
                    resumeDAO.deleteResume(resumeId);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if ("duplicate".equals(action) && idParam != null) {
            try {
                int resumeId = Integer.parseInt(idParam);
                Resume original = resumeDAO.getResumeById(resumeId);
                if (original != null && original.getUserId() == user.getId()) {
                    // Clone the resume
                    Resume copy = new Resume();
                    copy.setUserId(user.getId());
                    copy.setTitle("Copy of " + original.getTitle());
                    copy.setFullName(original.getFullName());
                    copy.setEmail(original.getEmail());
                    copy.setPhone(original.getPhone());
                    copy.setAddress(original.getAddress());
                    copy.setSummary(original.getSummary());
                    copy.setLinkedin(original.getLinkedin());
                    copy.setWebsite(original.getWebsite());
                    copy.setTemplate(original.getTemplate());
                    int newId = resumeDAO.createResume(copy);

                    if (newId > 0) {
                        // Clone education
                        EducationDAO eduDAO = new EducationDAO();
                        List<Education> eduList = eduDAO.getByResumeId(resumeId);
                        for (Education e : eduList) {
                            e.setResumeId(newId);
                            eduDAO.addEducation(e);
                        }

                        // Clone experience
                        ExperienceDAO expDAO = new ExperienceDAO();
                        List<Experience> expList = expDAO.getByResumeId(resumeId);
                        for (Experience e : expList) {
                            e.setResumeId(newId);
                            expDAO.addExperience(e);
                        }

                        // Clone skills
                        SkillDAO skillDAO = new SkillDAO();
                        List<Skill> skillList = skillDAO.getByResumeId(resumeId);
                        for (Skill s : skillList) {
                            s.setResumeId(newId);
                            skillDAO.addSkill(s);
                        }

                        // Clone projects
                        ProjectDAO projDAO = new ProjectDAO();
                        List<Project> projList = projDAO.getByResumeId(resumeId);
                        for (Project p : projList) {
                            p.setResumeId(newId);
                            projDAO.addProject(p);
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
