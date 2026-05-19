package com.SkolaStudentManagement.DAO;

import com.SkolaStudentManagement.Model.ClassModel;
import com.SkolaStudentManagement.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for the class table.
 * Columns: class_id, class_name
 */
public class ClassDAO {

    /**
     * Returns all classes ordered by class_name.
     * Used to populate the dropdown on the reservation form.
     */
    public List<ClassModel> getAllClasses() {
        String sql = "SELECT class_id, class_name FROM class ORDER BY class_name ASC";
        List<ClassModel> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new ClassModel(
                    rs.getInt("class_id"),
                    rs.getString("class_name")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}