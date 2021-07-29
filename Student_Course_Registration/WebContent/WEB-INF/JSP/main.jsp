<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="com.zoho.model.EncodeDecode"%>
 
<%
   boolean flag = true;
   Cookie ck[] = request.getCookies();
   for(int index = 0;index<ck.length;index++)
   {
	   if(ck[index].getName().equals(EncodeDecode.encryptText("userid")))
	   {
		   flag = false;
		   RequestDispatcher rd  = request.getRequestDispatcher("insert.jsp");
		   rd.forward(request, response);
	   }
   }
   if(flag)
   {
	   RequestDispatcher rd  = request.getRequestDispatcher("login.jsp");
	   rd.forward(request, response);
   }
%>