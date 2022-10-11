package com.deepblue.dab.chart.model.service;

import java.util.List;
import java.util.Map;

import com.deepblue.dab.chart.model.vo.Chart;

public interface ChartService {


	List<Chart> selectCategoryList(Map<String, Object> map);

	List<Chart> selectBarList(Map<String, Object> map);
}
