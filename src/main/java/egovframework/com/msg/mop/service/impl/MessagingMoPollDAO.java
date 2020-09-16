package egovframework.com.msg.mop.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.msg.mop.service.MessagingMoPollResponse;
import egovframework.com.msg.mop.service.MessagingMoPollVO;


@Repository("MessagingMoPollDAO")
public class MessagingMoPollDAO extends EgovComAbstractDAO{

	
	/**
     * 주어진 조건에 따른 문자투표결과를 불러온다.
     * 
     * @param MessagingMoPollVO
     * @return
     * @throws Exception
     */
	public List<MessagingMoPollVO> smsPollList(MessagingMoPollVO messagingMoPollVO) throws Exception {
        return  selectList("MessagingMoPollDAO.messagingMoPollList", messagingMoPollVO);
    }
	
	public List<MessagingMoPollVO> smsMngPollList(MessagingMoPollVO messagingMoPollVO) throws Exception {
        return  selectList("MessagingMoPollDAO.messagingMngMoPollList", messagingMoPollVO);
    }
	
	/*
	 * 신규등록 문자투표
	 */
	public void insertMessagingMoNewPoll(MessagingMoPollVO messagingMoPollVO) throws Exception {
		System.out.println("-----insertMessagingMoNewPoll DAO----");
		
		insert("MessagingMoPollDAO.insertMessagingMoNewPoll", messagingMoPollVO);
    }
	
	
	public MessagingMoPollVO smsPollSelectOne(MessagingMoPollVO messagingMoPollVO) throws Exception {
		
		return (MessagingMoPollVO) selectOne("MessagingMoPollDAO.messagingMoPollSelectOne", messagingMoPollVO);
    }
	
	public String updateMessagingMoPollShutdown(MessagingMoPollVO messagingMoPollVO) throws Exception {
		
		return String.valueOf((int)update("MessagingMoPollDAO.updateMessagingMoPollShutdown", messagingMoPollVO));
    }


	public List<MessagingMoPollVO> smsPollNewList(MessagingMoPollVO messagingMoPollVO) throws Exception {
        return  selectList("MessagingMoPollDAO.messagingMoPollNewList", messagingMoPollVO);
    }
	
	public List<MessagingMoPollVO> smsPollMngNewList(MessagingMoPollVO messagingMoPollVO) throws Exception {
        return  selectList("MessagingMoPollDAO.messagingMoPollMngNewList", messagingMoPollVO);
    }
	
	public String updateMessagingMoNewPollDel(MessagingMoPollVO messagingMoPollVO) throws Exception {
		
		return String.valueOf((int)update("MessagingMoPollDAO.updateMessagingMoNewPollDel", messagingMoPollVO));
    }
	
	public String updateMessagingMoNewPoll(MessagingMoPollVO messagingMoPollVO) throws Exception {
		
		return String.valueOf((int)update("MessagingMoPollDAO.updateMessagingMoNewPoll", messagingMoPollVO));
    }

	public void pollComClose(Integer seq) throws Exception{
		update("MessagingMoPollDAO.pollComClose", seq);
	}
	
	public List<MessagingMoPollResponse> pollResponseList(MessagingMoPollResponse messagingMoPollResponse) throws Exception{
		
		return selectList("MessagingMoPollDAO.pollResponseList", messagingMoPollResponse);
	}
	
	public List<MessagingMoPollResponse> pollResponseListSelect(MessagingMoPollResponse messagingMoPollResponse) throws Exception{
		
		return selectList("MessagingMoPollDAO.pollResponseListSelect", messagingMoPollResponse);
	}
}

