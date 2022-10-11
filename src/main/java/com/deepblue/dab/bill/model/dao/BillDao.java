package com.deepblue.dab.bill.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.deepblue.dab.bill.model.vo.Bill;
import com.deepblue.dab.bill.utils.PagingBill;
import com.deepblue.dab.common.Paging;
import com.deepblue.dab.qna.model.vo.Question;



@Repository("billDao")
public class BillDao {

	@Autowired
	private SqlSessionTemplate session;
	
	public int insertBill(Bill bill) {
		return session.insert("billMapper.insertBill", bill);
	}

	public int selectListCountDay(Map<String, Object> map) {
		return session.selectOne("billMapper.getListCountDay", map);
	}

	public ArrayList<Bill> selectList(PagingBill paging) {
		List<Bill> list = session.selectList("billMapper.selectList", paging);
		return (ArrayList<Bill>)list;
	}

	public Bill selectBill(int bill_id) {
		return session.selectOne("billMapper.selectBill", bill_id);
	}

	public int updateBill(Bill bill) {
		return session.update("billMapper.updateBill", bill);
	}

	public int deleteBill(int id) {
		// TODO Auto-generated method stub
		return session.delete("billMapper.deleteBill",id);
	}

	public int totalPrice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Integer i = session.selectOne("billMapper.getTotalPrice", map);
		if ( i != null)
			return i;
		else return 0;
	}

	public int selectListCountSearchPrice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Integer i = session.selectOne("billMapper.selectListCountSearchPrice", map);
		if ( i != null)
			return i;
		else return 0;
	}

	public int selectListCountSearchCategory(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Integer i = session.selectOne("billMapper.selectListCountSearchCategory", map);
		if ( i != null)
			return i;
		else return 0;
	}

	public int selectListCountSearchDate(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Integer i = session.selectOne("billMapper.selectListCountSearchDate", map);
		if ( i != null)
			return i;
		else return 0;
	}

	public int selectListCountSearch(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Integer i = session.selectOne("billMapper.selectListCountSearch", map);
		if ( i != null)
			return i;
		else return 0;
	}

	public ArrayList<Bill> selectListSearch(Map<String, Object> map) {
		List<Bill> list = session.selectList("billMapper.selectListSearch", map);
		return (ArrayList<Bill>)list;
	}

	public ArrayList<Bill> lastMultiUploadList(Map<String, Object> map) {
		List<Bill> list = session.selectList("billMapper.lastMultiUploadList", map);
		return (ArrayList<Bill>)list;
	}
}
