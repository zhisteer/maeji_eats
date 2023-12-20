package maeji_eats;

import java.io.IOException;
import java.io.InputStream;

import org.apache.tomcat.jakartaee.commons.io.IOUtils;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;



@MultipartConfig
public class EateryAddServlet extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Extract parameters from the request
        String eateryName = request.getParameter("eateryName");
        String eateryDescription = request.getParameter("eateryDescription");
        String eateryAddress = request.getParameter("eateryAddress");
        String eateryPhoneNumber = request.getParameter("eateryPhoneNumber");
        String eateryType = request.getParameter("eateryType");
        Part filePart = request.getPart("eateryImage");
        InputStream imageInputStream = filePart.getInputStream();
        byte[] imageData = IOUtils.toByteArray(imageInputStream);

        // Create Eatery object
        Eatery thisEatery = new Eatery();
        thisEatery.setName(eateryName);
        thisEatery.setDescription(eateryDescription);
        thisEatery.setAddress(eateryAddress);
        thisEatery.setPhoneNumber(eateryPhoneNumber);
        thisEatery.setType(eateryType);
        thisEatery.setImage(imageData);

        // Add Eatery to the database
        EateryDAO eateryDAO = new EateryDAO();
        eateryDAO.addEatery(thisEatery);

        // Redirect to the page displaying eateries or any other appropriate page
        response.sendRedirect("admin_places.jsp");
	}

}
