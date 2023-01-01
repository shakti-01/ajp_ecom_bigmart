<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>


<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Signup - BigMart</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="./static_files/style-login.css">
</head>
<body>
	<div class="flex-container">
		<p class="hero-text">
			<i class="fa fa-shopping-cart hero-icon"></i> <br> Big<br>Mart.
		</p>
		<div class="wrapper">
			<div class="title">Create new account</div>
			<form action="signupservlet" method="POST"
				onsubmit="return validate();">
				<div class="field">
					<input type="text" name="username" id="usern" autocomplete="username"> <label>Username</label>
				</div>
				<div class="field">
					<input type="password" name="userpass" id="userp" autocomplete="new-password" required>
					<label>Password</label>
				</div>
				<div style="margin-top: 0.6em;">Register as a seller? &ensp;<input style=" transform: scale(1.3);" type="checkbox" name="is_seller" value="1"/></div>
				<p style="margin-top: 1em; color: grey;">
					<small>*Min length of user name is 4<br> *Min password
						length is 4 with 1 number
					</small>
				</p>

				<div class="field">
					<input type="submit" value="Signup">
				</div>
			</form>
			<div class="signup-link">
				Already member? <a href="login.jsp">Login now</a>
			</div>
		</div>
	</div>
	<script>
      function validate(){
    	  let username = document.getElementById("usern").value;
    	  let password = document.getElementById("userp").value;
    	  if (!username || !password) {
    	    return false;
    	  }
    	  if (username.length < 4) {
    	    return false;
    	  }
    	  if (password.length < 4 || !/\d/.test(password)) {
    	    return false;
    	  }
			console.log("ac created");
    	  return true;
      }
      </script>
</body>
</html>