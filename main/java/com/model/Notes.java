package com.model;

import java.sql.Timestamp;

public class Notes {
    private int noteId;
    private String noteTitle;
    private String noteContent;
    private Timestamp noteCreatedAt;

    public int getNoteId() { return noteId; }
    public void setNoteId(int noteId) { this.noteId = noteId; }

    public String getNoteTitle() { return noteTitle; }
    public void setNoteTitle(String noteTitle) { this.noteTitle = noteTitle; }

    public String getNoteContent() { return noteContent; }
    public void setNoteContent(String noteContent) { this.noteContent = noteContent; }

    public Timestamp getNoteCreatedAt() { return noteCreatedAt; }
    public void setNoteCreatedAt(Timestamp noteCreatedAt) { this.noteCreatedAt = noteCreatedAt; }
}