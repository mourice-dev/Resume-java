package com.resumebuilder.dao;

import com.resumebuilder.model.Resume;
import com.resumebuilder.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResumeDAO {

    // CREATE
    public int createResume(Resume r) throws SQLException {
        String sql = "INSERT INTO resumes (user_id, title, full_name, email, phone, address, summary, linkedin, website, template, status) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, r.getUserId());
            ps.setString(2, r.getTitle());
            ps.setString(3, r.getFullName());
            ps.setString(4, r.getEmail());
            ps.setString(5, r.getPhone());
            ps.setString(6, r.getAddress());
            ps.setString(7, r.getSummary());
            ps.setString(8, r.getLinkedin());
            ps.setString(9, r.getWebsite());
            ps.setString(10, r.getTemplate());
            ps.setString(11, r.getStatus() != null ? r.getStatus() : "DRAFT");
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next())
                    return keys.getInt(1);
            }
        }
        return -1;
    }

    // READ - single
    public Resume getResumeById(int id) throws SQLException {
        String sql = "SELECT * FROM resumes WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return mapResume(rs);
            }
        }
        return null;
    }

    // READ - all by user
    public List<Resume> getResumesByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM resumes WHERE user_id = ? ORDER BY updated_at DESC";
        List<Resume> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    list.add(mapResume(rs));
            }
        }
        return list;
    }

    // READ - all (ADMIN)
    public List<Resume> getAllResumes() throws SQLException {
        String sql = "SELECT * FROM resumes ORDER BY updated_at DESC";
        List<Resume> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next())
                list.add(mapResume(rs));
        }
        return list;
    }

    // UPDATE
    public boolean updateResume(Resume r) throws SQLException {
        String sql = "UPDATE resumes SET title=?, full_name=?, email=?, phone=?, address=?, summary=?, linkedin=?, website=?, template=?, status=?, updated_at=NOW() WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getTitle());
            ps.setString(2, r.getFullName());
            ps.setString(3, r.getEmail());
            ps.setString(4, r.getPhone());
            ps.setString(5, r.getAddress());
            ps.setString(6, r.getSummary());
            ps.setString(7, r.getLinkedin());
            ps.setString(8, r.getWebsite());
            ps.setString(9, r.getTemplate());
            ps.setString(10, r.getStatus());
            ps.setInt(11, r.getId());
            return ps.executeUpdate() > 0;
        }
    }

    // DELETE
    public boolean deleteResume(int id) throws SQLException {
        String sql = "DELETE FROM resumes WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // UPDATE STATUS (ADMIN/SYSTEM)
    public boolean updateResumeStatus(int id, String status) throws SQLException {
        String sql = "UPDATE resumes SET status = ?, updated_at = NOW() WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }

    // SEARCH - by text (character & number), date, and time
    public List<Resume> searchResumes(int userId, String searchText, String dateFilter, String timeFrom, String timeTo)
            throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM resumes WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (userId != -1) {
            sql.append(" AND user_id = ?");
            params.add(userId);
        }

        // Search by character & number (text search on title and full_name)
        if (searchText != null && !searchText.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR full_name LIKE ? OR email LIKE ?)");
            String like = "%" + searchText.trim() + "%";
            params.add(like);
            params.add(like);
            params.add(like);
        }

        // Search by date
        if (dateFilter != null && !dateFilter.trim().isEmpty()) {
            sql.append(" AND DATE(created_at) = ?");
            params.add(dateFilter.trim());
        }

        // Search by time range
        if (timeFrom != null && !timeFrom.trim().isEmpty()) {
            sql.append(" AND created_at::time >= ?::time");
            params.add(timeFrom.trim());
        }
        if (timeTo != null && !timeTo.trim().isEmpty()) {
            sql.append(" AND created_at::time <= ?::time");
            params.add(timeTo.trim());
        }

        sql.append(" ORDER BY updated_at DESC");

        List<Resume> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                Object p = params.get(i);
                if (p instanceof Integer)
                    ps.setInt(i + 1, (Integer) p);
                else
                    ps.setString(i + 1, p.toString());
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    list.add(mapResume(rs));
            }
        }
        return list;
    }

    private Resume mapResume(ResultSet rs) throws SQLException {
        Resume r = new Resume();
        r.setId(rs.getInt("id"));
        r.setUserId(rs.getInt("user_id"));
        r.setTitle(rs.getString("title"));
        r.setFullName(rs.getString("full_name"));
        r.setEmail(rs.getString("email"));
        r.setPhone(rs.getString("phone"));
        r.setAddress(rs.getString("address"));
        r.setSummary(rs.getString("summary"));
        r.setLinkedin(rs.getString("linkedin"));
        r.setWebsite(rs.getString("website"));
        r.setTemplate(rs.getString("template"));
        r.setStatus(rs.getString("status"));
        r.setCreatedAt(rs.getString("created_at"));
        r.setUpdatedAt(rs.getString("updated_at"));
        return r;
    }
}
