package com.service;

import com.DAO.LoginDAO;
import org.mindrot.jbcrypt.BCrypt;

public class LoginService {

    private final LoginDAO loginDAO = new LoginDAO();

    public boolean login(String email, String password, String role) throws Exception {
        String hashedPassword = loginDAO.getUserByEmail(email, role);
        if (hashedPassword == null) {
            return false;
        }
        return BCrypt.checkpw(password, hashedPassword);
    }

    // ✅ Delegates to DAO — no SQL here
    public int getStudentId(String email) throws Exception {
        return loginDAO.getStudentIdByEmail(email);
    }
}