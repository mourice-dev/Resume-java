package com.resumebuilder.dao;

import com.resumebuilder.model.Project;
import com.resumebuilder.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

    public void addProject(Project p) throws SQLException {
        String sql = "INSERT INTO projects (resume_id, project_name, description, technologies, url) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getResumeId());
            ps.setString(2, p.getProjectName());
            ps.setString(3, p.getDescription());
            ps.setString(4, p.getTechnologies());
            ps.setString(5, p.getUrl());
            ps.executeUpdate();
        }
    }

    public List<Project> getByResumeId(int resumeId) throws SQLException {
        String sql = "SELECT * FROM projects WHERE resume_id = ? ORDER BY id";
        List<Project> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, resumeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Project p = new Project();
                    p.setId(rs.getInt("id"));
                    p.setResumeId(rs.getInt("resume_id"));
                    p.setProjectName(rs.getString("project_name"));
                    p.setDescription(rs.getString("description"));
                    p.setTechnologies(rs.getString("technologies"));
                    p.setUrl(rs.getString("url"));
                    list.add(p);
                }
            }
        }
        return list;
    }

    public void deleteByResumeId(int resumeId) throws SQLException {
        String sql = "DELETE FROM projects WHERE resume_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, resumeId);
            ps.executeUpdate();
        }
    }
}
