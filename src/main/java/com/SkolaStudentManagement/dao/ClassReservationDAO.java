package com.SkolaStudentManagement.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.SkolaStudentManagement.model.ClassReservation;
import com.SkolaStudentManagement.utils.DBconfig;

public class ClassReservationDAO {

	public boolean addReservation(ClassReservation r) {
	  
	    String sql = "INSERT INTO ClassReservation (student_id, class_id, date, time_from, time_to, comment, status) " +
	                 "VALUES (?, ?, ?, ?, ?, ?, 'Pending')";
	                 
	    try (Connection conn = DBconfig.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, r.getStudentId());
	        ps.setInt(2, r.getClassId());
	        ps.setDate(3, r.getDate());
	        ps.setTime(4, r.getTimeFrom());
	        ps.setTime(5, r.getTimeTo());
	        ps.setString(6, r.getComment());
	        
	        return ps.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace(); 
	        return false;
	    }
	}

	public List<ClassReservation> getReservationsByStudent(int studentId) {
	    // FIX: Changed s.firstName to s.first_name
	    String sql = "SELECT cr.*, c.class_name, s.first_name AS first_name "
	               + "FROM ClassReservation cr "
	               + "LEFT JOIN class c ON cr.class_id = c.class_id "
	               + "LEFT JOIN student s ON cr.student_id = s.student_id " 
	               + "WHERE cr.student_id = ? "
	               + "ORDER BY cr.created_at DESC";

	    List<ClassReservation> list = new ArrayList<>();
	    try (Connection conn = DBconfig.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, studentId);
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                list.add(mapRow(rs));
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace(); 
	    }
	    return list;
	}

	public List<ClassReservation> getAllReservations() {
	    // FIX: Changed s.firstName to s.first_name here as well
	    String sql = "SELECT cr.*, c.class_name, s.first_name AS first_name "
	               + "FROM ClassReservation cr "
	               + "LEFT JOIN class c ON cr.class_id = c.class_id "
	               + "LEFT JOIN student s ON cr.student_id = s.student_id " 
	               + "ORDER BY cr.created_at DESC";

	    List<ClassReservation> list = new ArrayList<>();
	    try (Connection conn = DBconfig.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            list.add(mapRow(rs));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}
    public List<ClassReservation> getReservationsByStatus(String status) {
        String sql = "SELECT cr.*, c.class_name FROM ClassReservation cr LEFT JOIN class c ON cr.class_id = c.class_id WHERE cr.status = ? ORDER BY cr.created_at DESC";
        List<ClassReservation> list = new ArrayList<>();
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int reservationId, String status) {
        String sql = "UPDATE ClassReservation SET status = ? WHERE reservation_id = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, reservationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getTotalReservations() {
        String sql = "SELECT COUNT(*) FROM ClassReservation";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getPendingCount() {
        String sql = "SELECT COUNT(*) FROM ClassReservation WHERE status = 'Pending'";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private ClassReservation mapRow(ResultSet rs) throws SQLException {
        ClassReservation r = new ClassReservation();
        r.setReservationId(rs.getInt("reservation_id"));
        r.setStudentId(rs.getInt("student_id"));
        r.setClassId(rs.getInt("class_id"));
        r.setDate(rs.getDate("date"));
        r.setTimeFrom(rs.getTime("time_from"));
        r.setTimeTo(rs.getTime("time_to"));
        r.setComment(rs.getString("comment"));
        r.setStatus(rs.getString("status"));
        
        // Safely reads the values returned by the SQL Aliases
        try { r.setClassName(rs.getString("class_name")); } catch (SQLException e) { r.setClassName(null); }
        try { r.setFirstName(rs.getString("first_name")); } catch (SQLException e) { r.setFirstName(null); }

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            r.setCreatedAt(ts.toLocalDateTime());
        }
        return r;
    }
}