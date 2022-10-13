package com.deepblue.dab.bill.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.deepblue.dab.bill.model.service.BillService;
import com.deepblue.dab.bill.model.vo.Bill;
import com.deepblue.dab.bill.utils.TextPreprocessing;
import com.deepblue.dab.bill.utils.ReceiptOCR;
import com.deepblue.dab.bill.utils.PagingBill;
import com.deepblue.dab.common.Paging;
import com.deepblue.dab.member.model.vo.Member;


@Controller
public class BillController {
	private static final Logger logger = LoggerFactory.getLogger(BillController.class);
	private static JSONParser jsonParser = new JSONParser();
	
	@Autowired
	private BillService billService;
	

	// 지출등록 페이지 이동
	@RequestMapping("bill.do")
	public String moveWritePage() {
		return "bill/billRegistForm";

	}

	// 여러 이미지 등록페이지 이동
	@RequestMapping("multiReg.do")
	public String moveMultiRegist() {
		return "bill/multiuploadForm";
	}
	
	/*
	 * @RequestMapping(value = "imageUpload.do", method = RequestMethod.POST) public
	 * void uploadImageMethod(@RequestParam("image") MultipartFile mfile,
	 * HttpServletRequest request, HttpServletResponse response, Model model) throws
	 * IOException { String suc = "ㅁㄹ"; String savePath =
	 * request.getSession().getServletContext().getRealPath("resources/bill");
	 * logger.info("mFile : " + mfile); logger.info("savePath : " + savePath);
	 * 
	 * // 첨부파일이 있을 때만 업로드된 파일을 지정된 폴더로 옮기기 if (!mfile.isEmpty()) { String fileName =
	 * mfile.getOriginalFilename();
	 * 
	 * // 다른 공지글의 첨부파일과 // 파일명이 중복되어서 오버라이팅되는 것을 막기 위해 // 파일명을 변경해서 폴더에 저장하는 방식을 사용할
	 * 수 있음 // 변경 파일명 : 년월일시분초.확장자 if (fileName != null && fileName.length() > 0) {
	 * SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); // 변경할 파일이름
	 * 만들기 String renameFileName = sdf.format(new Date(System.currentTimeMillis()));
	 * // 원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌 String ext = "." +
	 * fileName.substring(fileName.lastIndexOf(".") + 1); logger.info(ext);
	 * renameFileName += ext;
	 * 
	 * // 파일업로드 // 파일 객체 만들기 File originFile = new File(savePath + "\\" + fileName);
	 * File renameFile = new File(savePath + "\\" + renameFileName); //
	 * if(!originFile.exists()) originFile.mkdir(); // 업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
	 * try { logger.info(renameFileName); logger.info("저장시작");
	 * mfile.transferTo(renameFile); logger.info("끝!!"); } catch (Exception e) {
	 * e.printStackTrace(); model.addAttribute("message", "전송파일 저장 실패!"); // return
	 * "common/error"; } suc = "성공!"; } } // 첨부파일 있을때만 // ajax 전송 String returnValue
	 * = suc;
	 * 
	 * // response 를 이용해서 클라이언트로 출력스트림을 만들고 값 보내기
	 * response.setContentType("text/html; charset=utf-8"); PrintWriter out;
	 * 
	 * out = response.getWriter(); out.append(returnValue); out.flush();
	 * out.close(); }
	 */

