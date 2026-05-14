package com.SkolaStudentManagement.DAO;

import com.SkolaStudentManagement.Model.Classreservationmodel;
import com.SkolaStudentManagement.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassReservationDAO {

    // ── Student: submit a new reservation ────────────────────────────
    public boolean addReservation(Classreservationmodel r) {
        String sql = "INSERT INTO ClassReservation (student_id, first_name, date, time_from, time_to, comment, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 'Pending')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, r.getStudentId());
            ps.setString(2, r.getFirstName());
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

    // ── Student: get all reservations for one student ─────────────────
    public List<Classreservationmodel> getReservationsByStudent(int studentId) {
        String sql = "SELECT * FROM ClassReservation WHERE student_id = ? ORDER BY created_at DESC";
        List<Classreservationmodel> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── Admin: get all pending reservations ───────────────────────────
    public List<Classreservationmodel> getAllReservations() {
        String sql = "SELECT * FROM ClassReservation ORDER BY created_at DESC";
        List<Classreservationmodel> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── Admin: approve or disapprove ──────────────────────────────────
    public boolean updateStatus(int reservationId, String status) {
        String sql = "UPDATE ClassReservation SET status = ? WHERE reservation_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, reservationId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── Private: map ResultSet row to model ───────────────────────────
    private Classreservationmodel mapRow(ResultSet rs) throws SQLException {
    	Classreservationmodel r = new Classreservationmodel();
        r.setReservationId(rs.getInt("reservation_id"));
        r.setStudentId(rs.getInt("student_id"));
        r.setFirstName(rs.getString("first_name"));
        r.setDate(rs.getDate("date"));
        r.setTimeFrom(rs.getTime("time_from"));
        r.setTimeTo(rs.getTime("time_to"));
        r.setComment(rs.getString("comment"));
        r.setStatus(rs.getString("status"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        return r;
    }
}