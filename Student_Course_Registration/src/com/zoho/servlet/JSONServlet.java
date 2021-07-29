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
 * Servlet implementation class JSONServlet
 */
@WebServlet("/JSONServlet")
public class JSONServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JSONServlet() {
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
//		JSONObject result = new JSONObject();
	    JSONArray jsonArray = new JSONArray();
		try {
			con = DatabaseHandler.getConnection();
			String query = "select student.name,student.rollno,student.dept,course.course_name,course.instructor from student inner join selection on student.number = selection.number inner join course on selection.course_no = course.course_no";
			PreparedStatement pst = con.prepareStatement(query);
		    rs = pst.executeQuery();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			while(rs.next())
			{
				JSONObject record = new JSONObject();
				record.put("NAME",rs.getString(1).toLowerCase());
				record.put("ROLLNO", rs.getInt(2));
				record.put("DEPARTMENT", rs.getString(3).toLowerCase());
				record.put("COURSE_NAME", rs.getString(4).toLowerCase());
				record.put("INSTRUCTOR", rs.getString(5).toLowerCase());
				jsonArray.add(record);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	    String s = jsonArray.toString();
	    PrintWriter pw = response.getWriter();
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    pw.print(s);
	   }


}
