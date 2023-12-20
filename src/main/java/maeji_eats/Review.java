package maeji_eats;

import java.sql.Timestamp;

public class Review {
    private int reviewId;
    private int userId;
    private int placeId;
    private int rating;
    private String comment;
    private Timestamp createdAt;
    private String title;

    public Review() {

    }

    public Review(int reviewId, int userId, int placeId, int rating, String comment, String title, Timestamp createdAt) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.placeId = placeId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.title = title;
    }

    // Getters and setters (You can generate them using your IDE)
    public String getReviewTitle() {
    	return title;
    }

    public void setReviewTitle(String title) {
    	this.title = title;
    }

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPlaceId() {
        return placeId;
    }

    public void setPlaceId(int placeId) {
        this.placeId = placeId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
