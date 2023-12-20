package maeji_eats;

import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
public class MenuItemAddServlet extends HttpServlet implements Servlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// Retrieve form data
			String placeId = request.getParameter("placeId");
			String itemName = request.getParameter("itemName");
			String itemPrice = request.getParameter("itemPrice");
			String itemCategory = request.getParameter("itemCategory");

			// Retrieve and process image file
			Part imagePart = request.getPart("itemImage");
			InputStream imageInputStream = imagePart.getInputStream();
			byte[] imageBytes = imageInputStream.readAllBytes();

			// Encode image bytes to Base64

			// Create MenuItem object
			MenuItem menuItem = new MenuItem();
			menuItem.setPlaceId(Integer.parseInt(placeId));
			menuItem.setItemName(itemName);
			menuItem.setPrice(Integer.parseInt(itemPrice));
			menuItem.setImage(imageBytes);
			menuItem.setCategory(itemCategory);

			// Add the new menu item to the database
			MenuItemDAO menuItemDAO = new MenuItemDAO();
			menuItemDAO.addMenuItem(menuItem);

			// Redirect back to the admin_menu_items.jsp page with the eateryName parameter
			response.sendRedirect("place.jsp?eateryId=" + placeId);
		} catch (Exception e) {
			e.printStackTrace();
			// Handle the exception appropriately and show an error message
			response.getWriter().println("Error: " + e.getMessage());
		}
	}

}
