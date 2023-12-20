package maeji_eats;

public class Eatery {
    private int placeId;
    private String name;
    private String description;
    private String address;
    private String phoneNumber;
    private String type;
    private byte[] image;

    // Constructors
    public Eatery() {
    }

    public Eatery(int placeId, String name, String description, String address, String phoneNumber, String type, byte[] image) {
        this.placeId = placeId;
        this.name = name;
        this.description = description;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.type = type;
        this.image = image;
    }

    // Getter and Setter methods
    public int getPlaceId() {
        return placeId;
    }

    public void setPlaceId(int placeId) {
        this.placeId = placeId;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    // toString method for debugging or logging purposes
    @Override
    public String toString() {
        return "Eatery{" +
                "placeId=" + placeId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", address='" + address + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", type='" + type + '\'' +
                '}';
    }
}
