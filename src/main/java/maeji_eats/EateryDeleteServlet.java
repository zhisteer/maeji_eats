package maeji_eats;

import java.io.IOException;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class EateryDeleteServlet extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Extract parameters from the request
        String placeId = request.getParameter("placeId");

        // Invoke deleteEatery method in the DAO
        EateryDAO eateryDAO = new EateryDAO();
        eateryDAO.deleteEatery(placeId);

        // Redirect to the page displaying eateries or any other appropriate page
        response.sendRedirect("admin_places.jsp");
	}

}
