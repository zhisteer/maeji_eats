<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="maeji_eats.UserDAO"%>
<%@ page import="maeji_eats.User"%>
<%@ page import="maeji_eats.EateryDAO"%>
<%@ page import="maeji_eats.Eatery"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Base64"%>
<%@ page import="maeji_eats.MenuItemDAO"%>
<%@ page import="maeji_eats.MenuItem"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="maeji_eats.Review"%>
<%@ page import="maeji_eats.ReviewDAO"%>
<%@ page import="maeji_eats.LikeDAO" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>M-Eats | Explore Maejiri's Local Eateries</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="color.css">
<link rel="stylesheet" href="styles.css">
<script src="https://kit.fontawesome.com/4b5ce4bbef.js"></script>
</head>
<body>
	<%
	Integer loggedInUserId = (Integer) session.getAttribute("loggedInUserId");
	UserDAO userDAO = new UserDAO();
	User loggedInUser = null; // Initialize to null in case the attribute is not present or has an unexpected type

	if (loggedInUserId != null) {
		loggedInUser = userDAO.getUserById(loggedInUserId);
	}
	%>

	<!-- Navigation Bar -->
	<nav class="navbar navbar-expand-lg navbar-dark ml-5">
		<a class="navbar-brand" href="home.jsp">M-EATS</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end"
			id="navbarNav">
			<ul class="navbar-nav mr-5">
				<%
				if (loggedInUserId == null) {
				%>
				<li class="nav-item"><a class="nav-link" href="login.jsp">로그인</a>
				</li>
				<%
				} else if (loggedInUser.getUsername().equals("admin")) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="adminDashboard.jsp">Admin</a></li>
				<li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a>
				</li>
				<%
				} else {
				%>
				<li class="nav-item"><a class="nav-link" href="profile.jsp"><%=loggedInUser.getUsername()%></a>
				</li>
				<li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a>
				</li>
				<%
				}
				%>
			</ul>
		</div>
	</nav>

</body>
<%

Integer eateryId = Integer.parseInt(request.getParameter("eateryId"));


EateryDAO eateryDAO = new EateryDAO();
Eatery eatery = eateryDAO.getEateryById(eateryId);
%>

<!-- Display eatery details -->
<div class="item-container">
	<h1 class="text-center"><%=eatery.getName()%></h1>


	<div class="place-container">

		<%
		if (eatery.getImage() != null) {
		%>
		<img
			src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(eatery.getImage())%>"
			class="place-logo" alt="Place Image">
		<%
		} else {
		%>
		<img src="" class="place-image" alt="Default Image">
		<%
		}
		%>

		<div class="place-words">
			<div class="row" style="margin: 5px">
				<h5 class="place-type">종료: <%=eatery.getType()%></h5>
        		<h5 class="place-type">총 메뉴 좋아요: <%= eateryDAO.getLikeCount(eatery.getPlaceId()) %></h5>
        		<h5 class="place-type">리뷰 점수: <%=eateryDAO.getReviewScore(eatery.getPlaceId()) %>/10</h5>
    		</div>
			<h5 class="place-description"><%=eatery.getDescription()%></h5>
			<p class="place-description">전화번호: 	<%=eatery.getPhoneNumber()%></p>
			<%
			if (loggedInUser != null && loggedInUser.getUsername().equals("admin")) {
			%>
			<form action="admin_menu_item.jsp" class="place-actions" method="get">
				<input type="hidden" name="eateryName" value="<%=eatery.getName()%>">
				<button type="submit" class="btn btn-primary">Edit</button>
			</form>
			<%
			};
			%>
		</div>
		

	</div>
</div>
<%
MenuItemDAO menuItemDAO = new MenuItemDAO();
List<MenuItem> menuItems = menuItemDAO.getMenuItemsByPlaceId(eatery.getPlaceId());

// Group menu items by category
Map<String, List<MenuItem>> itemsByCategory = new HashMap<>();
for (MenuItem menuItem : menuItems) {
	String category = menuItem.getCategory();
	itemsByCategory.computeIfAbsent(category, k -> new ArrayList<>()).add(menuItem);
}
%>

