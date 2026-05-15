package com.SkolaStudentManagement.DAO;

import com.SkolaStudentManagement.Model.Notes;
import com.SkolaStudentManagement.utils.DBConnection;
import com.SkolaStudentManagement.Model.CreateNote;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CreateNoteDAO {

    public boolean saveNote(CreateNote createNote) {
        String sql = "INSERT INTO Notes (student_id, note_title, note_content) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
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
