package egovframework.com.msg.moc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.msg.moc.service.ComplainMemo;
import egovframework.com.msg.moc.service.EgovMessagingMoComplainService;
import egovframework.com.msg.moc.service.MessagingMoComplainVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


@Service("egovMessagingMoComplainService")
public class EgovMessagingMoComplainServiceImpl extends EgovAbstractServiceImpl implements EgovMessagingMoComplainService{

	
	@Resource(name = "MessagingMoComplainDAO")
    private MessagingMoComplainDAO messagingMoComplainDAO;
    
    @Resource(name = "egovAdbkIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "egovAdbkUserIdGnrService")
    private EgovIdGnrService idgenService2;
    
    /**
     * 민원관리 목록을 조회한다.
     */
	@Override
	public List<MessagingMoComplainVO> messagingMoComplainList(MessagingMoComplainVO messagingMoComplainVO) throws Exception {
		
        /*List<MessagingMoComplainVO> result = messagingMoComplainDAO.messagingMoComplainList(messagingMoComplainVO);
        return result;*/
        return messagingMoComplainDAO.messagingMoComplainList(messagingMoComplainVO);
	}
	
	@Override
	public MessagingMoComplainVO messagingMoComplainOne(MessagingMoComplainVO messagingMoComplainVO) throws Exception {
		
		MessagingMoComplainVO result = messagingMoComplainDAO.messagingMoComplainOne(messagingMoComplainVO);

        return result;
	}

	@Override
	public void moComMemoInsert(ComplainMemo complainMemo) throws Exception {
		messagingMoComplainDAO.moComMemoInsert(complainMemo);
	}

	@Override
	public List<ComplainMemo> moComMemoSelect(String mo_key) throws Exception {
		
		return messagingMoComplainDAO.moComMemoSelect(mo_key);
	}

	@Override
	public ComplainMemo moComMemoSelectName(Integer memo_seq) throws Exception {
		return messagingMoComplainDAO.moComMemoSelectName(memo_seq);
	}

	@Override
	public void moComMemoDelete(Integer memo_seq) throws Exception {
		messagingMoComplainDAO.moComMemoDelete(memo_seq);;
	}

	@Override
	public void moComAnswer(MessagingMoComplainVO messagingMoComplainVO) throws Exception {
		messagingMoComplainDAO.moComAnswer(messagingMoComplainVO);;
	}

	@Override
	public MessagingMoComplainVO moComAnswerSelect(String mo_key) throws Exception {
		return messagingMoComplainDAO.moComAnswerSelect(mo_key);
	}

	@Override
	public void moComMemoUpdate(ComplainMemo memo) throws Exception {
		messagingMoComplainDAO.moComMemoUpdate(memo);
	}
}
