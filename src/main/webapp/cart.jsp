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

ProductDao pd = new ProductDao();
List<Product> prods = pd.getCartProds(user);

boolean emptyCart = false;

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="./includes/header.jsp"%>
    <title>Cart - <%= request.getSession().getAttribute("user") %></title>
    <link rel="stylesheet" href="./static_files/style-home.css">
</head>
<body>
</head>
<body>
    <header>
        <!-- -------------------------NAVBAR start----------------------------------------- -->
        
        <%@include file="./includes/navbar.jsp"%>
        <!-- -------------------------NAVBAR END  ------------------------------------------- -->
            </header>
            
            <div class="cart-grid">

             <div class="banner">
                <div class="wrapper">
                
                <%
                	float sum= 0.00f;
					if (!prods.isEmpty()) {
						for (Product p : prods) {
							sum+= p.getPrice()*p.getQuantity();
				%>
                    <div class="cart-list">
                    	<div class="cart-item-info">
	                    	<%=p.getName() %> &emsp;<i class="material-icons">star_rate</i><%=p.getRating() %> <br/>
	                    	Current Price: &emsp;Rs.<%=p.getPrice() %>
                    	</div>
                    	<div class="cart-quantity">Quantity: <input type="number" id="quantity" min="1" max="100" value=<%=p.getQuantity() %>></div>
                        <a href="removefromcartservlet?pid=<%=p.getPid() %>"><button class="btn btn-danger"><i class="material-icons">close</i></button></a>
                    </div>
        		<%
						}
					} 
					else{ out.println("<h4>There are no proucts in your cart...<br>Please check order page for details</h4>");
					emptyCart = true;}
				%>
        			
                  </div>   
                    <%if(is_seller.equals("1")){ %>
                    <hr><span>Cannot purchase items using a seller account. Please create a customer account.</span>
        				<%} %>
                <!-- <img src="comp.png" class="image"> -->
            </div>
            <!-- -------------------------------banner ends---- -->
            <div class="cart-info">
            <div class="cart-info-sticky">
            	<p>Please confirm the items in your cart before placing the order.</p>
            	<p><b>Place order for all items in cart:</b></p>
            	<hr/>
            	<p>Total price: <%=sum %> </p>
            	<% if(emptyCart){ %>
            	<button type="button" class="btn btn-primary" disabled>BUY ALL</button>
            	<%}else{ %>
            	<a href="orderallservlet?uname=<%=user%>"><button type="button" class="btn btn-primary">BUY ALL</button></a>
            	<%} %>
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