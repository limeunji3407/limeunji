package egovframework.com.msg.moc.service;

import java.util.List;

public interface EgovMoNumberService {

	public List<MoNumber> moNumberList(MoNumber moNumber) throws Exception;
	
	public String moNumberInsert(MoNumber moNumber) throws Exception;
	
	public String moNumberUpdate(MoNumber moNumber) throws Exception;
	 
	public MoNumber searchMoNum(MoNumber moNumber) throws Exception;
}
