package com.zoho.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zoho.model.CourseDetails;
import com.zoho.model.EncodeDecode;
import com.zoho.model.StudentDetails;


public class StudentDatabaseServlet  {
	
	public static boolean availableUser(Connection con, String username) throws SQLException {
		String query = "select * from user where user_id like ?";
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, EncodeDecode.encryptText(username));
		ResultSet rs = pst.executeQuery();
		if (rs.next()) {
			return true;
		}
		return false;

	} 
	
	public static boolean availableSubject(Connection con, String id,String name ,String instructor) throws SQLException {
		String query = "select course_no,course_name,instructor from course use index(course_table) where course_no = ? and course_name = ? and instructor  = ?";
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, id);
		pst.setString(2, name);
		pst.setString(3, instructor);
		ResultSet rs = pst.executeQuery();
		if (rs.next()) {
			return true;
		}
		return false;

	} 
	public static void addForgetUser(Connection con, String username, String password) throws SQLException {
		String query = " update user set password like ? where user_id like ?";
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, EncodeDecode.encryptPass(password));
		pst.setString(2, EncodeDecode.encryptText(username));
		pst.executeUpdate();
		pst.close();

	}
	
	public static void addUser(Connection con, String fname, String lname, String email, String username,
			String password) throws SQLException {
			String query = "insert into user(fname,lname,email,user_id,password) values(?,?,?,?,?)";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, fname);
			pst.setString(2, lname);
			pst.setString(3, email);
			pst.setString(4, EncodeDecode.encryptText(username));
			pst.setString(5, EncodeDecode.encryptPass(password));
			pst.executeUpdate();
			pst.close();

		}
	
	public static boolean availableUserData(Connection con, String fname, String lname, String email, String username)
			throws SQLException {
		String query = "select * from user where fname like ? and lname like ? and email like ? and user_id like ?";
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, fname);
		pst.setString(2, lname);
		pst.setString(3, email);
		pst.setString(4, EncodeDecode.encryptText(username));
		ResultSet rs = pst.executeQuery();
		if (rs.next()) {
			return true;
		}
		return false;

	}
	
	public static boolean availableStudent(Connection  con ,String rollnumber , String course)
	{
		String query = "select * from selection USE INDEX(selection_table) where rollno like ? and course_no like ?";
		PreparedStatement pst = null;
		ResultSet rs  = null;
		boolean flag = false;
		try {
			pst  = con.prepareStatement(query);
			pst.setString(1, rollnumber);
			pst.setString(2, course);
			rs = pst.executeQuery();
			if(rs.next())
			{
				flag = true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			try {
				pst.close();
				rs.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return flag;
	}
	public static ArrayList<CourseDetails> showSubjects(Connection con) throws SQLException {
		String query = "select * from course";
		String course_name;
		int course_no;
		String dept;
		String instructor;
		ArrayList<CourseDetails> stuList = new ArrayList<CourseDetails>();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		while (rs.next()) {
			course_name = rs.getString(1);
			course_no = rs.getInt(2);
			dept = rs.getString(3);
			instructor = rs.getString(4);
			CourseDetails course = new CourseDetails(course_no, course_name, dept, instructor);
			stuList.add(course);
		}
		pst.close();
		rs.close();
		return stuList;
	}
	public static boolean loginUser(Connection con, String username, String password) throws SQLException {
		String query = "select * from user where user_id like ? and password like ?";
		PreparedStatement pst = con.prepareStatement(query);
		String user = EncodeDecode.encryptText(username);
		String pass = EncodeDecode.encryptPass(password);
		pst.setString(1, user);
		pst.setString(2, pass);
		ResultSet rs = pst.executeQuery();
		if (rs.next()) {
			if ((rs.getString(4).equals(user) && rs.getString(5).equals(pass))) {
				return true;
			} else {
				return false;
			}
		}
		pst.close();
		rs.close();
		return false;
	}
	
	public static void insertSubject(Connection con,String name ,String id, String dept,String instructor) throws SQLException
	{
        String query = "insert into course (course_name,course_no,dept,instructor) values(?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);
    		pst.setString(1, name.toLowerCase());
    		pst.setString(2, id);
    		pst.setString(3, dept.toLowerCase());
    		pst.setString(4, instructor.toLowerCase());
    		pst.executeUpdate();
		pst.close();
	}
	public static void insertData(Connection con, String rollno,String name ,String dept,String subject) throws Exception {
		int courseno = Integer.parseInt(subject);
		String query = "insert into student(name,rollno,dept) values (?,?,?)";
		PreparedStatement pstm = con.prepareStatement(query);
		pstm.setString(1, name.toLowerCase());
		pstm.setString(2, rollno);
		pstm.setString(3, dept.toLowerCase());
		pstm.executeUpdate();
		query = "select number from student USE INDEX(student_table_values) where name like ? and rollno like ? and dept like ?";
		pstm = con.prepareStatement(query);
		pstm.setString(1, name.toLowerCase());
		pstm.setString (2, rollno);
		pstm.setString(3, dept.toLowerCase());
		ResultSet rs = pstm.executeQuery();
		int number = 0;
        while(rs.next())
        {
            number  = rs.getInt(1);
        }
		insertSelection(con,number,rollno,subject);
		pstm.close();
	}
	public static StudentDetails getList(Connection con, String name ,String subject) throws Exception {
		String query = "select student.name,student.rollno,student.dept,course.course_name,course.instructor from student use index(student_name_value) inner join selection on student.number = selection.number inner join course use index (course_course_no) on  selection.course_no = course.course_no where student.name like ? and course.course_no like ?";
		PreparedStatement pstm = con.prepareStatement(query);
		pstm.setString(1, name.toLowerCase());
		pstm.setString(2, subject);
		ResultSet rs = pstm.executeQuery();
		StudentDetails stu = null;
		if (rs.next()) {
			name = rs.getString(1);
			int rollno = rs.getInt(2);
			String dept = rs.getString(3);
			subject = rs.getString(4);
			String instructor = rs.getString(5);
			stu = new StudentDetails(name,rollno,dept,subject,instructor);
		}
		pstm.close();
		return stu;
	}
    public static void insertSelection(Connection con ,int number , String rollnumber,String courseno) throws SQLException
    {
    	String query = "insert into selection(number ,rollno,course_no) values (?,?,?)";
		PreparedStatement pstm ;
		pstm = con.prepareStatement(query);
		pstm.setInt(1, number);
		pstm.setString(2, rollnumber);
		pstm.setString(3, courseno);
		pstm.executeUpdate();
		pstm.close();
    }
   
    public static ArrayList<StudentDetails> searchByValue(Connection con , String value,String column,String order,String lower,String upper) {
    	String query = "select student.name,student.rollno,student.dept,course.course_name,course.instructor from student use index(student_table_values) inner join selection on student.number = selection.number inner join course use index(course_text) on selection.course_no = course.course_no where student.name like concat(?,'%') or student.dept like concat(?,'%') or course.course_name like concat(?,'%') or course.instructor like concat(?,'%')  or student.rollno like concat (?,'%') order by "+column+" "+order+" limit "+lower+","+upper+" ";
    	int rollno;
		String name, dept, coursename, instructor;
		ArrayList<StudentDetails> stuList = new ArrayList<StudentDetails>();
		PreparedStatement pst = null;
		ResultSet rs = null;
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, value.toLowerCase());
			pst.setString(2, value.toLowerCase());
			pst.setString(3, value.toLowerCase());
			pst.setString(4, value.toLowerCase());
			pst.setString(5, value.toLowerCase());
			rs = pst.executeQuery();
			while (rs.next()) {
				name = rs.getString(1);
				rollno = rs.getInt(2);
				dept = rs.getString(3);
				coursename = rs.getString(4);
				instructor = rs.getString(5);
				StudentDetails stu = new StudentDetails( name,rollno, dept, coursename, instructor);
				stuList.add(stu);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
		
		try {
			pst.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		return stuList;
    	
    }
    public static int getRowCount(Connection con)
    {
    	String query = "select count(*) from student";
    	PreparedStatement pst = null ;
		ResultSet rs = null;
		int rowCount = 0;
		try {
			pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			if(rs.next())
			{
				rowCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			try {
				pst.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return rowCount;
    }
	public static ArrayList<StudentDetails> showDetails(Connection con ,String column,String order ,String lowerIndex,String UpperIndex) throws Exception {
		String query = "select student.name,student.rollno,student.dept,course.course_name,course.instructor from student inner join selection on student.number = selection.number inner join course on selection.course_no = course.course_no order by "+column+" "+order+" limit "+lowerIndex+","+UpperIndex;
		int rollno;
		String name, dept, coursename, instructor;
		ArrayList<StudentDetails> stuList = new ArrayList<StudentDetails>();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		while (rs.next()) {
			name = rs.getString(1);
			rollno = rs.getInt(2);
			dept = rs.getString(3);
			coursename = rs.getString(4);
			instructor = rs.getString(5);
			StudentDetails stu = new StudentDetails( name,rollno, dept, coursename, instructor);
			stuList.add(stu);
		}
		pst.close();
		rs.close();
		return stuList;
	}
	
	public static int getSearchRowCount(Connection con ,String value)
    {
		String query = "select count(*) from student use index(student_table_values) inner join selection on student.number = selection.number inner join course use index(course_text) on selection.course_no = course.course_no where student.name like concat(?,'%') or student.dept like concat(?,'%') or course.course_name like concat(?,'%') or course.instructor like concat(?,'%')  or student.rollno like concat (?,'%')";
		PreparedStatement pst = null;
		ResultSet rs = null;
		int rowCount = 0;
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, value.toLowerCase());
			pst.setString(2, value.toLowerCase());
			pst.setString(3, value.toLowerCase());
			pst.setString(4, value.toLowerCase());
			pst.setString(5, value.toLowerCase());
			rs = pst.executeQuery();
			if(rs.next())
			{
				rowCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
		
		try {
			pst.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		return rowCount;
    }
}
