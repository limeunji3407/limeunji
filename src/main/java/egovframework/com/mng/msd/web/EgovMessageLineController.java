package egovframework.com.mng.msd.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.mng.mem.service.EgovMessageRoleService;
import egovframework.com.mng.mem.service.MessageRoleVO;
import egovframework.com.mng.msd.service.EgovMessageLineConfigService;
import egovframework.com.mng.msd.service.EgovMessageLinePriceService;
import egovframework.com.mng.msd.service.MessageLineConfigVO;
import egovframework.com.mng.msd.service.MessageLinePriceVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 주소록정보를 관리하기 위한 컨트롤러 클래스
 * @author 공통컴포넌트팀 윤성록
 * @since 2009.09.25
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.9.25  윤성록         최초 생성
 *   2011.8.26	정진오		  IncludedInfo annotation 추가
 *   2016.12.13 최두영         클래스명 변경
 * </pre>
 */

@Controller
public class EgovMessageLineController {

    @Resource(name = "egovMessageLineConfigService")
    private EgovMessageLineConfigService mlcfService;
    
    @Resource(name = "egovMessageLinePriceService")
    private EgovMessageLinePriceService mlpService;

    @Resource(name = "egovMessageRoleService")
    private EgovMessageRoleService mrService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;  
	
	 
	
    //@IncludedInfo(name="주소록관리", order = 380, gid = 40)
    @RequestMapping("/mng/setline.do")
    public ModelAndView selectMessageLineConfig(ModelMap model) throws Exception {
    	System.out.println("------------setline-----------라인설정 & 라인가격설정");
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        ModelAndView mav = new ModelAndView();

        if(!isAuthenticated) {
        	//String URL = "redirect:/index.do";
        	//return new ModelAndView(URL);
        	mav.setViewName("egovframework/com/uat/uia/EgovLoginUsr");
            return mav;
        	
/*        	RedirectView redirectView = new RedirectView("egovframework/com/uat/uia/actionLogout.do");
        	redirectView.setContextRelative(true);
        	  
        	ModelAndView mav1 = new ModelAndView(redirectView);
        	  
        	return mav1; */
        	//mav.setViewName("egovframework/com/uat/uia/actionLogout.do");
            //return mav;
        }
 
/*        adbkVO.setUser_id(user.getId());
        adbkVO.setPart_id(user.getOrgnztId());*/

        MessageLineConfigVO map = mlcfService.selectMessageLineConfig(); 
        MessageLinePriceVO mapp = mlpService.selectMessageLinePrice();
        
        if(map == null) {
            mav.addObject("sms", "M_GOV");
            mav.addObject("lms", "M_GOV");
            mav.addObject("mms", "M_GOV");
            mav.addObject("noti", "I-Heart(알림톡)");
            mav.addObject("renoti", "I-Heart");
            mav.addObject("frit", "I-Heart(친구톡)");
            mav.addObject("refri", "I-Heart");
        }else {
            mav.addObject("sms", map.getSms());
            mav.addObject("lms", map.getLms());
            mav.addObject("mms", map.getMms());
            mav.addObject("noti", map.getNoti());
            mav.addObject("renoti", map.getRenoti());
            mav.addObject("frit", map.getFrit());
            mav.addObject("refri", map.getRefri());
        }
        
        if(mapp == null) { 
            mav.addObject("psms", "9");
            mav.addObject("plms", "9");
            mav.addObject("pmms", "9");
            mav.addObject("pnotice", "8");
            mav.addObject("pfriend_txt", "8");
            mav.addObject("pfriend_img", "8");
            mav.addObject("psms_g", "7");
            mav.addObject("plms_g", "7");
            mav.addObject("pmms_g", "7");
        }else {
            mav.addObject("psms", mapp.getSms());
            mav.addObject("plms", mapp.getLms());
            mav.addObject("pmms", mapp.getMms());
            mav.addObject("pnotice", mapp.getNotice());
            mav.addObject("pfriend_txt", mapp.getFriend_txt());
            mav.addObject("pfriend_img", mapp.getFriend_img());
            mav.addObject("psms_g", mapp.getSms_g());
            mav.addObject("plms_g", mapp.getLms_g());
            mav.addObject("pmms_g", mapp.getMms_g());
        }
        mav.setViewName("egovframework/com/mng/msd/EgovSetLine");

        return mav;
    }

/*    @RequestMapping("/mng/insLineCfg.do")
    public ModelAndView insertMsgLineConf(MessageLineConfigVO msglinecfgvo) throws Exception {
    	System.out.println("-----------jsonView------ModelAndView---------return");
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject(msglinecfgvo);
    	return mav;
    }*/

    @RequestMapping("/mng/insLineCfgStr.do")
    public ModelAndView insertMsgLineConfString(MessageLineConfigVO cfgvo) throws Exception {
    	System.out.println("-----------jsonView------String---------return------" + cfgvo.getFrit());
    	ModelAndView mav = new ModelAndView("jsonView");
        
        int count = mlcfService.countRole();
        
        DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		TransactionStatus txStatus = txManager.getTransaction(def); 
		try{ 		
				if(count == 0) {
					mlcfService.insertMessageLineConfig(cfgvo);
				}else{
					mlcfService.updateMessageLineConfig(cfgvo);
				}
				
				
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

        return mav;
    }
    

    
    @RequestMapping(value="/mng/insLinePriceStr.do", method=RequestMethod.POST)
   public ModelAndView insertMsgLinePriceString(MessageLinePriceVO mpvo) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
        
        int count = mlpService.countRole();
        System.out.println("getFriend_img :: "+mpvo.getFriend_img());
        System.out.println("getFriend_txt :: "+mpvo.getFriend_txt());
        DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		TransactionStatus txStatus = txManager.getTransaction(def); 
		try{ 		
				if(count == 0) {
					mlpService.insertMessageLinePrice(mpvo);
				}else{
					mlpService.updateMessageLinePrice(mpvo);
				}
				
				
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

        return mav;
    }
    
    
    @RequestMapping(value="/mng/insertMessageLineConfigx.do", method=RequestMethod.POST)
    @ResponseBody
    public String insertMessageLineConfig(@RequestBody String msessageLine , @ModelAttribute("MessageLineConfigVO") MessageLineConfigVO msgLineConfvo, BindingResult bindingResult, Model model, HttpServletRequest hReq) throws Exception {

    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "forward:/index.do";
		} 	
		
		
		//Transaction
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		TransactionStatus txStatus = txManager.getTransaction(def); 
		try{ 		


				txManager.commit(txStatus); 
				//정상일경우 COMMIT; 
				//model.put("result", 0); 
		} catch (Exception e) { 
				e.printStackTrace(); 
				txManager.rollback(txStatus); 
				//에러날경우 CATCH로 빠져서 ROLLBACK; 
				//model.put("result", -1); 
		}
 

		//if ("".equals(msgLineConfvo.getGroupId())) {//KISA 보안약점 조치 (2018-10-29, 윤창원)
		//	msgLineConfvo.setGroupId(null);
		//}
		String userid = user.getId();
		


		String result = mlcfService.insertMessageLineConfig(msgLineConfvo);
		//result = mlcfService.updateMessageLineConfig(msgLineConfvo);
		if(result.equals("1")) {
			model.addAttribute("resultMsg", result);
		}else {
			model.addAttribute("resultMsg", result);
			//return "ERROR";
		} 
		return "forward:/mng/setline.do";
    }
}
