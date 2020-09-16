package egovframework.com.mng.pwd.web;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.mng.pwd.service.EgovPwdConfigService;
import egovframework.com.mng.pwd.service.PasswordSetVO;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.uss.umt.service.UserDefaultVO;


@Controller
public class EgovPwdConfigController {
	
	@Resource(name = "egovPwdConfigService")
    private EgovPwdConfigService pwdConfigService;
    
    /** DefaultBeanValidator beanValidator */
	/*@Autowired
	private DefaultBeanValidator beanValidator;*/
	
	@Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;
	
	@RequestMapping(value = "/mng/passwordconfig.do")	
	public ModelAndView updatePasswordView(ModelMap model, @RequestParam Map<String, Object> commandMap, @ModelAttribute("searchVO") UserDefaultVO userSearchVO,
			@ModelAttribute("mberManageVO") MberManageVO mberManageVO) throws Exception {

		ModelAndView mav = new ModelAndView();
		
		PasswordSetVO pwSet = pwdConfigService.pwSet();
		mav.addObject("pwSet", pwSet);
		mav.setViewName("egovframework/com/mng/sts/EgovPasswordConfig");
		return mav;
	}
	
	/* pw 패턴에 대한 항목을 insert한다.*/
	@RequestMapping(value = "/mng/updatePwSet.do", method=RequestMethod.POST)
    public ModelAndView pwdConfigInsert(PasswordSetVO passwordSetVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		PasswordSetVO pwSet = pwdConfigService.pwSet();
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		passwordSetVO.setAdminid(user.getId());
		
		//Transaction
  		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def);
		if(pwSet.getPwdPattern()==null) {
			
	  		try{ 		

	  			pwdConfigService.pwdConfigInsert(passwordSetVO);
				
				txManager.commit(txStatus); 
				//정상일경우 COMMIT; 
				//model.put("result", 0); 
				mav.addObject("data", 0);
	  		} catch (Exception e) { 
				e.printStackTrace();
				txManager.rollback(txStatus); 
				//에러날경우 CATCH로 빠져서 ROLLBACK; 
				//model.put("result", -1); 
				mav.addObject("data", 1);
	  		}
		}else if(pwSet.getPwdPattern()!=null){

	  		try{ 		

	  			pwdConfigService.pwdConfigUpdate(passwordSetVO);
				
				txManager.commit(txStatus); 
				//정상일경우 COMMIT; 
				//model.put("result", 0); 
				mav.addObject("data", 0);
	  		} catch (Exception e) { 
				e.printStackTrace();
				txManager.rollback(txStatus); 
				//에러날경우 CATCH로 빠져서 ROLLBACK; 
				//model.put("result", -1); 
				mav.addObject("data", 1);
	  		}
		}
        return mav;
    }
}
