package egovframework.com.msg.moc.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.msg.moc.service.EgovMoNumberService;
import egovframework.com.msg.moc.service.MoNumber;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class EgovMoNumberController {
	
	@Resource(name = "egovMoNumberService")
    private EgovMoNumberService moNumberService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;
	
	/* 관리자 번호등록메뉴페이지 */
	@IncludedInfo(name="민원 및 문자투표에 대한 번호목록관리", order=2400, gid=1000)
	@RequestMapping("/mng/numberlist.do")
	public String moNumberList(MoNumber moNumber) throws Exception { 
        
		return "egovframework/com/mng/moc/EgovAddNumber";
	}
	
	/* 민원및문자투표에 대한 번호목록을 조회한다. */
	@RequestMapping("/mng/getnumberlist.do")
	public ModelAndView moNumberGetList(MoNumber moNumber) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<MoNumber> moNumberList = moNumberService.moNumberList(moNumber);
        System.out.println("------moNumberList:" + moNumberList); 
        mav.addObject("data", moNumberList);
        
        return mav;
	}
	
	
	
	/* 
	 * mo_number  mo_status  mo_number_sub  mo_type
	 * 번호등로  insert 
	 * 
	 * */	
	@RequestMapping("/mng/insertnumber.do")
	public ModelAndView moNumberSave (MoNumber mNum) throws Exception {
		ModelAndView modelAndView = new ModelAndView("jsonView");
		System.out.println("-------insertNumber : " + mNum.getMo_number() );
		
		MoNumber checkMoNum = moNumberService.searchMoNum(mNum);
		
		System.out.println(checkMoNum);
		
		if(checkMoNum==null) {
			DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	  		TransactionStatus txStatus = txManager.getTransaction(def); 
	  		try{ 	
	  			moNumberService.moNumberInsert(mNum);
				txManager.commit(txStatus);
				//정상일경우 COMMIT; 
				modelAndView.addObject("data", 0);
	  		} catch (Exception e) { 
				//e.printStackTrace();
				txManager.rollback(txStatus); 
				//에러날경우 CATCH로 빠져서 ROLLBACK; 
				modelAndView.addObject("data", 2);
	  		}
		}else {
			
			if(checkMoNum.getMo_status().equals("Y")) {
				modelAndView.addObject("data", 1);
			}else {
				DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		  		TransactionStatus txStatus = txManager.getTransaction(def); 
		  		try{ 	
		  			checkMoNum.setMo_status("Y");
		  			moNumberService.moNumberUpdate(checkMoNum);
					txManager.commit(txStatus);
					//정상일경우 COMMIT; 
					modelAndView.addObject("data", 0); 
		  		} catch (Exception e) { 
					//e.printStackTrace();
					txManager.rollback(txStatus); 
					//에러날경우 CATCH로 빠져서 ROLLBACK; 
					modelAndView.addObject("data", 2);
		  		}
			}
		}
	 
	  return modelAndView;
	}
	
	
	
	
	
	@RequestMapping("/mng/insertnumber2.do")
	public ModelAndView moNumberInsert(@ModelAttribute("MoNumber") MoNumber mNum, ModelMap model) throws Exception {
		
		
	    Map<String, String> resultMap = new HashMap<String, String>();
	    resultMap.put("result1", "mo_number");
	    resultMap.put("result2", "test222");
	 
	    ModelAndView modelAndView = new ModelAndView("jsonView",resultMap);
	    return modelAndView;
	    
	    
	//public String moNumberInsert(@ModelAttribute MoNumber mNum, Model model) throws Exception{ 
		
		/* String msessageLine , @ModelAttribute("MoNumber")  */
		/*System.out.println("-----moNumber : " + mNum);  */
	
 	//Transaction
/*  		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			//moNumberService.moNumberInsert(jsonObj);
			txManager.commit(txStatus);
			//정상일경우 COMMIT; 
			//model.addAttribute("result", 0); 
  		} catch (Exception e) { 
			//e.printStackTrace();
			txManager.rollback(txStatus); 
			//에러날경우 CATCH로 빠져서 ROLLBACK; 
			//model.addAttribute("result", -1);
  		}
 */ 
    }
	
	
	/*  delete 로 변경한다.*/
	@RequestMapping("/mng/numberdelete.do")
    public ModelAndView moNumberDelete(MoNumber moNumber) throws Exception {
        
		ModelAndView mav = new ModelAndView("jsonView");
		moNumber.setMo_status("N");
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			moNumberService.moNumberUpdate(moNumber);
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

}
