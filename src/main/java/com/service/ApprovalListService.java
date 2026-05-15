package com.service;
import com.dao.ApprovalListDAO;
import com.model.ApprovalListModel;
import java.util.List;

public class ApprovalListService {

    private ApprovalListDAO dao = new ApprovalListDAO();

    public List<ApprovalListModel> getPendingStudents() {
        return dao.getPendingStudents();
    }

    public boolean approveStudent(int studentId) {
        return dao.approveStudent(studentId);
    }
}