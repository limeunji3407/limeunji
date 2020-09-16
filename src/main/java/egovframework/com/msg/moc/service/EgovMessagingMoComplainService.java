package egovframework.com.msg.moc.service;

import java.util.List;

public interface EgovMessagingMoComplainService {

	/**
     * 민원관리 목록을 조회한다.
     */
    public List<MessagingMoComplainVO> messagingMoComplainList(MessagingMoComplainVO messagingMoComplainVO) throws Exception;
    
    public MessagingMoComplainVO messagingMoComplainOne(MessagingMoComplainVO messagingMoComplainVO) throws Exception;
    
    public void moComMemoInsert(ComplainMemo complainMemo) throws Exception;
    
    public List<ComplainMemo> moComMemoSelect(String mo_key) throws Exception;
    
    public ComplainMemo moComMemoSelectName(Integer memo_seq) throws Exception;
    
    public void moComMemoDelete(Integer memo_seq) throws Exception;
    
    public void moComAnswer(MessagingMoComplainVO messagingMoComplainVO) throws Exception;
    
    public MessagingMoComplainVO moComAnswerSelect(String mo_key) throws Exception;
    
    public void moComMemoUpdate(ComplainMemo memo) throws Exception;
}
