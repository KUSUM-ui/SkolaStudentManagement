package com.DAO;

import com.model.ClassModel;
import com.utils.DBConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassDAO {

    public List<ClassModel> getAllClasses() {
        String sql = "SELECT class_id, class_name FROM class ORDER BY class_name ASC";
        List<ClassModel> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ClassModel c = new ClassModel();
                c.setClassId(rs.getInt("class_id"));
                c.setClassName(rs.getString("class_name"));
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}