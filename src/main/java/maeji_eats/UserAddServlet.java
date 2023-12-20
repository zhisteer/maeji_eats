package maeji_eats;

import java.io.IOException;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class UserAddServlet extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String type = request.getParameter("userType");

        User newUser = new User(username, password, phoneNumber, type);



        // Attempt to register the user
        int registrationSuccess = UserDAO.registerUser(newUser);

        if (registrationSuccess != -1) {

			response.sendRedirect("home.jsp");
        } else {
            response.sendRedirect("registration-failure.jsp"); // Redirect to a failure page
        }
	}

}
