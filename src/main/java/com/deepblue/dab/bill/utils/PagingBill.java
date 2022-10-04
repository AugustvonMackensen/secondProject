package com.deepblue.dab.bill.utils;

public class PagingBill {
	private int startRow;
	private int endRow;
	private String userid;
	private String date;
	
	public PagingBill(int startRow, int endRow, String userid, String date) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.userid = userid;
		this.date = date;
	}

	public PagingBill() {}



	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		
		this.date = date;
	}

	@Override
	public String toString() {
		return "PagingBill [startRow=" + startRow + ", endRow=" + endRow + ", userid=" + userid + ", date=" + date
				+ "]";
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	
}
