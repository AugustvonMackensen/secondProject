package com.deepblue.dab.chart.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.chart.model.vo.Chart;

@Repository("chartDao")
public class ChartDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public List<Chart> selectCurrentMonthList(String userid) {
		return session.selectList("chartMapper.selectCurrentMonthList", userid);
	}
	
}
