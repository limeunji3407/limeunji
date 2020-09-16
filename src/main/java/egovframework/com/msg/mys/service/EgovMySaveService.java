package egovframework.com.msg.mys.service;

import java.util.List;

public interface EgovMySaveService {

	public void insertMySave(MySaveVO mySaveVO) throws Exception;
	
	public List<MySaveVO> MySaveList(MySaveVO mySaveVO) throws Exception;
	
	public void deleteMySave(MySaveVO mySaveVO) throws Exception;
}
