<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
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
                    status : "1"
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
			<form class ="p-4 center-align" action ="userRegistration" method = "Post">
			  <p class="pb-2" style="color: red;">${errorString}</p>
		      <p class = "pb-2" style="color: green;">${successString}</p>
		      <h2 class="title pb-3">SignUp</h2>
			  <div class="pb-3">
			      <input  type ="text" name = "fname" placeholder = "Enter First name" autocomplete="off" required>
			  </div>
			  <div class="pb-3" >
			     <input type="text" placeholder = "Enter Last name"  autocomplete="off" name ="lname"/>
			  </div>
			  <div class = "pb-3">
			  	 <input type="email" placeholder = "Enter Email-Id" autocomplete="off"  name = "email" required>
			  </div>
			  <div class = "pb-3">
			     <input type="text" placeholder ="Enter Username" autocomplete="off"  name ="username" id="username"  onInput ="checkUsername()" required/>
			      <div class="error-msg d-none" style="color:red" id = check-username></div>
			  </div>
			  <div class = "pb-3">
			  	 <input type="text" placeholder= "Password" autocomplete="off" pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]*" name = "password" id = "password" required>
			  </div>
			  <div class = "pb-3">
			  	 <input type="password" placeholder = "Confirm-Password" pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]*" name = "confirmpassword" id = "confirmpassword" onInput = "passwordCheck()" required>
			      <div class="error-msg d-none" style="color:red" id = check-password></div>
			  </div>
			  <div class = "pb-3">
			  <input id = "submit_button" type = "Submit" name = "Submit"/>
			  </div>
			  <div class="pb-3">
			     <a class = "goto_link" href="login.jsp">Go to Login</a>
			  </div>
			</form>
		</div>
	</div>
</body>
</html>