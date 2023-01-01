<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
String msg = (String)request.getSession().getAttribute("message");
%>

<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login - BigMart.</title>
<link rel="stylesheet" href="./static_files/style-login.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<script type="text/javascript" async="true">
	function showAlert(ele) {
		  ele.classList.add('show');
		}
		// Hide the alert message after 5 seconds
		function hideAlert(ele) {
		  setTimeout(() => {
		    ele.classList.add('hide');
		  }, 5000);
		}

		// Remove the alert message from the page after the fade-out transition is complete
		function removeAlert(ele) {
		  ele.addEventListener('transitionend', () => {
		    alert.remove();
		  });
		}
	</script>
	<div class="alert"></div>
	<%
	if(msg!=null){
		%>
		<script>
			
			const alert = document.querySelector('.alert');
			alert.innerText = '<%= msg %>';
			
			showAlert(alert);
			hideAlert(alert);
			removeAlert(alert);

			</script>
		<%
		}
		request.getSession().setAttribute("message", null);
		%>
	<div class="flex-container">
		<p class="hero-text">
			<i class="fa fa-shopping-cart hero-icon"></i> <br> Big<br>Mart.
		</p>
		<div class="wrapper">
			<div class="title">Login to your existing account</div>
			<form action="loginservlet" method="POST">
				<div class="field">
					<input type="text" name="username" autocomplete="username" required> <label>Username</label>
				</div>
				<div class="field">
					<input type="password" name="userpass" autocomplete="current-password" required> <label>Password</label>
				</div>
				<!--<div class="content">
               <div class="checkbox">
                  <input type="checkbox" id="remember-me">
                  <label for="remember-me">Remember me</label>
               </div>
               <div class="pass-link">
                  <a href="#">Forgot password?</a>
               </div>
            </div>-->
				<div class="field">
					<input type="submit" value="Login">
				</div>
			</form>
			<div class="signup-link">
				Not a member? <a href="signup.jsp">Signup now</a>
			</div>
		</div>
	</div>
</body>
</html>