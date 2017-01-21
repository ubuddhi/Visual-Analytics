package com.sca.bean;

public class ParseData {
	private String stringA;
	private String stringB;
	private Location location;
		
	public ParseData(String stringA, String stringB, Location location) {
		super();
		this.stringA = stringA;
		this.stringB = stringB;
		this.location = location;
	}
	
	public String getStringA() {
		return stringA;
	}
	public void setStringA(String stringA) {
		this.stringA = stringA;
	}
	public String getStringB() {
		return stringB;
	}
	public void setStringB(String stringB) {
		this.stringB = stringB;
	}
	public Location getLocation() {
		return location;
	}
	public void setLocation(Location location) {
		this.location = location;
	}
}
