package com.resumebuilder.dao;

import com.resumebuilder.model.Experience;
import com.resumebuilder.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExperienceDAO {

    public void addExperience(Experience e) throws SQLException {
        String sql = "INSERT INTO experience (resume_id, company, position, start_date, end_date, current_job, description) VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, e.getResumeId());
            ps.setString(2, e.getCompany());
            ps.setString(3, e.getPosition());
            ps.setString(4, e.getStartDate());
            ps.setString(5, e.getEndDate());
            ps.setBoolean(6, e.isCurrentJob());
            ps.setString(7, e.getDescription());
            ps.executeUpdate();
        }
    }

    public List<Experience> getByResumeId(int resumeId) throws SQLException {
        String sql = "SELECT * FROM experience WHERE resume_id = ? ORDER BY id";
        List<Experience> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, resumeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Experience e = new Experience();
                    e.setId(rs.getInt("id"));
                    e.setResumeId(rs.getInt("resume_id"));
                    e.setCompany(rs.getString("company"));
                    e.setPosition(rs.getString("position"));
                    e.setStartDate(rs.getString("start_date"));
                    e.setEndDate(rs.getString("end_date"));
                    e.setCurrentJob(rs.getBoolean("current_job"));
                    e.setDescription(rs.getString("description"));
                    list.add(e);
                }
            }
        }
        return list;
    }

    public void deleteByResumeId(int resumeId) throws SQLException {
        String sql = "DELETE FROM experience WHERE resume_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, resumeId);
            ps.executeUpdate();
        }
    }
}
