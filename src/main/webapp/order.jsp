<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="dao.*" %>

<%
String user = (String)request.getSession().getAttribute("user");
String is_seller = (String)request.getSession().getAttribute("is_seller");//1,0
if (user != null) {
    request.setAttribute("user", user);
}
else{
	response.sendRedirect("login.jsp");
}
if(is_seller==null){ response.sendRedirect("index.jsp");}
else if(is_seller.equals("1")){
	response.sendRedirect("seller_order.jsp");
}
ProductDao pd = new ProductDao();
List<Order> orders = pd.getOrderProds(user);


%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="./includes/header.jsp"%>
    <title>Orders - <%= request.getSession().getAttribute("user") %></title>
    <link rel="stylesheet" href="./static_files/style-home.css">
</head>
<body>
	<header>
		<%@include file="./includes/navbar.jsp"%>
	</header>
	<div class="banner">
		<div class="wrapper">

			<%
					if (!orders.isEmpty()) {
						for (Order o : orders) {
				%>
			<div class="cart-list">
				<div>Order id: <%=o.getOid() %></div>
				<div class="cart-item-info">
					<%=o.getName() %>
					&emsp;<i class="material-icons">star_rate</i><%=o.getRating() %>
					<br />Price: &emsp;Rs.<%=o.getPrice() %>
				</div>
				<div class="cart-quantity">
					Quantity: <span class="badge badge-info"><%=o.getQuantity() %></span>
				</div>
				<hr/>
				<% if(o.getConfirmed()==0){
						%>
				  <span class="badge badge-primary">pending</span><%}
				  else if(o.getConfirmed()==2){
						%>
					<span class="badge badge-danger">Canceled</span><%}
					else{
						%>
					<span class="badge badge-success">Order confirmed</span><%} %>	
				
			</div>
				<div class="alert alert-primary" role="alert">
					<% if(o.getConfirmed()==0){
						%>
				  Waiting for the seller to confirm your order.<%}
				  else if(o.getConfirmed()==2){
						%>
					Your order has been rejected by seller.<%}
					else{
						%>
					Order successfully verified.<%} %>	
				</div>
			<%
						}
					} 
					else out.println("<h2>You have not ordered any products.</h2>");
				%>


		</div>
	</div>
	<!-- -------------------------------banner ends---- -->
	
<!-- ------------------------------FOOTER-------------------------------------------------- -->
            <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
<!-- ------------------------------FOOTER-------------------------------------------------- --> 
</body>
</html>