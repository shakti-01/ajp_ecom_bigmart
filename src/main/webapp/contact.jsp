<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%
String user = (String)request.getSession().getAttribute("user");
if (user != null ) {
    request.setAttribute("user", user);
}
else{
	response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="./includes/header.jsp"%>
	<title>Big Mart. - mail me</title>
	<link rel="stylesheet" href="./static_files/style-home.css">
</head>
<body>
<header>
		<!-- -------------------------NAVBAR start----------------------------------------- -->

		<%@include file="./includes/navbar.jsp"%>
		<!-- -------------------------NAVBAR END  ------------------------------------------- -->
	</header>
	<script type="text/javascript" async="true">
	function showAlert(ele) {
			ele.classList.remove('hide');
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
	<div class="banner">
		<div class="about-container">
			<form id="mail-form" onsubmit="sendMail(event);">
			  <div class="form-group">
			    <label for="mail">Email address</label>
			    <input type="email" class="form-control" id="mail" name="mail" placeholder="Enter email" autocomplete="email" required>
			    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
			  </div>			 
			  <div class="form-group">
			    <label for="sub">Subject</label>
			    <input type="text" class="form-control" id="sub" name="sub" placeholder="subject" autocomplete="off" required>
			  </div>
			  <div class="form-group">
			    <label for="body">Mail body</label>
			    <textarea class="form-control" id="body" name="body" rows="3"></textarea>
			  </div>
			  
			  <button type="submit" class="btn btn-primary">Submit</button>
			</form>
		</div>
	</div>
	<!-- ------------------------------FOOTER-------------------------------------------------- -->
	<script type="text/javascript" defer>
	function sendMail(e) {
		e.preventDefault();
		  // Get the form element
		  const form = $("#mail-form");
		  const alert = document.querySelector('.alert');

		  // Serialize the form values
		  const formData = form.serialize();
		  $("#mail-form")[0].reset();
		  // Set up the request
		  $.ajax({
		    type: "POST",
		    url: "sendmailservlet",
		    data: formData,
		    success: function(response) {
				alert.innerText = response;				
				showAlert(alert);
				hideAlert(alert);
		    },
		    error: function(error) {
		      console.error("Error sending mail data");
		      alert.innerText = 'Error in sending mail';				
				showAlert(alert);
				hideAlert(alert);
		    }
		  });
		}

	</script>
            <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
<!-- ------------------------------FOOTER-------------------------------------------------- --> 
</body>
</html>