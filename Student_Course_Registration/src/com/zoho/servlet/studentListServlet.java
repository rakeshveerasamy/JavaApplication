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


@WebServlet("/studentListServlet")
public class studentListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public studentListServlet() {
        super();
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;
		PrintWriter pw  =response.getWriter();
		ArrayList<StudentDetails> stuList = new ArrayList<StudentDetails>();
		JSONArray array=new JSONArray();
		try {
			con = DatabaseHandler.getConnection();
			stuList = StudentDatabaseServlet.showDetails(con);
			for(StudentDetails stu :stuList)
			{
	            	JSONObject record = new JSONObject();
					record.put("NAME", stu.getName().toUpperCase());
					record.put("ROLLNO", stu.getRollno());
					record.put("DEPARTMENT", stu.getDepartment().toUpperCase());
					record.put("COURSE", stu.getCoursename().toUpperCase());
					record.put("INSTRUCTOR", stu.getInstructor().toUpperCase());
					array.add(record);
			}
			String output = array.toString();
			response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
			pw.print(output);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		 
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    doPost(request,response);
	}

}
