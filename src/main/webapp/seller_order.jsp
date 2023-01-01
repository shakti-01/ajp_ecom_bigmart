<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="dao.*" %>

<%
String user = (String)request.getSession().getAttribute("user");
if (user != null) {
    request.setAttribute("user", user);
}
else{
	response.sendRedirect("login.jsp");
}

ProductDao pd = new ProductDao();
List<Order> orders = pd.getCustOrder(user);


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
				<div class="cart-item-info">
					<%=o.getName() %>
					&emsp;<span>x<%=o.getQuantity() %></span>
					<br />Price: &emsp;Rs.<%=o.getPrice() %>
				</div>
				<div>
					<% if(o.getConfirmed()==0){
						%>
				  <span class="badge badge-primary">new</span><%}
				  else if(o.getConfirmed()==2){
						%>
					<span class="badge badge-danger">Rejected</span><%}
					else{
						%>
					<span class="badge badge-success">Accepted</span><%} %>	
				</div>
			</div>
				<div>
				<% if(o.getConfirmed()==0){
						%>
						<a href="handleorderservlet?confirmation=1&oid=<%=o.getOid()%>"><button type="button" class="btn btn-success">Accept</button></a>
						<a href="handleorderservlet?confirmation=2&oid=<%=o.getOid()%>"><button type="button" class="btn btn-danger">Reject</button></a>
					<%} %>
				</div>
			<%
						}
					} 
					else out.println("<h4>Too soon! You have not recieved any order requests of your products.</h4>");
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