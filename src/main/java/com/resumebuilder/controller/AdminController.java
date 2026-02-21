package com.resumebuilder.controller;

import com.resumebuilder.dao.ResumeDAO;
import com.resumebuilder.model.Resume;
import com.resumebuilder.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class AdminController extends HttpServlet {
    private ResumeDAO resumeDAO = new ResumeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Security check: Only ADMIN can access
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Get search parameters
        String search = request.getParameter("search");
        String dateFilter = request.getParameter("dateFilter");
        String timeFrom = request.getParameter("timeFrom");
        String timeTo = request.getParameter("timeTo");

        try {
            List<Resume> resumes;

            // Check if any search filter is active
            boolean hasSearch = (search != null && !search.trim().isEmpty()) ||
                    (dateFilter != null && !dateFilter.trim().isEmpty()) ||
                    (timeFrom != null && !timeFrom.trim().isEmpty()) ||
                    (timeTo != null && !timeTo.trim().isEmpty());

            if (hasSearch) {
                // ADMIN SEARCH: passing -1 as userId to search globally
                resumes = resumeDAO.searchResumes(-1, search, dateFilter, timeFrom, timeTo);
                request.setAttribute("searchActive", true);
                request.setAttribute("search", search);
                request.setAttribute("dateFilter", dateFilter);
                request.setAttribute("timeFrom", timeFrom);
                request.setAttribute("timeTo", timeTo);
            } else {
                // ADMIN READ ALL: list all resumes in the system
                resumes = resumeDAO.getAllResumes();
            }

            request.setAttribute("resumes", resumes);
            request.getRequestDispatcher("/WEB-INF/views/admin-dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading admin dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin-dashboard.jsp").forward(request, response);
        }
    }
}
