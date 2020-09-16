package egovframework.com.msg.tmp.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.msg.tmp.service.EgovMessagingTemplateService;
import egovframework.com.msg.tmp.service.MessagingTemplateVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


@Service("egovMessagingTemplateService")
public class EgovMessagingTemplateServiceImpl extends EgovAbstractServiceImpl implements EgovMessagingTemplateService{

	@Resource(name = "MessagingTemplateDAO")
    private MessagingTemplateDAO messagingTemplateDAO;
    
    @Resource(name = "egovAdbkIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "egovAdbkUserIdGnrService")
    private EgovIdGnrService idgenService2;
    
    /**
     * 템플릿 목록을 조회한다.
     */
	@Override
	public List<MessagingTemplateVO> messagingTemplateList(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
        List<MessagingTemplateVO> result = messagingTemplateDAO.messagingTemplateList(messagingTemplateVO);

        return result;
	}
	
	@Override
	public void messagingTemplateDelete(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		messagingTemplateDAO.messagingTemplateDelete(messagingTemplateVO);
	}
	
	@Override
	public String messagingTemplateInsert(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		String result = messagingTemplateDAO.messagingTemplateInsert(messagingTemplateVO);
	    
		return result;
	}
	
	@Override
	public String messagingTemplateUpdateWorkSeq(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		String result = messagingTemplateDAO.messagingTemplateUpdateWorkSeq(messagingTemplateVO);
	    
		return result;
	}
	
	@Override
	public String messagingTemplateUpdateUseYn(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		String result = messagingTemplateDAO.messagingTemplateUpdateUseYn(messagingTemplateVO);
	    
		return result;
	}
	
	@Override
	public String messagingTemplateUpdateTemplateType(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		String result = messagingTemplateDAO.messagingTemplateUpdateTemplateType(messagingTemplateVO);
	    
		return result;
	}
	
	@Override
	public String messagingTemplateUpdateSubject(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		String result = messagingTemplateDAO.messagingTemplateUpdateSubject(messagingTemplateVO);
	    
		return result;
	}

	@Override
	public MessagingTemplateVO templateDetail(String template_data_seq) throws Exception {
		
		return messagingTemplateDAO.templateDetail(template_data_seq);
	}

	@Override
	public Integer messagingTemplateCheckCode(String checkCode) throws Exception {
		return messagingTemplateDAO.messagingTemplateCheckCode(checkCode);
	}

	@Override
	public List<MessagingTemplateVO> messagingTemplateComment(String tmpCode) throws Exception {
		return messagingTemplateDAO.messagingTemplateComment(tmpCode);
	}

	@Override
	public void messagingUpdateTemplate(MessagingTemplateVO messagingTemplateVO) throws Exception {
		messagingTemplateDAO.messagingUpdateTemplate(messagingTemplateVO);
	}

	@Override
	public String selectTmpCode(Integer tmpSeq) throws Exception {
		return messagingTemplateDAO.selectTmpCode(tmpSeq);
	}

	@Override
	public void tmpIquiryInsert(MessagingTemplateVO messagingTemplateVO) throws Exception {
		messagingTemplateDAO.tmpIquiryInsert(messagingTemplateVO);
	}

	@Override
	public void tmpIquiryUpdate(MessagingTemplateVO messagingTemplateVO) throws Exception {
		messagingTemplateDAO.tmpIquiryUpdate(messagingTemplateVO);
	}
}
