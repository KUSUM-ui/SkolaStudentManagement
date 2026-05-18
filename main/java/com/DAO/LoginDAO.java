package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.utils.DBConfig;

public class LoginDAO {

    public String getUserByEmail(String email, String role) throws Exception {
        
        String table = "admin".equalsIgnoreCase(role) ? "Admin" : "Student";
        String sql = "SELECT password FROM " + table + " WHERE email = ?";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, email);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("password");
                }
                return null;
            }
        }
    }

    
    public int getStudentIdByEmail(String email) throws Exception {
        String sql = "SELECT student_id FROM Student WHERE email = ?";
        try (Connection con = DBConfig.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, email);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("student_id");
                }
            }
        }
        return -1;
    }
}