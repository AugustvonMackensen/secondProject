package com.deepblue.dab.bill.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.deepblue.dab.bill.model.vo.Bill;
import com.deepblue.dab.bill.utils.PagingBill;

public interface BillService {

	int insertBill(Bill bill);

	int selectListCountDay(Map<String, Object> map);

	ArrayList<Bill> selectList(PagingBill paging);

	Bill selectBill(int bill_id);

	int updateBill(Bill bill);

	int deleteBill(int id);

	int totalPrice(Map<String, Object> map);

	ArrayList<Bill> selectListSearchPrice(Map<String, Object> map);

	ArrayList<Bill> selectListSearchCategory(Map<String, Object> map);

	ArrayList<Bill> selectListSearchDate(Map<String, Object> map);

	int selectListCountSearchPrice(Map<String, Object> map);

	int selectListCountSearchCategory(Map<String, Object> map);

	int selectListCountSearchDate(Map<String, Object> map);

	int selectListCountSearch(Map<String, Object> map);

	ArrayList<Bill> selectListSearch(Map<String, Object> map);
}
