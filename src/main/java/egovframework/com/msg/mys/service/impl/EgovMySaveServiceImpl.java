package egovframework.com.msg.mys.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.msg.mys.service.EgovMySaveService;
import egovframework.com.msg.mys.service.MySaveVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("egovMySaveService")
public class EgovMySaveServiceImpl extends EgovAbstractServiceImpl implements EgovMySaveService{
	
	@Resource(name = "MySaveDAO")
    private MySaveDAO mySaveDAO;

	@Override
	public void insertMySave(MySaveVO mySaveVO) throws Exception {
		
		mySaveDAO.insertMySave(mySaveVO);
	}

	@Override
	public List<MySaveVO> MySaveList(MySaveVO mySaveVO) throws Exception {
		
		List<MySaveVO> list = mySaveDAO.MySaveList(mySaveVO);
		
		return list;
	}

	@Override
	public void deleteMySave(MySaveVO mySaveVO) throws Exception {
		
		mySaveDAO.deleteMySave(mySaveVO);
	}

}
