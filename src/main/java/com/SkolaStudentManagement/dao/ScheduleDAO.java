package com.SkolaStudentManagement.dao;

import com.SkolaStudentManagement.model.Faculty;
import com.SkolaStudentManagement.model.Module;
import com.SkolaStudentManagement.model.Schedule;
import com.SkolaStudentManagement.model.Section;
import com.SkolaStudentManagement.utils.DBconfig;

import java.sql.*;
import java.util.*;

public class ScheduleDAO {

    // ── Faculties ──────────────────────────────────────────
    public List<Faculty> getAllFaculties() throws SQLException {
        List<Faculty> list = new ArrayList<>();
        String sql = "SELECT faculty_id, faculty_name FROM faculty ORDER BY faculty_name";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Faculty f = new Faculty();
                f.setFacultyId(rs.getInt("faculty_id"));
                f.setFacultyName(rs.getString("faculty_name"));
                list.add(f);
            }
        }
        return list;
    }

    // ── Sections ───────────────────────────────────────────
    public List<Section> getSectionsByFaculty(int facultyId) throws SQLException {
        List<Section> list = new ArrayList<>();
        String sql = "SELECT section_id, section_name FROM section WHERE faculty_id = ? ORDER BY section_name";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, facultyId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Section s = new Section();
                    s.setSectionId(rs.getString("section_id"));
                    s.setSectionName(rs.getString("section_name"));
                    s.setFacultyId(facultyId);
                    list.add(s);
                }
            }
        }
        return list;
    }

    // ── Modules and semester ────────────────────────────────────────────
    public List<Module> getModulesByFacultyAndSemester(int facultyId, int semester) throws SQLException {
        List<Module> list = new ArrayList<>();
        String sql = "SELECT module_id, module_name FROM module WHERE faculty_id = ? AND semester = ? ORDER BY module_name";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, facultyId);
            ps.setInt(2, semester);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Module m = new Module();
                    m.setModuleId(rs.getInt("module_id"));
                    m.setModuleName(rs.getString("module_name"));
                    m.setFacultyId(facultyId);
                    list.add(m);
                }
            }
        }
        return list;
    }



    public void deleteScheduleBySection(Connection conn, String sectionId) throws SQLException {
        String sql = "DELETE FROM schedule WHERE section_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sectionId);
            ps.executeUpdate();
        }
    }
    public int getTotalFaculties() throws Exception {
        Connection con = DBconfig.getConnection();
        String sql = "SELECT COUNT(*) FROM faculty";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        int count = 0;
        if (rs.next()) count = rs.getInt(1);
        rs.close(); pst.close(); con.close();
        return count;
    }

    public void insertScheduleBatch(Connection conn, List<Schedule> schedules) throws SQLException {
        String sql = "INSERT INTO schedule (section_id, module_id, day, start_time, end_time) VALUES (?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (Schedule sc : schedules) {
                ps.setString(1, sc.getSectionId());
                ps.setInt   (2, sc.getModuleId());
                ps.setString(3, sc.getDay());
                ps.setString(4, sc.getStartTime());
                ps.setString(5, sc.getEndTime());
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }
    public List<Schedule> getScheduleBySection(String sectionId) throws SQLException {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT s.schedule_id, s.day, s.start_time, s.end_time, " +
                     "s.module_id, m.module_name " +
                     "FROM schedule s " +
                     "JOIN module m ON s.module_id = m.module_id " +
                     "WHERE s.section_id = ? " +
                     "ORDER BY FIELD(s.day,'Sunday','Monday','Tuesday','Wednesday','Thursday'), s.start_time";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sectionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Schedule sc = new Schedule();
                    sc.setScheduleId(rs.getInt("schedule_id"));
                    sc.setSectionId(sectionId);
                    sc.setDay(rs.getString("day"));
                    sc.setModuleId(rs.getInt("module_id"));
                    sc.setModuleName(rs.getString("module_name"));
                    
                    // SAFE TIME STRIPPING: Prevents StringIndexOutOfBoundsException crashes
                    String rawStart = rs.getString("start_time");
                    String rawEnd = rs.getString("end_time");
                    
                    sc.setStartTime(rawStart != null && rawStart.length() >= 5 ? rawStart.substring(0, 5) : rawStart);
                    sc.setEndTime(rawEnd != null && rawEnd.length() >= 5 ? rawEnd.substring(0, 5) : rawEnd);
                    
                    list.add(sc);
                }
            }
        }
        return list;
    }
    
}