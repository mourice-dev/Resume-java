package com.resumebuilder.controller;

import com.resumebuilder.dao.ResumeDAO;
import com.resumebuilder.model.Resume;
import com.resumebuilder.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class DashboardController extends HttpServlet {
    private ResumeDAO resumeDAO = new ResumeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

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
                // SEARCH: by text (character & number), date, and time
                resumes = resumeDAO.searchResumes(user.getId(), search, dateFilter, timeFrom, timeTo);
                request.setAttribute("searchActive", true);
                request.setAttribute("search", search);
                request.setAttribute("dateFilter", dateFilter);
                request.setAttribute("timeFrom", timeFrom);
                request.setAttribute("timeTo", timeTo);
            } else {
                // READ ALL: list all resumes for user
                resumes = resumeDAO.getResumesByUserId(user.getId());
            }

            request.setAttribute("resumes", resumes);
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
        }
    }
}
