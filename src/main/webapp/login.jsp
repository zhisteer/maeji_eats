<%@ page import="maeji_eats.UserDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
    <title>Login Page</title>
    

</head>
<body>

<!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark ml-5">
        <a class="navbar-brand" href="home.jsp">M-EATS</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
    </nav>
               <% 
                        String username = request.getParameter("username");
                        String password = request.getParameter("password");

                        if (username != null && password != null) {
                            int loggedInId = UserDAO.loginUser(username, password);

                            if (loggedInId != -1) { 
                                session.setAttribute("loggedInUserId", loggedInId);
            					response.sendRedirect("home.jsp");
                            } else { %>
                                <div class="alert alert-danger" role="alert">
                                    Invalid username or password.
                                </div>
                            <% }
                        }
                    %>
                    

                    <!-- Login Form -->
    <div class="form-container">
        <h1 class="text-center">로그인</h1>
        <form action="login.jsp" method="post">
            <div class="form-group">
                <label for="username">아이디:</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">로그인</button>
            <a href="register.jsp" class="btn btn-secondary">회원가입</a>
        </form>
    </div>
<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.8/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>





</body>
</html>
