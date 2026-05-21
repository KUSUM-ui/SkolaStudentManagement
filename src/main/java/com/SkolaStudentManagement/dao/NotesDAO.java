package com.SkolaStudentManagement.dao;

import com.SkolaStudentManagement.model.Notes;
import com.SkolaStudentManagement.utils.DBconfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NotesDAO {


    public List<Notes> searchNotesByTitle(int studentId, String keyword) {
        List<Notes> notesList = new ArrayList<>();
        String sql = "SELECT note_id, student_id, note_title, note_content, note_created_at " +
                     "FROM Notes WHERE student_id = ? AND LOWER(note_title) LIKE ? " +
                     "ORDER BY note_created_at DESC";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setString(2, "%" + keyword.toLowerCase().trim() + "%");
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
    
    public boolean saveNote(Notes createNote) {
        String sql = "INSERT INTO Notes (student_id, note_title, note_content) VALUES (?, ?, ?)";
        try (Connection conn = DBconfig.getConnection();
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
    
    
    public Notes getNoteById(int noteId) {
        String sql = "SELECT * FROM Notes WHERE note_id = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, noteId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Notes note = new Notes();
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

    public List<Notes> getNotesByStudentId(int studentId) {
        List<Notes> notes = new ArrayList<>();
        String sql = "SELECT * FROM Notes WHERE student_id = ? ORDER BY note_created_at DESC";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Notes note = new Notes();
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
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, noteId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    

}
