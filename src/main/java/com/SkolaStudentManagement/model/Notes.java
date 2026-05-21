package com.SkolaStudentManagement.model;

import java.sql.Timestamp;


public class Notes {
	private int noteId;
    private int studentId;
    private String noteTitle;
    private String noteContent;
    private Timestamp noteCreatedAt;
	/**
	 * @return the noteId
	 */
	public int getNoteId() {
		return noteId;
	}
	/**
	 * @param noteId the noteId to set
	 */
	public void setNoteId(int noteId) {
		this.noteId = noteId;
	}
	/**
	 * @return the studentId
	 */
	public int getStudentId() {
		return studentId;
	}
	/**
	 * @param studentId the studentId to set
	 */
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	/**
	 * @return the noteTitle
	 */
	public String getNoteTitle() {
		return noteTitle;
	}
	/**
	 * @param noteTitle the noteTitle to set
	 */
	public void setNoteTitle(String noteTitle) {
		this.noteTitle = noteTitle;
	}
	/**
	 * @return the noteContent
	 */
	public String getNoteContent() {
		return noteContent;
	}
	/**
	 * @param noteContent the noteContent to set
	 */
	public void setNoteContent(String noteContent) {
		this.noteContent = noteContent;
	}
	/**
	 * @return the noteCreatedAt
	 */
	public Timestamp getNoteCreatedAt() {
		return noteCreatedAt;
	}
	/**
	 * @param noteCreatedAt the noteCreatedAt to set
	 */
	public void setNoteCreatedAt(Timestamp noteCreatedAt) {
		this.noteCreatedAt = noteCreatedAt;
	}

    
}
