package com.service;

import java.util.List;
import com.DAO.NotesDAO;
import com.model.Notes;

public class NotesService {

    private NotesDAO notesDAO = new NotesDAO();

    public List<Notes> getNotesByStudentId(int studentId) throws Exception {
        return notesDAO.getNotesByStudentId(studentId);
    }

    public void addNote(int studentId, String title, String content) throws Exception {
        if (title == null || title.trim().isEmpty()) {
            title = "Untitled";
        }
        if (content == null || content.trim().isEmpty()) {
            throw new Exception("Note content cannot be empty.");
        }
        notesDAO.addNote(studentId, title.trim(), content.trim());
    }

    public void deleteNote(int noteId, int studentId) throws Exception {
        notesDAO.deleteNote(noteId, studentId);
    }
}