	@RequestMapping(value = "imageToText.do", method = RequestMethod.POST)
	@ResponseBody
	public String imageToTextMethod(@RequestParam("image") MultipartFile mfile, HttpServletRequest request,
			HttpServletResponse response, Model model) throws IOException {
		//String suc = "ㅁㄹ";
		String savePath = request.getSession().getServletContext().getRealPath("resources/bill");
		logger.info("mFile : " + mfile);
		logger.info("savePath : " + savePath);
		JSONObject sendJson = new JSONObject();
		// 첨부파일이 있을 때만 업로드된 파일을 지정된 폴더로 옮기기
		if (!mfile.isEmpty()) {
			String fileName = mfile.getOriginalFilename();

			// 다른 공지글의 첨부파일과
			// 파일명이 중복되어서 오버라이팅되는 것을 막기 위해
			// 파일명을 변경해서 폴더에 저장하는 방식을 사용할 수 있음
			// 변경 파일명 : 년월일시분초.확장자
			if (fileName != null && fileName.length() > 0) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				// 변경할 파일이름 만들기
				String renameFileName = sdf.format(new Date(System.currentTimeMillis()));
				// 원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
				String ext = "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				logger.info(ext);
				renameFileName += ext;
				
				// 파일업로드
				// 파일 객체 만들기
				File file = new File(mfile.getOriginalFilename());

				// if(!originFile.exists()) originFile.mkdir();
				// 업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
				try {
					logger.info("저장시작");
					mfile.transferTo(file); // MultipartFile 객체 -> File 객체로 변환
					logger.info("변환 완료");
					System.out.println("print확인");

					System.out.println("텍스트 변환 시작");
					System.out.println("지금은 저장된파일 가져옴");
					 //ocr 코드
					 ReceiptOCR iTT = new ReceiptOCR();
					 JSONObject jobj = iTT.mainMethod(file); // ocr 처리
					 //-------
					TextPreprocessing fText2 = new TextPreprocessing(); 
					sendJson = fText2.printInfo(jobj); // 전달할 값들 가공
//					try (BufferedReader reader = new BufferedReader(
//							new FileReader("C:\\python_workspace\\testcv\\namecard\\rec\\receiptOCR_ajaxText.txt"));) {
//						String bs = "";
//						String str;
//						ArrayList<String> keys = new
//
//						ArrayList<String>();
//
//						while ((str = reader.readLine()) != null) {
//							bs += str;
//						} //
//						System.out.println(bs);
//
//						JSONObject o = (JSONObject) jsonParser.parse(bs); // System.out.println(o);
//
//						System.out.println("JSONObject 가져오기 완료");
//
//						FileReaderTest fText = new FileReaderTest();
//						sendJson = fText.printInfo(o); // 전달할 값들 가공
//						model.addAttribute("message", "ocr완료");
//					}
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장 실패!");
					// return "common/error";
				}
				
			}
		} // 첨부파일 있을때만
			// ajax 전송
		
		return sendJson.toJSONString();
	}
	
	@RequestMapping(value = "insertBill.do", method = RequestMethod.POST)
	public String billInsertMethod(Bill bill, Model model,@RequestParam("bill_timestamp2") String ts) {
		
		logger.info(ts+"타임스스탬프");
		ts = ts.replace("T", " ");
		if(ts.length() == 16)
			ts = ts + ":00";
		
		Timestamp t = Timestamp.valueOf(ts);
		logger.info(t.toString());
		bill.setBill_timestamp(t);
		if(billService.insertBill(bill) > 0) {
			logger.info("지출 등록 성공!");
		} else {
			model.addAttribute("message", "지출 등록 실패!");
			return "common/error";
		}
			

		return "common/main";
	}
	
	// 해당하는 일의 지출목록 뷰
	@RequestMapping("billListView.do")
	public ModelAndView billListMethod(
			@RequestParam(name="page", required=false) String page,
			@RequestParam(name="date") String date,
			@RequestParam(name="userid",required=false) String userid,
			// 검색용 파라미터이지만 여기는 get요청 => 페이지 누름
			@RequestParam(name="type",required=false) String type,
			@RequestParam(name="p1",required=false) String p1,
			@RequestParam(name="p2",required=false) String p2,
			@RequestParam(name="begin",required=false) String begin,
			@RequestParam(name="end",required=false) String end,
			@RequestParam(name="category",required=false) String category,
			//
			ModelAndView mv) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		mv.addObject("date",date); //페이징 으로인해 다시 date값 전달
		
		String[] tokken = date.split(" ");
		String[] origin = tokken.clone();
		
		if(tokken.length == 3) {
			if(tokken[1].length() == 1)
				tokken[1] = "0" + tokken[1];
			if(tokken[2].length() == 1)
				tokken[2] = "0" + tokken[2];
			date = tokken[0] +" "+ tokken[1] + " " + tokken[2];
		}else if (tokken.length == 2)  {
			if(tokken[1].length() == 1)
				tokken[1] = "0" + tokken[1];
			date = tokken[0] +" "+ tokken[1];
		}
		
		
