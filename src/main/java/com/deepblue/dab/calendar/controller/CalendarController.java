package com.deepblue.dab.calendar.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowire;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.deepblue.dab.bill.model.service.BillService;
import com.deepblue.dab.calendar.model.vo.*;
import com.deepblue.dab.member.model.vo.Member;

@Controller
public class CalendarController {
	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);

	//@Autowired // 자동 의존성주임(DI) (자동 객체 생성됨)
	//private CalendarService calendarService;
	@Autowired
	private BillService billService;
	
	@RequestMapping(value="calendarListView.do", method = RequestMethod.GET)
	public String calendar(Model model, HttpServletRequest request, DateData dateData){
		
		// 해당 날짜의 지출 총합을 구하기 위한 유저아이디 가져옴
		String userid = ((Member)request.getSession().getAttribute("loginMember")).getUserid();
		logger.info(userid);
		
		// 해당 월의 총가격합계를 위한 변수
		int monthTotalPrice=0;
		
		Calendar cal = Calendar.getInstance();
		DateData calendarData;
		//검색 날짜
		if(dateData.getDate().equals("")&&dateData.getMonth().equals("")){
			dateData = new DateData(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
		}
		//검색 날짜 end

		Map<String, Integer> today_info =  dateData.today_info(dateData);
		List<DateData> dateList = new ArrayList<DateData>();
		
		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		for(int i=1; i<today_info.get("start"); i++){
			calendarData= new DateData(null, null, null, null);
			dateList.add(calendarData);
		}
		
		//날짜 삽입
		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
			if(i==today_info.get("today")){
				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today");
			}else{
				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "normal_date");
			}
			if(calendarData.getYear() != null) { // 날짜데이터가 존재하면
				logger.info(dateData.getYear() + dateData.getMonth() + i);
				Map<String,Object>map = new HashMap<String,Object>();

				map.put("userid", userid);
				
				String m = Integer.parseInt(dateData.getMonth()) < 9 ? "0"+String.valueOf(Integer.parseInt(dateData.getMonth())+1) : String.valueOf(Integer.parseInt(dateData.getMonth())+1);
				String d = i < 10 ? "0"+String.valueOf(i) : String.valueOf(i);
				String cdate = 	calendarData.getYear() + " " + m + " " + d; // yyyy MM dd 형식
				logger.info(cdate);
				map.put("date", cdate);
				int stprice = billService.totalPrice(map);
				monthTotalPrice += stprice;
				calendarData.setTotalPrice(stprice); // 해당 날짜의 지출합계를 구함
			}
			
			dateList.add(calendarData);
		}

		//달력 빈곳 빈 데이터로 삽입
		int index = 7 - dateList.size() % 7;
		
		if(dateList.size() % 7 !=0){
			
			for (int i = 0; i < index; i++) {
				calendarData= new DateData(null, null, null, null);
				dateList.add(calendarData);
			}
		}
		
		System.out.println(dateList);
		
		//배열에 담음
		model.addAttribute("dateList", dateList);		//날짜 데이터 배열
		model.addAttribute("today_info", today_info);
		model.addAttribute("monthTotalPrice", monthTotalPrice);
		return "calendar/calendarListView";
	}

}
