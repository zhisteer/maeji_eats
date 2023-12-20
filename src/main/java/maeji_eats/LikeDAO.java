package maeji_eats;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikeDAO {

    public LikeDAO() {
        // Initialize your database connection
        // ...
    }

    public void updateLike(int userId, int menuItemId) {
        try (Connection connection = DBUtil.getConnection()) {
            if (hasUserLikedMenuItem(userId, menuItemId)) {
                String updateQuery = "DELETE FROM Likes WHERE UserID=? AND MenuItemID=?";
                try (PreparedStatement updateStatement = connection.prepareStatement(updateQuery)) {
                    updateStatement.setInt(1, userId);
                    updateStatement.setInt(2, menuItemId);
                    updateStatement.executeUpdate();
                }
            } else {
                // User has not liked, so insert a new like record
                String insertQuery = "INSERT INTO Likes (UserID, MenuItemID) VALUES (?, ?)";
                try (PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {
                    insertStatement.setInt(1, userId);
                    insertStatement.setInt(2, menuItemId);
                    insertStatement.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    public int getLikeCount(int menuItemId) {
        int likeCount = 0;

        try (Connection connection = DBUtil.getConnection()) {
            String query = "SELECT COUNT(LikeID) AS LikeCount FROM Likes WHERE MenuItemID=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, menuItemId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        likeCount = resultSet.getInt("LikeCount");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }

        return likeCount;
    }

    public boolean hasUserLikedMenuItem(int userId, int menuItemId) {
        try (Connection connection = DBUtil.getConnection()) {
            String query = "SELECT COUNT(LikeID) AS LikeCount FROM Likes WHERE UserID=? AND MenuItemID=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, userId);
                preparedStatement.setInt(2, menuItemId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        int likeCount = resultSet.getInt("LikeCount");
                        return likeCount > 0; // If the count is greater than 0, the user has liked the menu item
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately, e.g., log it or throw a custom exception
        }

        return false; // Default to false if an error occurs
    }
}
