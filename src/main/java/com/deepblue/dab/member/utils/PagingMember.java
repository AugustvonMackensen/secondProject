package com.deepblue.dab.member.utils;

public class PagingMember {
	private int startRow;
	private int endRow;
	
	public PagingMember(int startRow, int endRow) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
	}

	public PagingMember() {}

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

	@Override
	public String toString() {
		return "PagingMember [startRow=" + startRow + ", endRow=" + endRow + "]";
	}

}
