package com.DAO;

import com.model.Notes;
import com.utils.DBConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NotesDAO {

    public List<Notes> getNotesByStudentId(int studentId) {
        List<Notes> notesList = new ArrayList<>();
        String sql = "SELECT note_id, student_id, note_title, note_content, note_created_at " +
                     "FROM Notes WHERE student_id = ? ORDER BY note_created_at DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Notes note = new Notes();
                note.setNoteId(rs.getInt("note_id"));
                note.setStudentId(rs.getInt("student_id"));
                note.setNoteTitle(rs.getString("note_title"));
                note.setNoteContent(rs.getString("note_content"));
                note.setNoteCreatedAt(rs.getTimestamp("note_created_at"));
                notesList.add(note);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notesList;
    }
}