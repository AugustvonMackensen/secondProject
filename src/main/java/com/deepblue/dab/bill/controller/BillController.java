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
						sendJson = fText.printInfo(o);
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
	public ModelAndView qnaListMethod(
			@RequestParam(name="page", required=false) String page,
			@RequestParam("date") String date,
			@RequestParam(name="userid",required=false) String userid,
			ModelAndView mv) {
		
		Map<String,Object>map = new HashMap<String,Object>();
		mv.addObject("date",date); //페이징 으로인해 다시 date값 전달
		
		String[] tokken = date.split(" ");
		String[] origin = tokken.clone();
		logger.info("년 + " +tokken[0]);
		logger.info("월 + " +tokken[1]);
		logger.info("일 + " +tokken[2]);
		if(tokken[1].length() == 1)
			tokken[1] = "0" + tokken[1];
		if(tokken[2].length() == 1)
			tokken[2] = "0" + tokken[2];
		
		
		date = tokken[0] +" "+ tokken[1] + " " + tokken[2];
//		logger.info(date);
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		map.put("userid", userid);
		map.put("date", date);
		int limit = 10;  
		int listCount = billService.selectListCountDay(map); //해당 날짜 를 매개변수로 줘서 몇개인지 계산
		logger.info("받음 + listCount : " + listCount);
		int maxPage = (int)((double)listCount / limit + 0.9);

		int startPage = currentPage / 10 * 10 + 1;
		int endPage = startPage + 10 - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		PagingBill paging = new PagingBill(startRow, endRow,userid, date);
		
		//페이징 계산 처리 끝 ---------------------------------------
		
		ArrayList<Bill> list = billService.selectList(paging); //
		
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
			logger.info("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			return "redirect:billListView.do?page=1&userid="+bill.getUserid()+"&date="+formatter.format(bill.getBill_timestamp());
		} else {
			model.addAttribute("message", "삭제실패ㅋ");
			return "common/error";
		}
		
	}
}
