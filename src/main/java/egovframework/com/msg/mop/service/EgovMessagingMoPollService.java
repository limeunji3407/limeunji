package egovframework.com.msg.mop.service;

import java.util.List;

public interface EgovMessagingMoPollService {
	
	/**
     * 문자투표 목록을 조회한다.
     * @param MessagingMoPollVO
     * @return  Map<String, Object>
     * @exception Exception
     */
	//문자결과있는 리스트
    public List<MessagingMoPollVO> smsPollList(MessagingMoPollVO smsPollVO) throws Exception;
    
    public List<MessagingMoPollVO> smsMngPollList(MessagingMoPollVO smsPollVO) throws Exception;
    
    public MessagingMoPollVO smsPollSelectOne(MessagingMoPollVO smsPollVO) throws Exception;
    
    public String updateMessagingMoPollShutdown(MessagingMoPollVO smsPollVO) throws Exception;

    //신규등록 문자투표리스트
    public List<MessagingMoPollVO> selectSmsPollNewList(MessagingMoPollVO smsPollVO) throws Exception;
    
    public List<MessagingMoPollVO> smsPollMngNewList(MessagingMoPollVO smsPollVO) throws Exception;
    
    public void insertMessagingMoNewPoll(MessagingMoPollVO smsPollVO) throws Exception;
    
    public String updateMessagingMoNewPollDel(MessagingMoPollVO smsPollVO) throws Exception;
    
    public String updateMessagingMoNewPoll(MessagingMoPollVO smsPollVO) throws Exception;
    
    public void pollComClose(Integer seq) throws Exception;

    public List<MessagingMoPollResponse> pollResponseList(MessagingMoPollResponse messagingMoPollResponse) throws Exception;

    public List<MessagingMoPollResponse> pollResponseListSelect(MessagingMoPollResponse messagingMoPollResponse) throws Exception;
}
