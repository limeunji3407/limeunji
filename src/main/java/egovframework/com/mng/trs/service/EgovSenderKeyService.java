package egovframework.com.mng.trs.service;

import java.util.List;
import egovframework.com.mng.trs.service.SenderKeyDefaultVO;
import egovframework.com.mng.trs.service.SenderKeyVO;

/**
 * @Class Name : SenderKeyService.java
 * @Description : SenderKey Business class
 * @Modification Information
 *
 * @author Kim SuRo
 * @since 2020/03/21
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovSenderKeyService {
	
	/**
	 * SENDER_KEY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SenderKeyVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertSenderKey(SenderKeyVO vo) throws Exception;
    
    /**
	 * SENDER_KEY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SenderKeyVO
	 * @return void형
	 * @exception Exception
	 */
    void updateSenderKey(SenderKeyVO vo) throws Exception;
    
    /**
	 * SENDER_KEY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SenderKeyVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteSenderKey(SenderKeyVO vo) throws Exception;
    
    /**
	 * SENDER_KEY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SenderKeyVO
	 * @return 조회한 SENDER_KEY
	 * @exception Exception
	 */
    SenderKeyVO selectSenderKey(SenderKeyVO vo) throws Exception;
    
    /**
	 * SENDER_KEY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SENDER_KEY 목록
	 * @exception Exception
	 */
    List<SenderKeyVO> selectSenderKeyList(SenderKeyDefaultVO searchVO) throws Exception;
    
    /**
	 * SENDER_KEY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SENDER_KEY 총 갯수
	 * @exception
	 */
    int selectSenderKeyListTotCnt(SenderKeyDefaultVO searchVO);
    
}
