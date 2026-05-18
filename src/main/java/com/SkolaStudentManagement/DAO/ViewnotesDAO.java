package com.SkolaStudentManagement.DAO;
import com.SkolaStudentManagement.Model.Viewnotes;
import com.SkolaStudentManagement.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ViewnotesDAO {

    public Viewnotes getNoteById(int noteId) {
        String sql = "SELECT * FROM Notes WHERE note_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, noteId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Viewnotes note = new Viewnotes();
                note.setNoteId(rs.getInt("note_id"));
                note.setNoteTitle(rs.getString("note_title"));
                note.setNoteContent(rs.getString("note_content"));
                note.setNoteCreatedAt(rs.getTimestamp("note_created_at"));
                note.setStudentId(rs.getInt("student_id"));
                return note;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Viewnotes> getNotesByStudentId(int studentId) {
        List<Viewnotes> notes = new ArrayList<>();
        String sql = "SELECT * FROM Notes WHERE student_id = ? ORDER BY note_created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Viewnotes note = new Viewnotes();
                note.setNoteId(rs.getInt("note_id"));
                note.setNoteTitle(rs.getString("note_title"));
                note.setNoteContent(rs.getString("note_content"));
                note.setNoteCreatedAt(rs.getTimestamp("note_created_at"));
                note.setStudentId(rs.getInt("student_id"));
                notes.add(note);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return notes;
    }

    public boolean deleteNote(int noteId) {
        String sql = "DELETE FROM Notes WHERE note_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, noteId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
