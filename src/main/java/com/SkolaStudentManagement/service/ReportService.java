package com.SkolaStudentManagement.service;

import com.SkolaStudentManagement.dao.ReportDAO;
import com.SkolaStudentManagement.model.Faculty;
import com.SkolaStudentManagement.model.Module;
import com.SkolaStudentManagement.model.Section;
import com.SkolaStudentManagement.model.StudentModel;

import java.util.List;
import java.util.Map;

public class ReportService {

    private final ReportDAO reportDAO = new ReportDAO();

    public List<Faculty> getAllFaculties() {
        return reportDAO.getAllFaculties();
    }

    public Map<Integer, List<Module>> getModulesByFaculty(int facultyId) {
        return reportDAO.getModulesByFaculty(facultyId);
    }

    public int countModulesByFaculty(int facultyId) {
        return reportDAO.countModulesByFaculty(facultyId);
    }

    public List<Section> getSectionsByFaculty(int facultyId) {
        return reportDAO.getSectionsByFaculty(facultyId);
    }

    public List<StudentModel> getStudents(int facultyId, String sectionId) {
        return reportDAO.getStudents(facultyId, sectionId);
    }

    public List<String> getStudentSectionIds(int facultyId, String sectionId) {
        return reportDAO.getStudentSectionIds(facultyId, sectionId);
    }

    public int countStudents(int facultyId, String sectionId) {
        return reportDAO.countStudents(facultyId, sectionId);
    }
}