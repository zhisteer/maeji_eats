<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="maeji_eats.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="maeji_eats.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>M-Eats | Admin Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body class="d-flex flex-column">
   <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark ml-5">
        <a class="navbar-brand" href="home.jsp">M-EATS</a>
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

    <!-- Main Content -->
    <section class="container mt-5 flex-grow-1">
        <div class="jumbotron" style="background-color: transparent;">

            <!-- Add form for adding user -->
            <form action="UserAddServlet" method="post">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="username">Username:</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="phoneNumber">Phone Number:</label>
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
                </div>
                <div class="form-group">
                    <label for="userType">Type:</label>
                    <select class="form-control" id="userType" name="userType" required>
                        <option value="admin">Admin</option>
                        <option value="regular">Regular</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Add User</button>
            </form>
            <hr>

            <!-- Display Users in a table -->
            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Phone Number</th>
                        <th>Type</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody style="color: white;">
                    <%
                        UserDAO userDAO = new UserDAO();
                        List<User> users = userDAO.getAllUsers();

                        for (User user : users) {
                    %>
                        <tr>
                            <!-- Display User Data -->
                            <td><%= user.getId() %></td>
                            <td><%= user.getUsername() %></td>
                            <td><%= user.getPassword() %></td>
                            <td><%= user.getPhoneNumber() %></td>
                            <td><%= user.getType() %></td>
                            <td>
                                <div style="display: flex;">
                                    <button class="btn btn-primary btn-sm" onclick="showEditUserDialog('<%= user.getId()%>', '<%= user.getUsername()%>', '<%= user.getPassword()%>', '<%= user.getPhoneNumber()%>', '<%= user.getType()%>')">Edit</button>

                                    <form action="UserDeleteServlet" method="post">
                                        <input type="hidden" name="userId" value="<%= user.getId()%>">
                                        <button class="btn btn-danger btn-sm" type="submit">Delete</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <hr>
            
            <!-- Edit User Dialog -->
            <div id="editUserDialog" style="display: none;">
                <form id="editUserForm" action="UserEditServlet" method="post">
                    <!-- Hidden input for userId -->
                    <input type="hidden" id="editUserId" name="userId">

                    <!-- Add other form fields for edit, e.g., editUsername, editPassword, editPhoneNumber, editType -->

                    <button type="submit" class="btn btn-primary">Save Changes</button>
                    <button type="button" class="btn btn-secondary" onclick="closeEditUserDialog()">Cancel</button>
                </form>
            </div>
        </div>
    </section>

    <script>
        function showEditUserDialog(userId, username, password, phoneNumber, userType) {
            // Set values in the edit form fields
            document.getElementById("editUserId").value = userId;
            document.getElementById("editUsername").value = username;
            document.getElementById("editPassword").value = password;
            document.getElementById("editPhoneNumber").value = phoneNumber;
            document.getElementById("editUserType").value = userType;

            // Display the edit dialog
            document.getElementById("editUserDialog").style.display = "block";
        }

        function closeEditUserDialog() {
            document.getElementById("editUserDialog").style.display = "none";
        }
    </script>

    <!-- Include your Bootstrap and other scripts here -->
</body>
</html>
