package egovframework.com.mng.mem.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.mng.mem.service.MessageRoleVO;
import egovframework.com.mng.mem.service.EgovMessageRoleService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;




@Service("egovMessageRoleService")
public class EgovMessageRoleServiceImpl extends EgovAbstractServiceImpl implements EgovMessageRoleService{

    @Resource(name = "MessageRoleDAO")
    private MessageRoleDAO msgroleDAO;

	public MessageRoleVO selectMessageRole() throws Exception {
		MessageRoleVO basicList = msgroleDAO.selectMessageRole();
		return basicList;
	}    
 
	public String insertMessageRole(MessageRoleVO msgroleVO) throws Exception {

		String result = msgroleDAO.insertMessageRole(msgroleVO);
		return result;
		
	}
	
	public void updateMessageRole(MessageRoleVO msgroleVO) throws Exception {
		msgroleDAO.updateMessageRole(msgroleVO);
	}
 

	public String insertMessageCash(MessageRoleVO msgroleVO) throws Exception {

		String result = msgroleDAO.insertMessageCash(msgroleVO);
		return result;
		
	}

	@Override
	public Integer countRole() throws Exception {
		
		return msgroleDAO.countRole();
	}

	@Override
	public void insMsgPartCash(MessageRoleVO msgRoleVO) throws Exception {
		msgroleDAO.insMsgPartCash(msgRoleVO);
	}

	@Override
	public void updMsgPartCash(MessageRoleVO msgRoleVO) throws Exception {
		msgroleDAO.updMsgPartCash(msgRoleVO);
	}

	@Override
	public void insMsgUsrCash(MessageRoleVO msgRoleVO) throws Exception {
		msgroleDAO.insMsgUsrCash(msgRoleVO);
	}

	@Override
	public void updMsgUsrCash(MessageRoleVO msgRoleVO) throws Exception {
		msgroleDAO.updMsgUsrCash(msgRoleVO);
	}
 
	 
}
