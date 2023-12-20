<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="maeji_eats.EateryDAO"%>
<%@ page import="maeji_eats.MenuItemDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="maeji_eats.Eatery"%>
<%@ page import="maeji_eats.MenuItem"%>
<%@ page import="java.util.Base64"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>M-Eats | Admin Page</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="styles.css">
</head>
<body class="d-flex flex-column">

	<%
	// Retrieve the eateryName parameter from the URL
	String eateryName = request.getParameter("eateryName");

	// Fetch eatery details based on the eateryName
	EateryDAO eateryDAO = new EateryDAO();
	Eatery eatery = eateryDAO.getEateryByName(eateryName);
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

				<li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a>
			</ul>
		</div>
	</nav>

	<!-- Main Content -->
	<section class="container mt-5 flex-grow-1">
		<div class="jumbotron" style="background-color: transparent;">
			<!-- Add New Menu Item Section -->
			<div class="add-menu-item-container">
				<h2 class="section-heading">메뉴 추가하기</h2>

				<form action="MenuItemAddServlet" method="post"
					enctype="multipart/form-data">
					<!-- Hidden input for eatery name -->
					<input type="hidden" name="placeId"
						value="<%=eatery.getPlaceId()%>">

					<div class="form-group">
						<label for="itemName">이름:</label> <input type="text"
							class="form-control" id="itemName" name="itemName" required>
					</div>

					<div class="form-group">
						<label for="itemPrice">가격:</label> <input type="number"
							class="form-control" id="itemPrice" name="itemPrice" required>
					</div>

					<div class="form-group">
						<label for="itemImage">사진:</label> <input type="file"
							class="form-control-file" id="itemImage" name="itemImage">
					</div>

					<div class="form-group">
						<label for="itemCategory">종료:</label> <input type="text"
							class="form-control" id="itemCategory" name="itemCategory"
							required>
					</div>

					<button type="submit" class="btn btn-primary">추가</button>
				</form>
			</div>

			<!-- Display the selected eatery name -->
			<h2 class="section-heading mt-5">
				Menu Items for
				<%=eatery.getName()%></h2>

			<!-- Display menu items table -->
			<table class="table table-bordered">
				<thead class="thead-light">
					<tr>
						<th>ID</th>
						<th>이름</th>
						<th>가격</th>
						<th>사진</th>
						<th>종료</th>
						<th></th>
					</tr>
				</thead>
				<tbody style="color: white;">
					<%
					// Fetch menu items based on the eatery name

					MenuItemDAO menuItemDAO = new MenuItemDAO();
					List<MenuItem> menuItems = menuItemDAO.getMenuItemsByPlaceId(eatery.getPlaceId());

					for (MenuItem menuItem : menuItems) {
					%>
					<tr>
						<!-- Display Menu Items Data -->
						<td><%=Integer.toString(menuItem.getItemId())%></td>
						<td><%=menuItem.getItemName()%></td>
						<td><%=menuItem.getPrice()%></td>
						<td><img
							src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(menuItem.getImage())%>"
							alt="Item Image" style="max-width: 100px; max-height: 100px;"></td>
						<td><%=menuItem.getCategory()%></td>
						<td>
							<form action="MenuItemAddServlet" method="post">
								<input type="hidden" name="itemId"
									value="<%=menuItem.getItemId()%>">
								<button class="btn btn-danger btn-sm" type="submit"
									name="action" value="delete">삭제</button>
							</form>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

		</div>
	</section>

	<!-- ... (unchanged script section) ... -->
</body>
</html>
