package maeji_eats;

import java.io.IOException;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
public class UpdateLikeServlet extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get the menuItemId parameter from the AJAX request
        String menuItemIdString = request.getParameter("menuItemId");
        int menuItemId = Integer.parseInt(menuItemIdString);


        // Get the logged-in user's ID (assuming you have a session attribute for that)
        int userId = (int) request.getSession().getAttribute("loggedInUserId");

        // Update likes in the database
        LikeDAO likeDAO = new LikeDAO();
        likeDAO.updateLike(userId, menuItemId);

        // Send the new like count as the response to the AJAX request
        response.getWriter().write(String.valueOf(likeDAO.getLikeCount(menuItemId)));
	}

}
