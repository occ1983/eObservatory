package org.eobservatory.util;

import java.util.Date;

public class NearEarthObjectFilter {
	private String id;
	private String userId;
	private String description;
	private Date discoveryDate;
	private String tags;
	private String title;
	private String code;
	private Double score;
	private Double longitude;
	private Double latitude;
	private Double altitude;
	private Double v;
	private Double h;
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
	public Date getDiscoveryDate() {
		return discoveryDate;
	}
	public void setDiscoveryDate(Date discoveryDate) {
		this.discoveryDate = discoveryDate;
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
	
}
