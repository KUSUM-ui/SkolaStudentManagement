package com.SkolaStudentManagement.model;

public class Module {
    private int    moduleId;
    private String moduleName;
    private int    facultyId;
    private int semester;
    private String module_description;
    private int module_credits;
    


	/**
	 * @return the semester
	 */
	public int getSemester() {
		return semester;
	}
	/**
	 * @param semester the semester to set
	 */
	public void setSemester(int semester) {
		this.semester = semester;
	}
	/**
	 * @return the moduleId
	 */
	public int getModuleId() {
		return moduleId;
	}
	/**
	 * @param moduleId the moduleId to set
	 */
	public void setModuleId(int moduleId) {
		this.moduleId = moduleId;
	}
	/**
	 * @return the moduleName
	 */
	public String getModuleName() {
		return moduleName;
	}
	/**
	 * @param moduleName the moduleName to set
	 */
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	/**
	 * @return the facultyId
	 */
	public int getFacultyId() {
		return facultyId;
	}
	/**
	 * @param facultyId the facultyId to set
	 */
	public void setFacultyId(int facultyId) {
		this.facultyId = facultyId;
	}
	/**
	 * @return the module_description
	 */
	public String getModule_description() {
		return module_description;
	}
	/**
	 * @param module_description the module_description to set
	 */
	public void setModule_description(String module_description) {
		this.module_description = module_description;
	}
	/**
	 * @return the module_credits
	 */
	public int getModule_credits() {
		return module_credits;
	}
	/**
	 * @param module_credits the module_credits to set
	 */
	public void setModule_credits(int module_credits) {
		this.module_credits = module_credits;
	}
}