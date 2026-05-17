package com.service;

import com.DAO.ViewnotesDAO;
import com.model.Viewnotes;

import java.util.List;

public class ViewnotesService {

    private final ViewnotesDAO viewnotesDAO = new ViewnotesDAO();

    public Viewnotes getNoteById(int noteId) {
        return viewnotesDAO.getNoteById(noteId);
    }

    public List<Viewnotes> getNotesByStudentId(int studentId) {
        return viewnotesDAO.getNotesByStudentId(studentId);
    }
}