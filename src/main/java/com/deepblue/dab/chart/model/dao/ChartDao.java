package com.deepblue.dab.chart.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.chart.model.vo.Chart;

@Repository("chartDao")
public class ChartDao {
	
	@Autowired
	private SqlSessionTemplate session;


	public List<Chart> selectCategoryList(Map<String, Object> map) {
		return session.selectList("chartMapper.selectCategoryList", map);
	}

	public List<Chart> selectBarList(Map<String, Object> map) {
		return session.selectList("chartMapper.selectBarList", map);
	}
	
}
