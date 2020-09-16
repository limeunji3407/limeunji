package egovframework.com.bil.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import egovframework.com.bil.service.CashBillingVO;
import egovframework.com.bil.service.EgovCashBillingService;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EgovCashBillingController {

	@Resource(name = "EgovCashBillingService")
	private EgovCashBillingService cashBillingService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;
	
	/* 캐시에 대한 목록을 조회한다. */
	@IncludedInfo(name="캐시관리", order=380, gid=40)
	@RequestMapping("/bil/CashBillingList.do")
	public ModelAndView cashBillingList(CashBillingVO cashbillingVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<CashBillingVO> cashList = cashBillingService.cashBillingList(cashbillingVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(cashbillingVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(cashbillingVO.getPageUnit());
        paginationInfo.setPageSize(cashbillingVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("cashList", cashList);
        
        return mav;
	}
	
	/* 캐시에 대한 항목을 insert한다.*/
	@RequestMapping("/bil/CashBillingInsert.do")
    public String cashBillingInsert(CashBillingVO cashbillingVO) throws Exception {
		
		//Transaction
  		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 		

  			cashBillingService.cashBillingInsert(cashbillingVO);
			
			txManager.commit(txStatus); 
			//정상일경우 COMMIT; 
			//model.put("result", 0); 
  		} catch (Exception e) { 
			e.printStackTrace();
			txManager.rollback(txStatus); 
			//에러날경우 CATCH로 빠져서 ROLLBACK; 
			//model.put("result", -1); 
  		}


        return "jsonView";
    }
	
	/* 캐시에 대한 항목을 Selete One 한다.*/
	@RequestMapping("/bil/CashBillingSelectOne.do")
    public String cashBillingSelectOne(CashBillingVO cashbillingVO) throws Exception {
        
		cashBillingService.cashBillingSelectOne(cashbillingVO);

        return "jsonView";
    }
	
	/* 캐시에 대한 항목을 update 한다.*/
	@RequestMapping("/bil/CashBillingUpdate.do")
    public String cashBillingUpdate(CashBillingVO cashbillingVO) throws Exception {
        
		cashBillingService.cashBillingUpdate(cashbillingVO);

        return "jsonView";
    }
	
	/* 캐시에 대한 항목을 delete 한다.*/
	@RequestMapping("/bil/CashBillingDelete.do")
    public String cashBillingDelete(CashBillingVO cashbillingVO) throws Exception {
        
		cashBillingService.cashBillingDelete(cashbillingVO);

        return "jsonView";
    }
}
