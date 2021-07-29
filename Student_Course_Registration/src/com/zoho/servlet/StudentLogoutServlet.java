package com.zoho.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.zoho.jdbc.DatabaseHandler;
import com.zoho.model.CourseDetails;
import com.zoho.model.EncodeDecode;
import com.zoho.model.StudentDetails;

/**
 * Servlet implementation class StudentLogoutServlet
 */
@WebServlet("/StudentLogoutServlet")
public class StudentLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentLogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

		protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession session = request.getSession();
			 session.invalidate();
			 Cookie ck=new Cookie(EncodeDecode.encryptText("userid"),"");  
			 ck.setMaxAge(0);
		    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		    response.addCookie(ck);
		    rd.forward(request, response); 		
		    }

}
