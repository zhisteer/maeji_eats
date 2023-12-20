package maeji_eats;

import java.io.IOException;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class EateryEditServlet extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	String eateryName = request.getParameter("eateryName");
	        String eateryDescription = request.getParameter("eateryDescription");
	        String eateryAddress = request.getParameter("eateryAddress");
	        String eateryPhoneNumber = request.getParameter("eateryPhoneNumber");
	        String eateryType = request.getParameter("eateryType");
	        String eateryId = request.getParameter("placeId");

	        // Create Eatery object
	        Eatery thisEatery = new Eatery();
	        thisEatery.setName(eateryName);
	        thisEatery.setDescription(eateryDescription);
	        thisEatery.setAddress(eateryAddress);
	        thisEatery.setPhoneNumber(eateryPhoneNumber);
	        thisEatery.setType(eateryType);
	        thisEatery.setPlaceId(Integer.parseInt(eateryId));

	        // Add Eatery to the database
	        EateryDAO eateryDAO = new EateryDAO();
	        eateryDAO.updateEatery(thisEatery);

	        // Redirect to the page displaying eateries or any other appropriate page
	        response.sendRedirect("admin_places.jsp");
	}

}
