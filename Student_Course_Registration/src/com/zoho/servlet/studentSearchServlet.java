package com.zoho.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletConfig;
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
 * Servlet implementation class studentSearchServlet
 */
@WebServlet("/studentSearchServlet")
public class studentSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public studentSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String rollnumber = request.getParameter("rollnumber");
		String subject = request.getParameter("subject");
		Connection con = null;
		PrintWriter pw  =response.getWriter();
		try {
			con = DatabaseHandler.getConnection();
			boolean value = StudentDatabaseServlet.availableStudent(con, rollnumber, subject);
			if(value)
			{
				    response.setContentType("text/html");
					pw.print("You have already choosen this subject");
			}
		}
		catch(Exception ex)
		{
			
		}
	}
}
