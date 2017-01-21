package com.sca.bean;

public class ParseDataRollUp {
	private String timeLine;
	private String crimeType;
	private int numberOfCrimes;
	
	
	public ParseDataRollUp(String crimeType, String timeLine, int numberOfCrimes) {
		super();
		this.timeLine = timeLine;
		this.crimeType = crimeType;
		this.numberOfCrimes = numberOfCrimes;
	}
	
	public String getTimeLine() {
		return timeLine;
	}
	public void setTimeLine(String timeLine) {
		this.timeLine = timeLine;
	}
	public String getCrimeType() {
		return crimeType;
	}
	public void setCrimeType(String crimeType) {
		this.crimeType = crimeType;
	}
	public int getNumberOfCrimes() {
		return numberOfCrimes;
	}
	public void setNumberOfCrimes(int numberOfCrimes) {
		this.numberOfCrimes = numberOfCrimes;
	}
	
}
