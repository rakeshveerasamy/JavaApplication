<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Hii</h1>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	  $("button").click(function(){
	    $.getJSON("JSONServlet", function(result){
	      $.each(result, function(i, field){
	        $("span").append(field.name + " ");
	      });
	    });
	  });
	});
</script>
 <button>Click Here</button>
 <span></span>
</body>
</html>