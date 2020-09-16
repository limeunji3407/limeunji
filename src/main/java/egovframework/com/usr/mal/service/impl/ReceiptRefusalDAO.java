package egovframework.com.usr.mal.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.usr.mal.service.ReceiptRefusalVO;


@Repository("ReceiptRefusalDAO")
public class ReceiptRefusalDAO extends EgovComAbstractDAO{

	
	/**
     * 주어진 조건에 따른 수신거부목록을 불러온다.
     * 
     * @param ReceiptRefusalVO
     * @return
     * @throws Exception
     */
	@SuppressWarnings({ "deprecation", "unchecked" })
	public List<ReceiptRefusalVO> rejtRcvList(ReceiptRefusalVO usrRejtRcvVO) throws Exception {
        return (List<ReceiptRefusalVO>) list("ReceiptRefusalDAO.rejtRcvList", usrRejtRcvVO);
    }
	
    /**
     * 수신거부 목록에 대한 전체 건수를 조회한다.
     * 
     * @param UsrRejtRcv
     * @throws Exception
     */
    public int rejtRcvListCnt(ReceiptRefusalVO usrRejtRcvVO) throws Exception {
        return (Integer)selectOne("ReceiptRefusalDAO.rejtRcvListCnt", usrRejtRcvVO);
    }
    
    
    /**
     * 수신거부 번호를 추가한다.
     * @param UsrRejtRcv
     */
    public String insertReceiptrefusal(ReceiptRefusalVO usrRejtRcvVO) throws Exception{
    	
    	return String.valueOf((int)insert("ReceiptRefusalDAO.insertReceiptrefusal", usrRejtRcvVO));
    }
    
    public String deleteReceiptrefusal(ReceiptRefusalVO usrRejtRcvVO) throws Exception{
    	
    	return String.valueOf((int)update("ReceiptRefusalDAO.deleteReceiptrefusal", usrRejtRcvVO));
    }
}
