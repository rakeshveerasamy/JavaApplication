package com.zoho.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zoho.jdbc.DatabaseHandler;
import com.zoho.model.EncodeDecode;

/**
 * Servlet implementation class StudentLoginServlet
 */
@WebServlet("/StudentLoginServlet")
public class StudentLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudentLoginServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
			String userid = request.getParameter("userid");
			String Password = request.getParameter("password");
			String errorString = null;
			Connection con = null;
				boolean flag = false;
				try {
					con = DatabaseHandler.getConnection();
					flag = StudentDatabaseServlet.loginUser(con, userid,Password);
				} catch (Exception e) {
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if (flag == false) {
					errorString = " " + "Invalid UserName or Password";
					request.setAttribute("errorString", errorString);
					RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
					rd.forward(request, response);
				}
				else {
					HttpSession session = request.getSession();
					session.setAttribute(EncodeDecode.encryptText("user"), EncodeDecode.encryptText(userid));
					Cookie ck = new Cookie(EncodeDecode.encryptText("userid"),EncodeDecode.encryptText(userid));
					response.addCookie(ck);
					RequestDispatcher rd = request.getRequestDispatcher ("/StudentLoginSuccessServlet");
					rd.include(request,response);
					
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
