package egovframework.com.bil.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.bil.service.CashBillingVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CashBillingDAO")
public class CashBillingDAO extends EgovComAbstractDAO {

	@SuppressWarnings({ "deprecation", "unchecked" })
	public List<CashBillingVO> cashBillingList(CashBillingVO cashBillingVO) throws Exception {
        return (List<CashBillingVO>) list("CashBillingDAO.cashBillingList", cashBillingVO);
    }
	
	public CashBillingVO cashBillingSelectOne(CashBillingVO cashBillingVO) throws Exception {
		
		return (CashBillingVO) selectOne("CashBillingDAO.cashBillingSelectOne", cashBillingVO);
    }
	
	public String cashBillingInsert(CashBillingVO cashBillingVO) throws Exception {
		
		return String.valueOf((int)insert("CashBillingDAO.cashBillingInsert", cashBillingVO));
    }

	public String cashBillingUpdate(CashBillingVO cashBillingVO) throws Exception {
		
		return String.valueOf((int)update("CashBillingDAO.cashBillingUpdate", cashBillingVO));
	}
	
	public String cashBillingDelete(CashBillingVO cashBillingVO) throws Exception {
		
		return String.valueOf((int)delete("CashBillingDAO.cashBillingDelete", cashBillingVO));
	}
}
