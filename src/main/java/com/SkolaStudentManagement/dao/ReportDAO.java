package com.SkolaStudentManagement.dao;

import com.SkolaStudentManagement.model.Faculty;
import com.SkolaStudentManagement.model.Module;
import com.SkolaStudentManagement.model.Section;
import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.utils.DBconfig;

import java.sql.*;
import java.util.*;

public class ReportDAO {

    // ── Faculties ──────────────────────────────────────────
    public List<Faculty> getAllFaculties() {
        List<Faculty> list = new ArrayList<>();
        String sql = "SELECT faculty_id, faculty_name FROM Faculty ORDER BY faculty_name";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Faculty f = new Faculty();
                f.setFacultyId(rs.getInt("faculty_id"));
                f.setFacultyName(rs.getString("faculty_name"));
                list.add(f);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // ── Modules grouped by semester for a faculty ──────────
    public Map<Integer, List<Module>> getModulesByFaculty(int facultyId) {
        Map<Integer, List<Module>> map = new LinkedHashMap<>();
        String sql = "SELECT module_id, module_name, module_description, module_credits, semester " +
                     "FROM Module WHERE faculty_id = ? ORDER BY semester, module_name";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, facultyId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Module m = new Module();
                    m.setModuleId(rs.getInt("module_id"));
                    m.setModuleName(rs.getString("module_name"));
                    m.setModule_description(rs.getString("module_description"));
                    m.setModule_credits(rs.getInt("module_credits"));
                    m.setSemester(rs.getInt("semester"));
                    m.setFacultyId(facultyId);
                    map.computeIfAbsent(m.getSemester(), k -> new ArrayList<>()).add(m);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return map;
    }

    public int countModulesByFaculty(int facultyId) {
        String sql = facultyId > 0
            ? "SELECT COUNT(*) FROM Module WHERE faculty_id = ?"
            : "SELECT COUNT(*) FROM Module";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (facultyId > 0) ps.setInt(1, facultyId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // ── Sections filtered by faculty ───────────────────────
    public List<Section> getSectionsByFaculty(int facultyId) {
        List<Section> list = new ArrayList<>();
        String sql = "SELECT section_id, section_name FROM Section " +
                     "WHERE faculty_id = ? ORDER BY section_id";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, facultyId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Section s = new Section();
                    s.setSectionId(rs.getString("section_id"));
                    s.setSectionName(rs.getString("section_name"));
                    list.add(s);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // ── Students: JOIN Faculty to get faculty_name, include section_id ──
    public List<StudentModel> getStudents(int facultyId, String sectionId) {
        List<StudentModel> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT s.student_id, s.first_name, s.last_name, " +
            "s.grade_level, s.section_id, s.faculty_id, f.faculty_name " +
            "FROM Student s " +
            "JOIN Faculty f ON s.faculty_id = f.faculty_id " +
            "WHERE s.faculty_id = ?");
        if (sectionId != null && !sectionId.isEmpty()) {
            sql.append(" AND s.section_id = ?");
        }
        sql.append(" ORDER BY s.section_id, s.last_name");
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            ps.setInt(1, facultyId);
            if (sectionId != null && !sectionId.isEmpty()) {
                ps.setString(2, sectionId);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StudentModel st = new StudentModel();
                    st.setStudentId(rs.getInt("student_id"));
                    st.setFirstName(rs.getString("first_name"));
                    st.setLastName(rs.getString("last_name"));
                    st.setGradeLevel(rs.getString("grade_level"));   // "1"–"6"
                    st.setSectionId(rs.getString("section_id"));     // ADD this field to StudentModel
                    st.setFacultyName(rs.getString("faculty_name")); // ADD this field to StudentModel
                    st.setProgram(rs.getInt("faculty_id"));
                    list.add(st);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
   
    // getStudentSectionIds() is no longer needed — sectionId is now on StudentModel directly.
    // Kept for backward compatibility but can be removed.
    public List<String> getStudentSectionIds(int facultyId, String sectionId) {
        List<String> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT s.section_id FROM Student s WHERE s.faculty_id = ?");
        if (sectionId != null && !sectionId.isEmpty()) {
            sql.append(" AND s.section_id = ?");
        }
        sql.append(" ORDER BY s.section_id, s.last_name");
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            ps.setInt(1, facultyId);
            if (sectionId != null && !sectionId.isEmpty()) {
                ps.setString(2, sectionId);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(rs.getString("section_id"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int countStudents(int facultyId, String sectionId) {
        boolean hasFaculty = facultyId > 0;
        boolean hasSection = sectionId != null && !sectionId.isEmpty();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Student");
        if (hasFaculty) sql.append(" WHERE faculty_id = ?");
        if (hasFaculty && hasSection) sql.append(" AND section_id = ?");
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            if (hasFaculty) {
                ps.setInt(1, facultyId);
                if (hasSection) ps.setString(2, sectionId);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
}