package egovframework.com.msg.moc.web;

import java.util.List;

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
import egovframework.com.msg.moc.service.ComplainMemo;
import egovframework.com.msg.moc.service.EgovMessagingMoComplainService;
import egovframework.com.msg.moc.service.MessagingMoComplainVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EgovMessagingMoComplainController {

	@Resource(name = "egovMessagingMoComplainService")
    private EgovMessagingMoComplainService messagingMoComplainService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;

    
    /* 사용자 민원수신,문자투표 */
    @RequestMapping("/usr/complain.do")
	public ModelAndView complainU(MessagingMoComplainVO messagingMoComplainVO, HttpSession session) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	LoginVO login = (LoginVO)session.getAttribute("loginVO");
    	
    	mav.addObject("userName", login.getName());
    	mav.setViewName("egovframework/com/usr/moc/EgovComplainU");
    	
        return mav;
	}
    @RequestMapping("/usr/molist.do")
	public String rcvlistU(MessagingMoComplainVO messagingMoComplainVO) throws Exception {

        return "egovframework/com/usr/moc/EgovMoListU";
	}
    
    @RequestMapping("/moComMemoInsert.do")
    public ModelAndView moComMemoInsert(ComplainMemo complainMemo, HttpSession session) throws Exception{
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	LoginVO login = (LoginVO)session.getAttribute("loginVO");
    	
    	complainMemo.setUser_id(login.getId());
    	complainMemo.setUser_name(login.getName());
    	
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			messagingMoComplainService.moComMemoInsert(complainMemo);
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
    
    @RequestMapping("/moComMemoSelect.do")
    public ModelAndView moComMemoSelect(ComplainMemo complainMemo, HttpSession session) throws Exception{
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	LoginVO login = (LoginVO) session.getAttribute("loginVO");
    	
    	String moKey = complainMemo.getMo_key();
  		
  		List<ComplainMemo> list = messagingMoComplainService.moComMemoSelect(moKey);
  		MessagingMoComplainVO answer = messagingMoComplainService.moComAnswerSelect(moKey);
  		
  		for(int i=0; i<list.size(); i++) {
  			ComplainMemo memo = list.get(i);
  			memo.setCheck_name(login.getName());
  		}
  		
  		mav.addObject("memo", list);
  		mav.addObject("answer", answer);
    	
    	return mav;
    }
    
    @RequestMapping("/moComMemoDelete.do")
    public ModelAndView moComMemoDelete(ComplainMemo complainMemo, HttpSession session) throws Exception{
    	ModelAndView mav = new ModelAndView("jsonView");
    	LoginVO login = (LoginVO)session.getAttribute("loginVO");
    	
    	ComplainMemo name = messagingMoComplainService.moComMemoSelectName(complainMemo.getMemo_seq());
    	
    	if(name.getUser_name().equalsIgnoreCase(login.getName())) {
    		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
      		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
      		TransactionStatus txStatus = txManager.getTransaction(def); 
      		try{ 	
      			messagingMoComplainService.moComMemoDelete(complainMemo.getMemo_seq());
    			txManager.commit(txStatus);
    			//정상일경우 COMMIT; 
    			mav.addObject("data", 0);
      		} catch (Exception e) { 
    			//e.printStackTrace();
    			txManager.rollback(txStatus); 
    			//에러날경우 CATCH로 빠져서 ROLLBACK; 
    			mav.addObject("data", 1);
      		}
    	}else {
    		mav.addObject("data", 2);
    	}
  		
  		
    	
    	return mav;
    }
    
    @RequestMapping("/moComMemoUpdate.do")
    public ModelAndView moComMemoUpdate(ComplainMemo complainMemo, HttpSession session) throws Exception{
    	ModelAndView mav = new ModelAndView("jsonView");
    	LoginVO login = (LoginVO)session.getAttribute("loginVO");
    	
    	ComplainMemo name = messagingMoComplainService.moComMemoSelectName(complainMemo.getMemo_seq());
    	
    	if(name.getUser_name().equalsIgnoreCase(login.getName())) {
    		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
      		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
      		TransactionStatus txStatus = txManager.getTransaction(def); 
      		try{ 	
      			messagingMoComplainService.moComMemoUpdate(complainMemo);
    			txManager.commit(txStatus);
    			//정상일경우 COMMIT; 
    			mav.addObject("data", 0);
      		} catch (Exception e) { 
    			//e.printStackTrace();
    			txManager.rollback(txStatus); 
    			//에러날경우 CATCH로 빠져서 ROLLBACK; 
    			mav.addObject("data", 1);
      		}
    	}else {
    		mav.addObject("data", 2);
    	}
  		
  		
    	
    	return mav;
    }
    
    @RequestMapping("/moComAnswer.do")
    public ModelAndView moComAnswer(MessagingMoComplainVO messagingMoComplainVO, HttpSession session) throws Exception{
    	ModelAndView mav = new ModelAndView("jsonView");
    	LoginVO login = (LoginVO)session.getAttribute("loginVO");
    	
    	messagingMoComplainVO.setAnswer_id(login.getId());
    	messagingMoComplainVO.setAnswer_name(login.getName());
    	messagingMoComplainVO.setAnswer_partname(login.getOrgnztId());
    	
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			messagingMoComplainService.moComAnswer(messagingMoComplainVO);
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
    
    /*
     * 관리자 - 민원관리
     * 
     */
 
    @RequestMapping("/mng/complain.do")
	public String complain(MessagingMoComplainVO messagingMoComplainVO) throws Exception {

        return "egovframework/com/mng/moc/EgovComplain";
	}
    
    @RequestMapping("/getcomplain.do")   
 	public ModelAndView complainAjax(@ModelAttribute("searchVO") MessagingMoComplainVO messagingMoComplainVO) throws Exception {

 		ModelAndView mav = new ModelAndView("jsonView");
 		
 		 
         List<MessagingMoComplainVO> moList = messagingMoComplainService.messagingMoComplainList(messagingMoComplainVO);
         System.out.println("------EM_MO_TRAN:" + moList );
 		 PaginationInfo paginationInfo = new PaginationInfo();

         paginationInfo.setCurrentPageNo(messagingMoComplainVO.getPageIndex());
         paginationInfo.setRecordCountPerPage(messagingMoComplainVO.getPageUnit());
         paginationInfo.setPageSize(messagingMoComplainVO.getPageSize());
         
         mav.addObject("paginationInfo" , paginationInfo);
         mav.addObject("data", moList);  
         return mav;
 	}
  

    
    /*
     * MO_SURVEY_RECEIVER
     */
    
    @RequestMapping("/mng/molist.do")
	public String moList(MessagingMoComplainVO messagingMoComplainVO) throws Exception {

        return "egovframework/com/mng/moc/EgovMoList";
	}


    

    
    
    /*
     * MO_SURVEY_RECEIVER
     */
    @RequestMapping("/getmoreceivelist.do")   
	public ModelAndView moReceiveListAjax(MessagingMoComplainVO messagingMoComplainVO) throws Exception {

		ModelAndView mav = new ModelAndView("jsonView");
		
		 
        List<MessagingMoComplainVO> moList = messagingMoComplainService.messagingMoComplainList(messagingMoComplainVO);
        System.out.println("------EM_MO_TRAN:" + moList );
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(messagingMoComplainVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(messagingMoComplainVO.getPageUnit());
        paginationInfo.setPageSize(messagingMoComplainVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", moList); 
        return mav;
	}
    
    
    /**
     * 민원관리에 대한 목록을 조회한다.
     */
    @IncludedInfo(name="민원관리", order = 380, gid = 40)
    @RequestMapping("/usr/MessagingMoComplainList.do")
    public ModelAndView messagingMoComplainList(@ModelAttribute("searchVO") MessagingMoComplainVO messagingMoComplainVO, ModelMap model) throws Exception {
        
        ModelAndView mav = new ModelAndView("jsonView");

        List<MessagingMoComplainVO> moList = messagingMoComplainService.messagingMoComplainList(messagingMoComplainVO);

        mav.addObject("moList", moList);

        return mav;
    }
    
    @RequestMapping("/usr/MessagingMoComplainOne.do")
    public String messagingMoComplainOne(@ModelAttribute("searchVO") MessagingMoComplainVO messagingMoComplainVO, ModelMap model) throws Exception {
        
    	messagingMoComplainService.messagingMoComplainOne(messagingMoComplainVO);

        return "jsonView";
    }
}
