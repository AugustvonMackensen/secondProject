package com.deepblue.dab;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	// @RequestMapping : 메소드 연결해주는 의미 ... 조심 : 404 에러 주요 원인 
	@RequestMapping("main.do") //main.do 파일 요청이 오면 메소드가 진행되게끔 하라는 의미 
	public String forwardMainView(HttpServletRequest request) throws IOException {
		String camPath = request.getSession().getServletContext().getRealPath("/resources/python/main.exe");
		ProcessBuilder builder = new ProcessBuilder(camPath);
		builder.start();
		return "common/main"; // 내보낼 뷰파일명 리턴
	}
	
}