<!-- Menu Section -->
<div class="menu-container">
	<h2 class="section-heading">메뉴</h2>

	<%
	for (Map.Entry<String, List<MenuItem>> entry : itemsByCategory.entrySet()) {
	%>
	<div class="menu-category">
		<h3><%=entry.getKey()%></h3>

		<div class="menu-items">
			<%
			for (MenuItem menuItem : entry.getValue()) {
			%>
			<div class="menu-item">
				<%
				if (menuItem.getImage() != null) {
				%>
				<img
					src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(menuItem.getImage())%>"
					class="place-image" alt="Place Image">
				<%
				} else {
				%>
				<img src="" class="place-image" alt="Default Image">
				<%
				}
				%>
				<div class="menu-content">
					<h4><%=menuItem.getItemName()%></h4>
					<span><%=menuItem.getPrice()%>원</span>
				</div>

				<%
					boolean hasLiked = false;
					LikeDAO likeDAO = new LikeDAO();
					int likesNum = likeDAO.getLikeCount(menuItem.getItemId());
					if (loggedInUserId != null){
						
						hasLiked = likeDAO.hasUserLikedMenuItem(loggedInUserId, menuItem.getItemId());}
					if (hasLiked){
				%>
				<div class="like-section">
					<button class="like-button has-liked-button" id="like-count-<%=menuItem.getItemId() %>" onclick="handleLikeButtonClick(<%=menuItem.getItemId()%>)">좋아요 <%=likesNum %></button>

				</div>
				<% } else{%>
					<div class="like-section">
					<button class="like-button" id="like-count-<%=menuItem.getItemId() %>" onclick="handleLikeButtonClick(<%=menuItem.getItemId()%>)">좋아요 <%=likesNum %></button>

				</div>
				<%} %>
				
				
			</div>
			<%
			}
			%>
		</div>
	</div>
	<%
	}
	%>
</div>




<!-- Reviews Section -->
<div class="reviews-container">
	<h2 class="section-heading">리뷰</h2>

	<div class="reviews">
		<%
		ReviewDAO reviewDAO = new ReviewDAO();
		List<Review> reviews = reviewDAO.getReviewsByPlaceId(eatery.getPlaceId());
		for (Review review : reviews) {
		%>
		<div class="review">
			<div class="title-rating">
				<h3 class="review-title"><%=review.getReviewTitle()%></h3>
				<div class="rating">
					<span class="rating-value"><%=review.getRating()%></span>/10
				</div>
			</div>
			<div class="user-info">
				<h4>by <%=userDAO.getUserById(review.getUserId()).getUsername() %></h4>
			</div>

			<p class="review-comment"><%=review.getComment()%></p>
			<p class="review-date"><%=review.getCreatedAt()%></p>
		</div>
		<%
		}
		%>
	</div>

	<form action="write_review.jsp" method="get">
		<input type="hidden" name="eateryId" value="<%=eatery.getPlaceId()%>">
		<button type="submit" class="btn btn-primary">리뷰 쓰기</button>
	</form>
</div>


<script>
function handleLikeButtonClick(menuItemId) {

    // Create a FormData object to send data in the request
    var formData = new FormData();
    formData.append("menuItemId", menuItemId);

    // Create an XMLHttpRequest object
    var xhr = new XMLHttpRequest();
    
    // Define the request method, URL, and set asynchronous to true
    xhr.open("POST", "UpdateLikeServlet", true);

    // Set the onload event handler to process the response
    xhr.onload = function () {
        if (xhr.status === 200) {
            // Log the response to the console
            console.log("Response from server: " + xhr.responseText);
            
            // Update the like count on the front end (replace this with your actual logic)
            // You need to have an element with a class or ID to display the like count
            // Example: <span class="like-count" id="like-count-menuItemID">0</span>
            var likeCountElement = document.getElementById('like-count-' + menuItemId);
            if (likeCountElement) {
                likeCountElement.innerHTML = "좋아요 " + xhr.responseText;
                likeCountElement.classList.toggle('has-liked-button');
            }
        } else {
            console.error("Failed to update likes. Status: " + xhr.status);
        }
    };

    // Send the request with the FormData
    xhr.send(formData);
}
</script>

</html>