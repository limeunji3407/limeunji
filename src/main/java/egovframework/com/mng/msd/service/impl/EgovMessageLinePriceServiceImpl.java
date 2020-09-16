package egovframework.com.mng.msd.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.mng.msd.service.EgovMessageLinePriceService;
import egovframework.com.mng.msd.service.MessageLinePriceVO;
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
@Service("egovMessageLinePriceService")
public class EgovMessageLinePriceServiceImpl extends EgovAbstractServiceImpl implements EgovMessageLinePriceService{

    
	 	@Resource(name = "MessageLinePriceDAO")
	    private MessageLinePriceDAO msglinepriceDAO;
	    

		@Override
		public MessageLinePriceVO selectMessageLinePrice() throws Exception {
			MessageLinePriceVO mlpVO = msglinepriceDAO.selectMessageLinePrice();
			return mlpVO;
		}
		
		@Override
		public void insertMessageLinePrice(MessageLinePriceVO mlpVO) throws Exception {
			msglinepriceDAO.insertMessageLinePrice(mlpVO);
		}

		@Override
		public Integer countRole() {
			// TODO Auto-generated method stub
			return msglinepriceDAO.countRole();
		}

		@Override
		public void updateMessageLinePrice(MessageLinePriceVO msglineconfVO) throws Exception {
			msglinepriceDAO.updateMessageLinePrice(msglineconfVO);
		}
}
