package egovframework.com.mng.mem.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.mng.mem.service.EgovMessageRoleService;
import egovframework.com.mng.mem.service.MessageRoleVO;
import egovframework.com.uss.umt.service.EgovDeptManageService;
import egovframework.com.uss.umt.service.DeptManageVO;

 

@Controller
public class EgovMessageRoleController {

	/** userManageService */
	@Resource(name = "egovMessageRoleService")
	private EgovMessageRoleService msgRoleService;

	@Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;
	
	/** cmmUseService */
	@Resource(name = "egovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/* 부서원드옭을 위해 */
	@Resource(name = "egovDeptManageService")
	private EgovDeptManageService egovDeptManageService;

	 
	  //@IncludedInfo(name="주소록관리", order = 380, gid = 40)
	    @RequestMapping("/mng/setrole.do")
	    public ModelAndView setMessageRole() throws Exception {
	    	System.out.println("------------setMessageRole----------메세지권한 설정");
	        
	        ModelAndView mav = new ModelAndView("jsonView");

	        MessageRoleVO roleVO = msgRoleService.selectMessageRole();
	        
	        mav.addObject("roleVO", roleVO);
	        
	        System.out.println(roleVO.toString());
	        
	        mav.setViewName("egovframework/com/mng/msd/EgovSetRole");

	        return mav;
	    } 
	    
	    @RequestMapping("/mng/insertrole.do")
	    public ModelAndView insertMessageRole(MessageRoleVO messageRoleVO) throws Exception {
	    	System.out.println("------------setMessageRole----------메세지권한 설정");
	        
	        ModelAndView mav = new ModelAndView("jsonView");
	        
	        int count = msgRoleService.countRole();
	        
	        DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
			TransactionStatus txStatus = txManager.getTransaction(def); 
			try{ 		
					if(count == 0) {
						msgRoleService.insertMessageRole(messageRoleVO);
					}else{
						msgRoleService.updateMessageRole(messageRoleVO);
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
	    
	    @RequestMapping("/mng/insMsgPartCash.do")
	    public ModelAndView insMsgPartCash(MessageRoleVO messageRoleVO) throws Exception {
	    	System.out.println("------------setMessageRole----------메세지권한 설정");
	        
	        ModelAndView mav = new ModelAndView("jsonView");
	        
	        int count = msgRoleService.countRole();
	        
	        DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
			TransactionStatus txStatus = txManager.getTransaction(def); 
			try{ 		
					if(count == 0) {
						msgRoleService.insMsgPartCash(messageRoleVO);
					}else{
						msgRoleService.updMsgPartCash(messageRoleVO);
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
	    
	    @RequestMapping("/mng/insMsgUsrCash.do")
	    public ModelAndView insMsgUsrCash(MessageRoleVO messageRoleVO) throws Exception {
	    	System.out.println("------------setMessageRole----------메세지권한 설정");
	        
	        ModelAndView mav = new ModelAndView("jsonView");
	        
	        int count = msgRoleService.countRole();
	        
	        DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
			TransactionStatus txStatus = txManager.getTransaction(def); 
			try{ 		
					if(count == 0) {
						msgRoleService.insMsgUsrCash(messageRoleVO);
					}else{
						msgRoleService.updMsgUsrCash(messageRoleVO);
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
	    
		//@IncludedInfo(name="메세지권한 & 캐시", order = 380, gid = 40)
		@RequestMapping("/mng/batchrole.do")
		public ModelAndView selectMessageRole(MessageRoleVO roleVO, ModelMap model, DeptManageVO deptManageVO) throws Exception {

		        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		        ModelAndView mav = new ModelAndView();

		        if(!isAuthenticated) {
		        	mav.setViewName("/uat/uia/actionLogout.do");
		            return mav;
		        }

		        String userid = user.getId(); 
		        MessageRoleVO map = msgRoleService.selectMessageRole();
		      //검색을 위해 부서리스트
		        //사용자검색
		        ComDefaultCodeVO vo = new ComDefaultCodeVO();

				//사용자상태코드를 코드정보로부터 조회
				vo.setCodeId("COM013");
				List<?> emplyrSttusCode_result = cmmUseService.selectCmmCodeDetail(vo);
				//소속기관코드를 코드정보로부터 조회 - COM025
				vo.setCodeId("COM025");
				List<?> insttCode_result = cmmUseService.selectCmmCodeDetail(vo);
				//조직정보를 조회 - ORGNZT_ID정보
				vo.setTableNm("COMTNORGNZTINFO");
				List<?> orgnztId_result = cmmUseService.selectOgrnztIdDetail(vo);
				//그룹정보를 조회 - GROUP_ID정보
				vo.setTableNm("COMTNORGNZTINFO");
				List<?> groupId_result = cmmUseService.selectGroupIdDetail(vo);

				mav.addObject("emplyrSttusCode_result", emplyrSttusCode_result);//사용자상태코드목록
				mav.addObject("insttCode_result", insttCode_result); //소속기관코드목록
				mav.addObject("orgnztId_result", orgnztId_result); //조직정보 목록
				mav.addObject("groupId_result", groupId_result); //그룹정보 목록


		        if(map == null) { //옵션 properties 적용대상  
		            mav.addObject("sms", 0);
		            mav.addObject("lms", 0);
		            mav.addObject("mms", 0);
		            mav.addObject("notice", 0);
		            mav.addObject("noticelms", 0);
		            mav.addObject("friend", 0);
		            mav.addObject("friendlms", 0);
		            mav.addObject("friendmms", 0);
		            mav.addObject("mo", 0);
		            mav.addObject("partcash", 5000);
		            mav.addObject("usercash", 5000);
		        }else {
		            mav.addObject("sms", map.getSms());
		            mav.addObject("lms", map.getLms());
		            mav.addObject("mms", map.getMms());
		            mav.addObject("notice", map.getNotice());
		            mav.addObject("noticelms", map.getNoticelms());
		            mav.addObject("friend", map.getFriend());
		            mav.addObject("friendlms", map.getFriendlms());
		            mav.addObject("friendmms", map.getFriendmms());
		            mav.addObject("mo", map.getMo());
		            mav.addObject("partcash", map.getPartcash());
		            mav.addObject("usercash", map.getUsercash());
		        }
		        List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);


		        mav.setViewName("egovframework/com/mng/mem/EgovMessageRole");
				mav.addObject("partIdList", list);
				 return mav;
	    }
}
