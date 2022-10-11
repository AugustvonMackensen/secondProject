package com.deepblue.dab.chart.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deepblue.dab.chart.model.dao.ChartDao;
import com.deepblue.dab.chart.model.vo.Chart;

@Service("chartService")
public class ChartServiceImpl implements ChartService {
	@Autowired
	private ChartDao chartDao;


	@Override
	public List<Chart> selectBarList(Map<String, Object> map) {
		return chartDao.selectBarList(map);
	}

	@Override
	public List<Chart> selectCategoryList(Map<String, Object> map) {
		return chartDao.selectCategoryList(map);
	}
}
