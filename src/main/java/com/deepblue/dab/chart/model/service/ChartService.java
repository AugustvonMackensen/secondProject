package com.deepblue.dab.chart.model.service;

import java.util.List;

import com.deepblue.dab.chart.model.vo.Chart;

public interface ChartService {

	
	List<Chart> selectCurrentMonthList(String userid);
}
