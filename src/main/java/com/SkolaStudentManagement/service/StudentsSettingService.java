package com.SkolaStudentManagement.service;

import java.sql.SQLException;

import com.SkolaStudentManagement.dao.StudentSettingsDAO;
import com.SkolaStudentManagement.model.SettingsStudentModel;

public class StudentsSettingService {
	 private final StudentSettingsDAO dao = new StudentSettingsDAO();

	    public SettingsStudentModel getStudentById(int studentId) {
	        return dao.getStudentById(studentId);
	    }

	    public boolean updatePhone(int studentId, String phone) {
	        if (phone == null || phone.trim().isEmpty()) return false;
	        if (!phone.trim().matches("^[+]?[0-9]{7,15}$")) return false;
	        return dao.updatePhone(studentId, phone.trim());
	    }

	    public boolean updatePassword(int studentId, String current,
	                                  String newPass, String confirm,
	                                  String actualPassword) throws SQLException {
	        if (!current.equals(actualPassword)) return false;
	        if (!newPass.equals(confirm))        return false;
	        if (newPass.length() < 6)            return false;
	        return dao.updatePassword(studentId, newPass);
	    }

	    public boolean updateImage(int studentId, String relativePath) {
	        return dao.updateImage(studentId, relativePath);
	    }

	    public boolean removeImage(int studentId) {
	        return dao.updateImage(studentId, "");
	    }
}
