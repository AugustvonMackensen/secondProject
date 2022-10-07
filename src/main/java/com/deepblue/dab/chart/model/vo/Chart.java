package com.deepblue.dab.chart.model.vo;



public class Chart {
	
	private String label;	//1월~ 12월, 카테고리등 
	private int sumPrice; //각월의 합계
	public Chart() {
		super();
	}
	public Chart(String label, int sumPrice) {
		super();
		this.label = label;
		this.sumPrice = sumPrice;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public int getSumPrice() {
		return sumPrice;
	}
	public void setSumPrice(int sumPrice) {
		this.sumPrice = sumPrice;
	}
	@Override
	public String toString() {
		return "Chart [label=" + label + ", sumPrice=" + sumPrice + "]";
	}

	
}
