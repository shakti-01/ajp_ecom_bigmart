<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.util.*"%>
<%@page import="dao.*"%>
<%
String user = (String)request.getSession().getAttribute("user");
if (user == null ) {
	response.sendRedirect("login.jsp");
}

ProductDao pd = new ProductDao();
List<Product> prods;
prods = pd.getSellerProds((String)request.getSession().getAttribute("userid"));
%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="./includes/header.jsp"%>
	<title>Big Mart. - Seller page</title>
	<link rel="stylesheet" href="./static_files/style-home.css">
</head>
<body>
	<header>
		<%@include file="./includes/navbar.jsp"%>
	</header>
	<!-- ---------------------add prod------------------- -->
	
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Adding new item listing</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form action="addnewprodservlet" method="POST">
				  <div class="form-group">
				    <label for="pname">Enter product name:</label>
				    <input type="text" class="form-control" id="pname" name="pname" placeholder="Enter product name" required>
				    <small class="form-text text-muted">Enter a suitable name to help customers find the product easily.</small>
				  </div>
				  <div class="form-group">
				    <label for="price">Set price:</label>
				    <input type="number" class="form-control" id="price" name="price" placeholder="In rs" required>
				  </div>
				  <div class="form-group">
				  	<label>Product listed by: </label>
				    <input type="text" class="form-control" name="seller" value="<%=(String)request.getSession().getAttribute("user") %>" readonly/>
				  </div>
				  <div class="form-group">
				  	<label>Initial rating:</label>
				    <input type="number" class="form-control" name="rating" value="5" readonly/>
				  </div>
				  <button type="submit" class="btn btn-primary">Add</button>
			</form>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="banner">
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
		  Add new item
		</button>
	<!-- -----------------------add prod ends----------------- -->
		<div class="wrapper">

			<%
					if (!prods.isEmpty()) {
						for (Product p : prods) {
				%>
					<div class="cart-list">
                    	<div class="cart-item-info">
	                    	<%=p.getName() %> &emsp;<i class="material-icons">star_rate</i><%=p.getRating() %> <br/>
	                    	Current Price: &emsp;Rs.<%=p.getPrice() %>
                    	</div>
                    	<div>Order requests: <%=p.getTimesOrdered() %></div>
                    	<div>
                    	<a href="removesellerprodservlet?pid=<%=p.getPid() %>"> <button type="button" class="btn btn-danger">Remove item</button></a>
                    	</div>
                    </div>
			<%
						}
					} 
					else out.println("<h3>You have not put up any products yet!!</h3>");
					
				%>


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