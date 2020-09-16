package egovframework.com.mng.mem.web;

import java.util.List;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.mng.mem.service.BasicCashLevelVO;
import egovframework.com.mng.mem.service.EgovBasicCashLevelService;
import egovframework.com.uss.ion.bnr.service.Banner;
import egovframework.rte.fdl.property.EgovPropertyService;
import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * 사용자 캐쉬(건)
 * @author 김수로
 * @since 2020.02.29
 * @version 1.0
 * @see
 *
 */

@Controller
public class EgovBasicCashLevelController {

	/** userManageService */
	@Resource(name = "egovBasicCashLevelService")
	private EgovBasicCashLevelService basicCashLevelService;

	/** cmmUseService */
	@Resource(name = "egovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;
	/**
	 * 등급목록 (No Paging)
	 * @param userSearchVO 검색조건정보
	 * @param model 화면모델
	 * @return mng/mem/EgovCashLevel
	 * @throws Exception
	 */ 
	//@IncludedInfo(name = "등급부여", order = 990, gid = 50)
	@RequestMapping(value = "/mng/cashlevel.do")
	public String selectCashLevel(BasicCashLevelVO uCashLevelVO, ModelMap model) throws Exception {
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "index";
		} 
		return "egovframework/com/mng/mem/EgovBasicCashLevel"; 
	}  

	@RequestMapping(value = "/getCashlevel.do")
	public Object selectCashLevelajax(BasicCashLevelVO uCashLevelVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	String adminId = user.getId(); 
		List<?> cashLevelList = basicCashLevelService.selectBasicCashLevelList(adminId);  
		model.addAttribute("data", cashLevelList);
		return "jsonView"; 
	} 
	@RequestMapping(value = "/getCashlevelAll.do")
	public Object selectCashLevelajaxAll(BasicCashLevelVO uCashLevelVO, ModelMap model) throws Exception {
		List<?> cashLevelList = basicCashLevelService.selectBasicCashLevelListAll(uCashLevelVO.getUids());  
		model.addAttribute("data", cashLevelList);
		return "jsonView";
	} 
	

	@RequestMapping(value = "/mng/InsertcashLevel.do")
	public ModelAndView insertCashLevelajax(BasicCashLevelVO uCashLevelVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	uCashLevelVO.setUserid(user.getId());
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			basicCashLevelService.insertBasicCashLevel(uCashLevelVO);
			txManager.commit(txStatus);
			//정상일경우 COMMIT; 
			mav.addObject("data", 0);
  		} catch (Exception e) { 
			//e.printStackTrace();
			txManager.rollback(txStatus); 
			//에러날경우 CATCH로 빠져서 ROLLBACK; 
			mav.addObject("data", 1);
  		}
	    return mav; 
	}
	@RequestMapping(value = "/mng/DeleteLevel.do")
	public ModelAndView deleteCashLevelajax(@RequestParam int lvid ) throws Exception {
		
    	ModelAndView mav = new ModelAndView("jsonView");
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			basicCashLevelService.deleteBasicCashLevel(lvid);
			txManager.commit(txStatus);
			mav.addObject("data", 0);
  		} catch (Exception e) { 
			txManager.rollback(txStatus); 
			mav.addObject("data", 1);
  		}
	    return mav; 
	}  
	
	@RequestMapping(value="/mng/updateLevel.do")
	public ModelAndView updateBanners( BasicCashLevelVO basicCashLevelVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
    	TransactionStatus txStatus = txManager.getTransaction(def); 
    	try{ 	
    		basicCashLevelService.updateLevel(basicCashLevelVO);
    		txManager.commit(txStatus);
    		mav.addObject("data", 0);
    	} catch (Exception e) { 
    		txManager.rollback(txStatus); 
    		mav.addObject("data", 1);
    	}
    	return mav;
	}
	
}
