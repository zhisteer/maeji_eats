<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="maeji_eats.Eatery"%>
<%@ page import="maeji_eats.EateryDAO"%>
<%@ page import="java.util.Base64"%>
<%@ page import="maeji_eats.MenuItemDAO"%>
<%@ page import="maeji_eats.MenuItem"%>
<%@ page import="java.util.List"%>
<%@ page import="maeji_eats.User" %>
<%@ page import="maeji_eats.UserDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>M-Eats | Write a Review</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="styles.css">
</head>
<body class="d-flex flex-column">
	<% Integer loggedInUserId = (Integer) session.getAttribute("loggedInUserId");
    UserDAO userDAO = new UserDAO();
    User loggedInUser = null; 

    if (loggedInUserId != null) {
    	loggedInUser = userDAO.getUserById(loggedInUserId);
    }
    	
    	%>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark ml-5">
        <a class="navbar-brand" href="home.jsp">M-EATS</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav mr-5">
                <% if (loggedInUserId == null) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">로그인</a>
                    </li>
                <% } else if (loggedInUser.getUsername().equals("admin")) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="adminDashboard.jsp">Admin</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp"><%= loggedInUser.getUsername() %></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </nav>

	<!-- Main Content -->
	<section class="container mt-5 flex-grow-1">
		<div class="jumbotron" style="background-color: transparent;">

			<!-- Display the eatery details -->
			<h2 class="section-heading">
				리뷰 쓰기</h2>
			<%
			Integer eateryId =Integer.parseInt(request.getParameter("eateryId"));
			EateryDAO eateryDAO = new EateryDAO();
			Eatery eatery = eateryDAO.getEateryById(eateryId);

			// Fetch menu items based on the eatery name
			MenuItemDAO menuItemDAO = new MenuItemDAO();
			List<MenuItem> menuItems = menuItemDAO.getMenuItemsByPlaceId(eatery.getPlaceId());
			%>


			<!-- Review Form -->
			<form action="SubmitReviewServlet" method="post" enctype="multipart/form-data">
				<input type="hidden" name="placeId" value="<%=eatery.getPlaceId()%>">
				<input type="hidden" name="eateryName" value="<%=eatery.getName()%>">
				<div class="form-group">
					<label for="reviewTitle">제목:</label> <input type="text"
						class="form-control" id="reviewTitle" name="reviewTitle" required>
				</div>
				<div class="form-group">
					<label for="reviewContent">리뷰:</label>
					<textarea class="form-control" id="reviewContent"
						name="reviewContent" rows="3" required></textarea>
				</div>
				<div class="form-group">
					<label for="rating">점수 (1 to 10):</label> <input type="number"
						class="form-control" id="rating" name="rating" min="1" max="10" style="width: 100px;"
						required>
				</div>
				<button type="submit" class="btn btn-primary">리뷰 남기기</button>
			</form>

		</div>
	</section>


</body>
</html>
