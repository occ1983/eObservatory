package org.eobservatory.model;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "attachments")
public class Attachment {
	@Id
	private String id;
	private String fileId;
	private String fileName;
	private String contentType;
	private List<BoundingPolygon> polygons;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public List<BoundingPolygon> getPolygons() {
		return polygons;
	}
	public void setPolygons(List<BoundingPolygon> polygons) {
		this.polygons = polygons;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	
}
