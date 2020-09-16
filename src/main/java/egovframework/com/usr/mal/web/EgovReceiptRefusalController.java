package egovframework.com.usr.mal.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.msg.rcv.service.EgovRcvaddrListService;
import egovframework.com.msg.rcv.service.RcvaddrListVO;
import egovframework.com.usr.mal.service.EgovReceiptRefusalService;
import egovframework.com.usr.mal.service.ReceiptRefusalVO;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EgovReceiptRefusalController {
	
	@Resource(name = "egovRcvaddrListService")
    private EgovRcvaddrListService rcvaddrListService;
	
	@Resource(name = "egovReceiptRefusalService")
    private EgovReceiptRefusalService rejtRcvService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;

    /**
     * 주소록 정보에 대한 목록을 조회한다.
     *
     * @param adbkVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @IncludedInfo(name="사용자수신거부목록", order = 380, gid = 40)
    @RequestMapping("/usr/receiptrefusalU.do")
    public String selectReceiptRefusalListU(@ModelAttribute("ReceiptRefusalVO") ReceiptRefusalVO usrRejtRcvVO, ModelMap model) throws Exception {
    	System.out.println("----receiptrefusalU: 사용자수신거부록록");
    	return "egovframework/com/usr/msg/EgovReceiptRefusalU";
    }
     
    @RequestMapping("/getreceiptrefusalU.do")
    public ModelAndView selectReceiptRefusalListUAjax(@ModelAttribute("ReceiptRefusalVO") ReceiptRefusalVO usrRejtRcvVO, ModelMap model) throws Exception {
    	
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        ModelAndView mav = new ModelAndView("jsonView");

        if(!isAuthenticated) {
            mav.addObject("data", "index.do");
            return mav;
        }

        usrRejtRcvVO.setPageUnit(propertyService.getInt("pageUnit"));
        usrRejtRcvVO.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(usrRejtRcvVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(usrRejtRcvVO.getPageUnit());
        paginationInfo.setPageSize(usrRejtRcvVO.getPageSize());

        usrRejtRcvVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        usrRejtRcvVO.setLastIndex(paginationInfo.getLastRecordIndex());
        usrRejtRcvVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        usrRejtRcvVO.setRecordCountPerPage(999);
        
        Map<String, Object> map = null;
        if(usrRejtRcvVO.getPartgRole() != null && "Y".equals(usrRejtRcvVO.getPartgRole())) {
			//부서장일경우
        	 
        	
        	RcvaddrListVO rcvLst = new RcvaddrListVO();
        	rcvLst.setOrgnztId(user.getOrgnztId());
        	
 			List<UserManageVO> userManageVOList = rcvaddrListService.rcvaddrListUserId(rcvLst);
 			usrRejtRcvVO.setUserManageVOList(userManageVOList);
        	 
		}else {
			 usrRejtRcvVO.setRegister_id(user.getId());
		}
        map = rejtRcvService.rejtRcvList(usrRejtRcvVO);
        
        
        int totCnt = Integer.parseInt((String)map.get("resultCnt"));
    	System.out.println("----getreceiptrefusalU: 사용자수신거부록록" + map.get("resultList"));

        paginationInfo.setTotalRecordCount(totCnt);

        mav.addObject("data",  map.get("resultList"));
        mav.addObject("resultCnt", map.get("resultCnt"));
        mav.addObject("userId", user.getId());
        mav.addObject("paginationInfo", paginationInfo);
 
    	return mav;
    }
    
    
    /* 관리자 수신거부목록 */
    @RequestMapping("/mng/receiptrefusal.do")
    public ModelAndView selectMngReceiptRefusalList(@ModelAttribute("ReceiptRefusalVO") ReceiptRefusalVO usrRejtRcvVO, ModelMap model) throws Exception {
    	
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        ModelAndView mav = new ModelAndView();

        if(!isAuthenticated) {
        	mav.setViewName("egovframework/com/uat/uia/EgovLoginUsr");
            return mav;
        }

        usrRejtRcvVO.setPageUnit(propertyService.getInt("pageUnit"));
        usrRejtRcvVO.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(usrRejtRcvVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(usrRejtRcvVO.getPageUnit());
        paginationInfo.setPageSize(usrRejtRcvVO.getPageSize());

        usrRejtRcvVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        usrRejtRcvVO.setLastIndex(paginationInfo.getLastRecordIndex());
        usrRejtRcvVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> map = rejtRcvService.rejtRcvList(usrRejtRcvVO);
        int totCnt = Integer.parseInt((String)map.get("resultCnt"));


        paginationInfo.setTotalRecordCount(totCnt);

        mav.addObject("resultList", map.get("resultList"));
        mav.addObject("resultCnt", map.get("resultCnt"));
        mav.addObject("userId", user.getId());
        mav.addObject("paginationInfo", paginationInfo);
        mav.setViewName("egovframework/com/mng/msd/EgovReceiptRefusal"); 

        return mav;
    }
    
    /*수신거부 추가*/
    @RequestMapping("/usr/InsertReceiptrefusalU.do")
	public ModelAndView InsertReceiptrefusal (ReceiptRefusalVO receiptRefusalVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	receiptRefusalVO.setRegister_id(user.getId());
    	receiptRefusalVO.setStatus(1);
    	
		System.out.println("-------insertNumber : " + receiptRefusalVO.getReject_phone() );
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			rejtRcvService.insertReceiptrefusal(receiptRefusalVO);
			txManager.commit(txStatus);
			//정상일경우 COMMIT; 
			//model.addAttribute("", 0); 
			mav.addObject("data", 0);
  		} catch (Exception e) { 
			//e.printStackTrace();
			txManager.rollback(txStatus); 
			//에러날경우 CATCH로 빠져서 ROLLBACK; 
			//model.addAttribute("data", -1);
			mav.addObject("data", 1);
  		}
	 
	  return mav;
	}
    
    @RequestMapping("/usr/DeleteReceiptrefusalU.do")
	public ModelAndView DeleteReceiptrefusal (ReceiptRefusalVO receiptRefusalVO, HttpSession session) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	LoginVO user = (LoginVO) session.getAttribute("loginVO");
    	
    	System.out.println("delete id :: "+receiptRefusalVO.getId());
    	
    	receiptRefusalVO.setCancel_id(user.getId());
    	
		System.out.println("-------getId : " + receiptRefusalVO.getId() );
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			rejtRcvService.deleteReceiptrefusal(receiptRefusalVO);
			txManager.commit(txStatus);
			//정상일경우 COMMIT; 
			//model.addAttribute("", 0); 
			mav.addObject("data", 0);
  		} catch (Exception e) { 
			//e.printStackTrace();
			txManager.rollback(txStatus); 
			//에러날경우 CATCH로 빠져서 ROLLBACK; 
			//model.addAttribute("data", -1);
			mav.addObject("data", 1);
  		}
	 
	  return mav;
	}
}
