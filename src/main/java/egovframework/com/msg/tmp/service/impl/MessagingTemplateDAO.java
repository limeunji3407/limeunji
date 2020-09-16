package egovframework.com.msg.tmp.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.msg.tmp.service.MessagingTemplateVO;

@Repository("MessagingTemplateDAO")
public class MessagingTemplateDAO extends EgovComAbstractDAO{
	
	/**
     * 주어진 조건에 따른 템플릿 목록을 불러온다.
     */

	public List<MessagingTemplateVO> messagingTemplateList(MessagingTemplateVO messagingTemplateVO) throws Exception {
        return selectList("MessagingTemplateDAO.messagingTemplateList", messagingTemplateVO);
    }

	public void messagingTemplateDelete(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		update("MessagingTemplateDAO.messagingTemplateDelete", messagingTemplateVO);
    }
	
	public List<MessagingTemplateVO> messagingTemplateComment(String template_code) throws Exception {
		return selectList("MessagingTemplateDAO.templateComments", template_code);
	}
	
	public String messagingTemplateInsert(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		return String.valueOf((int)insert("MessagingTemplateDAO.messagingTemplateInsert", messagingTemplateVO));
    }
	
	public String messagingTemplateUpdateWorkSeq(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		return String.valueOf((int)update("MessagingTemplateDAO.messagingTemplateUpdateWorkSeq", messagingTemplateVO));
    }
	
	public String messagingTemplateUpdateUseYn(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		return String.valueOf((int)update("MessagingTemplateDAO.messagingTemplateUpdateUseYn", messagingTemplateVO));
    }
	
	public String messagingTemplateUpdateTemplateType(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		return String.valueOf((int)update("MessagingTemplateDAO.messagingTemplateUpdateTemplateType", messagingTemplateVO));
    }
	
	public String messagingTemplateUpdateSubject(MessagingTemplateVO messagingTemplateVO) throws Exception {
		
		return String.valueOf((int)update("MessagingTemplateDAO.messagingTemplateUpdateSubject", messagingTemplateVO));
    }
	
	public MessagingTemplateVO templateDetail(String template_data_seq) throws Exception{
		
		return selectOne("MessagingTemplateDAO.templateDetail", template_data_seq);
	}
	
	public Integer messagingTemplateCheckCode(String checkCode) throws Exception{
		return selectOne("MessagingTemplateDAO.messagingTemplateCheckCode", checkCode);
	}
	
	public void messagingUpdateTemplate(MessagingTemplateVO messagingTemplateVO) throws Exception{
		update("MessagingTemplateDAO.messagingUpdateTemplate", messagingTemplateVO);
	}
	
	public String selectTmpCode(Integer tmpSeq) throws Exception{
		return selectOne("MessagingTemplateDAO.selectTmpCode", tmpSeq);
	}
	
	public void tmpIquiryInsert(MessagingTemplateVO messagingTemplateVO) throws Exception {
		insert("MessagingTemplateDAO.tmpIquiryInsert", messagingTemplateVO);
	}
	
	public void tmpIquiryUpdate(MessagingTemplateVO messagingTemplateVO) throws Exception {
		update("MessagingTemplateDAO.tmpIquiryUpdate", messagingTemplateVO);
	}
}
