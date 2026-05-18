package com.service;

import com.DAO.ClassReservationDAO;
import com.DAO.ClassDAO;
import com.model.ClassModel;
import com.model.Classreservationmodel;

import java.util.List;

public class ClassReservationService {

    private final ClassReservationDAO reservationDAO = new ClassReservationDAO();
    private final ClassDAO classDAO = new ClassDAO();

    public List<ClassModel> getAllClasses() {
        return classDAO.getAllClasses();
    }

    public boolean addReservation(Classreservationmodel r) {
        return reservationDAO.addReservation(r);
    }

    public List<Classreservationmodel> getReservationsByStudent(int studentId) {
        return reservationDAO.getReservationsByStudent(studentId);
    }

    public List<Classreservationmodel> getAllReservations() {
        return reservationDAO.getAllReservations();
    }

    public boolean updateStatus(int reservationId, String status) {
        return reservationDAO.updateStatus(reservationId, status);
    }
}