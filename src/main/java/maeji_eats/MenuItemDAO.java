package maeji_eats;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuItemDAO {

    // Method to add a menu item to the database
    public void addMenuItem(MenuItem menuItem) {
        try (Connection connection = DBUtil.getConnection()) {

            String query = "INSERT INTO MenuItems (ItemName, Price, Image, Category, PlaceID) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, menuItem.getItemName());
                preparedStatement.setDouble(2, menuItem.getPrice());
                preparedStatement.setBytes(3, menuItem.getImage());
                preparedStatement.setString(4, menuItem.getCategory());
                preparedStatement.setInt(5, menuItem.getPlaceId());

                // Execute the query
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    // Method to get all menu items for a specific place
    public List<MenuItem> getMenuItemsByPlaceId(int placeId) {
        List<MenuItem> menuItems = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection()) {
            String query = "SELECT * FROM MenuItems WHERE PlaceID=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, placeId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        MenuItem menuItem = new MenuItem(
                                resultSet.getInt("ItemID"),
                                resultSet.getString("ItemName"),
                                resultSet.getInt("Price"),
                                resultSet.getBytes("Image"),
                                resultSet.getString("Category"),
                                resultSet.getInt("PlaceID")
                        );
                        menuItems.add(menuItem);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }

        return menuItems;
    }

    // Method to update a menu item in the database
    public void updateMenuItem(MenuItem menuItem) {
        try (Connection connection = DBUtil.getConnection()) {
            String query = "UPDATE MenuItems SET ItemName=?, Price=?, Image=?, Category=? WHERE ItemID=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, menuItem.getItemName());
                preparedStatement.setDouble(2, menuItem.getPrice());
                preparedStatement.setBytes(3, menuItem.getImage());
                preparedStatement.setString(4, menuItem.getCategory());
                preparedStatement.setInt(5, menuItem.getItemId());
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    // Method to delete a menu item from the database
    public void deleteMenuItem(int itemId) {
        try (Connection connection = DBUtil.getConnection()) {
            String query = "DELETE FROM Menu_Items WHERE ItemID=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, itemId);
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    // Method to get a menu item by its ID
    public MenuItem getMenuItemById(int itemId) {
        MenuItem menuItem = null;

        try (Connection connection = DBUtil.getConnection()) {
            String query = "SELECT * FROM MenuItems WHERE ItemID=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, itemId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        menuItem = new MenuItem(
                                resultSet.getInt("ItemID"),
                                resultSet.getString("ItemName"),
                                resultSet.getInt("Price"),
                                resultSet.getBytes("Image"),
                                resultSet.getString("Category"),
                                resultSet.getInt("PlaceID")
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }

        return menuItem;
    }

    public int getLikeCount(int menuItemId) {
        LikeDAO likeDAO = new LikeDAO();
        return likeDAO.getLikeCount(menuItemId);
    }
}
