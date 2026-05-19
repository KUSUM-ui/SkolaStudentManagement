package com.SkolaStudentManagement.Model;

/**
 * Maps to the class table.
 * Columns: class_id, class_name
 */
public class ClassModel {

    private int    classId;
    private String className;

    public ClassModel() {}

    public ClassModel(int classId, String className) {
        this.classId   = classId;
        this.className = className;
    }

    public int    getClassId()               { return classId; }
    public void   setClassId(int classId)    { this.classId = classId; }

    public String getClassName()             { return className; }
    public void   setClassName(String name)  { this.className = name; }
}