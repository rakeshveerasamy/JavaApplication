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
 * Servlet implementation class searchRowCount
 */
@WebServlet("/searchRowCount")
public class searchRowCount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchRowCount() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String value = request.getParameter("data");
		Connection con  =null;
		PrintWriter pw  =response.getWriter();
		int rowCount = 0;
		try {
			con = DatabaseHandler.getConnection();
		    rowCount = StudentDatabaseServlet.getSearchRowCount(con,value);
			response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
			pw.print(rowCount);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
