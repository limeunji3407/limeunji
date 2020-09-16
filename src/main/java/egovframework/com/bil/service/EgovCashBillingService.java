package egovframework.com.bil.service;

import java.util.List;

public interface EgovCashBillingService {
	
	public List<CashBillingVO> cashBillingList(CashBillingVO cashbillingVO) throws Exception;
    
	public String cashBillingInsert(CashBillingVO cashbillingVO) throws Exception;
	
	public CashBillingVO cashBillingSelectOne(CashBillingVO cashbillingVO) throws Exception;
	
	public String cashBillingUpdate(CashBillingVO cashbillingVO) throws Exception;
	
	public String cashBillingDelete(CashBillingVO cashbillingVO) throws Exception;
}
