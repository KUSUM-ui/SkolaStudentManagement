package com.SkolaStudentManagement.Service;

import com.SkolaStudentManagement.DAO.CreateNoteDAO;
import com.SkolaStudentManagement.Model.CreateNote;

public class CreateNoteService {

    private final CreateNoteDAO createNoteDAO = new CreateNoteDAO();

    public boolean saveNote(int studentId, String title, String content) {
        if (content == null || content.trim().isEmpty()) {
            return false;
        }

        CreateNote createNote = new CreateNote();
        createNote.setStudentId(studentId);
        createNote.setNoteTitle(title != null ? title.trim() : "");
        createNote.setNoteContent(content.trim());

        return CreateNoteDAO.saveNote(createNote);
    }
}
