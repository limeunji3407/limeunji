package egovframework.com.usr.mal.service;

import java.util.Map;

public interface EgovReceiptRefusalService {
	
	/**
     * 수신거부 목록을 조회한다.
     * @param UsrAddressBookVO
     * @return  Map<String, Object>
     * @exception Exception
     */
    public Map<String, Object> rejtRcvList(ReceiptRefusalVO usrRejtRcvVO) throws Exception;
    
    /**
     * 수신거부 번호를 추가한다.
     * @param UsrAddressBookVO
     * @return  Map<String, Object>
     * @exception Exception
     */
    public String insertReceiptrefusal(ReceiptRefusalVO usrRejtRcvVO) throws Exception;

    public String deleteReceiptrefusal(ReceiptRefusalVO usrRejtRcvVO) throws Exception;
}
