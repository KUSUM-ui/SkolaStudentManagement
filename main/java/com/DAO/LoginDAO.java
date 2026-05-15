package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.utils.DBConfig;

public class LoginDAO {

    public String getUserByEmail(String email, String role) throws Exception {

        
        String table;
        if ("admin".equalsIgnoreCase(role)) {
            table = "admin";
        } else {
            table = "student";
        }

        String sql = "SELECT password FROM " + table + " WHERE email = ?";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, email);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("password");
                }
                return null; // email not found in this table
            }
        }
    }
}
