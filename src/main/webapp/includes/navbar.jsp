<nav class="navbar navbar-expand-lg navbar-dark ">
			<a href="#"><img src="./static_files/bm-logo.png"
				style="width: 1.8em;transform: scale(1.5);margin-right:1em;"></a>
			<!-- <a class="navbar-brand" href="#">TREND</a> -->
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link" href="index.jsp#">Home
					</a></li>
					<li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="order.jsp">Orders</a>
					</li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> Related </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="about.jsp">About </a> <a
								class="dropdown-item" href="contact.jsp">Contact me</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="#"></a>
						</div></li>
					<li class="nav-item"><a class="nav-link disabled" href="#">Offer</a>
					</li>

				</ul>
				<form class="form-inline my-2 my-lg-0" action="logoutservlet"
					method="POST">
					<p class="user-welcome">
						Hello!,
						<%= request.getSession().getAttribute("user") %></p>
					<button class="btn btn-outline-danger my-2 my-sm-0" type="submit">Logout</button>
				</form>
			</div>
		</nav>