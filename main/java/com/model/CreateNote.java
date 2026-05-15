package com.model;

import java.sql.Timestamp;

public class CreateNote {
    private int noteId;
    private int studentId;
    private String noteTitle;
    private String noteContent;
    private Timestamp noteCreatedAt;

    public int getNoteId() { return noteId; }
    public void setNoteId(int noteId) { this.noteId = noteId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getNoteTitle() { return noteTitle; }
    public void setNoteTitle(String noteTitle) { this.noteTitle = noteTitle; }

    public String getNoteContent() { return noteContent; }
    public void setNoteContent(String noteContent) { this.noteContent = noteContent; }

    public Timestamp getNoteCreatedAt() { return noteCreatedAt; }
    public void setNoteCreatedAt(Timestamp noteCreatedAt) { this.noteCreatedAt = noteCreatedAt; }
}