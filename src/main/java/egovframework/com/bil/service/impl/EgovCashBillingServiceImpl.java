package egovframework.com.bil.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.bil.service.CashBillingVO;
import egovframework.com.bil.service.EgovCashBillingService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("EgovCashBillingService")
public class EgovCashBillingServiceImpl extends EgovAbstractServiceImpl implements EgovCashBillingService {
	
	@Resource(name = "CashBillingDAO")
    private CashBillingDAO cashBillingDAO;
    
    @Resource(name = "egovAdbkIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "egovAdbkUserIdGnrService")
    private EgovIdGnrService idgenService2;

	@Override
	public List<CashBillingVO> cashBillingList(CashBillingVO cashbillingVO) throws Exception {
		
		List<CashBillingVO> result = cashBillingDAO.cashBillingList(cashbillingVO);
		
		return result;
	}

	@Override
	public String cashBillingInsert(CashBillingVO cashbillingVO) throws Exception {
		
		String result = cashBillingDAO.cashBillingInsert(cashbillingVO);
		
		return result;
	}

	@Override
	public CashBillingVO cashBillingSelectOne(CashBillingVO cashbillingVO) throws Exception {
		
		CashBillingVO result = cashBillingDAO.cashBillingSelectOne(cashbillingVO);
		
		return result;
	}

	@Override
	public String cashBillingUpdate(CashBillingVO cashbillingVO) throws Exception {
		
		String result = cashBillingDAO.cashBillingUpdate(cashbillingVO);
		
		return result;
	}

	@Override
	public String cashBillingDelete(CashBillingVO cashbillingVO) throws Exception {
		
		String result = cashBillingDAO.cashBillingDelete(cashbillingVO);
		
		return result;
	}
}
