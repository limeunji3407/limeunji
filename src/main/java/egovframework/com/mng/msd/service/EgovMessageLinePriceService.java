package egovframework.com.mng.msd.service;

/**

 */
public interface EgovMessageLinePriceService {
	
	public MessageLinePriceVO selectMessageLinePrice() throws Exception;
	
	public void insertMessageLinePrice(MessageLinePriceVO msglineconfVO) throws Exception; 

	public Integer countRole();
	public void updateMessageLinePrice(MessageLinePriceVO msglineconfVO) throws Exception; 

}