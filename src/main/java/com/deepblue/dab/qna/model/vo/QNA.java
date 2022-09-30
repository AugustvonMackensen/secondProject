package com.deepblue.dab.qna.model.vo;

import java.sql.Date;

public class QNA implements java.io.Serializable{

	private static final long serialVersionUID = 1766193439657005461L;
	
	public QNA () {}
	
	private int q_no;
	private String q_writer;
	private String q_title;
	private java.sql.Date q_date;
	private String q_content;
	private String q_upfile;
	private int readcount;

	@Override
	public String toString() {
		return "QNA [q_no=" + q_no + ", q_writer=" + q_writer + ", q_title=" + q_title + ", q_date=" + q_date
				+ ", q_content=" + q_content + ", q_upfile=" + q_upfile + ", readcount=" + readcount + "]";
	}

	public QNA(int q_no, String q_writer, String q_title, Date q_date, String q_content, String q_upfile,
			int readcount) {
		super();
		this.q_no = q_no;
		this.q_writer = q_writer;
		this.q_title = q_title;
		this.q_date = q_date;
		this.q_content = q_content;
		this.q_upfile = q_upfile;
		this.readcount = readcount;
	}

	public int getQ_no() {
		return q_no;
	}

	public void setQ_no(int q_no) {
		this.q_no = q_no;
	}

	public String getQ_writer() {
		return q_writer;
	}

	public void setQ_writer(String q_writer) {
		this.q_writer = q_writer;
	}

	public String getQ_title() {
		return q_title;
	}

	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}

	public java.sql.Date getQ_date() {
		return q_date;
	}

	public void setQ_date(java.sql.Date q_date) {
		this.q_date = q_date;
	}

	public String getQ_content() {
		return q_content;
	}

	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}

	public String getQ_upfile() {
		return q_upfile;
	}

	public void setQ_upfile(String q_upfile) {
		this.q_upfile = q_upfile;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
	
}
