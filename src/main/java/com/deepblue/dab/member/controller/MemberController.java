package com.deepblue.dab.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.deepblue.dab.common.SearchDate;
import com.deepblue.dab.member.model.vo.Member;

@Controller // xml에 자동 등록됨 ... import 해서 annotation 써야 됨
public class MemberController {
	// 이 컨트롤러 안의 메소드들에 구동 상태에 대한 로그 출력용 객체 생성
	// classpath 에 log4j.xml 에 설정된 내용으로 출력 적용됨
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	

}
