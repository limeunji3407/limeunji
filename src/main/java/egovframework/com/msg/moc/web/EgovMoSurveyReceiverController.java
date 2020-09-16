package egovframework.com.msg.moc.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.msg.moc.service.EgovMoSurveyReceiverService;
import egovframework.com.msg.moc.service.MoSurveyReceiverVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class EgovMoSurveyReceiverController {
	
	@Resource(name = "egovMoSurveyReceiverService")
    private EgovMoSurveyReceiverService moSurveyReceiverService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;
	
	/* 민원 답변에 대한 목록을 조회한다. */
	@IncludedInfo(name="민원 답변관리", order=380, gid=40)
	@RequestMapping("/usr/MoSurveyReceiverList.do")
	public ModelAndView moSurveyReceiverList(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<MoSurveyReceiverVO> moSurveyReceiverList = moSurveyReceiverService.moSurveyReceiverList(moSurveyReceiverVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(moSurveyReceiverVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(moSurveyReceiverVO.getPageUnit());
        paginationInfo.setPageSize(moSurveyReceiverVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("addrGroupList", moSurveyReceiverList);
        
        return mav;
	}
	
	/* 민원 답변에 대한 항목을 insert한다.*/
	@RequestMapping("/usr/MoSurveyReceiverInsert.do")
    public String moSurveyReceiverInsert(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception {
		
		//Transaction
  		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 		

  			moSurveyReceiverService.moSurveyReceiverInsert(moSurveyReceiverVO);
			
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
	
	/* 민원 답변에 대한 항목을 update 한다.*/
	@RequestMapping("/usr/MoSurveyReceiverUpdate.do")
    public String moSurveyReceiverUpdate(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception {
        
		moSurveyReceiverService.moSurveyReceiverUpdate(moSurveyReceiverVO);

        return "jsonView";
    }
	
	/* 민원 답변에 대한 항목을 delete 한다.*/
	@RequestMapping("/usr/MoSurveyReceiverDelete.do")
    public String moSurveyReceiverDelete(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception {
        
		moSurveyReceiverService.moSurveyReceiverDelete(moSurveyReceiverVO);

        return "jsonView";
    }

}
