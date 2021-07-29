<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
 function passwordCheck()
 {
	 var password = document.getElementById("password").value;
	 var confirm = document.getElementById("confirmpassword").value;
	 $.ajax({
		 url :"checkPasswordServlet",
		 data:{
			 password:password,
			 confirm : confirm
		 },
	    type:"POST",
	    success:function(data){
	    	$('#check-password').addClass('d-block').removeClass('d-none').html(data);
	    },
	    error:function(){}
	 });
 }
</script>
</head>
<body>
   <div class="main-container d-flex justify-content-center align-items-center">
	   <div class = "box">
			<form class ="p-4 center-align" action ="forgetPasswordServlet" method = "Post">
			  <p style="color: red;">${errorString}</p>
			  <p style="color: green;">${successString}</p>
			  <h2 class="title pb-3">Forget Password</h2>
			  <div class="pb-3">
			      <input type ="text" placeholder = "Enter Username" name = "username" autocomplete = "off" id = "username" onInput ="checkUsername()" required/>
			       <div class="error-msg d-none" style="color:red" id = check-username></div>
			  </div>
			  <div class="pb-3" >
			     <input type="text" placeholder = "Password" name ="password" autocomplete = "off" id = "password" required/>
			  </div>
			  <div class="pb-3" >
			     <input type="password" placeholder = "Confirm-Password" autocomplete="off" name ="confirmpassword" id = "confirmpassword" onInput = "passwordCheck()" required/>
			      <div class="error-msg d-none" style="color:red" id = check-password></div>
			  </div>
			  <div class ="pb-3">
			  	<input id = "submit_button" type = "Submit" name = "Login"/>
			  </div>
			  <div class="pb-3">
			     <a class = "goto_link" href="login.jsp">Go to Login</a>
			  </div>
			  <div class="pb-3">
			     <a href="signup.jsp">Go to New Registration</a>
			  </div>
			</form>
		</div>
	</div>
</body>
</html>