<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="dao.*"%>

<%
String user = (String)request.getSession().getAttribute("user");
String is_seller = (String)request.getSession().getAttribute("is_seller");//1,0
String userid = (String)request.getSession().getAttribute("userid");
if (user != null ) {
    request.setAttribute("user", user);
}
else{
	response.sendRedirect("login.jsp");
}

if(is_seller!=null && is_seller.equals("1")){
	response.sendRedirect("seller_home.jsp");
}

String substr = (String)request.getParameter("search-substr");
ProductDao pd = new ProductDao();
List<Product> prods;
if(substr==null | substr==""){
	prods = pd.getAllProds();
}
else{
	prods = pd.getFilterProds(substr);
}

%>
<!DOCTYPE html>


<html lang="en">
<head>
	<%@include file="./includes/header.jsp"%>
	<title>Big Mart.</title>
	<link rel="stylesheet" href="./static_files/style-home.css">
</head>
<body>
	<header>
		<!-- -------------------------NAVBAR start----------------------------------------- -->

		<%@include file="./includes/navbar.jsp"%>
		<!-- -------------------------NAVBAR END  ------------------------------------------- -->
	</header>
	
	<!-- alert -->
	<script type="text/javascript" async="true">
	function showAlert(ele) {
			ele.classList.remove('hide');
		  ele.classList.add('show');
		}
		// Hide the alert message after 3 seconds
		function hideAlert(ele) {
		  setTimeout(() => {
		    ele.classList.add('hide');
		  }, 3000);
		}

		// Remove the alert message from the page after the fade-out transition is complete
		function removeAlert(ele) {
		  ele.addEventListener('transitionend', () => {
		    alert.remove();
		  });
		}
	</script>
	<div class="alert"></div>
	
	
	<div class="search-div">
		<form class="form-inline my-2 my-lg-0" action="index.jsp" method="GET">
			<input class="form-control mr-sm-2 sbar" type="search"
				placeholder="Search" aria-label="Search" name="search-substr" autocomplete="on">
			<button class="btn btn-dark my-2 my-sm-0" type="submit">Search</button>
		</form>
	</div>

	<div class="banner">
		<div class="wrapper">

			<%
					if (!prods.isEmpty()) {
						for (Product p : prods) {
				%>
				
			<div class="box" onclick="window.location.href='product.jsp?pid=<%=p.getPid()%>'">
				
				<h2><%=p.getName() %></h2>
				<h4>Item for sale..</h4>
				
				<div class="content">
					<div class="info">
						<div class="price">
							Rs
							<%=p.getPrice() %></div>
						<div class="job"><%=p.getSeller() %></div>
						<div class="stars">
							<i class="fas fa-star"><b class="rating"><%=p.getRating() %>/5</b></i>
						</div>
						<br> <button
								class="btn btn-primary" onclick="event.stopPropagation();addToCart(<%=p.getPid()%>)">order it</button>
					</div>
				</div>
			</div>
			<%
						}
					} 
					else out.println("There are no proucts...");
					
				%>


		</div>
	</div>


	<!-- ------------------------------FOOTER-------------------------------------------------- -->
	<script type="text/javascript" defer>
	function addToCart(pid) {
		  // Set up the request
		  console.log("cal");
		  const alert = document.querySelector('.alert');
		  $.ajax({
		    type: "GET",
		    url: "addtocartservlet",
		    data: { pid: pid },
		    success: function(response) {
		    	alert.innerText = 'Item added to cart';				
				showAlert(alert);
				hideAlert(alert);
		    },
		    error: function(error) {
		    	alert.innerText = 'Error adding item to cart';				
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