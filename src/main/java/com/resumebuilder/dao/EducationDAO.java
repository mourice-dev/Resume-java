package com.resumebuilder.dao;

import com.resumebuilder.model.Education;
import com.resumebuilder.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EducationDAO {

    public void addEducation(Education e) throws SQLException {
        String sql = "INSERT INTO education (resume_id, institution, degree, field_of_study, start_date, end_date, gpa, description) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, e.getResumeId());
            ps.setString(2, e.getInstitution());
            ps.setString(3, e.getDegree());
            ps.setString(4, e.getFieldOfStudy());
            ps.setString(5, e.getStartDate());
            ps.setString(6, e.getEndDate());
            ps.setString(7, e.getGpa());
            ps.setString(8, e.getDescription());
            ps.executeUpdate();
        }
    }

    public List<Education> getByResumeId(int resumeId) throws SQLException {
        String sql = "SELECT * FROM education WHERE resume_id = ? ORDER BY id";
        List<Education> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, resumeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Education e = new Education();
                    e.setId(rs.getInt("id"));
                    e.setResumeId(rs.getInt("resume_id"));
                    e.setInstitution(rs.getString("institution"));
                    e.setDegree(rs.getString("degree"));
                    e.setFieldOfStudy(rs.getString("field_of_study"));
                    e.setStartDate(rs.getString("start_date"));
                    e.setEndDate(rs.getString("end_date"));
                    e.setGpa(rs.getString("gpa"));
                    e.setDescription(rs.getString("description"));
                    list.add(e);
                }
            }
        }
        return list;
    }

    public void deleteByResumeId(int resumeId) throws SQLException {
        String sql = "DELETE FROM education WHERE resume_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, resumeId);
            ps.executeUpdate();
        }
    }
}
