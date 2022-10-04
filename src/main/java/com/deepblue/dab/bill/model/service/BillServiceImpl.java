package com.deepblue.dab.bill.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deepblue.dab.bill.model.dao.BillDao;
import com.deepblue.dab.bill.model.vo.Bill;
import com.deepblue.dab.bill.utils.PagingBill;

@Service("billService")
public class BillServiceImpl implements BillService{
	@Autowired
	private BillDao billDao;

	@Override
	public int insertBill(Bill bill) {
		return billDao.insertBill(bill);
	}

	@Override
	public int selectListCountDay(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return billDao.selectListCountDay(map);
	}

	@Override
	public ArrayList<Bill> selectList(PagingBill paging) {
		// TODO Auto-generated method stub
		return billDao.selectList(paging);
	}
	
	
}
