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


@WebServlet("/searchServlet")
public class searchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public searchServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          String value = request.getParameter("data").trim();
          ArrayList<StudentDetails>list = new ArrayList<StudentDetails>();
          Connection con = null;
  		  PrintWriter pw  =response.getWriter();
  	      JSONArray array = new JSONArray();
          try{
        	  con = DatabaseHandler.getConnection();
        	  list = StudentDatabaseServlet.searchByValue(con,value);
          }
           catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally
          {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
          }
          for(StudentDetails stu :list)
			{
	            	JSONObject record = new JSONObject();
					record.put("NAME", stu.getName().toUpperCase());
					record.put("ROLLNO", stu.getRollno());
					record.put("DEPARTMENT", stu.getDepartment().toUpperCase());
					record.put("COURSE", stu.getCoursename().toUpperCase());
					record.put("INSTRUCTOR", stu.getInstructor().toUpperCase());
					array.add(record);
			}
            String output = null;
            if(!list.isEmpty())
			     output = array.toString();
			response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
			pw.print(output);
	}

}
