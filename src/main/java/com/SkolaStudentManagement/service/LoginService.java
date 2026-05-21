package com.SkolaStudentManagement.service;

import com.SkolaStudentManagement.dao.LoginDAO;
import com.SkolaStudentManagement.utils.PasswordUtil;


public class LoginService {

    public boolean login(String email, String password, String role) throws Exception {

        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("Email and password are required.");
        }

        LoginDAO dao = new LoginDAO();
        String storedHash = dao.getUserByEmail(email.trim(), role);
        System.out.println("DB stored hash: " + storedHash);

        if (storedHash == null) {
            return false;
        }

        return PasswordUtil.checkPassword(password, storedHash);
    }
    
}