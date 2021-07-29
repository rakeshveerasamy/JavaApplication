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


@WebServlet("/checkUserName")
public class checkUserName extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public checkUserName() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String user = request.getParameter("username");
		String status = request.getParameter("status");
		Connection con = null;
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		try {
			con = DatabaseHandler.getConnection();
			boolean flag = StudentDatabaseServlet.availableUser(con,user);
			if(flag  == false)
			{
				if(status.equals("0"))
				   out.write(" User not  exists ");
			}
			else if(flag == true && status.equals("1"))
			{
				   out.write(" Username  is already  exists ");
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
