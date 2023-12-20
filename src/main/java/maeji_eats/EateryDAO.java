package maeji_eats;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class EateryDAO {


	public void addEatery(Eatery eatery) {
	    try (Connection connection = DBUtil.getConnection()) {

	    	String query = "INSERT INTO places (Name, Description, Address, PhoneNumber, Type, Image) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, eatery.getName());
                preparedStatement.setString(2, eatery.getDescription());
                preparedStatement.setString(3, eatery.getAddress());
                preparedStatement.setString(4, eatery.getPhoneNumber());
                preparedStatement.setString(5, eatery.getType());
                preparedStatement.setBytes(6, eatery.getImage());

                preparedStatement.executeUpdate();
            }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}




    public List<Eatery> getAllEateries() {
        List<Eatery> eateries = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection(); ) {
            String query = "SELECT * FROM places";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query);
                 ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Eatery eatery = new Eatery(
                            resultSet.getInt("PlaceID"),
                            resultSet.getString("Name"),
                            resultSet.getString("Description"),
                            resultSet.getString("Address"),
                            resultSet.getString("PhoneNumber"),
                            resultSet.getString("Type"),
                            resultSet.getBytes("Image")
                    );
                    eateries.add(eatery);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }

        return eateries;
    }


    public void updateEatery(Eatery eatery) {
        try (Connection connection = DBUtil.getConnection(); ) {
            String query = "UPDATE places SET Name=?, Description=?, Address=?, PhoneNumber=?, Type=? WHERE PlaceID=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, eatery.getName());
                preparedStatement.setString(2, eatery.getDescription());
                preparedStatement.setString(3, eatery.getAddress());
                preparedStatement.setString(4, eatery.getPhoneNumber());
                preparedStatement.setString(5, eatery.getType());
                preparedStatement.setInt(6, eatery.getPlaceId());
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteEatery(String placeId) {
        try (Connection connection = DBUtil.getConnection(); ) {
            String query = "DELETE FROM places WHERE PlaceID=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, placeId);
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public Eatery getEateryByName(String eateryName) {
        Eatery eatery = null;

        try (Connection connection = DBUtil.getConnection()) {
            String query = "SELECT * FROM places WHERE Name=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, eateryName);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        eatery = new Eatery(
                                resultSet.getInt("PlaceID"),
                                resultSet.getString("Name"),
                                resultSet.getString("Description"),
                                resultSet.getString("Address"),
                                resultSet.getString("PhoneNumber"),
                                resultSet.getString("Type"),
                                resultSet.getBytes("Image")
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return eatery;
    }

    public Eatery getEateryById(int eateryId) {
        Eatery eatery = null;

        try (Connection connection = DBUtil.getConnection()) {
            String query = "SELECT * FROM places WHERE PlaceID=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, eateryId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        eatery = new Eatery(
                                resultSet.getInt("PlaceID"),
                                resultSet.getString("Name"),
                                resultSet.getString("Description"),
                                resultSet.getString("Address"),
                                resultSet.getString("PhoneNumber"),
                                resultSet.getString("Type"),
                                resultSet.getBytes("Image")
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return eatery;
    }

    public List<Eatery> searchEateries(String searchQuery) {
        List<Eatery> searchResults = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection()) {

            String query = "SELECT * FROM places WHERE LOWER(Name) LIKE LOWER(?) OR LOWER(Description) LIKE LOWER(?) OR LOWER(Type) LIKE LOWER(?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {

                preparedStatement.setString(1, "%" + searchQuery + "%");
                preparedStatement.setString(2, "%" + searchQuery + "%");
                preparedStatement.setString(3, "%" + searchQuery + "%");

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        Eatery eatery = new Eatery(
                                resultSet.getInt("PlaceID"),
                                resultSet.getString("Name"),
                                resultSet.getString("Description"),
                                resultSet.getString("Address"),
                                resultSet.getString("PhoneNumber"),
                                resultSet.getString("Type"),
                                resultSet.getBytes("Image")
                        );
                        searchResults.add(eatery);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }

        return searchResults;
    }

    public int getLikeCount(int placeId) {
        int totalLikeCount = 0;

        try (Connection connection = DBUtil.getConnection()) {
            // Retrieve all menu items for the given place
            String menuItemQuery = "SELECT ItemID FROM MenuItems WHERE PlaceID=?";
            try (PreparedStatement menuItemStatement = connection.prepareStatement(menuItemQuery)) {
                menuItemStatement.setInt(1, placeId);

                try (ResultSet menuItemResultSet = menuItemStatement.executeQuery()) {
                    while (menuItemResultSet.next()) {
                        // For each menu item, retrieve its like count using LikeDAO
                        int menuItemId = menuItemResultSet.getInt("ItemID");
                        LikeDAO likeDAO = new LikeDAO();
                        int menuItemLikeCount = likeDAO.getLikeCount(menuItemId);
                        totalLikeCount += menuItemLikeCount;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }

        return totalLikeCount;
    }

    public float getReviewScore(int placeId) {
        int totalReviewScore = 0;
        float avgReviewScore = 0;

        try (Connection connection = DBUtil.getConnection()) {
            String query = "SELECT Rating FROM reviews WHERE placeId = ?";

            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, placeId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    int reviewCount = 0;

                    while (resultSet.next()) {
                        int score = resultSet.getInt("rating");
                        totalReviewScore += score;
                        reviewCount++;
                    }

                    if (reviewCount > 0) {
                        avgReviewScore = (float) totalReviewScore / reviewCount;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return avgReviewScore;
    }
    public List<Eatery> getPlacesByLikesCount() {
        List<Eatery> places = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection()) {
            String query = "SELECT places.placeId, COUNT(likes.LikeID) AS like_count " +
                           "FROM places " +
                           "JOIN menuItems ON places.placeId = menuItems.PlaceID " +
                           "LEFT JOIN likes ON menuItems.ItemID = likes.MenuItemID " +
                           "GROUP BY places.placeId " +
                           "ORDER BY like_count DESC " +
                           "LIMIT 2";

            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        int placeId = resultSet.getInt("placeId");

                        Eatery place = getEateryById(placeId);
                        places.add(place);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return places;
    }


}
