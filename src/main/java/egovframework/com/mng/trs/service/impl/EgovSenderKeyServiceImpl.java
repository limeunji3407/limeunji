package egovframework.com.mng.trs.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.com.mng.trs.service.EgovSenderKeyService;
import egovframework.com.mng.trs.service.SenderKeyDefaultVO;
import egovframework.com.mng.trs.service.SenderKeyVO;
/**
 * @Class Name : SenderKeyServiceImpl.java
 * @Description : SenderKey Business Implement class
 * @Modification Information
 *
 * @author Kim SuRo
 * @since 2020/03/21
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("egovSenderKeyService")
public class EgovSenderKeyServiceImpl extends EgovAbstractServiceImpl implements
        EgovSenderKeyService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(EgovSenderKeyServiceImpl.class);

    @Resource(name="senderKeyDAO")
    private SenderKeyDAO senderKeyDAO;
    
    //@Resource(name="senderKeyDAO")
    //private SenderKeyDAO senderKeyDAO;
    
    /** ID Generation */
    //@Resource(name="{egovSenderKeyIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * SENDER_KEY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SenderKeyVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSenderKey(SenderKeyVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	senderKeyDAO.insertSenderKey(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * SENDER_KEY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SenderKeyVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSenderKey(SenderKeyVO vo) throws Exception {
        senderKeyDAO.updateSenderKey(vo);
    }

    /**
	 * SENDER_KEY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SenderKeyVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSenderKey(SenderKeyVO vo) throws Exception {
        senderKeyDAO.deleteSenderKey(vo);
    }

    /**
	 * SENDER_KEY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SenderKeyVO
	 * @return 조회한 SENDER_KEY
	 * @exception Exception
	 */
    public SenderKeyVO selectSenderKey(SenderKeyVO vo) throws Exception {
        SenderKeyVO resultVO = senderKeyDAO.selectSenderKey(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * SENDER_KEY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SENDER_KEY 목록
	 * @exception Exception
	 */
    public List<SenderKeyVO> selectSenderKeyList(SenderKeyDefaultVO searchVO) throws Exception {
        return senderKeyDAO.selectSenderKeyList(searchVO);
    }

    /**
	 * SENDER_KEY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SENDER_KEY 총 갯수
	 * @exception
	 */
    public int selectSenderKeyListTotCnt(SenderKeyDefaultVO searchVO) {
		return senderKeyDAO.selectSenderKeyListTotCnt(searchVO);
	}
    
}
