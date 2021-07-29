<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
   .center-align{
      text-align:center;
      margin:auto;
   }
   .paddingControl
   {
        padding:20px 20px;
   }
   
</style>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="style.css" rel="stylesheet">
<script>
 function checkUsername()
 {
		 var name = document.getElementById("username").value;
		 $.ajax({
			    url: "checkUserName",
			    data:{
	                    username :name,
	                    status : "0"
			    },
			    type: "POST",
			    success:function(data){
			    	     
			             $("#check-username").addClass('d-block').removeClass('d-none').html(data);
			    },
			    error:function (){}
			    });
     
 }
</script>
</head>
<body>
    <div class="main-container d-flex justify-content-center align-items-center">
        <div class = "box">
			<form class ="p-4 center-align" action ="StudentLoginServlet" method = "Post">
				  <!-- <p style="color: red;">${errorString}</p> -->
				  <h2 class="title pb-3">Login</h2>
				  <div class="pb-3">
				      <input type ="text" placeholder="Enter Username" name = "userid" id = "username" onInput ="checkUsername()" autocomplete="off" required/>
				      <div class="error-msg d-none" id = "check-username" ></div>
				  </div>
				  <div class="pb-3" >
				     <input type="password" Placeholder="Enter Password" name ="password" autocomplete="off" required/>
				  </div>
				  <div class = "pb-3">
				  <input  id = "submit_button" type = "Submit" name = "Login"/>
				  </div>
				  <div class="pb-3">
				     <label class= "title" for= "newUser"><font face="sans-serif" size="3px">New User </font></label>
				     <a class = "signup_link" href="signup.jsp">SignUp Here</a>
				  </div>
				  <div class="pb-3">
				     <label class = "title" for= "forgetpassword"><font face="sans-serif" size="3px">Forget Password </font></label>
				     <a class = "forget_link" href="forget.jsp">Click Here</a>
				  </div>
			</form>
		 </div>
	</div>
</body>
</html>