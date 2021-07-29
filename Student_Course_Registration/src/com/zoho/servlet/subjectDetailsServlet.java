package com.zoho.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
 * Servlet implementation class subjectServlet
 */
@WebServlet("/subjectDetailsServlet")
public class subjectDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public subjectDetailsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection con = null;
		ResultSet rs = null;
	    JSONArray jsonSubArray = new JSONArray();
		try{
			con = DatabaseHandler.getConnection();
			String query1 ="select course_name,course_no from course";
			PreparedStatement pst = con.prepareStatement(query1);
			rs = pst.executeQuery();
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			while(rs.next())
			{
				JSONObject record = new JSONObject();
				record.put("COURSE_NAME", rs.getString(1).toUpperCase());
				record.put("COURSE_ID", rs.getInt(2));
				jsonSubArray.add(record);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    String sub = jsonSubArray.toString();
	    PrintWriter pw = response.getWriter();
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    pw.print(sub);
	   }
}
