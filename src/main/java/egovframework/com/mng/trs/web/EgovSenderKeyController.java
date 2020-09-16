package egovframework.com.mng.trs.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.mng.trs.service.EgovSenderKeyService;
import egovframework.com.mng.trs.service.SenderKeyDefaultVO;
import egovframework.com.mng.trs.service.SenderKeyVO;
import egovframework.com.uss.umt.service.DeptManageVO;
import egovframework.com.uss.umt.service.EgovDeptManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : SenderKeyController.java
 * @Description : SenderKey Controller class
 * @Modification Information
 *
 * @author Kim SuRo
 * @since 2020/03/21
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=SenderKeyVO.class)
public class EgovSenderKeyController {

    @Resource(name = "egovSenderKeyService")
    private EgovSenderKeyService senderKeyService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /* 부서원드옭을 위해 */
	@Resource(name = "egovDeptManageService")
	private EgovDeptManageService egovDeptManageService;


	/** Message ID Generation */
	//@Resource(name = "egovSenderKeytManageIdGnrService")
	//private EgovIdGnrService egovSenderKeyManageIdGnrService;
	
	@Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;   

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
    /**
	 * SENDER_KEY 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SenderKeyDefaultVO
	 * @return "/senderKey/SenderKeyList"
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/senderkey.do")
    public ModelAndView selectSenderKeyList_S(@ModelAttribute("searchVO") SenderKeyDefaultVO searchVO, 
    		DeptManageVO deptManageVO)
            throws Exception {
    	/*
    	*//** EgovPropertyService.sample *//*
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	*//** pageing *//*
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> senderKeyList = senderKeyService.selectSenderKeyList(searchVO);
        model.addAttribute("resultList", senderKeyList);
        
        int totCnt = senderKeyService.selectSenderKeyListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);*/
    	
    	ModelAndView mav = new ModelAndView();
		//List<?> departList = egovDeptManageService.selectDeptManageList(deptManageVO);
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);
			
		mav.setViewName("egovframework/com/mng/trs/EgovSenderKey");
		mav.addObject("partIdList", list);
        
        return mav;
    }
    
    

    @RequestMapping(value="/getSenderKey.do")
    public String selectSenderKeyListAjax(SenderKeyVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	
        List<?> senderKeyList = senderKeyService.selectSenderKeyList(searchVO);
        model.addAttribute("data", senderKeyList);
        System.out.println("-----------------GetSenderKeyList---------------------" + senderKeyList );
        
        return "jsonView";
    }
    
    
    
    /**
	 * SENDER_KEY 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SenderKeyDefaultVO
	 * @return "/senderKey/SenderKeyList"
	 * @exception Exception
	 */
    @RequestMapping(value="/senderKey/SenderKeyList.do")
    public String selectSenderKeyList(@ModelAttribute("searchVO") SenderKeyDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> senderKeyList = senderKeyService.selectSenderKeyList(searchVO);
        model.addAttribute("resultList", senderKeyList);
        
        int totCnt = senderKeyService.selectSenderKeyListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/senderKey/SenderKeyList";
    }
    
    
    
    @RequestMapping("/senderKey/addSenderKeyView.do")
    public String addSenderKeyView(
            @ModelAttribute("searchVO") SenderKeyDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("senderKeyVO", new SenderKeyVO());
        return "/senderKey/SenderKeyRegister";
    }
    
    @RequestMapping("/senderKey/addSenderKey.do")
    public String addSenderKey(
            SenderKeyVO senderKeyVO,
            @ModelAttribute("searchVO") SenderKeyDefaultVO searchVO, SessionStatus status)
            throws Exception {
        senderKeyService.insertSenderKey(senderKeyVO);
        status.setComplete();
        return "forward:/senderKey/SenderKeyList.do";
    }
    
    
    @RequestMapping("/mng/insSenderKey.do")
    public ModelAndView addSenderKeyAjax(SenderKeyVO senderKeyVO, SessionStatus status,  ModelMap model)
            throws Exception {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	/*String seq = "11111"; //egovSenderKeyManageIdGnrService.getNextStringId();
    	BigDecimal seqB = new BigDecimal(seq); 
    	senderKeyVO.setSenderKeySeq(seqB);*/
    	
    	senderKeyVO.setUseYn("Y");
    	
    	//Transaction
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
    	TransactionStatus txStatus = txManager.getTransaction(def); 
    	try{ 		

            senderKeyService.insertSenderKey(senderKeyVO);
            status.setComplete();
    			
    			txManager.commit(txStatus); 
    			//model.addAttribute("result", egovMessageSource.getMessage("success.common.insert"));
    			//정상일경우 COMMIT; 
    			//model.put("result", 0); 
    			mav.addObject("data", 0);
    	} catch (Exception e) { 
    			e.printStackTrace();
    			txManager.rollback(txStatus); 
    			//model.addAttribute("result", egovMessageSource.getMessage("success.error.insert"));
    			//에러날경우 CATCH로 빠져서 ROLLBACK; 
    			//model.put("result", -1); 
    			mav.addObject("data", 1);
    	}
    	
    	return mav;
    	
    	
    	

        //return "forward:/mng/.do";
        //return "egovframework/com/mng/trs/EgovSenderKey";
    }
 

	
    @RequestMapping("/mng/delSenderKey.do")
    public ModelAndView delSenderKeyAjax(SenderKeyVO senderKeyVO, SessionStatus status,  ModelMap model)
            throws Exception {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
    	TransactionStatus txStatus = txManager.getTransaction(def); 
    	try{ 		

            senderKeyService.deleteSenderKey(senderKeyVO);
    			
    			txManager.commit(txStatus); 
    			//model.addAttribute("result", egovMessageSource.getMessage("success.common.insert"));
    			//정상일경우 COMMIT; 
    			//model.put("result", 0); 
    			mav.addObject("data", 0);
    	} catch (Exception e) { 
    			e.printStackTrace();
    			txManager.rollback(txStatus); 
    			//model.addAttribute("result", egovMessageSource.getMessage("success.error.insert"));
    			//에러날경우 CATCH로 빠져서 ROLLBACK; 
    			//model.put("result", -1); 
    			mav.addObject("data", 1);
    	}
    	
    	return mav;
    	
    	
    	

        //return "forward:/mng/.do";
        //return "egovframework/com/mng/trs/EgovSenderKey";
    }
    
    @RequestMapping("/mng/updSenderKey.do")
    public ModelAndView updSenderKeyAjax(SenderKeyVO senderKeyVO, SessionStatus status,  ModelMap model)
            throws Exception {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
    	TransactionStatus txStatus = txManager.getTransaction(def); 
    	try{ 		

            senderKeyService.updateSenderKey(senderKeyVO);
    			
    			txManager.commit(txStatus); 
    			//model.addAttribute("result", egovMessageSource.getMessage("success.common.insert"));
    			//정상일경우 COMMIT; 
    			//model.put("result", 0); 
    			mav.addObject("data", 0);
    	} catch (Exception e) { 
    			e.printStackTrace();
    			txManager.rollback(txStatus); 
    			//model.addAttribute("result", egovMessageSource.getMessage("success.error.insert"));
    			//에러날경우 CATCH로 빠져서 ROLLBACK; 
    			//model.put("result", -1); 
    			mav.addObject("data", 1);
    	}
    	
    	return mav;
    	
    	
    	

        //return "forward:/mng/.do";
        //return "egovframework/com/mng/trs/EgovSenderKey";
    }
    
    
    
    
    
