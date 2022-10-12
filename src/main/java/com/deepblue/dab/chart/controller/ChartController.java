package com.deepblue.dab.chart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.deepblue.dab.chart.model.service.ChartService;
import com.deepblue.dab.chart.model.vo.Chart;
import com.deepblue.dab.member.model.vo.Member;

@Controller //컨트롤러 등록
public class ChartController {
	@Autowired
	private ChartService chartService;
	private static final Logger logger = LoggerFactory.getLogger(ChartController.class);
	//막대 차트용 
	
	
	@RequestMapping("barChart.do")
	@ResponseBody
	public List<Chart> barChartMethod(Model model, HttpSession session,
			@RequestParam("userid") String userid,
			@RequestParam("year") String year) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		logger.info("user : " + userid);
		logger.info("year : " + year);
		map.put("userid", userid);
		map.put("year", year);
		
		
		userid = ((Member)session.getAttribute("loginMember")).getUserid();
		//List<Chart> list = chartService.selectCurrentMonthList(userid);
		List<Chart> list = chartService.selectBarList(map);
		
		model.addAttribute("list", list);
		
		return list;
	}
	
	//파이
	@RequestMapping("CategoryChart.do")
	@ResponseBody
	public List<Chart> pieChartMehtod(Model model, HttpSession session,
			@RequestParam("userid") String userid,
			@RequestParam("date") String date ) {
		//인자 전달해줄 map생성
		Map<String,Object> map = new HashMap<String,Object>();
		logger.info("user : " + userid);
		logger.info("date : " + date);
		map.put("userid", userid);
		map.put("date", date);
		
		
		//userid = ((Member)session.getAttribute("loginMember")).getUserid();
		//List<Chart> list = chartService.selectCategoryList(userid);
		List<Chart> list = chartService.selectCategoryList(map);
		
		model.addAttribute("list", list);
		return list;
	}
	
	@RequestMapping("chartView.do")
	public String moveChartView(Model model) {
		
		return "chart/chartView";
	}
}
