package org.eobservatory.model;

import java.util.Date;
import java.util.List;
import org.bson.BSONObject;
import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.eobservatory.util.AppDateDeserializer;
import org.eobservatory.util.AppDateSerializer;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "nearearthobjects")
public class NearEarthObject {
	@Id
	private String id;
	private String userId;
	private String description;
	private Date discoveryDate;
	private Date lastUpdate;
	private String tags;
	private String title;
	private String code;
	private Double score;
	private Double longitude;
	private Double latitude;
	private Double altitude;
	private Double v;
	private Double h;
	private Double arc;
	/*private Integer commentsCount;
	private Integer observationsCount;*/
	private List<String> categories;
	private List<Comment> comments;
	private List<Observation> observations;
	private List<String> attachments;
	private List<Attachment> attachmentObjects;
	
	public List<String> getCategories() {
		return categories;
	}

	public void setCategories(List<String> categories) {
		this.categories = categories;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@JsonSerialize(using = AppDateSerializer.class)
	public Date getDiscoveryDate() {
		return discoveryDate;
	}

	@JsonDeserialize(using = AppDateDeserializer.class)
	public void setDiscoveryDate(Date discoveryDate) {
		this.discoveryDate = discoveryDate;
	}

	public Date getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(Date lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getAltitude() {
		return altitude;
	}

	public void setAltitude(Double altitude) {
		this.altitude = altitude;
	}

	public Double getV() {
		return v;
	}

	public void setV(Double v) {
		this.v = v;
	}

	public Double getH() {
		return h;
	}

	public void setH(Double h) {
		this.h = h;
	}

	public Double getArc() {
		return arc;
	}

	public void setArc(Double arc) {
		this.arc = arc;
	}

	public List<Observation> getObservations() {
		return observations;
	}

	public void setObservations(List<Observation> observations) {
		this.observations = observations;
	}

	/*public Integer getCommentsCount() {
		return commentsCount;
	}

	public Integer getObservationsCount() {
		return observationsCount;
	}*/

	public List<String> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<String> attachments) {
		this.attachments = attachments;
	}

	public List<Attachment> getAttachmentObjects() {
		return attachmentObjects;
	}

	public void setAttachmentObjects(List<Attachment> attachmentObjects) {
		this.attachmentObjects = attachmentObjects;
	}
	
}
