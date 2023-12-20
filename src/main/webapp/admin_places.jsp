<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="maeji_eats.EateryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="maeji_eats.Eatery" %>
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
            
           

            <!-- Add form for adding data -->
            <form action="EateryAddServlet" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="eateryName">이름</label>
                        <input type="text" class="form-control" id="eateryName" name="eateryName" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="eateryType">종료:</label>
                        <select class="form-control" id="eateryType" name="eateryType" required>
                        	<option value="중식">중식</option> 
                        	<option value="카페">카페</option>
                        	<option value="술집">술집</option>
                        	<option value="한식">한식</option>
                        	<option value="양식">양식</option>
                        	<option value="치킨">치킨</option>
                        	<option value="분식">분식</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="eateryDescription">설명:</label>
                    <textarea class="form-control" id="eateryDescription" name="eateryDescription" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="eateryPhoneNumber">전화번호:</label>
                    <input type="text" class="form-control" id="eateryPhoneNumber" name="eateryPhoneNumber" required>
                </div>
                <div class="form-group">
        			<label for="eateryImage">사진:</label>
        			<input type="file" class="form-control-file" id="eateryImage" name="eateryImage">
    			</div>
                <button type="submit" class="btn btn-primary" style="font-size: 30px; border">추가</button>
            </form>
			<hr>

            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>ID</th>
                        <th>이름</th>
                        <th>설명</th>
                        <th>전화번호</th>
                        <th>종료</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody style="color:white;">
                    <%
                        EateryDAO eateryDAO = new EateryDAO();
                        List<Eatery> eateries = eateryDAO.getAllEateries();

                        for (Eatery eatery : eateries) {
                    %>
                        <tr>
                            <!-- Display Eateries Data -->
                            <td><%= Integer.toString(eatery.getPlaceId()) %></td>
                            <td><%= eatery.getName() %></td>
                            <td><%= eatery.getDescription() %></td>
                            <td><%= eatery.getPhoneNumber() %></td>
                            <td><%= eatery.getType() %></td>
                            <td>
                                <div style="display:flex;">
                                <button class="btn btn-primary btn-sm" onclick="showEditDialog('<%= eatery.getPlaceId()%>', '<%= eatery.getName()%>', '<%= eatery.getDescription()%>', '<%= eatery.getAddress()%>', '<%= eatery.getPhoneNumber()%>', '<%= eatery.getType()%>')">수정</button>

                                <form action="EateryDeleteServlet" method="post">
                                    <input type="hidden" name="placeId" value="<%= eatery.getPlaceId()%>">
                                    <button class="btn btn-danger btn-sm" type="submit">삭제</button>
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
    <div id="editEateryDialog" style="display: none;">
	

    <form id="editEateryForm" action="EateryEditServlet" method="post">
        <!-- Hidden input for placeId -->
        <input type="hidden" id="editPlaceId" name="placeId">

        <div class="form-group">
            <label for="editEateryName">이름:</label>
            <input type="text" class="form-control" id="editEateryName" name="eateryName" required>
        </div>

        <div class="form-group">
            <label for="editEateryDescription">설명:</label>
            <textarea class="form-control" id="editEateryDescription" name="eateryDescription" rows="3" required></textarea>
        </div>
 
        <div class="form-group">
            <label for="editEateryPhoneNumber">전화번호:</label>
            <textarea class="form-control" id="editEateryPhoneNumber" name="eateryPhoneNumber" rows="3" required></textarea>
        </div>
        <div class="form-group">
            <label for="editEateryType">종료:</label>
            <textarea class="form-control" id="editEateryType" name="eateryType" rows="3" required></textarea>
        </div>

        <!-- Add other form fields for edit, e.g., eateryAddress, eateryPhoneNumber, eateryType -->

        <button type="submit" class="btn btn-primary">저장</button>
        <button type="button" class="btn btn-secondary" onclick="closeEditDialog()">Cancel</button>
    </form>
</div>
        </div>
    </section>

    
    
    <script>
    	function showEditDialog(placeId, eateryName, eateryDescription, eateryAddress, eateryPhoneNumber, eateryType) {
        	// Set values in the edit form fields
        	document.getElementById("editPlaceId").value = placeId;
        	document.getElementById("editEateryName").value = eateryName;
        	document.getElementById("editEateryDescription").value = eateryDescription;
        	
        	document.getElementById("editEateryPhoneNumber").value = eateryPhoneNumber;
        	document.getElementById("editEateryType").value = eateryType;
        	// Set values for other form fields

        	// Display the edit dialog
        	document.getElementById("editEateryDialog").style.display = "block";
    	}

        function closeEditDialog() {
            document.getElementById("editEateryDialog").style.display = "none";
        }
    </script>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.8/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>