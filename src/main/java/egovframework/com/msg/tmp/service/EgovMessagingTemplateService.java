package egovframework.com.msg.tmp.service;

import java.util.List;

public interface EgovMessagingTemplateService {

	/**
     * 템플릿 목록을 조회한다.
     */
    public List<MessagingTemplateVO> messagingTemplateList(MessagingTemplateVO messagingTemplateVO) throws Exception;
    
    public MessagingTemplateVO templateDetail(String template_data_seq) throws Exception;
    
    public void messagingTemplateDelete(MessagingTemplateVO messagingTemplateVO) throws Exception;
    
    public String messagingTemplateInsert(MessagingTemplateVO messagingTemplateVO) throws Exception;
    
    public String messagingTemplateUpdateWorkSeq(MessagingTemplateVO messagingTemplateVO) throws Exception;
    
    public String messagingTemplateUpdateUseYn(MessagingTemplateVO messagingTemplateVO) throws Exception;
    
    public String messagingTemplateUpdateTemplateType(MessagingTemplateVO messagingTemplateVO) throws Exception;
    
    public String messagingTemplateUpdateSubject(MessagingTemplateVO messagingTemplateVO) throws Exception;

    public Integer messagingTemplateCheckCode(String checkCode) throws Exception;
    
    public List<MessagingTemplateVO> messagingTemplateComment(String tmpCode) throws Exception;

    public void messagingUpdateTemplate(MessagingTemplateVO messagingTemplateVO) throws Exception;
    
    public String selectTmpCode(Integer tmpSeq) throws Exception;
    
    public void tmpIquiryInsert(MessagingTemplateVO messagingTemplateVO) throws Exception;
    public void tmpIquiryUpdate(MessagingTemplateVO messagingTemplateVO) throws Exception;
}
