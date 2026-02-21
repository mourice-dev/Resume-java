package com.resumebuilder.dao;

import com.resumebuilder.model.Skill;
import com.resumebuilder.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SkillDAO {

    public void addSkill(Skill s) throws SQLException {
        String sql = "INSERT INTO skills (resume_id, skill_name, proficiency) VALUES (?,?,?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, s.getResumeId());
            ps.setString(2, s.getSkillName());
            ps.setString(3, s.getProficiency());
            ps.executeUpdate();
        }
    }

    public List<Skill> getByResumeId(int resumeId) throws SQLException {
        String sql = "SELECT * FROM skills WHERE resume_id = ? ORDER BY id";
        List<Skill> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, resumeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Skill s = new Skill();
                    s.setId(rs.getInt("id"));
                    s.setResumeId(rs.getInt("resume_id"));
                    s.setSkillName(rs.getString("skill_name"));
                    s.setProficiency(rs.getString("proficiency"));
                    list.add(s);
                }
            }
        }
        return list;
    }

    public void deleteByResumeId(int resumeId) throws SQLException {
        String sql = "DELETE FROM skills WHERE resume_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, resumeId);
            ps.executeUpdate();
        }
    }
}
