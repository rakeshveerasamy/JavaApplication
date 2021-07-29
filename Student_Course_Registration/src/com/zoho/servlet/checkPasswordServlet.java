package com.zoho.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/checkPasswordServlet")
public class checkPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public checkPasswordServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String password = request.getParameter("password");
		String confirm = request.getParameter("confirm");
		PrintWriter out = response.getWriter();
		if (!(password.equals(confirm)))
		{
			out.write("Password and Confirm Password both should be same ");
		}
	}

}
