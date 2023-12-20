package maeji_eats;

import java.io.IOException;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@MultipartConfig
public class SubmitReviewServlet extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Integer loggedInUserId = (Integer) session.getAttribute("loggedInUserId");

        // Retrieve parameters from the form
        int placeId = Integer.parseInt(request.getParameter("placeId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("reviewContent");
        String title = request.getParameter("reviewTitle");

        // Create a new review object
        Review review = new Review();
        review.setUserId(loggedInUserId);
        review.setPlaceId(placeId);
        review.setRating(rating);
        review.setComment(comment);
        review.setReviewTitle(title);


        ReviewDAO reviewDAO = new ReviewDAO();
        reviewDAO.addReview(review);
		// Redirect back to the eatery page after the review is submitted
		response.sendRedirect("place.jsp?eateryId=" + placeId);
	}

}
