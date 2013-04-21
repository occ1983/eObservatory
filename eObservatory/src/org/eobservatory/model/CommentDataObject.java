package org.eobservatory.model;

import java.sql.Date;

public class CommentDataObject {
	private String userId;
	private String comment;
	private Integer rating;
	private String neoId;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Integer getRating() {
		return rating;
	}
	public void setRating(Integer rating) {
		this.rating = rating;
	}
	public String getNeoId() {
		return neoId;
	}
	public void setNeoId(String neoId) {
		this.neoId = neoId;
	}
	
}
