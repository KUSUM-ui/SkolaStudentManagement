package com.DAO;

import com.model.CreateNote;
import com.utils.DBConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CreateNoteDAO {

    public boolean saveNote(CreateNote createNote) {
        String sql = "INSERT INTO Notes (student_id, note_title, note_content) VALUES (?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, createNote.getStudentId());
            ps.setString(2, createNote.getNoteTitle());
            ps.setString(3, createNote.getNoteContent());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
