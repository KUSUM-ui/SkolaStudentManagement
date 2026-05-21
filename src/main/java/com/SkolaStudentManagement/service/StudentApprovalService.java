package com.SkolaStudentManagement.service;

import java.util.ArrayList;
import java.util.List;

import com.SkolaStudentManagement.dao.RegisterDAO;
import com.SkolaStudentManagement.model.StudentModel;

public class StudentApprovalService {

    private final RegisterDAO registerDAO;

    public StudentApprovalService() {
        registerDAO = new RegisterDAO();
    }

    // =========================
    // GET PENDING
    // =========================
    public List<StudentModel> getPendingStudents() {

        try {
            return registerDAO.getStudentsByStatus("PENDING");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }

    // =========================
    // GET APPROVED
    // =========================
    public List<StudentModel> getApprovedStudents() {

        try {
            return registerDAO.getStudentsByStatus("APPROVED");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }

    // =========================
    // GET REJECTED
    // =========================
    public List<StudentModel> getRejectedStudents() {

        try {
            return registerDAO.getStudentsByStatus("REJECTED");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }

    // =========================
    // COUNTS
    // =========================
    public int getPendingCount() {
        return getPendingStudents().size();
    }

    public int getApprovedCount() {
        return getApprovedStudents().size();
    }

    public int getRejectedCount() {
        return getRejectedStudents().size();
    }

    // =========================
    // APPROVE
    // =========================
    public boolean approveStudent(int studentId) {

        try {
            return registerDAO.updateStudentStatus(
                    studentId,
                    "APPROVED");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // REJECT
    // =========================
    public boolean rejectStudent(int studentId) {

        try {
            return registerDAO.updateStudentStatus(
                    studentId,
                    "REJECTED");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}