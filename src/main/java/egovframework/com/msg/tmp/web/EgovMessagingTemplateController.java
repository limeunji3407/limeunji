package egovframework.com.msg.tmp.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.mng.trs.service.EgovSenderKeyService;
import egovframework.com.mng.trs.service.SenderKeyVO;
import egovframework.com.msg.tmp.service.EgovMessagingTemplateService;
import egovframework.com.msg.tmp.service.MessagingTemplateVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class EgovMessagingTemplateController {
	
	@Resource(name = "egovMessagingTemplateService")
    private EgovMessagingTemplateService messagingTemplateService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;  
    
    @Resource(name = "egovSenderKeyService")
    private EgovSenderKeyService senderKeyService;
    
    /**
     * 템플릿에 대한 목록을 조회한다.
     */
    @IncludedInfo(name="템플릿관리", order = 1000, gid = 100)
    @RequestMapping("/mng/template.do")
    public ModelAndView messagingTemplateList_S(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, SenderKeyVO searchVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
		List<SenderKeyVO> list = senderKeyService.selectSenderKeyList(searchVO);
		
		mav.addObject("senderKeyList", list);
		mav.setViewName("egovframework/com/mng/trs/EgovTemplate");
        return mav;
    }
    
    
    @RequestMapping("/usr/tempDetail.do")
    public ModelAndView messagingTemplateDetail(@RequestParam("tmpcode") String tmpcode, ModelMap model, SenderKeyVO searchVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	MessagingTemplateVO templateinfo = messagingTemplateService.templateDetail(tmpcode);
    	
    	String insStatus = templateinfo.getInspection_status();
    	
    	List<SenderKeyVO> senderKey = senderKeyService.selectSenderKeyList(searchVO);
    	
    	//REG:등록,REQ:검수요청,APR:승인,KRR:등록거절,REJ:승인반려,DEL:삭제
    	if(insStatus.equalsIgnoreCase("REG")) {
    		templateinfo.setInspection_status("등록");
    	}else if(insStatus.equalsIgnoreCase("REQ")) {
    		templateinfo.setInspection_status("검수요청");
    	}else if(insStatus.equalsIgnoreCase("APR")) {
    		templateinfo.setInspection_status("승인");
    	}else if(insStatus.equalsIgnoreCase("KRR")) {
    		templateinfo.setInspection_status("등록거절");
    	}else if(insStatus.equalsIgnoreCase("REJ")) {
    		templateinfo.setInspection_status("승인반려");
    	}else if(insStatus.equalsIgnoreCase("DEL")) {
    		templateinfo.setInspection_status("삭제");
    	}else {
    		templateinfo.setInspection_status(null);
    	}
    	
    	List<MessagingTemplateVO> tmpComment = messagingTemplateService.messagingTemplateComment(templateinfo.getTemplate_code());
    	
    	mav.addObject("tmpComment", tmpComment);
    	mav.addObject("templateinfo", templateinfo);
    	mav.addObject("senderKey", senderKey);
    	mav.setViewName("egovframework/com/usr/exe/EgovTemplateDetail");
        return mav;
    }
    
    @RequestMapping("/usr/templateUpdate.do")
    public ModelAndView messagingTemplateUpdate(@RequestParam("tmpcode") String tmpcode, ModelMap model, SenderKeyVO searchVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	MessagingTemplateVO templateinfo = messagingTemplateService.templateDetail(tmpcode);
    	
    	String insStatus = templateinfo.getInspection_status();
    	
    	List<SenderKeyVO> senderKey = senderKeyService.selectSenderKeyList(searchVO);
    	
    	//REG:등록,REQ:검수요청,APR:승인,KRR:등록거절,REJ:승인반려,DEL:삭제
    	if(insStatus.equalsIgnoreCase("REG")) {
    		templateinfo.setInspection_status("등록");
    	}else if(insStatus.equalsIgnoreCase("REQ")) {
    		templateinfo.setInspection_status("검수요청");
    	}else if(insStatus.equalsIgnoreCase("APR")) {
    		templateinfo.setInspection_status("승인");
    	}else if(insStatus.equalsIgnoreCase("KRR")) {
    		templateinfo.setInspection_status("등록거절");
    	}else if(insStatus.equalsIgnoreCase("REJ")) {
    		templateinfo.setInspection_status("승인반려");
    	}else if(insStatus.equalsIgnoreCase("DEL")) {
    		templateinfo.setInspection_status("삭제");
    	}else {
    		templateinfo.setInspection_status(null);
    	}
    	
    	List<MessagingTemplateVO> tmpComment = messagingTemplateService.messagingTemplateComment(templateinfo.getTemplate_code());
    	
    	mav.addObject("tmpComment", tmpComment);
    	mav.addObject("templateinfo", templateinfo);
    	mav.addObject("senderKey", senderKey);
    	mav.setViewName("egovframework/com/usr/exe/EgovTemplateUpdate");
        return mav;
    }
    
    @RequestMapping("/mng/templateDetail.do")
    public ModelAndView mngTemplateDetail(@RequestParam("tmpcode") String tmpcode, ModelMap model, SenderKeyVO searchVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	MessagingTemplateVO templateinfo = messagingTemplateService.templateDetail(tmpcode);
    	
    	String insStatus = templateinfo.getInspection_status();
    	
    	List<SenderKeyVO> senderKey = senderKeyService.selectSenderKeyList(searchVO);
    	
    	//REG:등록,REQ:검수요청,APR:승인,KRR:등록거절,REJ:승인반려,DEL:삭제
    	if(insStatus.equalsIgnoreCase("REG")) {
    		templateinfo.setInspection_status("등록");
    	}else if(insStatus.equalsIgnoreCase("REQ")) {
    		templateinfo.setInspection_status("검수요청");
    	}else if(insStatus.equalsIgnoreCase("APR")) {
    		templateinfo.setInspection_status("승인");
    	}else if(insStatus.equalsIgnoreCase("KRR")) {
    		templateinfo.setInspection_status("등록거절");
    	}else if(insStatus.equalsIgnoreCase("REJ")) {
    		templateinfo.setInspection_status("승인반려");
    	}else if(insStatus.equalsIgnoreCase("DEL")) {
    		templateinfo.setInspection_status("삭제");
    	}else {
    		templateinfo.setInspection_status(null);
    	}
    	
    	List<MessagingTemplateVO> tmpComment = messagingTemplateService.messagingTemplateComment(templateinfo.getTemplate_code());
    	
    	mav.addObject("tmpComment", tmpComment);
    	mav.addObject("templateinfo", templateinfo);
    	mav.addObject("senderKey", senderKey);
    	mav.setViewName("egovframework/com/mng/trs/EgovTemplateDetail");
        return mav;
    }
    
    /**
     * 템플릿에 대한 목록을 조회한다.
     */
    @RequestMapping("/getTemplate")
    public ModelAndView messagingTemplateListAjax(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model) throws Exception {
        
        ModelAndView mav = new ModelAndView("jsonView");
        messagingTemplateVO.setPageSize(10);
        messagingTemplateVO.setPageIndex(1); 
        messagingTemplateVO.setPageSize(4);
        messagingTemplateVO.setRecordCountPerPage(4);
        
        System.out.println(messagingTemplateVO.getSubject());
        System.out.println(messagingTemplateVO.getTemplate_name());
        System.out.println(messagingTemplateVO.getTemplate_content());
        System.out.println(messagingTemplateVO.getUse_yn());
        System.out.println(messagingTemplateVO.getWork_seq());
        System.out.println(messagingTemplateVO.getInspection_status());
        
        List<MessagingTemplateVO> moList = messagingTemplateService.messagingTemplateList(messagingTemplateVO);
        System.out.println("---- GetTemplateList :" + moList );
        mav.addObject("data", moList);
        return mav;
    } 
 
    /**
     * 템플릿에 대한 목록을 조회한다.
     */
    @IncludedInfo(name="템플릿관리", order = 380, gid = 40)
    @RequestMapping("/usr/MessagingTemplateList.do")
    public ModelAndView messagingTemplateList(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model) throws Exception {
        
        ModelAndView mav = new ModelAndView("jsonView");
        List<MessagingTemplateVO> moList = messagingTemplateService.messagingTemplateList(messagingTemplateVO);
        System.out.println("---- /usr/MessagingTemplateList :" + moList );
        mav.addObject("data", moList);
        return mav;
    }
    
    /**
     * 템플릿 추가.
     */
    @RequestMapping("/insertTemplate.do")
    public ModelAndView insertTEmplate(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model, HttpSession session) throws Exception {
    	
    	LoginVO user = (LoginVO) session.getAttribute("loginVO");
    	
    	String user_id = user.getId();
    	
    	String butten = messagingTemplateVO.getTemplate_buttons().replaceAll("&quot;", "\"");
    	butten = butten.replaceAll("[\\[\\]]", "");
    	//butten = butten.replace("]", "");
    	
    	System.out.println("templet butten :: "+butten);
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	messagingTemplateVO.setReg_id(user_id);
    	messagingTemplateVO.setTemplate_buttons(butten);
        
    	//Transaction
	      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  messagingTemplateService.messagingTemplateInsert(messagingTemplateVO);
	            
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
    
    @RequestMapping("/updateTemplate.do")
    public ModelAndView updateTemplate(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model, HttpSession session) throws Exception {
    	
    	LoginVO user = (LoginVO) session.getAttribute("loginVO");
    	
    	String user_id = user.getId();
    	
    	String butten = messagingTemplateVO.getTemplate_modify_buttons().replaceAll("&quot;", "\"");
    	butten = butten.replaceAll("[\\[\\]]", "");
    	//butten = butten.replace("]", "");
    	
    	System.out.println("templet butten :: "+butten);
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	messagingTemplateVO.setMod_id(user_id);
    	messagingTemplateVO.setTemplate_modify_buttons(butten);
        
    	//Transaction
	      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  messagingTemplateService.messagingUpdateTemplate(messagingTemplateVO);
	            
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
    
    @RequestMapping("/tmpIquiry.do")
    public ModelAndView tmpIquiry(MessagingTemplateVO messagingTemplateVO, HttpSession session) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	LoginVO user = (LoginVO) session.getAttribute("loginVO");
    	
    	String user_id = user.getId();
    	//select tmp_code
    	String tmpCode = messagingTemplateService.selectTmpCode(messagingTemplateVO.getTemplate_data_seq());
    	//set tmp_code
    	messagingTemplateVO.setTemplate_code(tmpCode);
    	messagingTemplateVO.setMod_id(user_id);
    	
    	System.out.println("getTemplate_code :: "+messagingTemplateVO.getTemplate_code());
    	System.out.println("getMod_id :: "+messagingTemplateVO.getMod_id());
    	System.out.println("getContent :: "+messagingTemplateVO.getContent());
    	
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       
	    	  // insert comment
	    	  // update template
	    	  messagingTemplateService.tmpIquiryInsert(messagingTemplateVO);
	    	  messagingTemplateService.tmpIquiryUpdate(messagingTemplateVO);
	            
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
    
    @RequestMapping("/insertTemplateExcel.do")
    public ModelAndView insertTemplateExcel(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model, HttpSession session) throws Exception {
    	
    	LoginVO user = (LoginVO) session.getAttribute("loginVO");
    	
    	String user_id = user.getId();
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	messagingTemplateVO.setReg_id(user_id);
        
    	//Transaction
	      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  messagingTemplateService.messagingTemplateInsert(messagingTemplateVO);
	            
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
    
    @RequestMapping("/deleteTemplate.do")
    public ModelAndView deleteTemplate(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model, HttpSession session) throws Exception {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	System.out.println("deleteTemplate invoked ");
    	System.out.println("messagingTemplateVO.getInspection_status() :: "+messagingTemplateVO.getTemplate_data_seq());
    	LoginVO loginvo = (LoginVO)session.getAttribute("loginVO");
    	System.out.println("loginvo.getId() :: "+loginvo.getId());
    	messagingTemplateVO.setMod_id(loginvo.getId());
    	
    	System.out.println("messagingTemplateVO.getId() :: "+messagingTemplateVO.getMod_id());
    	System.out.println("messagingTemplateVO.seq() :: "+messagingTemplateVO.getTemplate_data_seq());
    	
		//Transaction
	      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       
	
	    	  messagingTemplateService.messagingTemplateDelete(messagingTemplateVO);
	            
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
    
    /*
     * 템플릿 코드 중복체크
     * */
    @RequestMapping("/tmpCodeCheck.do")
    public ModelAndView tmpCodeCheck(@RequestParam Map<String, Object> commandMap) throws Exception{
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	String checkCode = (String) commandMap.get("checkcode");
    	
    	Integer check = messagingTemplateService.messagingTemplateCheckCode(checkCode);
    	
    	if(check==0) {
    		mav.addObject("data", 0);
    	}else {
    		mav.addObject("data", 1);
    	}
    	
    	return mav;
    }
    
    
    /**
     * 템플릿 삭제.
     */
    @RequestMapping("/usr/MessagingTemplateDelete.do")
    public String messagingTemplateDelete(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model) throws Exception {
        
    	messagingTemplateService.messagingTemplateDelete(messagingTemplateVO);

        return "jsonView";
    }
    
    /**
     * 템플릿 추가.
     */
    @RequestMapping("/usr/MessagingTemplateInsert.do")
    public String messagingTemplateInsert(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model) throws Exception {
        
    	messagingTemplateService.messagingTemplateInsert(messagingTemplateVO);

        return "jsonView";
    }

    /**
     * 템플릿 업무분류 변경.
     */
    @RequestMapping("/usr/MessagingTemplateUpdateWorkSeq.do")
    public ModelAndView messagingTemplateUpdateWorkSeq(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model) throws Exception {
        
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  messagingTemplateService.messagingTemplateUpdateWorkSeq(messagingTemplateVO);
	            
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
    
    /**
     * 템플릿 사용여부 변경.
     */
    @RequestMapping("/usr/MessagingTemplateUpdateUseYn.do")
    public ModelAndView messagingTemplateUpdateUseYn(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model) throws Exception {
        
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  messagingTemplateService.messagingTemplateUpdateUseYn(messagingTemplateVO);
	            
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
    
    /**
     * 템플릿 종류 변경.
     */
    @RequestMapping("/usr/MessagingTemplateUpdateTemplateType.do")
    public ModelAndView messagingTemplateUpdateTemplateType(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model) throws Exception {
        
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  messagingTemplateService.messagingTemplateUpdateTemplateType(messagingTemplateVO);
	            
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
    
    /**
     * 템플릿 제목 변경.
     */
    @RequestMapping("/usr/MessagingTemplateUpdateSubject.do")
    public ModelAndView messagingTemplateUpdateSubject(@ModelAttribute("searchVO") MessagingTemplateVO messagingTemplateVO, ModelMap model) throws Exception {
        
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  messagingTemplateService.messagingTemplateUpdateSubject(messagingTemplateVO);
	            
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
}
