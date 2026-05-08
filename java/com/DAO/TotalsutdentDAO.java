package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.utils.DBConfig;

public class TotalsutdentDAO {

    public int getTotalStudentCount() throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "SELECT COUNT(student_id) AS total FROM Student";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        int count = 0;
        if (rs.next()) {
            count = rs.getInt("total");
        }
        rs.close();
        pst.close();
        con.close();
        return count;
    }
}