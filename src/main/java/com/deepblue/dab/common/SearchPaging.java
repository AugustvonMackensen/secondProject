package com.deepblue.dab.common;

import java.sql.Date;

public class SearchPaging {
	private String keyword;
	private int startRow;
	private int endRow;
	private Date begin;
	private Date end;
	
	public SearchPaging() {}

	public SearchPaging(String keyword, int startRow, int endRow) {
		super();
		this.keyword = keyword;
		this.startRow = startRow;
		this.endRow = endRow;
	}

	public SearchPaging (Date begin, Date end, int startRow, int endRow) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.begin = begin;
		this.end = end;
	}

	
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
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

	public Date getBegin() {
		return begin;
	}

	public void setBegin(Date begin) {
		this.begin = begin;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	@Override
	public String toString() {
		return "SearchPaging [keyword=" + keyword + ", startRow=" + startRow + ", endRow=" + endRow + ", begin=" + begin
				+ ", end=" + end + "]";
	}

}
