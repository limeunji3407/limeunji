package egovframework.com.msg.mop.web;

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
import egovframework.com.msg.mop.service.EgovMessagingMoPollService;
import egovframework.com.msg.mop.service.MessagingMoPollResponse;
import egovframework.com.msg.mop.service.MessagingMoPollVO;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EgovMessagingMoPollController {
	
	@Resource(name = "egovMessagingMoPollService")
    private EgovMessagingMoPollService messagingMoPollService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name = "userManageService")
	private EgovUserManageService userManageService;

	@Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;
 

    /****** 문자투표 메인 *****/
    @RequestMapping("/usr/poll.do")
	public String pollU(MessagingMoPollVO messagingMoPollVO) throws Exception {
    	System.out.println("--------usr/poll--------");
        return "egovframework/com/usr/moc/EgovPollU";
	}
    /******** 문자결과 **********/
    @RequestMapping("/usr/pollresult.do")
	public String pollresultU(MessagingMoPollVO messagingMoPollVO) throws Exception {

    	System.out.println("--------문자결과--------");
        return "egovframework/com/usr/moc/EgovPollResultU";
	}
    
    /********* 문자등록 및 리스트 *********/
    @RequestMapping("/usr/pollregist.do")
	public ModelAndView pollregistU(MessagingMoPollVO messagingMoPollVO, HttpSession session) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	System.out.println("-------문자등록 및 리스트--------");
    	
    	mav.addObject("userName", session.getAttribute("userName"));
    	mav.setViewName("egovframework/com/usr/moc/EgovPollListU");
        return mav;
	}
    
    
    
    
    
    @RequestMapping("/mng/poll.do")
	public String poll(MessagingMoPollVO messagingMoPollVO) throws Exception {

        return "egovframework/com/mng/moc/EgovPoll";
	}

    @RequestMapping("/mng/pollresult.do")
	public String pollResult(MessagingMoPollVO messagingMoPollVO) throws Exception {

        return "egovframework/com/mng/moc/EgovPollResult";
	}
    

    @RequestMapping("/mng/polllist.do")
	public ModelAndView polllist(MessagingMoPollVO messagingMoPollVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	mav.setViewName("egovframework/com/mng/moc/EgovPollList");

        return mav;
	}
    
    
    /*
     * 결과포함 문자투표리스트
     */
    @RequestMapping("/getpollresult.do")   
	public ModelAndView pollResultAjax(MessagingMoPollVO messagingMoPollVO, HttpSession session) throws Exception {

		ModelAndView mav = new ModelAndView("jsonView");
		

/*		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(); 
	    String userId = user.getId();  
	    
    	//관리자이면 세팅패스 
    	if( (user.getUserSe() != "admin" ) && userId != null)
    		messagingMoPollVO.setReg_user_id(userId);*/
		String userId = (String) session.getAttribute("userId");
		
		System.out.println("userId :: "+userId);
		
		messagingMoPollVO.setReg_user_id(userId);
		 
        List<MessagingMoPollVO> moList = messagingMoPollService.smsPollList(messagingMoPollVO);
        System.out.println("------MO_SURVEY_TB: Result -----" + moList );
        
        
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(messagingMoPollVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(messagingMoPollVO.getPageUnit());
        paginationInfo.setPageSize(messagingMoPollVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", moList); 
        return mav;
	}
    
    @RequestMapping("/mng/getpollresult.do")   
	public ModelAndView mngPollResultAjax(MessagingMoPollVO messagingMoPollVO, HttpSession session) throws Exception {

		ModelAndView mav = new ModelAndView("jsonView");
		

/*		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(); 
	    String userId = user.getId();  
	    
    	//관리자이면 세팅패스 
    	if( (user.getUserSe() != "admin" ) && userId != null)
    		messagingMoPollVO.setReg_user_id(userId);*/
		 
        List<MessagingMoPollVO> moList = messagingMoPollService.smsMngPollList(messagingMoPollVO);
        System.out.println("------MO_SURVEY_TB: Result -----" + moList );
        
        
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(messagingMoPollVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(messagingMoPollVO.getPageUnit());
        paginationInfo.setPageSize(messagingMoPollVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", moList); 
        return mav;
	}
    
    
    
    /*
     * 신규등록 문자투표리스트
     * 
     */
    @RequestMapping("/getpolllist.do")    
	public ModelAndView pollListAjax(MessagingMoPollVO messagingMoPollVO, HttpSession session) throws Exception {

		ModelAndView mav = new ModelAndView("jsonView");
		
/*		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	String userId = user.getId(); 
    	//관리자이면 세팅패스 
    	if( (user.getUserSe() != "admin" ) && userId != null)
    		messagingMoPollVO.setReg_user_id(userId);*/
		LoginVO login = (LoginVO) session.getAttribute("loginVO");
		messagingMoPollVO.setReg_user_id(login.getId());
		 
        List<MessagingMoPollVO> moList = messagingMoPollService.selectSmsPollNewList(messagingMoPollVO);
        System.out.println("------MO_SURVEY_TB: List --" + moList );
        
        
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(messagingMoPollVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(messagingMoPollVO.getPageUnit());
        paginationInfo.setPageSize(messagingMoPollVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", moList); 
        return mav;
	}
    
    @RequestMapping("/usr/pollResponseList.do")
    public ModelAndView pollResponseList(MessagingMoPollResponse messagingMoPollResponse) throws Exception{
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	List<MessagingMoPollResponse> list = messagingMoPollService.pollResponseList(messagingMoPollResponse);
    	
    	mav.addObject("list", list);
    	
    	return mav;
    }
    
	@RequestMapping("/usr/pollResponseListSelect.do")
    public ModelAndView pollResponseListSelect(MessagingMoPollResponse messagingMoPollResponse) throws Exception{
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	List<MessagingMoPollResponse> list = messagingMoPollService.pollResponseListSelect(messagingMoPollResponse);
    	
    	mav.addObject("list", list);
    	
    	return mav;
    }
    
    @RequestMapping("/mng/getpolllist.do")   
	public ModelAndView mngPollListAjax(MessagingMoPollVO messagingMoPollVO, HttpSession session) throws Exception {

		ModelAndView mav = new ModelAndView("jsonView");
		
/*		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	String userId = user.getId(); 
    	//관리자이면 세팅패스 
    	if( (user.getUserSe() != "admin" ) && userId != null)
    		messagingMoPollVO.setReg_user_id(userId);*/
		 
        List<MessagingMoPollVO> moList = messagingMoPollService.smsPollMngNewList(messagingMoPollVO);
        System.out.println("------MO_SURVEY_TB: List --" + moList );
        
        
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(messagingMoPollVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(messagingMoPollVO.getPageUnit());
        paginationInfo.setPageSize(messagingMoPollVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", moList); 
        return mav;
	}
 
    
    
    /*
     * 신규투표작성 Insert
     */
    @RequestMapping("/usr/insertpoll.do")
    public String InsertPoll(MessagingMoPollVO messagingMoPollVO, ModelMap model) throws Exception {
    	
    	System.out.println("--------InsertPoll : ");
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	String userid = user.getId();
    	messagingMoPollVO.setMod_user_id(userid);
    	
    	messagingMoPollService.insertMessagingMoNewPoll(messagingMoPollVO);

        return "jsonView";
    }
    
    @RequestMapping("/usr/deleteNewPoll.do")
    public ModelAndView DeletePoll(MessagingMoPollVO messagingMoPollVO, ModelMap model, HttpSession session) throws Exception {
    	
    	System.out.println("--------DeletePoll : ");
    	System.out.println("survey_seq :: "+messagingMoPollVO.getSurvey_seq());

    	ModelAndView mav = new ModelAndView("jsonView");
    	messagingMoPollVO.setDel_flag("Y");
    	
        //Transaction
      	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
      	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
      	TransactionStatus txStatus = txManager.getTransaction(def); 
      	try{ 		

      		messagingMoPollService.updateMessagingMoNewPollDel(messagingMoPollVO);     				
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
     * 문자투표에 대한 목록을 조회한다.
     *
     * @param adbkVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @IncludedInfo(name="문자투표관리", order = 380, gid = 40)
    @RequestMapping("/usr/MessagingMoPollList.do")
    public ModelAndView selectSmsPollList(@ModelAttribute("searchVO") MessagingMoPollVO messagingMoPollVO, ModelMap model) throws Exception {
        
        ModelAndView mav = new ModelAndView("jsonView");

        List<MessagingMoPollVO> moList = messagingMoPollService.smsPollList(messagingMoPollVO);

        mav.addObject("moList", moList);

        return mav;
    }

    @RequestMapping("/usr/MessagingMoPollSelectOne.do")
    public ModelAndView selectOneSmsPoll(@ModelAttribute("searchVO") MessagingMoPollVO messagingMoPollVO, ModelMap model) throws Exception {
        
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	MessagingMoPollVO pollResert = messagingMoPollService.smsPollSelectOne(messagingMoPollVO);
    	
    	mav.addObject("pollResert", pollResert);
    	mav.addObject("data", 0);

        return mav;
    }
    
    @RequestMapping("/usr/UpdateMessagingMoPollShutdown.do")
    public String UpdateMessagingMoPollShutdown(@ModelAttribute("searchVO") MessagingMoPollVO messagingMoPollVO, HttpSession session) throws Exception {
        
    	LoginVO login = (LoginVO) session.getAttribute("loginVO");
    	
    	messagingMoPollVO.setMod_part_name(login.getOrgnztNm());
    	messagingMoPollVO.setMod_user_id(login.getId());
    	messagingMoPollVO.setMod_user_name(login.getName());
    	
    	messagingMoPollService.updateMessagingMoPollShutdown(messagingMoPollVO);

        return "jsonView";
    }
    
    @RequestMapping("/usr/MessagingMoPollNewList.do")
    public ModelAndView selectSmsPollNewList(@ModelAttribute("searchVO") MessagingMoPollVO messagingMoPollVO, ModelMap model) throws Exception {
        
        ModelAndView mav = new ModelAndView("jsonView");

        List<MessagingMoPollVO> moList = messagingMoPollService.selectSmsPollNewList(messagingMoPollVO);

        mav.addObject("moList", moList);

        return mav;
    }
    
    /*
     * 
     * 투표등록
     *      * 
     */
    
    @RequestMapping("/usr/InsertMessagingMoNewPoll.do")
    public ModelAndView InsertMessagingMoNewPoll(@ModelAttribute("searchVO") MessagingMoPollVO messagingMoPollVO, ModelMap model, HttpSession session) throws Exception {
        
    	ModelAndView mav = new ModelAndView("jsonView");
    	System.out.println("-----투표등록----" + messagingMoPollVO);
        messagingMoPollVO.setEmo_recipient(messagingMoPollVO.getMo_recipient());
    	
    	LoginVO login= (LoginVO) session.getAttribute("loginVO");
    	messagingMoPollVO.setReg_part_name(login.getOrgnztId());
    	messagingMoPollVO.setReg_user_id(login.getId());
        
        //Transaction
      	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
      	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
      	TransactionStatus txStatus = txManager.getTransaction(def); 
      	try{ 		

      		messagingMoPollService.insertMessagingMoNewPoll(messagingMoPollVO);      				
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
    
    @RequestMapping("/usr/UpdateMessagingMoNewPollDel.do")
    public String updateMessagingMoNewPollDel(@ModelAttribute("searchVO") MessagingMoPollVO messagingMoPollVO, ModelMap model) throws Exception {
        
    	messagingMoPollService.updateMessagingMoNewPollDel(messagingMoPollVO);

        return "jsonView";
    }
    
    @RequestMapping("/usr/UpdateMessagingMoNewPoll.do")
    public ModelAndView updateMessagingMoNewPoll(@ModelAttribute("searchVO") MessagingMoPollVO messagingMoPollVO, HttpSession session) throws Exception {
        
    	ModelAndView mav = new ModelAndView("jsonView");

    	
    	LoginVO login = (LoginVO) session.getAttribute("loginVO");
    	
    	messagingMoPollVO.setMod_part_name(login.getOrgnztId());
    	messagingMoPollVO.setMod_user_id(login.getId());
    	messagingMoPollVO.setMod_user_name(login.getName());
    	
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
      	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
      	TransactionStatus txStatus = txManager.getTransaction(def); 
      	try{ 		
        	messagingMoPollService.updateMessagingMoNewPoll(messagingMoPollVO);			
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
    
    @RequestMapping("/usr/pollComClose.do")
    public ModelAndView pollComClose(MessagingMoPollVO messagingMoPollVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	Integer seq = messagingMoPollVO.getSurvey_seq();
    	
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
      	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
      	TransactionStatus txStatus = txManager.getTransaction(def); 
      	try{ 		

        	messagingMoPollService.pollComClose(seq);   				 
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
