package org.eobservatory.model;

import java.util.List;

public class BoundingPolygon {
	private String shortName;
	private String name;
	private String descripcion;
	private List<PolygonPoint> points;
	
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public List<PolygonPoint> getPoints() {
		return points;
	}
	public void setPoints(List<PolygonPoint> points) {
		this.points = points;
	}
	
}
