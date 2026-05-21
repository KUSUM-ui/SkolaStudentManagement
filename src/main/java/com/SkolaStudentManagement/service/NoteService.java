package com.SkolaStudentManagement.service;

import com.SkolaStudentManagement.dao.NotesDAO;
import com.SkolaStudentManagement.model.Notes;
import java.util.List;

public class NoteService {
    
    // FIX: Single, clean DAO reference shared by all method mappings
    private final NotesDAO notesDAO = new NotesDAO();

    public boolean saveNote(int studentId, String title, String content) {
        if (content == null || content.trim().isEmpty()) {
            return false;
        }

        Notes createNote = new Notes();
        createNote.setStudentId(studentId);
        createNote.setNoteTitle(title != null ? title.trim() : "Untitled Note");
        createNote.setNoteContent(content.trim());

        return notesDAO.saveNote(createNote);
    }
    
    public List<Notes> getNotesByStudentId(int studentId) {
        return notesDAO.getNotesByStudentId(studentId);
    }

    public List<Notes> searchNotesByTitle(int studentId, String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return notesDAO.getNotesByStudentId(studentId);
        }
        return notesDAO.searchNotesByTitle(studentId, keyword.trim());
    }
    
    public Notes getNoteById(int noteId) {
        return notesDAO.getNoteById(noteId);
    }

    public boolean deleteNote(int noteId) {
        return notesDAO.deleteNote(noteId);
    }
}