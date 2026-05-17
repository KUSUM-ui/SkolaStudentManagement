package com.service;
import com.DAO.NotesDAO;
import com.model.Notes;
import java.util.List;

public class NotesService {
    private final NotesDAO notesDAO = new NotesDAO();

    public List<Notes> getNotesByStudentId(int studentId) {
        return notesDAO.getNotesByStudentId(studentId);
    }

    public List<Notes> searchNotesByTitle(int studentId, String keyword) {
        return notesDAO.searchNotesByTitle(studentId, keyword);
    }
}