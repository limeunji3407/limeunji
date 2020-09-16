package egovframework.com.msg.moc.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.msg.moc.service.ComplainMemo;
import egovframework.com.msg.moc.service.MessagingMoComplainVO;


@Repository("MessagingMoComplainDAO")
public class MessagingMoComplainDAO extends EgovComAbstractDAO{
	
	/**
     * 주어진 조건에 따른 민원관리목록을 불러온다.
     */
	public List<MessagingMoComplainVO> messagingMoComplainList(MessagingMoComplainVO messagingMoComplainVO) throws Exception {
        return selectList("MessagingMoComplainDAO.messagingMoComplainList", messagingMoComplainVO);
    }

	public MessagingMoComplainVO messagingMoComplainOne(MessagingMoComplainVO messagingMoComplainVO) throws Exception {
		
		return (MessagingMoComplainVO) selectOne("MessagingMoComplainDAO.messagingMoComplainOne", messagingMoComplainVO);
    }
	
	public void moComMemoInsert(ComplainMemo complainMemo) throws Exception{
		insert("MessagingMoComplainDAO.moComMemoInsert", complainMemo);
	}
	
	public List<ComplainMemo> moComMemoSelect(String mo_key) throws Exception{
		return selectList("MessagingMoComplainDAO.moComMemoSelect", mo_key);
	}
	
	public ComplainMemo moComMemoSelectName(Integer memo_seq) throws Exception{
		return selectOne("MessagingMoComplainDAO.moComMemoSelectName", memo_seq);
	}
	
	public void moComMemoDelete(Integer memo_seq) throws Exception{
		delete("MessagingMoComplainDAO.moComMemoDelete", memo_seq);
	}
	
	public void moComAnswer(MessagingMoComplainVO messagingMoComplainVO) throws Exception{
		insert("MessagingMoComplainDAO.moComAnswer", messagingMoComplainVO);
	}
	
	public  MessagingMoComplainVO moComAnswerSelect(String mo_key) throws Exception{
		return selectOne("MessagingMoComplainDAO.moComAnswerSelect",mo_key);
	}
	
	public void moComMemoUpdate(ComplainMemo memo) throws Exception{
		update("MessagingMoComplainDAO.moComMemoUpdate", memo);
	}
}
