package com.deepblue.dab.qna.model.vo;

import java.sql.Date;

public class  Answer implements java.io.Serializable {

	private static final long serialVersionUID = -7020424181045585384L;
	public Answer() {}
	
	private int a_id;
	private int a_no;
	private String a_writer;
	private String a_title;
	private java.sql.Date a_date;
	private String a_content;
	private String a_original_filename;
	private String a_rename_filename;
	public Answer(int a_id, int a_no, String a_writer, String a_title, Date a_date, String a_content,
			String a_original_filename, String a_rename_filename) {
		super();
		this.a_id = a_id;
		this.a_no = a_no;
		this.a_writer = a_writer;
		this.a_title = a_title;
		this.a_date = a_date;
		this.a_content = a_content;
		this.a_original_filename = a_original_filename;
		this.a_rename_filename = a_rename_filename;
	}
	@Override
	public String toString() {
		return "Answer [a_id=" + a_id + ", a_no=" + a_no + ", a_writer=" + a_writer + ", a_title=" + a_title
				+ ", a_date=" + a_date + ", a_content=" + a_content + ", a_original_filename=" + a_original_filename
				+ ", a_rename_filename=" + a_rename_filename + "]";
	}
	public int getA_id() {
		return a_id;
	}
	public void setA_id(int a_id) {
		this.a_id = a_id;
	}
	public int getA_no() {
		return a_no;
	}
	public void setA_no(int a_no) {
		this.a_no = a_no;
	}
	public String getA_writer() {
		return a_writer;
	}
	public void setA_writer(String a_writer) {
		this.a_writer = a_writer;
	}
	public String getA_title() {
		return a_title;
	}
	public void setA_title(String a_title) {
		this.a_title = a_title;
	}
	public java.sql.Date getA_date() {
		return a_date;
	}
	public void setA_date(java.sql.Date a_date) {
		this.a_date = a_date;
	}
	public String getA_content() {
		return a_content;
	}
	public void setA_content(String a_content) {
		this.a_content = a_content;
	}
	public String getA_original_filename() {
		return a_original_filename;
	}
	public void setA_original_filename(String a_original_filename) {
		this.a_original_filename = a_original_filename;
	}
	public String getA_rename_filename() {
		return a_rename_filename;
	}
	public void setA_rename_filename(String a_rename_filename) {
		this.a_rename_filename = a_rename_filename;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	

}
