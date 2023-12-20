<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="maeji_eats.UserDAO" %>
<%@ page import="maeji_eats.User" %>
<%@ page import="maeji_eats.EateryDAO" %>
<%@ page import="maeji_eats.Eatery" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>M-Eats | Explore Maejiri's Local Eateries</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="color.css">
    <link rel="stylesheet" href="styles.css">
    <script src="https://kit.fontawesome.com/4b5ce4bbef.js"></script>
</head>
<body>
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


    <div class="item-container">
    <h1 class="text-center">식당 찾기</h1>
    <form class="form-inline mt-4" action="search.jsp" method="get">
        <div class="search-container">
            <input type="text" class="search-input" name="query" placeholder="마라탕...">
            <button type="submit" class="search-button">
                <i class="fa fa-search"></i>
            </button>
        </div>
    </form>
</div>


    <!-- Featured Places Section -->	
    <div class="item-container">
        <h1 class="text-center">인기</h1>
        <div class="place-row">
            <% 
                EateryDAO eateryDAO = new EateryDAO();
                List<Eatery> eateries = eateryDAO.getPlacesByLikesCount();

                for (Eatery eatery : eateries) {
            %>
                
                    <a class="place-card" href="place.jsp?eateryId=<%= eatery.getPlaceId() %>">
                        
                        <div class="place-content">
                            <h5 class="place-title"><%= eatery.getName() %></h5>
                            <p class="card-text"><%= eatery.getDescription() %></p>
                            <div class="card-like">
                            	<i class="fa-regular fa-thumbs-up"></i>
                            	<p class="card-text"><%= eateryDAO.getLikeCount(eatery.getPlaceId()) %>
                            </div>
                        </div>
                        <% if (eatery.getImage() != null) { %>
            				<img src="data:image/png;base64,<%= Base64.getEncoder().encodeToString(eatery.getImage()) %>" class="place-image" alt="Place Image">
        					<% } else { %>
            				<img src="" class="place-image" alt="Default Image">
        					<% } %>
                    </a>
            <% } %>
        </div>
    </div>
    
    <div class="item-container">
    <h1 class="text-center">전체</h1>
    <div class="categories">
        <div onclick="redirectToSearch('카페')" class="category-card">
            <i class="fa-solid fa-mug-hot fa-3x category-img"></i>
            <p class="category-text">카페</p>
        </div>
        <div onclick="redirectToSearch('술집')" class="category-card">
            <i class="fa-solid fa-martini-glass fa-3x category-img"></i>
            <p class="category-text">술집</p>
        </div>
        <div onclick="redirectToSearch('양식')" class="category-card">
            <i class="fa-solid fa-pizza-slice fa-3x category-img"></i>
            <p class="category-text">양식</p>
        </div>
        <div onclick="redirectToSearch('치킨')" class="category-card">
            <i class="fa-solid fa-drumstick-bite fa-3x category-img"></i>
            <p class="category-text">치킨</p>
        </div>
        <div onclick="redirectToSearch('한식')" class="category-card">
            <i class="fa-solid fa-bowl-food fa-3x category-img"></i>
            <p class="category-text">한식</p>
        </div>
        <div onclick="redirectToSearch('중식')" class="category-card">
            <i class="fa-solid fa-shrimp fa-3x category-img"></i>
            <p class="category-text">중식</p>
        </div>
        <div onclick="redirectToSearch('분식')" class="category-card">
            <i class="fa-solid fa-fish fa-3x category-img"></i>
            <p class="category-text">분식</p>
        </div>
    </div>
</div>



	<script>
        function redirectToSearch(category) {
            window.location.href = 'search.jsp?query=' + encodeURIComponent(category);
        }
    </script>
	    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.8/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
