package egovframework.com.mng.trs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.mng.trs.service.SenderKeyVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.mng.trs.service.SenderKeyDefaultVO;

/**
 * @Class Name : SenderKeyDAO.java
 * @Description : SenderKey DAO Class
 * @Modification Information
 *
 * @author Kim SuRo
 * @since 2020/03/21
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("senderKeyDAO")
public class SenderKeyDAO extends EgovComAbstractDAO {

	/**
	 * SENDER_KEY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SenderKeyVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSenderKey(SenderKeyVO vo) throws Exception {
		return String.valueOf((int)insert("senderKeyDAO.insertSenderKey", vo));
    }

    /**
	 * SENDER_KEY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SenderKeyVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSenderKey(SenderKeyVO vo) throws Exception {
        update("senderKeyDAO.updateSenderKey", vo);
    }

    /**
	 * SENDER_KEY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SenderKeyVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSenderKey(SenderKeyVO vo) throws Exception {
        delete("senderKeyDAO.deleteSenderKey", vo);
    }

    /**
	 * SENDER_KEY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SenderKeyVO
	 * @return 조회한 SENDER_KEY
	 * @exception Exception
	 */
    public SenderKeyVO selectSenderKey(SenderKeyVO vo) throws Exception {
        return (SenderKeyVO) selectOne("senderKeyDAO.selectSenderKey", vo);
    }

    /**
	 * SENDER_KEY 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SENDER_KEY 목록
	 * @exception Exception
	 */
    public List<SenderKeyVO> selectSenderKeyList(SenderKeyDefaultVO searchVO) throws Exception {
		return selectList("senderKeyDAO.selectSenderKeyList", searchVO);
        
    }

    /**
	 * SENDER_KEY 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SENDER_KEY 총 갯수
	 * @exception
	 */
    public int selectSenderKeyListTotCnt(SenderKeyDefaultVO searchVO) {
        return (Integer) selectOne("senderKeyDAO.selectSenderKeyListTotCnt", searchVO);
    }

}
