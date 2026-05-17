package com.SkolaStudentManagement.Model;

public class ScheduleModel {
    private int    scheduleId;
    private String sectionId;
    private int    moduleId;
    private String day;
    private String startTime;
    private String endTime;
    private String moduleName;

    public ScheduleModel() {}

    public int    getScheduleId()          { return scheduleId; }
    public void   setScheduleId(int id)    { this.scheduleId = id; }

    public String getSectionId()           { return sectionId; }
    public void   setSectionId(String s)   { this.sectionId = s; }

    public int    getModuleId()            { return moduleId; }
    public void   setModuleId(int id)      { this.moduleId = id; }

    public String getDay()                 { return day; }
    public void   setDay(String day)       { this.day = day; }

    public String getStartTime()           { return startTime; }
    public void   setStartTime(String t)   { this.startTime = t; }

    public String getEndTime()             { return endTime; }
    public void   setEndTime(String t)     { this.endTime = t; }

    public String getModuleName()          { return moduleName; }
    public void   setModuleName(String m)  { this.moduleName = m; }
}