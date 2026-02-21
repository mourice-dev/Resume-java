package com.resumebuilder.controller;

import com.resumebuilder.dao.*;
import com.resumebuilder.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ResumePreviewController extends HttpServlet {
    private ResumeDAO resumeDAO = new ResumeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        try {
            int resumeId = Integer.parseInt(idParam);
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");

            Resume resume = resumeDAO.getResumeById(resumeId);
            if (resume == null || resume.getUserId() != user.getId()) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
                return;
            }

            EducationDAO eduDAO = new EducationDAO();
            ExperienceDAO expDAO = new ExperienceDAO();
            SkillDAO skillDAO = new SkillDAO();
            ProjectDAO projDAO = new ProjectDAO();

            request.setAttribute("resume", resume);
            request.setAttribute("educationList", eduDAO.getByResumeId(resumeId));
            request.setAttribute("experienceList", expDAO.getByResumeId(resumeId));
            request.setAttribute("skillList", skillDAO.getByResumeId(resumeId));
            request.setAttribute("projectList", projDAO.getByResumeId(resumeId));

            request.getRequestDispatcher("/WEB-INF/views/resume-preview.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading resume: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }
}
