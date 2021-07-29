package com.zoho.model;

public class CourseDetails {
   private int id;
   private String name;
   private String department;
   private String instructor;
	public CourseDetails() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CourseDetails(int id, String name, String department, String instructor) {
		super();
		this.id = id;
		this.name = name;
		this.department = department;
		this.instructor = instructor;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getInstructor() {
		return instructor;
	}
	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}
	
   
}
