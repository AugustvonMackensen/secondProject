package com.deepblue.dab.qna.model.vo;

import java.sql.Date;

import com.deepblue.dab.qna.model.service.AnswerService;

public class  Answer implements java.io.Serializable {

	private static final long serialVersionUID = -7020424181045585384L;
	public Answer() {}
	
	private int a_id;
	private int a_ref;
	private String a_writer;
	private String a_title;
	private java.sql.Date a_date;
	private String a_content;
	
	public Answer(int a_id, int a_ref, String a_writer, String a_title, Date a_date, String a_content) {
		super();
		this.a_id = a_id;
		this.a_ref = a_ref;
		this.a_writer = a_writer;
		this.a_title = a_title;
		this.a_date = a_date;
		this.a_content = a_content;
	}

	@Override
	public String toString() {
		return "Answer [a_id=" + a_id + ", a_ref=" + a_ref + ", a_writer=" + a_writer + ", a_title=" + a_title
				+ ", a_date=" + a_date + ", a_content=" + a_content + "]";
	}

	public int getA_id() {
		return a_id;
	}

	public void setA_id(int a_id) {
		this.a_id = a_id;
	}

	public int getA_ref() {
		return a_ref;
	}

	public void setA_ref(int a_ref) {
		this.a_ref = a_ref;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	}
	
	
	

