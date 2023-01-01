<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
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
	response.sendRedirect("index.jsp");
}
String pid = (String)request.getParameter("pid");
ProductDao pd = new ProductDao();
Product p=null;
List<Review> revs=null;
if(pid==null | pid==""){
	response.sendRedirect("index.jsp");
}
else{
	p = pd.getProd(pid);
	revs = pd.getReviews(pid,userid);
}

boolean reviewExists = pd.checkReviewExists(userid,pid);
%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="./includes/header.jsp"%>
	<title>Big Mart. - <%=p.getName() %></title>
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
	
	<div class="grid-prod-container">
		<div class="prod-title"><h1><%=p.getName()%></h1></div>
		<div class="prod-info">
			<div class="psudo"></div>
			<p>Rs. <%=p.getPrice()%></p>
			<p>Sold by: <%=p.getSeller() %></p>
			<p>Rated: <%=p.getRating() %>/5</p>
		</div>
	</div>
	<section class="review-section">
		<h4 style="border-bottom:0.1em solid black">Product reviews:</h4>
		<!-- Button trigger modal -->
		<%if(reviewExists){
			%>
			<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#reviewModal" data-backdrop="static" disabled>Write a review</button>
		<%}else{ %>
		<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#reviewModal" data-backdrop="static">
		  Write a review
		</button>
		<%} %>
		<br/>
		<small style="color:rgb(200,200,200);">*one review per user</small>
		
		<!-- Modal -->
		<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="reviewModalLongTitle">Your review</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        	<form id = "review-form" onsubmit="sendFormValues(event);">
					  <div class="form-group">
					    
					    <input type="text" class="form-control" id="r-title" name="r-title" placeholder="review title" required>
					  </div>
					  <div class="form-group">
					    <label for="r-rating">Please rate our product</label>
					    <select class="form-control" id="r-rating" name="r-rating" required>
					      <option value="1">&#xf005; </option>
					      <option value="2">&#xf005; &#xf005; </option>
					      <option value="3">&#xf005; &#xf005; &#xf005; </option>
					      <option value="4">&#xf005; &#xf005; &#xf005; &#xf005; </option>
					      <option value="5">&#xf005; &#xf005; &#xf005; &#xf005; &#xf005; </option>
					    </select>
					  </div>
					  
					  <div class="form-group">
					    <textarea class="form-control" id="r-content" name="r-content" rows="3" placeholder="write review here..." required></textarea>
					    <small class="form-text text-muted">Please be honest with your review as it helps others to make informed decisions.</small>
					  </div>
					  <input name="pid" type="text" value="<%=p.getPid() %>" style="display:none;"/>
					  <div class="modal-footer">
					  <small>*your review is public</small>
					  <button type="submit" class="btn btn-primary">Post</button>
					  </div>
					</form>
		      </div>
		    </div>
		  </div>
		</div>
		<hr/>
		
		<%
					if (!revs.isEmpty()) {
						for (Review r : revs) {
				%>
				
			<div class="review-box">
				<h5><b><%=r.getTitle() %></b></h5>
				<p><%for(int i=0;i<r.getRating();++i){ %>
					<i class="material-icons">star_rate</i> 
					<%} %>
				</p>
				<p class="review-content"><%=r.getContent() %></p>
				
			</div>
			<%
						}
					} 
					else out.println("<h4>This product does not have any reviews yet.</h4>");
					
				%>
		
		
	</section>
	<div class="bottom-fixed rounded-top">
	 <a href="addtocartservlet?pid=<%=p.getPid() %>"><button type="button" class="btn btn-success float-right">Add to cart</button></a>
	</div>
	<!-- ------------------------------FOOTER-------------------------------------------------- -->
	<script type="text/javascript" defer>
	function sendFormValues(e) {
		e.preventDefault();
		$('#reviewModal').modal('hide');
		  // Get the form element
		  const form = $("#review-form");
		  const alert = document.querySelector('.alert');

		  // Serialize the form values
		  const formData = form.serialize();
		  $("#review-form")[0].reset();
		  // Set up the request
		  $.ajax({
		    type: "POST",
		    url: "addreviewservlet",
		    data: formData,
		    success: function(response) {
		      console.log("Review Form values sent successfully!");
				alert.innerText = 'Review submitted';				
				showAlert(alert);
				hideAlert(alert);
		    },
		    error: function(error) {
		      console.error("Error sending review form");
		      alert.innerText = 'Error in sending review';				
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