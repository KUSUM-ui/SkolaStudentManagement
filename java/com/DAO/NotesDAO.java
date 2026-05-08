package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.model.Notes;
import com.utils.DBConfig;

public class NotesDAO {

    public List<Notes> getNotesByStudentId(int studentId) throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "SELECT note_id, note_title, note_content, note_created_at FROM Notes WHERE student_id = ? ORDER BY note_created_at DESC";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, studentId);
        ResultSet rs = pst.executeQuery();
        List<Notes> list = new ArrayList<>();
        while (rs.next()) {
            Notes n = new Notes();
            n.setNoteId(rs.getInt("note_id"));
            n.setNoteTitle(rs.getString("note_title"));
            n.setNoteContent(rs.getString("note_content"));
            n.setNoteCreatedAt(rs.getTimestamp("note_created_at"));
            list.add(n);
        }
        rs.close();
        pst.close();
        con.close();
        return list;
    }

    public void addNote(int studentId, String title, String content) throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "INSERT INTO Notes (student_id, note_title, note_content) VALUES (?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, studentId);
        pst.setString(2, title);
        pst.setString(3, content);
        pst.executeUpdate();
        pst.close();
        con.close();
    }

    public void deleteNote(int noteId, int studentId) throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "DELETE FROM Notes WHERE note_id = ? AND student_id = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, noteId);
        pst.setInt(2, studentId);
        pst.executeUpdate();
        pst.close();
        con.close();
    }
}