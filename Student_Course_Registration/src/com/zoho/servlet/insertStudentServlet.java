package com.zoho.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.zoho.jdbc.DatabaseHandler;
import com.zoho.model.StudentDetails;

/**
 * Servlet implementation class insertStudentServlet
 */
@WebServlet("/insertStudentServlet")
public class insertStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public insertStudentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String rollnumber = request.getParameter("rollnumber");
		String name = request.getParameter("name");
		String dept = request.getParameter("dept");
		String subject = request.getParameter("subject");
		Connection con = null;
		JSONArray array=new JSONArray();
    	JSONObject record = new JSONObject();
		PrintWriter pw  =response.getWriter();
		try {
			con = DatabaseHandler.getConnection();
			StudentDatabaseServlet.insertData(con, rollnumber, name, dept, subject);
			StudentDetails stu = StudentDatabaseServlet.getList(con,name,subject);
			record.put("NAME", stu.getName().toUpperCase());
			record.put("ROLLNO", stu.getRollno());
			record.put("DEPARTMENT", stu.getDepartment().toUpperCase());
			record.put("COURSE", stu.getCoursename().toUpperCase());
			record.put("INSTRUCTOR", stu.getInstructor().toUpperCase());
			array.add(record);
			String output = array.toString();
			response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
			pw.print(output);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}

}
