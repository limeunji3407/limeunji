package egovframework.com.msg.mys.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.msg.mys.service.MySaveVO;

@Repository("MySaveDAO")
public class MySaveDAO extends EgovComAbstractDAO{
	
	String namespace = "MySaveDAO";
	
	public void insertMySave(MySaveVO mySaveVO) throws Exception{
		insert(namespace+".insertMySave", mySaveVO);
	}
	
	public List<MySaveVO> MySaveList(MySaveVO mySaveVO) throws Exception{
		List<MySaveVO> list = selectList(namespace+".MySaveList", mySaveVO);
		return list;
	}
	
	public void deleteMySave(MySaveVO mySaveVO) throws Exception{
		delete(namespace+".deleteMySave", mySaveVO);
	}
}
