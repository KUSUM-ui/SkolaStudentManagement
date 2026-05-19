package com.SkolaStudentManagement.Service;

import com.SkolaStudentManagement.DAO.ViewnotesDAO;
import com.SkolaStudentManagement.Model.Viewnotes;
import java.util.List;

public class ViewnotesService {

    private final ViewnotesDAO viewnotesDAO = new ViewnotesDAO();

    public Viewnotes getNoteById(int noteId) {
        return viewnotesDAO.getNoteById(noteId);
    }

    public List<Viewnotes> getNotesByStudentId(int studentId) {
        return viewnotesDAO.getNotesByStudentId(studentId);
    }

    public boolean deleteNote(int noteId) {
        return viewnotesDAO.deleteNote(noteId);
    }
}