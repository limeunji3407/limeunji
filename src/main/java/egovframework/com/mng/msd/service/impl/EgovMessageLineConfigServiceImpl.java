package egovframework.com.mng.msd.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.mng.msd.service.EgovMessageLineConfigService;
import egovframework.com.mng.msd.service.MessageLineConfigVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 주소록정보를 관리하기 위한 서비스 구현  클래스
 * @author 공통컴포넌트팀 윤성록
 * @since 2009.09.25
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.9.25  윤성록          최초 생성
 *   2016.12.13 최두영          클래스명 변경
 *
 * </pre>
 */
@Service("egovMessageLineConfigService")
public class EgovMessageLineConfigServiceImpl extends EgovAbstractServiceImpl implements EgovMessageLineConfigService{

    
    @Resource(name = "MessageLineConfigDAO")
    private MessageLineConfigDAO msglineconfDAO;
    

	public MessageLineConfigVO selectMessageLineConfig() throws Exception {
		MessageLineConfigVO msglineconfVO = msglineconfDAO.selectMessageLineConfig();
		return msglineconfVO;
	}
	
	public String insertMessageLineConfig(MessageLineConfigVO msglineconfVO) throws Exception {

		String result = msglineconfDAO.insertMessageLineConfig(msglineconfVO);
		return result;
	}

	@Override
	public Integer countRole() throws Exception {
		return msglineconfDAO.countRole();
	}

	@Override
	public void updateMessageLineConfig(MessageLineConfigVO cfgvo) throws Exception {
		msglineconfDAO.updateMessageLineConfig(cfgvo);
	}
	
}
