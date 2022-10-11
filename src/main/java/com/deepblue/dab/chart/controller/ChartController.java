package com.deepblue.dab.chart.controller;

import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.deepblue.dab.chart.model.service.ChartService;
import com.deepblue.dab.chart.model.vo.Chart;
import com.deepblue.dab.member.model.vo.Member;

@Controller //컨트롤러 등록
public class ChartController {
	@Autowired
	private ChartService chartService;
	
	//막대 차트용
	@RequestMapping("currentYearChart.do")
	@ResponseBody
	public List<Chart> YearChartMethod(Model model, HttpSession session) {
		
		String userid = ((Member)session.getAttribute("loginMember")).getUserid();
		List<Chart> list = chartService.selectCurrentMonthList(userid);
		model.addAttribute("list", list);
		return list;
	}
	
	//파이
	@RequestMapping("CategoryChart.do")
	@ResponseBody
	public List<Chart> pieChartMehtod(Model model, HttpSession session) {
		
		String userid = ((Member)session.getAttribute("loginMember")).getUserid();
		List<Chart> list = chartService.selectCategoryList(userid);
		model.addAttribute("list", list);
		return list;
	}
	
	@RequestMapping("chartView.do")
	public String moveChartView(Model model) {
		
		return "chart/chartView";
	}
}
