package com.zoho.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseHandler {

	public static Connection getConnection() throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentdetails", "root",
				"R@ke$h26121999");
		return con;
	}
}
