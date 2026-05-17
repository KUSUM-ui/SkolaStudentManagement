package com.SkolaStudentManagement.Service;

import com.SkolaStudentManagement.DAO.ScheduleDAO;
import com.SkolaStudentManagement.Model.ScheduleModel;

import java.sql.SQLException;
import java.util.List;

public class ScheduleService {

    private final ScheduleDAO dao = new ScheduleDAO();

    public List<ScheduleModel> getScheduleForStudent(String sectionId) throws SQLException {
        if (sectionId == null || sectionId.trim().isEmpty()) {
            throw new IllegalArgumentException("Section ID cannot be empty.");
        }
        return dao.getScheduleBySection(sectionId);
    }
}