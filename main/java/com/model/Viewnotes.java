package com.model;

import java.sql.Timestamp;

public class Viewnotes {

    private int noteId;
    private String noteTitle;
    private String noteContent;
    private Timestamp noteCreatedAt;
    private int studentId;

    public Viewnotes() {}

    public Viewnotes(int noteId, String noteTitle, String noteContent, Timestamp noteCreatedAt, int studentId) {
        this.noteId = noteId;
        this.noteTitle = noteTitle;
        this.noteContent = noteContent;
        this.noteCreatedAt = noteCreatedAt;
        this.studentId = studentId;
    }

    public int getNoteId()              { return noteId; }
    public String getNoteTitle()        { return noteTitle; }
    public String getNoteContent()      { return noteContent; }
    public Timestamp getNoteCreatedAt() { return noteCreatedAt; }
    public int getStudentId()           { return studentId; }

    public void setNoteId(int noteId)                     { this.noteId = noteId; }
    public void setNoteTitle(String noteTitle)             { this.noteTitle = noteTitle; }
    public void setNoteContent(String noteContent)         { this.noteContent = noteContent; }
    public void setNoteCreatedAt(Timestamp noteCreatedAt)  { this.noteCreatedAt = noteCreatedAt; }
    public void setStudentId(int studentId)                { this.studentId = studentId; }
}