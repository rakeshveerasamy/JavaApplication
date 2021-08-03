package com.zoho.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zoho.jdbc.DatabaseHandler;

/**
 * Servlet implementation class searchSubjectDuplicateServlet
 */
@WebServlet("/searchSubjectDuplicateServlet")
public class searchSubjectDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchSubjectDuplicateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("id").toLowerCase();
		String name  = request.getParameter("name").toLowerCase();
		String instructor = request.getParameter("instructor").toLowerCase();
		Connection con = null;
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		try {
			con = DatabaseHandler.getConnection();
			boolean flag = StudentDatabaseServlet.availableSubject(con,id,name,instructor);
			if(flag  == true)
			{
				   out.write("Subject is already  exists ");
			}
			else 
			{
				out.write("");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
