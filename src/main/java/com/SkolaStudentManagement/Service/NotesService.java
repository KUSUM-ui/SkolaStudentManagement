package com.SkolaStudentManagement.Service;

import com.SkolaStudentManagement.DAO.NotesDAO;
import com.SkolaStudentManagement.Model.Notes;

import java.util.List;

public class NotesService {

    private final NotesDAO notesDAO = new NotesDAO();

    public List<Notes> getNotesByStudentId(int studentId) {
        return notesDAO.getNotesByStudentId(studentId);
    }
}