/*    
    public String addUser(@ModelAttribute("searchVO") AddressBookVO adbkVO,  HttpServletRequest request) throws Exception {

        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        if(!isAuthenticated) {
            return "egovframework/com/uat/uia/EgovLoginUsr";
        }

        adbkService.insertAddressBook(adbkVO);

        return "egovframework/com/usr/add/EgoInsAddr";
    } */ 
    
    
    @RequestMapping("/senderKey/updateSenderKeyView.do")
    public String updateSenderKeyView(
            @RequestParam("senderKeySeq") Integer senderKeySeq ,
            @ModelAttribute("searchVO") SenderKeyDefaultVO searchVO, Model model)
            throws Exception {
        SenderKeyVO senderKeyVO = new SenderKeyVO();
        senderKeyVO.setSenderKeySeq(senderKeySeq);
        // 변수명은 CoC 에 따라 senderKeyVO
        model.addAttribute(selectSenderKey(senderKeyVO, searchVO));
        return "/senderKey/SenderKeyRegister";
    }

    @RequestMapping("/senderKey/selectSenderKey.do")
    public @ModelAttribute("senderKeyVO")
    SenderKeyVO selectSenderKey(
            SenderKeyVO senderKeyVO,
            @ModelAttribute("searchVO") SenderKeyDefaultVO searchVO) throws Exception {
        return senderKeyService.selectSenderKey(senderKeyVO);
    }

    @RequestMapping("/senderKey/updateSenderKey.do")
    public String updateSenderKey(
            SenderKeyVO senderKeyVO,
            @ModelAttribute("searchVO") SenderKeyDefaultVO searchVO, SessionStatus status)
            throws Exception {
        senderKeyService.updateSenderKey(senderKeyVO);
        status.setComplete();
        return "forward:/senderKey/SenderKeyList.do";
    }
    
    @RequestMapping("/senderKey/deleteSenderKey.do")
    public String deleteSenderKey(
            SenderKeyVO senderKeyVO,
            @ModelAttribute("searchVO") SenderKeyDefaultVO searchVO, SessionStatus status)
            throws Exception {
        senderKeyService.deleteSenderKey(senderKeyVO);
        status.setComplete();
        return "forward:/senderKey/SenderKeyList.do";
    }

}