//		logger.info(date);
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		map.put("userid", userid);
		map.put("date", date);
		int listCount=0;
		if(type != null && type.length() >2) {
			switch (type) { // 검색 종류 판단
			case "searchPrice":
				if(p1.equals("") || p1 == null) p1 = "0";
				map.put("p1", p1);
				map.put("p2", p2);
				mv.addObject("p1", p1);
				mv.addObject("p2", p2);
				//listCount = billService.selectListCountSearchPrice(map);
				break;
			case "searchCategory":
				map.put("category", category);
				mv.addObject("category", category);
				//listCount = billService.selectListCountSearchCategory(map);
				break;
			case "searchDate":
				map.put("begin", begin);
				map.put("end", end);
				mv.addObject("begin", begin);
				mv.addObject("end", end);
				//listCount = billService.selectListCountSearchDate(map);
				break; //모델에 검색한데이터 인풋했음
			}
		}
		int limit = 10;  

		if(type!=null && type.length() > 2) {
			map.put("type",type); // 이걸안넣어줘서 ㅋㅋ
			mv.addObject("type",type);
			listCount = billService.selectListCountSearch(map);
		} else { // 검색을 이용하지 않은 페이지 선택 또는 메인 listview 페이지 count
			mv.addObject("type","0");
			listCount = billService.selectListCountDay(map); //해당 날짜 를 매개변수로 줘서 몇개인지 계산
		}
		logger.info("받음 + listCount : " + listCount);
		int maxPage = (int)((double)listCount / limit + 0.9);

		
		int endPage = (int)(Math.ceil(currentPage / 10.0)) * 10;
		int startPage = endPage-9;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		
		//페이징 계산 처리 끝 ---------------------------------------
		
		ArrayList<Bill> list = null;
		
		if(type!=null && type.length() > 0) { // 검색을 이용한 페이지
			map.put("startRow", startRow);
			map.put("endRow", endRow);
			list = billService.selectListSearch(map);
		} else { //검색을 이용하지 않은 페이지 선택 또는 메인 list
			PagingBill paging = new PagingBill(startRow, endRow,userid, date);
			list = billService.selectList(paging); //
		}
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			
			if(origin.length == 3)
				mv.addObject("currentDate", origin[0] + "년 "+ origin[1] +"월 " + origin[2] + "일");
			else if(origin.length == 2)
				mv.addObject("currentDate", origin[0] + "년 "+ origin[1] +"월");
			else if(origin.length == 1)
				mv.addObject("currentDate", origin[0] + "년");
			
			mv.setViewName("bill/billListView");
		}else {
			mv.addObject("message", 
					currentPage + " 페이지 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	
	@RequestMapping(value = "billdetail.do")
	public ModelAndView billDetailMethod(
			ModelAndView mv, 
			@RequestParam("bill_id") int bill_id,
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "count", required = false) String count,
			@RequestParam(value = "date", required = false) String date) {
		int currentPage = 1;
		if (page != null && page.length()>0) {
			currentPage = Integer.parseInt(page);
		}
		
		if (count != null && count.length()>0) {
			mv.addObject("count", Integer.parseInt(count));
		}
		
		Bill bill = billService.selectBill(bill_id);
		
		if(bill != null) {
			mv.addObject("bill", bill);
			mv.addObject("currentPage", currentPage);
			mv.addObject("date", date);
			mv.setViewName("bill/billDetailView");
		} else {
			mv.addObject("message", bill_id + "번 지출 조회 실패!");
			mv.setViewName("common/error");
		}
		
		
		return mv;

	}
	
	@RequestMapping(value="updateBill.do", method = RequestMethod.POST)
	public String billUpdateMethod(
			Bill bill,
			@RequestParam("page") int page,
			@RequestParam("bill_timestamp2") String ts,
			@RequestParam("bill_id") int bill_id,
			@RequestParam(value = "count", required = false) String count,
			@RequestParam(name="date") String date,
			HttpServletRequest request, Model model) {
		logger.info(ts+"타임스스탬프");
		ts = ts.replace("T", " ");
		if(ts.length() == 16)
			ts = ts + ":00";
		
		if (count != null && count.length()>0) {
			model.addAttribute("count", Integer.parseInt(count));
		}
		
		logger.info("지출 확인 : " + bill);
		logger.info("bill_timestamp2 확인 : " + ts);
		Timestamp t = Timestamp.valueOf(ts);
		logger.info(t.toString());
		bill.setBill_timestamp(t);
		
		if(billService.updateBill(bill) > 0 ) {
			//수정 성공시
			model.addAttribute("page", page);
			model.addAttribute("bill_id", bill_id);
			model.addAttribute("date", date);
			return "redirect:billdetail.do";
		} else {
			model.addAttribute("message", bill_id+"번 글 수정 실패!");
			return "common/error";
		}
	}
	
	@RequestMapping("deleteBill.do")
	public String billDeleteMethod(
			@RequestParam("bill_id") String bill_id,
			Model model) {
		int id = Integer.parseInt(bill_id);
		
		Bill bill = billService.selectBill(id);
		
		//SimpleDateFormat formatter = new SimpleDateFormat("yyyy MM dd");
		//logger.info("date : " + formatter.format(bill.getBill_timestamp()));
		if(billService.deleteBill(bill.getId()) > 0) {
			//삭제 성공
			
			return "redirect:billListView.do?page=1&userid="+bill.getUserid()+"&date=";
		} else {
			model.addAttribute("message", "삭제실패ㅋ");
			return "common/error";
		}
		
	}
	
	
	//검색할 경우 포스트로 받음
	@RequestMapping(value="billListView.do", method = RequestMethod.POST)
	public ModelAndView billSearchListMethod(
			@RequestParam(name="page", required=false) String page,
			@RequestParam("date") String date,
			@RequestParam(name="userid",required=false) String userid,
			// 검색용 파라미터
			@RequestParam(name="type",required=false) String type,
			@RequestParam(name="p1",required=false) String p1,
			@RequestParam(name="p2",required=false) String p2,
			@RequestParam(name="begin",required=false) String begin,
			@RequestParam(name="end",required=false) String end,
			@RequestParam(name="category",required=false) String category,
			//
			ModelAndView mv) {
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		mv.addObject("date",date); //페이징 으로인해 다시 date값 전달
		
		String[] tokken = date.split(" ");
		String[] origin = tokken.clone();
		
		if(tokken.length == 3) {
			if(tokken[1].length() == 1)
				tokken[1] = "0" + tokken[1];
			if(tokken[2].length() == 1)
				tokken[2] = "0" + tokken[2];
			date = tokken[0] +" "+ tokken[1] + " " + tokken[2];
		}else if (tokken.length == 2)  {
			if(tokken[1].length() == 1)
				tokken[1] = "0" + tokken[1];
			date = tokken[0] +" "+ tokken[1];
		}
		
		
//		logger.info(date);
		int currentPage = 1;
//		if(page != null) {
//			currentPage = Integer.parseInt(page);
//		} 검색이므로 페이지는 무조건 처음으로
		map.put("userid", userid);
		map.put("date", date);
		int limit = 10;
		int listCount = 0;
		switch (type) { // 검색 종류 판단
		case "searchPrice":
			if( p1.length()==0 || p1.equals("") || p1 == null ) p1 = "0";
			map.put("p1", p1);
			map.put("p2", p2);
			mv.addObject("p1", p1);
			mv.addObject("p2", p2);
			//listCount = billService.selectListCountSearchPrice(map);
			break;
		case "searchCategory":
			map.put("category", category);
			mv.addObject("category", category);
			//listCount = billService.selectListCountSearchCategory(map);
			break;
		case "searchDate":
			map.put("begin", begin);
			map.put("end", end);
			mv.addObject("begin", begin);
			mv.addObject("end", end);
			//listCount = billService.selectListCountSearchDate(map);
			break; //모델에 검색한데이터 인풋했음
		}
		map.put("type", type);
		mv.addObject("type", type); // 검색타입도 모델에 넣어줌
		
		listCount = billService.selectListCountSearch(map); //해당 날짜 를 매개변수로 줘서 몇개인지 계산
		logger.info("받음 + listCount : " + listCount);
		int maxPage = (int)((double)listCount / limit + 0.9);

		
		int endPage = (int)(Math.ceil(currentPage / 10.0)) * 10;
		int startPage = endPage-9;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		//PagingBill paging = new PagingBill(startRow, endRow,userid, date);
		
		//페이징 계산 처리 끝 ---------------------------------------
		// row put
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		ArrayList<Bill> list = billService.selectListSearch(map);
				//billService.selectList(paging); //
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			
			// 검색한 타입과 맵을 모델에 인풋해야한다 위에서 함
			if(origin.length == 3)
				mv.addObject("currentDate", origin[0] + "년 "+ origin[1] +"월 " + origin[2] + "일");
			else if(origin.length == 2)
				mv.addObject("currentDate", origin[0] + "년 "+ origin[1] +"월");
			else if(origin.length == 1)
				mv.addObject("currentDate", origin[0] + "년");
			
			mv.setViewName("bill/billListView");
		}else {
			mv.addObject("message", 
					currentPage + " 페이지 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	@RequestMapping(value="multiUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public String multiUploadMethod(
			@RequestParam("article_file") List<MultipartFile> multipartFile, 
			HttpServletRequest request,
			MultipartHttpServletRequest mtfRequest,
			HttpSession session) {
		String strResult = "{ \"result\":\"FAIL\" }";
		//List<MultipartFile> multipartFile = mtfRequest.getFiles("file"); // 업로드할 파일리스트
		logger.info(multipartFile.size()+"개넣음");
		//String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		JSONObject sendJson = new JSONObject(); // 전달용
		
		String userid = ((Member)session.getAttribute("loginMember")).getUserid();
		logger.info("try진입전");
		try {
			ReceiptOCR iTT = new ReceiptOCR();
			TextPreprocessing fText2 = new TextPreprocessing(); 
			// 파일이 있을때 탄다.
			logger.info("번째 업로드 포문");
			if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
				int c=0; // 개수 체크
				for(MultipartFile mfile:multipartFile) {
					try {
						File file = new File(mfile.getOriginalFilename());
						mfile.transferTo(file);
						logger.info("getOriginalFilename"+mfile.getOriginalFilename());
						JSONObject jobj = iTT.mainMethod(file); // ocr후 텍스트 가공처리
						jobj =  fText2.printInfo(jobj);
						logger.info(jobj+"");
						Bill bill = new Bill();
						bill.setUserid(userid); // 유저아이디 입력
						if(jobj.containsKey("fTotalPrice")) {
							bill.setBill_price( Integer.parseInt((String) jobj.get("fTotalPrice"))); // 총가격입력
						}
						
						if(jobj.containsKey("tDate") && jobj.containsKey("tTime")) {
							String date = (String) jobj.get("tDate");
							String time = (String) jobj.get("tTime");
							
							//공백제거
							date = date.trim();
							time = time.trim().replace(" ", "");
							
							// '/' 문자 '-' 로바꾸기
							date = date.replace("/", "-");
							if(date.length() == 5)
								date = "2022-"+date; // 월과 일만있을경우
			
							String timePattern = "(0[1-9]|1[0-9]|2[0-4]):(0[1-9]|[0-5][0-9]):(0[1-9]|[0-5][0-9])";
							String stampPattern = "\\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01]) (0[1-9]|1[0-9]|2[0-4]):(0[1-9]|[0-5][0-9]):(0[1-9]|[0-5][0-9])";
							String stime = "";
							if( Pattern.matches(timePattern, time)) {
								stime= date +" " + time;
							}else {
								stime= date +" " + "11:15:15";
 							}
							
								
							if( Pattern.matches(stampPattern, stime) ) { //맞으면
								Timestamp tsmp = Timestamp.valueOf(stime); 
								bill.setBill_timestamp(tsmp); // 시간입력
								logger.info(tsmp+"시간확인시간확인");
							} else { // 틀리면 현재시간넣음
								Timestamp tsmp = new Timestamp(System.currentTimeMillis());
								bill.setBill_timestamp(tsmp); // 시간입력
								logger.info(tsmp+"시간확인시간확인");
							}
								
						} else if(jobj.containsKey("tDate")) {
							String date = (String) jobj.get("tDate");
							date = date.replace("/", "-");
							if(date.length() == 5)
								date = "2022-"+date;
							date = date + " 12:00:00";
							Timestamp tsmp = Timestamp.valueOf(date); 
							bill.setBill_timestamp(tsmp); // 시간입력
						}
						
						bill.setBill_category("식비"); // 기본 식비로 설정
						//내용
						if(jobj.containsKey("subResults") && ((JSONArray)jobj.get("subResults")).size() > 0 ) {
							String content="";
							int sum=0;
							for(Object item: (JSONArray)jobj.get("subResults")  ) {
								if(item instanceof JSONObject) {
									JSONObject jitem = (JSONObject)item;
									
									if(jitem.containsKey("subResults_name")) {
										content += jitem.get("subResults_name");
									}
									
									if(jitem.containsKey("subResults_count")) {
										content += " "+jitem.get("subResults_count") + "개";
									}
									
									if(jitem.containsKey("subResults_subPrice")) {
										content += " "+jitem.get("subResults_subPrice") + "원\n";
										sum += Integer.parseInt((String)jitem.get("subResults_subPrice"));
									}
									
								}
								bill.setBill_content(content);
							}//end for
							if( bill.getBill_price() == 0 )
								bill.setBill_price(sum); //위에서 가격을 설정하지 못했을경우 여기서라도
							
						}
						
						//카드 정보
						if(jobj.containsKey("tCom") && jobj.containsKey("tCardnum")) {
							String cardinfo = jobj.get("tCom") +" " + jobj.get("tCardnum");
							bill.setBill_cardinfo(cardinfo);
						}
						
						//상호명
						if(jobj.containsKey("storeInfo_name")) {
							String infoName = (String) jobj.get("storeInfo_name");
							bill.setBill_storeinfo_name(infoName);
						}
						
						//사업자 번호
						if(jobj.containsKey("storeInfo_bizNum")) {
							String biznum = (String) jobj.get("storeInfo_bizNum");
							bill.setBill_storeinfo_biznum(biznum);
						}
						
						//매장 전화번호
						if(jobj.containsKey("storeInfo_tel")) {
							String tel = (String) jobj.get("storeInfo_tel");
							bill.setBill_storeinfo_tel(tel);
						}
						
						if(bill.getBill_timestamp() == null) {
							Timestamp tsmp = new Timestamp(System.currentTimeMillis());
							bill.setBill_timestamp(tsmp); // 시간입력
							logger.info(tsmp+"시간확인시간확인");
						}
						
						logger.info("insert전 확인!!!!!!!!!!!!!!!!");
						logger.info(bill.toString());
						if(billService.insertBill(bill) > 0) {
							//등록성공할경우
							c++;
						}
					}
					catch(Exception e) { logger.info("이미지중 하나 실패!"); e.printStackTrace();  }
				} // end for
				logger.info(c+"개 이미지 지출등록 완료.");
				sendJson.put("count", c); //지출등록한 개수
				strResult = "{ \"result\":\"OK\" }";
			}
			// 파일 아무것도 첨부 안했을때 탄다.(게시판일때, 업로드 없이 글을 등록하는경우)
			else
				strResult = "{ \"result\":\"OK\" }";
		}catch(Exception e){
			e.printStackTrace();
		}
		sendJson.put("result", "OK");
		sendJson.put("userid", userid);
		return sendJson.toJSONString();
	}
	
	@RequestMapping("multiUploadCompleteView.do")
	public String multiUploadCompleteViewMethod(Model model,
			@RequestParam("count") String count,
			@RequestParam("userid") String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("count", Integer.parseInt(count) );
		map.put("userid", userid);
		
		ArrayList<Bill> list = billService.lastMultiUploadList(map);
		
		if(list != null && list.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("count", count);
			model.addAttribute("userid", userid);
			return "bill/uploadCompleteView";
			
		} else {
			model.addAttribute("message", "입력한 데이터가 없거나, 옮바른 접근이 아닙니다.");
			return "common/error";
		}
		
	}
	
}
