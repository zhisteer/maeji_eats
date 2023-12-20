package maeji_eats;

public class User {
    private int id;
    private String username;
    private String password;
    private String phoneNumber;
    private String type;

    // Default no-argument constructor
    public User() {
    }

    // Constructor with parameters
    public User(String username, String password, String phoneNumber, String type) {
        this.username = username;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.type = type;
    }

    public User(int UserID, String username, String password, String phoneNumber, String type) {
    	this.id = UserID;
        this.username = username;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.type = type;
    }

    // Getter and setter methods for id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
    	return type;
    }

    public void setType(String type) {
    	this.type = type;
    }

    // Getter and setter methods for username
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Getter and setter methods for password
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}
