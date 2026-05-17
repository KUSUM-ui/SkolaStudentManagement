package com.SkolaStudentManagement.DAO;

import com.SkolaStudentManagement.Model.ScheduleModel;
import com.SkolaStudentManagement.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScheduleDAO {

    public List<ScheduleModel> getScheduleBySection(String sectionId) throws SQLException {
        String sql = "SELECT s.schedule_id, s.section_id, s.module_id, s.day, " +
                     "       s.start_time, s.end_time, m.module_name " +
                     "FROM Schedule s " +
                     "JOIN Module m ON s.module_id = m.module_id " +
                     "WHERE s.section_id = ? " +
                     "ORDER BY FIELD(s.day,'Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'), " +
                     "         s.start_time ASC";

        List<ScheduleModel> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, sectionId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ScheduleModel s = new ScheduleModel();
                    s.setScheduleId(rs.getInt("schedule_id"));
                    s.setSectionId(rs.getString("section_id"));
                    s.setModuleId(rs.getInt("module_id"));
                    s.setDay(rs.getString("day"));
                    Time start = rs.getTime("start_time");
                    Time end   = rs.getTime("end_time");
                    s.setStartTime(start != null ? start.toString().substring(0, 5) : "00:00");
                    s.setEndTime(end   != null ? end.toString().substring(0, 5)   : "00:00");
                    s.setModuleName(rs.getString("module_name"));
                    list.add(s);
                }
            }
        }
        return list;
    }
}