package egovframework.com.mng.msd.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.mng.msd.service.MessageLineConfigVO;


@Repository("MessageLineConfigDAO")
public class MessageLineConfigDAO extends EgovComAbstractDAO { 

	public MessageLineConfigVO selectMessageLineConfig() {
        return (MessageLineConfigVO) selectOne("MessageLineConfigDAO.selectMessageLineConfig_S");
	}
	
    public String insertMessageLineConfig(MessageLineConfigVO msgLineConfVO){
        return String.valueOf((int)insert("MessageLineConfigDAO.insertMessageLineConfig_S", msgLineConfVO));
    } 
    
    /* 사용안함 */
    public void updateMessageLineConfig(MessageLineConfigVO msgLineConfVO){
    	update("MessageLineConfigDAO.updateMessageLineConfig", msgLineConfVO);
    }

    public Integer countRole() {
    	return selectOne("MessageLineConfigDAO.countRole");
    }
}

