package egovframework.com.mng.msd.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.mng.msd.service.MessageLinePriceVO;


@Repository("MessageLinePriceDAO")
public class MessageLinePriceDAO extends EgovComAbstractDAO{
 
 
		public MessageLinePriceVO selectMessageLinePrice() {
	        return (MessageLinePriceVO) selectOne("MessageLinePriceDAO.selectMessageLinePrice_S");
		}
		
	    public void insertMessageLinePrice(MessageLinePriceVO mlpVO){
	        insert("MessageLinePriceDAO.insertMessageLinePrice_S", mlpVO);
	    } 
	    
	    public void updateMessageLinePrice(MessageLinePriceVO mlpVO){
	        update("MessageLinePriceDAO.updateMessageLinePrice", mlpVO);
	    } 
	    
	    public Integer countRole() {
	    	return selectOne("MessageLinePriceDAO.countRole");
	    }
}
