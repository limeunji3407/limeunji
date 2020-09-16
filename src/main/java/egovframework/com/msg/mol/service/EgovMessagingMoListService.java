package egovframework.com.msg.mol.service;

import java.util.List;

import egovframework.com.msg.mop.service.MessagingMoListVO;

public interface EgovMessagingMoListService {
	
	/**
     * 문자투표 목록을 조회한다.
     * @param MessagingMoPollVO
     * @return  Map<String, Object>
     * @exception Exception
     */
	//문자결과있는 리스트
    public List<MessagingMoListVO> msgMoListAll(MessagingMoListVO molist) throws Exception; 

}
