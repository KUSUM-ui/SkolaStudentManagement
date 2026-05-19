package com.SkolaStudentManagement.DAO;

import com.SkolaStudentManagement.Model.Classreservationmodel;
import com.SkolaStudentManagement.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassReservationDAO {

    // ── Student: submit a new reservation ────────────────────────────
    public boolean addReservation(Classreservationmodel r) {
        String sql = "INSERT INTO ClassReservation "
                   + "(student_id, first_name, class_id, date, time_from, time_to, comment, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, 'Pending')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt   (1, r.getStudentId());
            ps.setString(2, r.getFirstName());
            ps.setInt   (3, r.getClassId());
            ps.setDate  (4, r.getDate());
            ps.setTime  (5, r.getTimeFrom());
            ps.setTime  (6, r.getTimeTo());
            ps.setString(7, r.getComment());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── Student: get all reservations for one student (with class name) ──
    public List<Classreservationmodel> getReservationsByStudent(int studentId) {
        String sql = "SELECT cr.*, c.class_name "
                   + "FROM ClassReservation cr "
                   + "JOIN class c ON cr.class_id = c.class_id "
                   + "WHERE cr.student_id = ? "
                   + "ORDER BY cr.created_at DESC";

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

    // ── Admin: get all reservations (with class name) ─────────────────
    public List<Classreservationmodel> getAllReservations() {
        String sql = "SELECT cr.*, c.class_name "
                   + "FROM ClassReservation cr "
                   + "JOIN class c ON cr.class_id = c.class_id "
                   + "ORDER BY cr.created_at DESC";

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
            ps.setInt   (2, reservationId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── Private: map ResultSet row to model ───────────────────────────
    private Classreservationmodel mapRow(ResultSet rs) throws SQLException {
        Classreservationmodel r = new Classreservationmodel();
        r.setReservationId(rs.getInt   ("reservation_id"));
        r.setStudentId    (rs.getInt   ("student_id"));
        r.setFirstName    (rs.getString("first_name"));
        r.setClassId      (rs.getInt   ("class_id"));
        r.setClassName    (rs.getString("class_name"));   // from JOIN
        r.setDate         (rs.getDate  ("date"));
        r.setTimeFrom     (rs.getTime  ("time_from"));
        r.setTimeTo       (rs.getTime  ("time_to"));
        r.setComment      (rs.getString("comment"));
        r.setStatus       (rs.getString("status"));
        r.setCreatedAt    (rs.getTimestamp("created_at"));
        return r;
    }
}