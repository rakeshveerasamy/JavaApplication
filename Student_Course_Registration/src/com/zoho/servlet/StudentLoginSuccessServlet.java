package com.zoho.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zoho.model.EncodeDecode;

/**
 * Servlet implementation class StudentLoginSuccessServlet
 */
@WebServlet("/StudentLoginSuccessServlet")
public class StudentLoginSuccessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentLoginSuccessServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// TODO Auto-generated method stub
					HttpSession session = request.getSession();
					String name = (String)session.getAttribute(EncodeDecode.encryptText("user"));
					String successString = null;
					if(name!=null)
					{
						name = EncodeDecode.decryptText(name);
						successString = "Login Successfully.....Welcome  "+name+"....";
						request.setAttribute("successString", successString);
						RequestDispatcher rd = request.getRequestDispatcher("insert.jsp");
						rd.include(request, response);
					}
					else
					{
						RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
						rd.include(request, response);
					}
		      
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
