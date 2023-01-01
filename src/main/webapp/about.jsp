<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="./includes/header.jsp"%>
	<title>Big Mart. - about</title>
	<link rel="stylesheet" href="./static_files/style-home.css">
</head>
<body>
<header>
		<!-- -------------------------NAVBAR start----------------------------------------- -->

		<%@include file="./includes/navbar.jsp"%>
		<!-- -------------------------NAVBAR END  ------------------------------------------- -->
	</header>
	
	<div class="banner">
		<div class="about-container">
			<h4>E-commerce site</h4>
			<div>Completed on : 02/01/2023 <br>This project aims to simulate basic features of an e-commerce site.
			I added the below functionalities in this project:
			<ul>
				<li>ac. creation/ login/ logout system</li>
				<li>create seller/ customer ac.</li>
				<li>seller can <ul>
					<li>add products and set price</li>
					<li>accept or reject orders made by customers</li>
					<li>view order requests of each product he has</li>
					<li>remove his existing product</li>
					<li>check status of orders made by customers</li>
					<li>cannot buy using seller ac.</li>
					</ul>
				</li>
				<li>view total price of cart</li>
				<li>add/remove item to/from cart</li>
				<li>modify quantity of items</li>
				<li>place order for items in cart</li>
				<li>check order status if its been confirmed by seller</li>
				<li>search products by name</li>
				<li>view reviews, rating of products</li>
				<li>add review</li>
				<li>rate the product</li>
				<li>send mail to organization</li>
			</ul>
			To give me any feedback or suggestions which are always welcome, please <a href="contact.jsp">mail me</a>
			</div>
		</div>
	</div>
	<!-- ------------------------------FOOTER-------------------------------------------------- -->
            <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
<!-- ------------------------------FOOTER-------------------------------------------------- --> 
</body>
</html>