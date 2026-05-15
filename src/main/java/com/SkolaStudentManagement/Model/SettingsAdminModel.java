package com.SkolaStudentManagement.Model;

public class SettingsAdminModel {
    private int    adminId;
    private String firstName;
    private String lastName;
    private String email;
    private String password;

    public SettingsAdminModel() {}

    public int    getAdminId()            { return adminId; }
    public void   setAdminId(int v)       { this.adminId = v; }

    public String getFirstName()          { return firstName; }
    public void   setFirstName(String v)  { this.firstName = v; }

    public String getLastName()           { return lastName; }
    public void   setLastName(String v)   { this.lastName = v; }

    public String getEmail()              { return email; }
    public void   setEmail(String v)      { this.email = v; }

    public String getPassword()           { return password; }
    public void   setPassword(String v)   { this.password = v; }
}