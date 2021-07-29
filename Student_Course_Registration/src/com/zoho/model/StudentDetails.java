package com.zoho.model;

public class StudentDetails {
   private String name;
   private int rollno;
   private String department;
   private String coursename;
   private String instructor;
	public StudentDetails(String name, int rollno, String department, String coursename, String instructor) {
		super();
		this.name = name;
		this.rollno = rollno;
		this.department = department;
		this.coursename = coursename;
		this.instructor = instructor;
	}
	public StudentDetails() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getRollno() {
		return rollno;
	}
	public void setRollno(int rollno) {
		this.rollno = rollno;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getCoursename() {
		return coursename;
	}
	public void setCoursename(String coursename) {
		this.coursename = coursename;
	}
	public String getInstructor() {
		return instructor;
	}
	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}
   
}
