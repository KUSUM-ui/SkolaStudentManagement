package com.SkolaStudentManagement.model;
import java.util.List;


public class DashboardData {
	private SettingsStudentModel student;
    private String               todayDay;
    private List<Schedule>  todaySchedule;
    private List<Announcements> announcements;
    private List<Notes>          notes;

    public DashboardData() {}
    

    public SettingsStudentModel getStudent()                          { return student; }
    public void setStudent(SettingsStudentModel student)              { this.student = student; }

    public String getTodayDay()                                       { return todayDay; }
    public void setTodayDay(String todayDay)                          { this.todayDay = todayDay; }

    public List<Schedule> getTodaySchedule()                     { return todaySchedule; }
    public void setTodaySchedule(List<Schedule> todaySchedule)   { this.todaySchedule = todaySchedule; }

    public List<Announcements> getAnnouncements()                 { return announcements; }
    public void setAnnouncements(List<Announcements> announcements){ this.announcements = announcements; }

    public List<Notes> getNotes()                                     { return notes; }
    public void setNotes(List<Notes> notes)                           { this.notes = notes; }

}
