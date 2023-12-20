<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="maeji_eats.EateryDAO" %>
<%@ page import="maeji_eats.Eatery" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ page import="maeji_eats.User" %>
<%@ page import="maeji_eats.UserDAO" %>

<%
    String searchQuery = request.getParameter("query");

    EateryDAO eateryDAO = new EateryDAO();
    List<Eatery> searchResults = eateryDAO.searchEateries(searchQuery);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>M-Eats | Search Results</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="color.css">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="search.css">
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
        
        <!-- Search Form -->
        <form class="form-inline mt-4 search-form" action="search.jsp" method="get">
            <div class="search-container">
                <input type="text" class="search-input" name="query" value="<%= searchQuery %>" placeholder="마라탕...">
                <button type="submit" class="search-button">
                    <i class="fa fa-search"></i>
                </button>
            </div>
            
        </form>

        

        <!-- Display Search Results -->
        <% if (searchResults != null && !searchResults.isEmpty()) { %>
            <div class="place-column">
                <% for (Eatery eatery : searchResults) { %>
                    <a class="place-card" href="place.jsp?eateryId=<%= eatery.getPlaceId() %>">
                        <div class="place-content">
                            <h5 class="place-title"><%= eatery.getName() %></h5>
                            <p class="card-text"><%= eatery.getDescription() %></p>
                        </div>
                        <% if (eatery.getImage() != null) { %>
                            <img src="data:image/png;base64,<%= Base64.getEncoder().encodeToString(eatery.getImage()) %>" class="place-image" alt="Place Image">
                        <% } else { %>
                            <img src="" class="place-image" alt="Default Image">
                        <% } %>
                    </a>
                <% } %>
            </div>
        <% } else { %>
            <p class="text-center">"<%= searchQuery %>"가 없습니다.</p>
        <% } %>
    </div>


</body>
</html>
