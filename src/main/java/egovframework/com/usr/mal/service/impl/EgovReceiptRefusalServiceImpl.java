package egovframework.com.usr.mal.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.usr.mal.service.EgovReceiptRefusalService;
import egovframework.com.usr.mal.service.ReceiptRefusalVO;
import egovframework.com.usr.mal.service.impl.ReceiptRefusalDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


@Service("egovReceiptRefusalService")
public class EgovReceiptRefusalServiceImpl extends EgovAbstractServiceImpl implements EgovReceiptRefusalService {
	
	@Resource(name = "ReceiptRefusalDAO")
    private ReceiptRefusalDAO rejtRcvDAO;
    
    @Resource(name = "egovAdbkIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "egovAdbkUserIdGnrService")
    private EgovIdGnrService idgenService2;
    
    /**
     * 수신거부 목록을 조회한다.
     * @param UsrAddressBookVO
     * @return  Map<String, Object>
     * @exception Exception
     */
	@Override
	public Map<String, Object> rejtRcvList(ReceiptRefusalVO usrRejtRcvVO) throws Exception {
        List<ReceiptRefusalVO> result = rejtRcvDAO.rejtRcvList(usrRejtRcvVO);

        int cnt = rejtRcvDAO.rejtRcvListCnt(usrRejtRcvVO);

        Map<String, Object> map = new HashMap<String, Object>();

        map.put("resultList", result);
        map.put("resultCnt", Integer.toString(cnt));

        return map;
	}
	
	/**
     * 수신거부 번호를 추가한다.
     * @param UsrAddressBookVO
     * @return  Map<String, Object>
     * @exception Exception
     */
    public String insertReceiptrefusal(ReceiptRefusalVO usrRejtRcvVO) throws Exception{
    	
    	String result = rejtRcvDAO.insertReceiptrefusal(usrRejtRcvVO);
		return result;
    }
    
    
    public String deleteReceiptrefusal(ReceiptRefusalVO usrRejtRcvVO) throws Exception{
    	
    	String result = rejtRcvDAO.deleteReceiptrefusal(usrRejtRcvVO);
		return result;
    }
}
