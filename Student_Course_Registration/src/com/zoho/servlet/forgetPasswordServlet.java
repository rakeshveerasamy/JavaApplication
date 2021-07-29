package com.zoho.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zoho.jdbc.DatabaseHandler;

/**
 * Servlet implementation class forgetPasswordServlet
 */
@WebServlet("/forgetPasswordServlet")
public class forgetPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public forgetPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmpassword = request.getParameter("confirmpassword");
		String errorString = null;
		String successString = null;
		Connection con = null;
		try {
			con = DatabaseHandler.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (!(password.equals(confirmpassword))) {
			errorString = " " + "Password and Confirm Password both should be same ";
			request.setAttribute("errorString", errorString);
			RequestDispatcher rd = request.getRequestDispatcher("forget.jsp");
			rd.forward(request, response);
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else
			try {
				if (StudentDatabaseServlet.availableUser(con,username) == false) {
					errorString = " " + "Username is not  exists .Enter Correct User Name or  Try new Registration";
					request.setAttribute("errorString", errorString);
					RequestDispatcher rd = request.getRequestDispatcher("forget.jsp");
					rd.forward(request, response);
					try {
						con.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				} else {
					successString = "  " + "Password Changed .....successfully.....Go to Login";
					try {
						StudentDatabaseServlet.addForgetUser(con, username, password);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					try {
						con.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					request.setAttribute("successString", successString);
					RequestDispatcher rd = request.getRequestDispatcher("forget.jsp");
					rd.forward(request, response);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
