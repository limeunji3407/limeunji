package egovframework.com.msg.mop.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.msg.mop.service.EgovMessagingMoPollService;
import egovframework.com.msg.mop.service.MessagingMoPollResponse;
import egovframework.com.msg.mop.service.MessagingMoPollVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


@Service("egovMessagingMoPollService")
public class EgovMessagingMoPollServiceImpl extends EgovAbstractServiceImpl implements EgovMessagingMoPollService {
	
	@Resource(name = "MessagingMoPollDAO")
    private MessagingMoPollDAO messagingMoPollDAO;
    
    @Resource(name = "egovAdbkIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "egovAdbkUserIdGnrService")
    private EgovIdGnrService idgenService2;
    
    /**
     * 문자투표 목록을 조회한다.
     * @param MessagingMoPollVO
     * @return  Map<String, Object>
     * @exception Exception
     */
	@Override
	public List<MessagingMoPollVO> smsPollList(MessagingMoPollVO smsPollVO) throws Exception {
		
        List<MessagingMoPollVO> result = messagingMoPollDAO.smsPollList(smsPollVO);

        return result;
	}
	
	@Override
	public List<MessagingMoPollVO> smsMngPollList(MessagingMoPollVO smsPollVO) throws Exception {
		List<MessagingMoPollVO> result = messagingMoPollDAO.smsMngPollList(smsPollVO);
		return result;
	}

	@Override
	public MessagingMoPollVO smsPollSelectOne(MessagingMoPollVO messagingMoPollVO) throws Exception {
		
		MessagingMoPollVO result = messagingMoPollDAO.smsPollSelectOne(messagingMoPollVO);

        return result;
	}
	
	@Override
	public String updateMessagingMoPollShutdown(MessagingMoPollVO messagingMoPollVO) throws Exception {
		
		String result = messagingMoPollDAO.updateMessagingMoPollShutdown(messagingMoPollVO);
	    
		return result;
	}
	
	@Override
	public List<MessagingMoPollVO> selectSmsPollNewList(MessagingMoPollVO smsPollVO) throws Exception {
		
        List<MessagingMoPollVO> result = messagingMoPollDAO.smsPollNewList(smsPollVO);

        return result;
	}	
	

	@Override
	public List<MessagingMoPollVO> smsPollMngNewList(MessagingMoPollVO smsPollVO) throws Exception {
		List<MessagingMoPollVO> result = messagingMoPollDAO.smsPollMngNewList(smsPollVO);
		return result;
	}
	
	
	@Override
	public void insertMessagingMoNewPoll(MessagingMoPollVO messagingMoPollVO) throws Exception {
		System.out.println("-----insertMessagingMoNewPoll Service----");
		messagingMoPollDAO.insertMessagingMoNewPoll(messagingMoPollVO);
	}
	
	@Override
	public String updateMessagingMoNewPollDel(MessagingMoPollVO messagingMoPollVO) throws Exception {
		
		String result = messagingMoPollDAO.updateMessagingMoNewPollDel(messagingMoPollVO);
	    
		return result;
	}
	
	@Override
	public String updateMessagingMoNewPoll(MessagingMoPollVO messagingMoPollVO) throws Exception {
		
		String result = messagingMoPollDAO.updateMessagingMoNewPoll(messagingMoPollVO);
	    
		return result;
	}

	@Override
	public void pollComClose(Integer seq) throws Exception {
		messagingMoPollDAO.pollComClose(seq);
	}

	@Override
	public List<MessagingMoPollResponse> pollResponseList(MessagingMoPollResponse messagingMoPollResponse)throws Exception {
		
		return messagingMoPollDAO.pollResponseList(messagingMoPollResponse);
	}

	@Override
	public List<MessagingMoPollResponse> pollResponseListSelect(MessagingMoPollResponse messagingMoPollResponse)
			throws Exception {
		// TODO Auto-generated method stub
		return messagingMoPollDAO.pollResponseListSelect(messagingMoPollResponse);
	}
}
