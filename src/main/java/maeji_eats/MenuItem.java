package maeji_eats;



public class MenuItem {
    private int itemId;
    private String itemName;
    private int price;
    private byte[] image;
    private String category;
    private int placeId; // Foreign Key (reference to the Eatery table)

    // Constructors, getters, and setters
    public MenuItem() {

    }

    public MenuItem(int itemId, String itemName, int price, byte[] image, String category, int placeId) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.price = price;
        this.image = image;
        this.category = category;
        this.placeId = placeId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getPlaceId() {
        return placeId;
    }

    public void setPlaceId(int placeId) {
        this.placeId = placeId;
    }
}
