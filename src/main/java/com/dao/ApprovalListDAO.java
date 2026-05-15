package com.dao;
import com.model.ApprovalListModel;
import com.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ApprovalListDAO {

    public List<ApprovalListModel> getPendingStudents() {
        List<ApprovalListModel> list = new ArrayList<>();
        String sql = "SELECT student_id, first_name, last_name, status " +
                     "FROM student WHERE status = 'NOT APPROVED'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ApprovalListModel student = new ApprovalListModel();
                student.setStudentId(rs.getInt("student_id"));
                student.setFirstName(rs.getString("first_name"));
                student.setLastName(rs.getString("last_name"));
                student.setStatus(rs.getString("status"));
                list.add(student);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ApprovalListModel> searchStudents(String search) {
        List<ApprovalListModel> list = new ArrayList<>();

        String sql = "SELECT student_id, first_name, last_name, status " +
                     "FROM student WHERE status = 'NOT APPROVED' " +
                     "AND (first_name LIKE ? OR last_name LIKE ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ApprovalListModel s = new ApprovalListModel();
                s.setStudentId(rs.getInt("student_id"));
                s.setFirstName(rs.getString("first_name"));
                s.setLastName(rs.getString("last_name"));
                s.setStatus(rs.getString("status"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean approveStudent(int studentId) {
        String sql = "UPDATE student SET status = 'APPROVED' WHERE student_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}