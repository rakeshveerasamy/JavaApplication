<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
     html,body
     {
      height:100%;
      width:100%;
      overflow:hidden;
     }
	.input-tag-border{
	  border-width:0 0 2px 0;
	  margin:10px 0;
	  width:90%;
	}
	.input-tag-border:focus-visible {
		outline:none;
	}
	body{
	 background-color:white;
	}
	form{
	 background-color:white;
	 border:1px solid darkgrey ;
	}
	.form-header{
	 color:dimgrey;
	 font-family:sans-serif;
	 height:60px;
	}
	.form-center{
	 text-align:center;
	 margin:auto;
	 width:20%;
	 height:30%;
	 padding:0 10% 10% 10%;
	}
	.page-center{
	height: 100%;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-around;
    align-content: center;
	}
	.padding-topbottom{
	  padding:10px 0 10px 0;
	}
	.form-body{
	  height:clac(100% - 60px);
	}
	.button-style{
	  background-color:dimgrey;
	  color:white;
	}
</style>
</head>
<body>
<div class ="page-center ">    
	<form class="form-center" >
	    <div class = "form-header">
		 	<h1 class="dark-grey">Login</h1>
		</div>
		<div class="form-body">
		    <div >
			  <p></p>
			</div>
			<div>
				<input class = "input-tag-border padding-topbottom" type = "text" name = "userName" id = "userName" placeholder ="UserName"/>
			</div>
			<div>
				<input class = "input-tag-border padding top-bottom" type = "password" name ="password" id = "password" placeholder = "Password"/>
			</div>
			<div class = "padding-topbottom">
			     <button class = "button-style">Submit</button>
			     <div class ="padding-topbottom">
			       <a href="#">New Registration</a>
			       &nbsp;
			       <a href ="#">Forget Password</a>
			     </div>
			</div>
		</div>
	</form>
</div>
</body>
</html>