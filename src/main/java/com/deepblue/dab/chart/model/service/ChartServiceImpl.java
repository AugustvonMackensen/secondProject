package com.deepblue.dab.chart.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deepblue.dab.chart.model.dao.ChartDao;
import com.deepblue.dab.chart.model.vo.Chart;

@Service("chartService")
public class ChartServiceImpl implements ChartService {
	@Autowired
	private ChartDao chartDao;

	@Override
	public List<Chart> selectCurrentMonthList(String userid) {
		return chartDao.selectCurrentMonthList(userid);
	}
}
