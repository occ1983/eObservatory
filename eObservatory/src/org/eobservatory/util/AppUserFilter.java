package org.eobservatory.util;

import java.util.Date;

public class AppUserFilter {
	private String userId;
	private String firstName;
	private String lastName;
	private Date registrationFrom;
	private Date registrationTo;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public Date getRegistrationFrom() {
		return registrationFrom;
	}
	public void setRegistrationFrom(Date registrationFrom) {
		this.registrationFrom = registrationFrom;
	}
	public Date getRegistrationTo() {
		return registrationTo;
	}
	public void setRegistrationTo(Date registrationTo) {
		this.registrationTo = registrationTo;
	}
	
}
