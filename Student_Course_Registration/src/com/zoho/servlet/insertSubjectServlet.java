package com.zoho.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.zoho.jdbc.DatabaseHandler;

/**
 * Servlet implementation class insertSubjectServlet
 */
@WebServlet("/insertSubjectServlet")
public class insertSubjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public insertSubjectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	     String id = request.getParameter("id");
	     String name = request.getParameter("name");
	     String dept = request.getParameter("dept");
	     String instructor = request.getParameter("instructor");
	     JSONArray array=new JSONArray();
	     JSONObject record = new JSONObject();
		 PrintWriter pw  =response.getWriter();
	     Connection con = null;
	     try {
			con = DatabaseHandler.getConnection();
			StudentDatabaseServlet.insertSubject(con, name, id, dept, instructor);
			record.put("COURSE_NAME", name.toUpperCase());
			record.put("COURSE_ID", id.toUpperCase());
			array.add(record);
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

}
