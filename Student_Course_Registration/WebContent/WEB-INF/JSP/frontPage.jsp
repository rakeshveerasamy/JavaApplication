<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<h1>Hii</h1>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
		    $.getJSON("JSONServlet", function(result){
		     localStorage.setItem('person', JSON.stringify(result));
	       });
           $.getJSON("subjectDetailsServlet",function(result){
  		     localStorage.setItem("subject",JSON.stringify(result));
           });
     	  window.open("insert.jsp");

});
</script>
<script>
</script>
 <button id = "click">Click Here</button>
 <button onclick="onpress()">insert to</button>
 <div></div>
</body>
</html>