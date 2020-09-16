package egovframework.com.msg.mol.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO; 
import egovframework.com.msg.mop.service.MessagingMoListVO;


@Repository("MessagingMoListAllDAO")
public class MessaginMoListAllDAO extends EgovComAbstractDAO{
 
	
	/**
     * 통합리스트
     * 
     * @param msgMoList
     * @return
     * @throws Exception
     */ 
	public List<MessagingMoListVO> msgMoList(MessagingMoListVO molist) throws Exception {
        return  selectList("MessagingMoListDAO.messagingMoList", molist);
    } 
	 
}

