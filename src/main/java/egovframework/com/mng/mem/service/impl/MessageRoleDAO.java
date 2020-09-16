package egovframework.com.mng.mem.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.mng.mem.service.MessageRoleVO;


@Repository("MessageRoleDAO")
public class MessageRoleDAO extends EgovComAbstractDAO { 
	
	
	public MessageRoleVO selectMessageRole() throws Exception { 
        return (MessageRoleVO) selectOne("MessageRoleDAO.selectMessageRole");
		
	};

 
	public String insertMessageRole(MessageRoleVO msgRoleVO) throws Exception {
        return String.valueOf((int)insert("MessageRoleDAO.insertMessageRole", msgRoleVO));
	}


	public String insertMessageCash(MessageRoleVO msgRoleVO) throws Exception {
        return String.valueOf((int)insert("MessageRoleDAO.insertMessageCash", msgRoleVO));
	}
	
	public Integer countRole() throws Exception{
		return selectOne("MessageRoleDAO.countRole");
	}
	
	public void updateMessageRole(MessageRoleVO msgRoleVO) throws Exception{
		update("MessageRoleDAO.updateMessageRole", msgRoleVO);
	}
	
	public void insMsgPartCash(MessageRoleVO msgRoleVO) throws Exception{
		insert("MessageRoleDAO.insMsgPartCash", msgRoleVO);
	}
	
	public void updMsgPartCash(MessageRoleVO msgRoleVO) throws Exception{
		update("MessageRoleDAO.updMsgPartCash", msgRoleVO);
	}
	
	public void insMsgUsrCash(MessageRoleVO msgRoleVO) throws Exception{
		insert("MessageRoleDAO.insMsgUsrCash", msgRoleVO);
	}
	
	public void updMsgUsrCash(MessageRoleVO msgRoleVO) throws Exception{
		update("MessageRoleDAO.updMsgUsrCash", msgRoleVO);
	}
}

