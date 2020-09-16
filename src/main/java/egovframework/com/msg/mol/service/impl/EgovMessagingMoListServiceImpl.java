package egovframework.com.msg.mol.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.msg.mol.service.EgovMessagingMoListService;
import egovframework.com.msg.mop.service.EgovMessagingMoPollService;
import egovframework.com.msg.mop.service.MessagingMoListVO;
import egovframework.com.msg.mop.service.MessagingMoPollVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


@Service("egovMessagingMoListService")
public class EgovMessagingMoListServiceImpl extends EgovAbstractServiceImpl implements EgovMessagingMoListService {
	
	@Resource(name = "MessagingMoListAllDAO")
    private MessaginMoListAllDAO messagingMoListAllDAO;
    
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
	public List<MessagingMoListVO> msgMoListAll(MessagingMoListVO moListVO) throws Exception {
		
        return messagingMoListAllDAO.msgMoList(moListVO); 
	} 
}
