package com.deepblue.dab.bill.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.deepblue.dab.bill.model.service.BillService;
import com.deepblue.dab.bill.model.vo.Bill;
import com.deepblue.dab.bill.utils.FileReaderTest;
import com.deepblue.dab.bill.utils.PagingBill;
import com.deepblue.dab.common.Paging;


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

	@RequestMapping(value = "imageUpload.do", method = RequestMethod.POST)
	public void uploadImageMethod(@RequestParam("image") MultipartFile mfile, HttpServletRequest request,
			HttpServletResponse response, Model model) throws IOException {
		String suc = "ㅁㄹ";
		String savePath = request.getSession().getServletContext().getRealPath("resources/bill");
		logger.info("mFile : " + mfile);
		logger.info("savePath : " + savePath);

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
				File originFile = new File(savePath + "\\" + fileName);
				File renameFile = new File(savePath + "\\" + renameFileName);
				// if(!originFile.exists()) originFile.mkdir();
				// 업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
				try {
					logger.info(renameFileName);
					logger.info("저장시작");
					mfile.transferTo(renameFile);
					logger.info("끝!!");
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장 실패!");
					// return "common/error";
				}
				suc = "성공!";
			}
		} // 첨부파일 있을때만
			// ajax 전송
		String returnValue = suc;

		// response 를 이용해서 클라이언트로 출력스트림을 만들고 값 보내기
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out;

		out = response.getWriter();
		out.append(returnValue);
		out.flush();
		out.close();
	}

	@RequestMapping(value = "imageToText.do", method = RequestMethod.POST)
	@ResponseBody
	public String imageToTextMethod(@RequestParam("image") MultipartFile mfile, HttpServletRequest request,
			HttpServletResponse response, Model model) throws IOException {
		String suc = "ㅁㄹ";
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
					// ocr 코드
					// OCRGeneralAPIDemo2receipt2tofuc iTT = new OCRGeneralAPIDemo2receipt2tofuc();
					// JSONObject jobj = iTT.mainMethod(file);
					// -------

					try (BufferedReader reader = new BufferedReader(
							new FileReader("C:\\python_workspace\\testcv\\namecard\\rec\\receiptOCR_ajaxText.txt"));) {
						String bs = "";
						String str;
						ArrayList<String> keys = new

						ArrayList<String>();

						while ((str = reader.readLine()) != null) {
							bs += str;
						} //
						System.out.println(bs);

						JSONObject o = (JSONObject) jsonParser.parse(bs); // System.out.println(o);

						System.out.println("JSONObject 가져오기 완료");

						FileReaderTest fText = new FileReaderTest();
						sendJson = fText.printInfo(o); // 전달할 값들 가공
						model.addAttribute("test", "문자어캐꺼냄?");
					}
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
		
		ts = ts.replace("T", " ");
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
			@RequestParam(value = "page", required = false) String page) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		Bill bill = billService.selectBill(bill_id);
		
		if(bill != null) {
			mv.addObject("bill", bill);
			mv.addObject("currentPage", currentPage);
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
			HttpServletRequest request, Model model) {
		logger.info("지출 확인 : " + bill);
		logger.info("bill_timestamp2 확인 : " + ts);
		ts = ts.replace("T", " ");
		Timestamp t = Timestamp.valueOf(ts);
		logger.info(t.toString());
		bill.setBill_timestamp(t);
		
		if(billService.updateBill(bill) > 0 ) {
			//수정 성공시
			model.addAttribute("page", page);
			model.addAttribute("bill_id", bill_id);
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
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy MM dd");
		logger.info("date : " + formatter.format(bill.getBill_timestamp()));
		if(billService.deleteBill(bill.getId()) > 0) {
			//삭제 성공
			
			return "redirect:billListView.do?page=1&userid="+bill.getUserid()+"&date="+formatter.format(bill.getBill_timestamp());
		} else {
			model.addAttribute("message", "삭제실패ㅋ");
			return "common/error";
		}
		
	}
	
	@RequestMapping(value="list2.do", method = RequestMethod.POST)
	public void abc() {
		
	}
	
	@RequestMapping("list2.do")
	public void abc1() {
		
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
}
