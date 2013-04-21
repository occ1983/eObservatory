package org.eobservatory.model;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.eobservatory.util.AppDateSerializer;

public class Comment {
	private String userId;
	private String comment;
	private Date commentDate;
	private Integer rating;
	
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
	
	@JsonSerialize(using = AppDateSerializer.class)
	public Date getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}
	public Integer getRating() {
		return rating;
	}
	public void setRating(Integer rating) {
		this.rating = rating;
	}
	
}
