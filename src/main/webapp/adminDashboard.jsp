<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
    <title>M-Eats | Admin Dashboard</title>
    <!-- Add any additional styles if needed -->
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark ml-5">
        <a class="navbar-brand" href="home.jsp">M-EATS ADMIN</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav mr-5">
                
                <li class="nav-item">
                    <a class="nav-link" href="logout.jsp">Logout</a>
            
            </ul>
        </div>
    </nav>

    <!-- Admin Dashboard Content -->
    <div class="admin-button" onclick="location.href='admin_places.jsp';">
    	<p class="admin-button-text">
    		식당 관리
    	</p>
    </div>
    
    <div class="admin-button" onclick="location.href='admin_users.jsp';">
    	<p class="admin-button-text">
    		유저 관리
    	</p>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.8/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>
