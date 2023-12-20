package maeji_eats;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	public static int registerUser(User user) {
	    try (Connection connection = DBUtil.getConnection();
	         PreparedStatement statement = connection.prepareStatement("INSERT INTO customers (username, password, phonenumber, type) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS)) {
	        statement.setString(1, user.getUsername());
	        statement.setString(2, user.getPassword());
	        statement.setString(3, user.getPhoneNumber());
	        statement.setString(4, user.getType());

	        int rowsAffected = statement.executeUpdate();
	        if (rowsAffected > 0) {
	            ResultSet generatedKeys = statement.getGeneratedKeys();
	            if (generatedKeys.next()) {
	                return generatedKeys.getInt(1);
	            }
	        }
	        return -1;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return -1;
	    }
	}


    public static int loginUser(String username, String password) {
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT UserID FROM customers WHERE username=? AND password=?")) {
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("UserID");
            } else {
                return -1; // Or any other value indicating login failure
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Or any other value indicating login failure
        }
    }



    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection(); ) {
            String query = "SELECT * FROM customers";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query);
                 ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    User user = new User(
                            resultSet.getInt("UserID"),
                            resultSet.getString("Username"),
                            resultSet.getString("Password"),
                            resultSet.getString("PhoneNumber"),
                            resultSet.getString("Type")
                    );
                    users.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }

        return users;
    }

    public User getUserById(int userId) {
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT * FROM customers WHERE UserID=?")) {
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {

                User user = new User();
                user.setId(resultSet.getInt("UserID"));
                user.setUsername(resultSet.getString("username"));
                user.setPhoneNumber(resultSet.getString("PhoneNumber"));
                user.setType(resultSet.getString("Type"));

                return user;
            } else {
                return null; // Or throw an exception, depending on your application's logic
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null; // Or throw an exception, depending on your application's error handling strategy
        }
    }

}
