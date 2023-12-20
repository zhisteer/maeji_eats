package maeji_eats;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    // Method to add a review to the database
    public void addReview(Review review) {
        try (Connection connection = DBUtil.getConnection()) {

            String query = "INSERT INTO Reviews (UserId, PlaceID, Rating, Comment, Title) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, review.getUserId());
                preparedStatement.setInt(2, review.getPlaceId());
                preparedStatement.setInt(3, review.getRating());
                preparedStatement.setString(4, review.getComment());
                preparedStatement.setString(5, review.getReviewTitle());

                // Execute the query
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    // Method to get all reviews for a specific place
    public List<Review> getReviewsByPlaceId(int placeId) {
        List<Review> reviews = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection()) {
            String query = "SELECT * FROM Reviews WHERE PlaceID=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, placeId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        Review review = new Review(
                                resultSet.getInt("ReviewID"),
                                resultSet.getInt("UserId"),
                                resultSet.getInt("PlaceID"),
                                resultSet.getInt("Rating"),
                                resultSet.getString("Comment"),
                                resultSet.getString("Title"),
                                resultSet.getTimestamp("CreatedAt")

                        );
                        reviews.add(review);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }

        return reviews;
    }

    // Additional methods as needed

    // ...

}
