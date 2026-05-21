package com.SkolaStudentManagement.model;

public class Schedule {
    private int    scheduleId;
    private String sectionId;
    private int    moduleId;
    private String moduleName;
    private String day;
    private String startTime;
    private String endTime;

    public Schedule() {}

    public int    getScheduleId()            { return scheduleId; }
    public void   setScheduleId(int v)       { this.scheduleId = v; }

    public String getSectionId()             { return sectionId; }
    public void   setSectionId(String v)     { this.sectionId = v; }

    public int    getModuleId()              { return moduleId; }
    public void   setModuleId(int v)         { this.moduleId = v; }

    public String getModuleName()            { return moduleName; }
    public void   setModuleName(String v)    { this.moduleName = v; }

    public String getDay()                   { return day; }
    public void   setDay(String v)           { this.day = v; }

    public String getStartTime()             { return startTime; }
    public void   setStartTime(String v)     { this.startTime = v; }

    public String getEndTime()               { return endTime; }
    public void   setEndTime(String v)       { this.endTime = v; }
}