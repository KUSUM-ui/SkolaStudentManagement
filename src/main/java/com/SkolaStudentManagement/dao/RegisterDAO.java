package com.SkolaStudentManagement.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.utils.DBconfig;

public class RegisterDAO {

    // =========================
    // 1. INSERT STUDENT (REGISTER)
    //    Now includes grade_level and section_id collected at registration time.
    // =========================
    public void insertStudent(String firstName, String lastName, String dob,
                              String gender, String email, String phone,
                              String password, int facultyId, String sectionId,
                              String gradeLevel, String image,
                              String status) throws Exception {

        Connection con = DBconfig.getConnection();

        String sql = "INSERT INTO student "
                   + "(first_name, last_name, dob, gender, email, phone, password, "
                   + " faculty_id, section_id, grade_level, image, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1,  firstName);
        pst.setString(2,  lastName);
        pst.setString(3,  dob);
        pst.setString(4,  gender);
        pst.setString(5,  email);
        pst.setString(6,  phone);
        pst.setString(7,  password);
        pst.setInt(8,     facultyId);
        pst.setString(9,  sectionId);
        pst.setString(10, gradeLevel);
        pst.setString(11, image);
        pst.setString(12, status);

        pst.executeUpdate();
        pst.close();
        con.close();
    }

    // =========================
    // 2. GET ALL STUDENTS
    // =========================
    public List<StudentModel> getAllStudents() throws Exception {

        List<StudentModel> students = new ArrayList<>();
        Connection con = DBconfig.getConnection();

        String sql = "SELECT * FROM student";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            StudentModel s = new StudentModel();
            s.setStudentId(rs.getInt("student_id"));
            s.setFirstName(rs.getString("first_name"));
            s.setLastName(rs.getString("last_name"));
            s.setDob(rs.getDate("dob"));
            s.setGender(rs.getString("gender"));
            s.setEmail(rs.getString("email"));
            s.setNumber(rs.getString("phone"));
            s.setFacultyId(String.valueOf(rs.getInt("faculty_id")));
            s.setImage(rs.getString("image"));
            s.setStatus(rs.getString("status"));
            students.add(s);
        }

        rs.close(); pst.close(); con.close();
        return students;
    }

    // =========================
    // 3. GET PENDING STUDENTS
    // =========================
    public List<StudentModel> getPendingStudents() throws Exception {

        List<StudentModel> list = new ArrayList<>();
        Connection con = DBconfig.getConnection();

        String sql = "SELECT * FROM student WHERE status='PENDING' ORDER BY student_id DESC";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            StudentModel s = new StudentModel();
            s.setStudentId(rs.getInt("student_id"));
            s.setFirstName(rs.getString("first_name"));
            s.setLastName(rs.getString("last_name"));
            s.setEmail(rs.getString("email"));
            s.setNumber(rs.getString("phone"));
            s.setImage(rs.getString("image"));
            s.setStatus(rs.getString("status"));
            list.add(s);
        }

        rs.close(); pst.close(); con.close();
        return list;
    }

    // =========================
    // 4. APPROVE STUDENT
    // =========================
    public boolean approveStudent(int studentId) throws Exception {

        Connection con = DBconfig.getConnection();
        String sql = "UPDATE student SET status='APPROVED' WHERE student_id=?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, studentId);

        int rows = pst.executeUpdate();
        pst.close(); con.close();
        return rows > 0;
    }

    // =========================
    // 5. GET STUDENTS BY STATUS
    // =========================
    public List<StudentModel> getStudentsByStatus(String status) throws Exception {

        List<StudentModel> list = new ArrayList<>();
        Connection con = DBconfig.getConnection();

        String sql = "SELECT s.student_id, s.first_name, s.last_name, s.email, s.phone, "
                   + "       s.image, s.status, f.faculty_name AS course "
                   + "FROM student s "
                   + "LEFT JOIN faculty f ON s.faculty_id = f.faculty_id "
                   + "WHERE s.status = ? "
                   + "ORDER BY s.student_id DESC";

        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, status);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            StudentModel s = new StudentModel();
            s.setStudentId(rs.getInt("student_id"));
            s.setFirstName(rs.getString("first_name"));
            s.setLastName(rs.getString("last_name"));
            s.setEmail(rs.getString("email"));
            s.setNumber(rs.getString("phone"));
            s.setImage(rs.getString("image"));
            s.setStatus(rs.getString("status"));
            try { s.setFacultyName(rs.getString("course")); } catch (Exception ignored) {}
            list.add(s);
        }

        rs.close(); pst.close(); con.close();
        return list;
    }

    // =========================
    // 6. UPDATE STUDENT STATUS
    // =========================
    public boolean updateStudentStatus(int studentId, String status) throws Exception {

        Connection con = DBconfig.getConnection();
        String sql = "UPDATE student SET status = ? WHERE student_id = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, status);
        pst.setInt(2, studentId);

        int rows = pst.executeUpdate();
        pst.close(); con.close();
        return rows > 0;
    }

    // =========================
    // 7. GET STUDENT BY EMAIL
    // =========================
    public StudentModel getStudentByEmail(String email) throws Exception {

        Connection con = DBconfig.getConnection();
        String sql = "SELECT * FROM student WHERE email = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, email);

        ResultSet rs = pst.executeQuery();
        StudentModel student = null;

        if (rs.next()) {
            student = new StudentModel();
            student.setStudentId(rs.getInt("student_id"));
            student.setFirstName(rs.getString("first_name"));
            student.setLastName(rs.getString("last_name"));
            student.setDob(rs.getDate("dob"));
            student.setGender(rs.getString("gender"));
            student.setEmail(rs.getString("email"));
            student.setNumber(rs.getString("phone"));
            student.setFacultyId(String.valueOf(rs.getInt("faculty_id")));
            student.setSectionId(rs.getString("section_id"));
            student.setGradeLevel(rs.getString("grade_level"));
            student.setImage(rs.getString("image"));
            student.setStatus(rs.getString("status"));
        }

        rs.close(); pst.close(); con.close();
        return student;
    }
}