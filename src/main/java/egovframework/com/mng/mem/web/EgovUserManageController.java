package egovframework.com.mng.mem.web;


import java.math.BigInteger;
import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.mng.mem.service.CashVO;
import egovframework.com.mng.mem.service.EgovMessageRoleService;
import egovframework.com.mng.mem.service.MessageRoleVO;
import egovframework.com.mng.pwd.service.EgovPwdConfigService;
import egovframework.com.mng.pwd.service.PasswordSetVO;
import egovframework.com.usr.add.service.AddressBookVO;
import egovframework.com.usr.add.service.EgovAddressBookService;
import egovframework.com.uss.umt.service.DeptManageVO;
import egovframework.com.uss.umt.service.EgovDeptManageService;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.com.uss.umt.service.UserDefaultVO;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 업무사용자관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    --------------------------- 
 *
 * </pre>
 */

@Controller
public class EgovUserManageController {

	/** userManageService */
	@Resource(name = "userManageService")
	private EgovUserManageService userManageService;

	/** egovCmmUseService */
	@Resource(name = "egovCmmUseService")
	private EgovCmmUseService egovCmmUseService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "egovMessageRoleService")
	private EgovMessageRoleService msgRoleService;

	/** DefaultBeanValidator beanValidator */
	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;  
	
	/* 부서원등록을 위해 */
	@Resource(name = "egovDeptManageService")
	private EgovDeptManageService egovDeptManageService;
	
	@Resource(name = "egovPwdConfigService")
    private EgovPwdConfigService pwdConfigService;
	
	/* properties 사용 */
	//@Resource(name = "globalsProperties")
	//private Properties globalsProp;

	@Value("#{globalsProperties['ENCRYPTFLG']}")
	private String encFlagG;
	
	@Autowired Properties globalsProperties;
	
	@Resource(name = "egovAddressBookService")
    private EgovAddressBookService adbkService;
	
	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param userSearchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovUserManage
	 * @throws Exception
	 */
	@IncludedInfo(name = "업무사용자관리", order = 460, gid = 50)
	@RequestMapping(value = "/mng/mem/EgovUserManage.do")
	public ModelAndView selectUserList(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, ModelMap model, DeptManageVO deptManageVO) throws Exception {

		ModelAndView mav = new ModelAndView();
        //List<?> departList = egovDeptManageService.selectDeptManageList(deptManageVO);
        List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);

        mav.setViewName("egovframework/com/mng/mem/EgovUserManage");
        mav.addObject("partIdList", list);
		
		return mav;
	}
	
	

	@RequestMapping(value = "/getUserList")
	public String selectUserListajax(UserManageVO userVO, ModelMap model) throws Exception {
 
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        System.out.println(user.getOrgnztId());
        userVO.setOrgnztId(user.getOrgnztId());

        String approval = globalsProperties.getProperty("g_UserList_Except_Approval");

        System.out.println("approval :: " +approval);

        List<UserManageVO> userList;

        if(approval.equalsIgnoreCase("Y")) {
            userList = userManageService.selectUserList(userVO);
        }else {
            userList = userManageService.selectUserListNo(userVO);
        }

        model.addAttribute("data", userList);

        System.out.println("--------getUserList----userList-------------" + userList);
        String encFlag = globalsProperties.getProperty("ENCRYPTFLG");
        System.out.println("encFlag : "+ encFlag );
        System.out.println("encFlagG : "+ encFlagG );
        return "jsonView";
	} 
	
	@RequestMapping(value = "/getUserListPartId")
	public String getUserListPartId(UserManageVO userVO, ModelMap model, String part_id) throws Exception {
 
        userVO.setOrgnztId(part_id);

        String approval = globalsProperties.getProperty("g_UserList_Except_Approval");

        List<UserManageVO> userList;

        if(approval.equalsIgnoreCase("Y")) {
            userList = userManageService.selectUserList(userVO);
        }else {
            userList = userManageService.selectUserListNo(userVO);
        }

        model.addAttribute("data", userList);

        System.out.println("--------getUserList----userList-------------" + userList);
        String encFlag = globalsProperties.getProperty("ENCRYPTFLG");
        System.out.println("encFlag : "+ encFlag );
        System.out.println("encFlagG : "+ encFlagG );
        return "jsonView";
	} 
	
	@RequestMapping(value = "/getUserListTotal")
	public String selectUserListajaxTotal(UserManageVO userVO, ModelMap model) throws Exception {
		
		List<UserManageVO> userList;
		userList = userManageService.selectUserListTotal(userVO);
		model.addAttribute("data", userList);
		
		return "jsonView";
	} 
	
	
	
	
	/**
	 * 부서원 관리
	 * @param bannerVO - 배너 VO
	 * @return String - 리턴 URL
	 * @throws Exception
	 */
  
	@RequestMapping(value = "/usr/staff.do")
	public String usrstaff(@ModelAttribute("deptManageVO") DeptManageVO deptManageVO, ModelMap model) throws Exception {

		return "egovframework/com/usr/prt/EgovStaff";
	}
	
	/**
	 * 부서원 등록화면.
	 * @param bannerVO - 배너 VO
	 * @return String - 리턴 URL
	 * @throws Exception
	 */
	@RequestMapping(value = "/usr/addstaff.do")
	public ModelAndView usrAddstaff(@ModelAttribute("deptManageVO") DeptManageVO deptManageVO, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		//List<?> departList = egovDeptManageService.selectDeptManageList(deptManageVO);
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);
		PasswordSetVO pwSet = pwdConfigService.pwSet();
		
		mav.setViewName("egovframework/com/usr/prt/EgovAddStaff");
		mav.addObject("partIdList", list);
		mav.addObject("pwSet", pwSet);
		
		return mav;
	}  
	
	@RequestMapping(value = "/mng/addusr.do")
	public ModelAndView addusr(@ModelAttribute("deptManageVO") DeptManageVO deptManageVO, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		//List<?> departList = egovDeptManageService.selectDeptManageList(deptManageVO);
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);
		PasswordSetVO pwSet = pwdConfigService.pwSet();
		MessageRoleVO msgRole = msgRoleService.selectMessageRole();
		
		mav.setViewName("egovframework/com/mng/mem/EgovUserManageIns");
		mav.addObject("partIdList", list);
		mav.addObject("pwSet", pwSet);
		mav.addObject("msgRole", msgRole);
		
		return mav;
	} 
	
	@RequestMapping(value = "/usr/prtstaff.do")
	public ModelAndView usrUpdatestaff(@RequestParam("userId") String userId, ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		//List<?> departList = egovDeptManageService.selectDeptManageList(deptManageVO);
		UserManageVO userInfo = userManageService.selectUser(userId);
		System.out.println("--------getSms_add-------------" + userInfo.getSmsAdd());
		System.out.println("--------getLms_add-------------" + userInfo.getLmsAdd());
		System.out.println("--------getMms_add-------------" + userInfo.getMmsAdd());
		System.out.println("--------getNms_add-------------" + userInfo.getNmsAdd());
		System.out.println("--------getFms_add-------------" + userInfo.getFmsAdd());
		System.out.println("--------getUse_status-------------" + userInfo.getUseStatus());
		System.out.println("--------getSms_add-------------" + userInfo.getEmplyrId());
		
		String phonNo = userInfo.getMoblphonNo();
		if(phonNo.length()==11) {
			mav.addObject("phonNo1", phonNo.substring(0,3));
			mav.addObject("phonNo2", phonNo.substring(3,7));
			mav.addObject("phonNo3", phonNo.substring(7));
		}else if(phonNo.length()==10) {
			mav.addObject("phonNo1", phonNo.substring(0,3));
			mav.addObject("phonNo2", phonNo.substring(3,6));
			mav.addObject("phonNo3", phonNo.substring(6));
		}
		
		String offmTelno = userInfo.getOffmTelno();
		if(offmTelno !=null) {
	    	  if( offmTelno.substring(2) == "02" ){
	 	         String phone1 = offmTelno.substring(0,1);
	 	         String phone2 = offmTelno.substring(1,offmTelno.length()-4);
	 	         String phone3 = offmTelno.substring(offmTelno.length() - 4, offmTelno.length());
	 	         
	 	         model.addAttribute("phone1",phone1);
	 	         model.addAttribute("phone2",phone2);
	 	         model.addAttribute("phone3",phone3);

	 	      }else {
	 	         String phone1 = offmTelno.substring(0,2);
	 	         String phone2 = offmTelno.substring(2,offmTelno.length()-4);
	 	         String phone3 = offmTelno.substring(offmTelno.length() - 4, offmTelno.length());
	 	         
	 	         
	 	         model.addAttribute("phone1",phone1);
	 	         model.addAttribute("phone2",phone2);
	 	         model.addAttribute("phone3",phone3);
	 	      }
		}
		
		String status = userInfo.getEmplyrSttusCode();
		if(status.equals("AAA")) {
			mav.addObject("status", "근무");
		}else if(status.equals("AAB")) {
			mav.addObject("status", "근무(파견)");
		}else if(status.equals("ABA")) {
			mav.addObject("status", "휴직");
		}else if(status.equals("DAB")) {
			mav.addObject("status", "전출");
		}else if(status.equals("DAA")) {
			mav.addObject("status", "퇴직");
		}
		
		String partNm = egovDeptManageService.selectOnePartName(userInfo.getOrgnztId());
		mav.addObject("partNm", partNm);
			
		mav.setViewName("egovframework/com/usr/prt/EgovUpdateStaff");
		mav.addObject("userInfo", userInfo);
		
		PasswordSetVO pwSet = pwdConfigService.pwSet();
		mav.addObject("pwSet", pwSet);
		
		return mav;
	}  
	
	@RequestMapping(value = "/mng/updusr.do")
	public ModelAndView mngUpdatestaff(@RequestParam("userId") String userId, ModelMap model, DeptManageVO deptManageVO) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);
		UserManageVO userInfo = userManageService.selectUser(userId);
		System.out.println("--------getSms_add-------------" + userInfo.getSmsAdd());
		System.out.println("--------getLms_add-------------" + userInfo.getLmsAdd());
		System.out.println("--------getMms_add-------------" + userInfo.getMmsAdd());
		System.out.println("--------getNms_add-------------" + userInfo.getNmsAdd());
		System.out.println("--------getFms_add-------------" + userInfo.getFmsAdd());
		System.out.println("--------getUse_status-------------" + userInfo.getUseStatus());
		System.out.println("--------getSms_add-------------" + userInfo.getEmplyrId());
		
		String phonNo = userInfo.getMoblphonNo();
		if(phonNo.length()==11) {
			mav.addObject("phonNo1", phonNo.substring(0,3));
			mav.addObject("phonNo2", phonNo.substring(3,7));
			mav.addObject("phonNo3", phonNo.substring(7));
		}else if(phonNo.length()==10) {
			mav.addObject("phonNo1", phonNo.substring(0,3));
			mav.addObject("phonNo2", phonNo.substring(3,6));
			mav.addObject("phonNo3", phonNo.substring(6));
		}
		
		String status = userInfo.getEmplyrSttusCode();
		if(status.equals("AAA")) {
			mav.addObject("status", "근무");
		}else if(status.equals("AAB")) {
			mav.addObject("status", "근무(파견)");
		}else if(status.equals("ABA")) {
			mav.addObject("status", "휴직");
		}else if(status.equals("DAB")) {
			mav.addObject("status", "전출");
		}else if(status.equals("DAA")) {
			mav.addObject("status", "퇴직");
		}
		
		String offmTelno = userInfo.getOffmTelno();
		if(offmTelno !=null) {
	    	  if( offmTelno.substring(2) == "02" ){
	 	         String phone1 = offmTelno.substring(0,1);
	 	         String phone2 = offmTelno.substring(1,offmTelno.length()-4);
	 	         String phone3 = offmTelno.substring(offmTelno.length() - 4, offmTelno.length());
	 	         
	 	         model.addAttribute("phone1",phone1);
	 	         model.addAttribute("phone2",phone2);
	 	         model.addAttribute("phone3",phone3);

	 	      }else {
	 	         String phone1 = offmTelno.substring(0,2);
	 	         String phone2 = offmTelno.substring(2,offmTelno.length()-4);
	 	         String phone3 = offmTelno.substring(offmTelno.length() - 4, offmTelno.length());
	 	         
	 	         
	 	         model.addAttribute("phone1",phone1);
	 	         model.addAttribute("phone2",phone2);
	 	         model.addAttribute("phone3",phone3);
	 	      }
	      }
		
		String partNm = egovDeptManageService.selectOnePartName(userInfo.getOrgnztId());
		mav.addObject("partNm", partNm);
			
		mav.setViewName("egovframework/com/mng/mem/EgovUserManageupd");
		mav.addObject("userInfo", userInfo);
		mav.addObject("partIdList", list);
		
		System.out.println("orgnztId :: "+userInfo.getOrgnztId());
		
		PasswordSetVO pwSet = pwdConfigService.pwSet();
		mav.addObject("pwSet", pwSet);
		
		return mav;
	}  
	/*
	 * 부서원 등록
	 */
	@RequestMapping(value = "/usr/InsertPartUser.do")
	public ModelAndView insertPartUser(UserManageVO userVO, BindingResult bindingResult, ModelMap model) throws Exception{
				
		ModelAndView mav = new ModelAndView("jsonView");
		String encryptflg = globalsProperties.getProperty("ENCRYPTFLG");
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		userVO.setOrgnztId(user.getOrgnztId());
		userVO.setUseStatus("Y");
		if(encryptflg.equalsIgnoreCase("Y")) {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			messageDigest.update(((String) userVO.getPassword()).getBytes("utf8"));
			String changPw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
			userVO.setPassword(changPw);
		}
	      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{
	    	  userManageService.insertPartUser(userVO);
	            txManager.commit(txStatus); 
	            mav.addObject("data", 0);
	      } catch (Exception e) { 
	            e.printStackTrace();
	            txManager.rollback(txStatus); 
	            mav.addObject("data", 1);
	      }
		return mav;
	}
	@RequestMapping(value = "/usr/insertPartUserAdmin.do")
	public ModelAndView insertPartUserAdmin(UserManageVO userVO, BindingResult bindingResult, ModelMap model) throws Exception{
		
		ModelAndView mav = new ModelAndView("jsonView");
		String encryptflg = globalsProperties.getProperty("ENCRYPTFLG");
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();  
		userVO.setOrgnztId(user.getOrgnztId());
		userVO.setUseStatus("Y"); 
		if(encryptflg.equalsIgnoreCase("Y")) {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			messageDigest.update(((String) userVO.getPassword()).getBytes("utf8"));
			String changPw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
			userVO.setPassword(changPw);
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		TransactionStatus txStatus = txManager.getTransaction(def); 
		try{
			userManageService.insertPartUserAdmin(userVO);
			txManager.commit(txStatus); 
			mav.addObject("data", 0);
		} catch (Exception e) { 
			e.printStackTrace();
			txManager.rollback(txStatus); 
			mav.addObject("data", 1);
		}
		return mav;
	}
	
	@RequestMapping(value = "/mng/InsertUser.do")
	public ModelAndView mngInsertUser(UserManageVO userVO, BindingResult bindingResult, ModelMap model) throws Exception{
				
		ModelAndView mav = new ModelAndView("jsonView");
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		String encryptflg = globalsProperties.getProperty("ENCRYPTFLG");
		System.out.println("encryptflg : "+encryptflg);
		
		System.out.println("직원 주소록 추가 여부 : "+userVO.getStaffAdr());
		
		if(encryptflg.equalsIgnoreCase("Y")) {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			messageDigest.update(((String) userVO.getPassword()).getBytes("utf8"));
			String changPw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
			
			System.out.println("changPw sha-256 :: " + changPw);
			
			userVO.setPassword(changPw);
		}
		
		if(userVO.getStaffAdr().equalsIgnoreCase("Y")) {
			AddressBookVO adbkVO = new AddressBookVO();
			
			Date today = new Date();
	        DateFormat format = new SimpleDateFormat("yy/MM/dd");
			
			adbkVO.setAddress_name(userVO.getEmplyrNm());
			adbkVO.setAddress_type("3");
			adbkVO.setAddress_num(userVO.getMoblphonNo());
			adbkVO.setAddress_date(format.format(today));
			adbkVO.setUser_id(user.getId());
			adbkVO.setAddress_capy("N");
			
			
			DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		      TransactionStatus txStatus = txManager.getTransaction(def); 
		      try{

		    	  adbkService.insertAddressBook(adbkVO);
		            
		            txManager.commit(txStatus);
		            //정상일경우 COMMIT; 
		            //model.put("result", 0);
		      } catch (Exception e) { 
		            e.printStackTrace();
		            txManager.rollback(txStatus); 
		            //에러날경우 CATCH로 빠져서 ROLLBACK; 
		            //model.put("result", -1);
		      }
		}
		
		//Transaction
	      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{
	
	    	  userManageService.mngInsertUser(userVO);
	            
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
	
	@RequestMapping(value ="/usr/UpdatePartUser.do")
	public ModelAndView updatePartUser(UserManageVO userVO, BindingResult bindingResult, ModelMap model) throws Exception{
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		String encryptflg = globalsProperties.getProperty("ENCRYPTFLG");
		System.out.println("encryptflg : "+encryptflg);
		
		
		//Transaction
	      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  userManageService.updateUser(userVO);
	            
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
	
	@RequestMapping(value="/mng/partMCheck.do")
	public ModelAndView partMCheck(UserManageVO userVO) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		
		UserManageVO partMCheck = userManageService.partMCheck(userVO);
		
		if(partMCheck==null) {
			mav.addObject("data", 0);
		}else {
			if(partMCheck.getEmplyrId().equalsIgnoreCase(userVO.getEmplyrId())) {
				mav.addObject("data", 1);
			}else {
				mav.addObject("data", 0);
			}
		}
		
		return mav;
	}
	
	@RequestMapping(value ="/mng/UpdateUser.do")
	public ModelAndView UpdateUser(UserManageVO userVO, BindingResult bindingResult, ModelMap model) throws Exception{
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		String encryptflg = globalsProperties.getProperty("ENCRYPTFLG");
		System.out.println("encryptflg : "+encryptflg);
		System.out.println("userVO.getPassword()"+userVO.getPassword());
		
		if(encryptflg.equalsIgnoreCase("Y")) {
			if(userVO.getPassword()!="") {
				MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
				messageDigest.update(((String) userVO.getPassword()).getBytes("utf8"));
				String changPw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
				System.out.println("changPw sha-256 :: " + changPw);
				userVO.setPassword(changPw);
			}
		}
		
		
		//Transaction
	      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  userManageService.mngUpdateUser(userVO);
	            
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
	
	@RequestMapping(value ="/mng/UpdateUserPartg.do")
	public ModelAndView UpdateUserPartg(UserManageVO userVO, BindingResult bindingResult, ModelMap model) throws Exception{
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		String encryptflg = globalsProperties.getProperty("ENCRYPTFLG");
		System.out.println("encryptflg : "+encryptflg);
		
		if(encryptflg.equalsIgnoreCase("Y")) {
			if(userVO.getPassword()!=null) {
				MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
				messageDigest.update(((String) userVO.getPassword()).getBytes("utf8"));
				String changPw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
				System.out.println("changPw sha-256 :: " + changPw);
				userVO.setPassword(changPw);
			}
		}
		
		
		//Transaction
	      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       
	    	  userManageService.mngdowndateUser(userVO);
	    	  userManageService.mngUpdateUser(userVO);
	            
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
	
	//부서원 삭제
	@RequestMapping(value ="/mng/deleteUserR.do")
	public ModelAndView deleteUserR(UserManageVO userVO, BindingResult bindingResult, ModelMap model) throws Exception{
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		String userId = userVO.getEmplyrId();
		
		String checkUse = userManageService.checkUse(userId);
		
		if (checkUse.equalsIgnoreCase("Y")) {
			 mav.addObject("data", 1);
		}else {
			//Transaction
		      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		      TransactionStatus txStatus = txManager.getTransaction(def); 
		      try{       

		    	  userManageService.deleteUserR(userId);
		            
		            txManager.commit(txStatus); 
		            //정상일경우 COMMIT; 
		            //model.put("result", 0);
		            mav.addObject("data", 0);
		      } catch (Exception e) { 
		            e.printStackTrace();
		            txManager.rollback(txStatus); 
		            //에러날경우 CATCH로 빠져서 ROLLBACK; 
		            //model.put("result", -1); 
		            mav.addObject("data", 2);
		      }
		}
		return mav;
	}
	
	@RequestMapping("/mng/updateUseStatusN.do")
	public ModelAndView updateUseStatusN(UserManageVO userVO) throws Exception {
ModelAndView mav = new ModelAndView("jsonView");
		
		String userId = userVO.getEmplyrId();
		
		//Transaction
	      DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  userManageService.updateUseStatusN(userId);
	            
	            txManager.commit(txStatus); 
	            //정상일경우 COMMIT; 
	            //model.put("result", 0);
	            mav.addObject("data", 0);
	      } catch (Exception e) { 
	            e.printStackTrace();
	            txManager.rollback(txStatus); 
	            //에러날경우 CATCH로 빠져서 ROLLBACK; 
	            //model.put("result", -1); 
	            mav.addObject("data", 2);
	      }
		return mav;
	}
	
	
	/**
	 * 사용자등록화면으로 이동한다.
	 * @param userSearchVO 검색조건정보
	 * @param userManageVO 사용자초기화정보
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovUserInsert
	 * @throws Exception
	 * @RequestMapping("/uss/umt/EgovUserInsertView.do")
	 */
	
	@RequestMapping("/join.do")
	public ModelAndView insertUserView(@ModelAttribute("deptManageVO") DeptManageVO deptManageVO, @ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, @ModelAttribute("userManageVO") UserManageVO userManageVO, Model model)
			throws Exception {
		
		ModelAndView mav = new ModelAndView();
		//List<?> departList = egovDeptManageService.selectDeptManageList(deptManageVO);
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);
		PasswordSetVO pwSet = pwdConfigService.pwSet();
			
		mav.setViewName("egovframework/com/uss/umt/EgovUserInsert");
		mav.addObject("partIdList", list);
		mav.addObject("pwSet", pwSet);
		
		return mav;
	}

	/**
	 * 사용자등록처리후 목록화면으로 이동한다.
	 * @param userManageVO 사용자등록정보
	 * @param bindingResult 입력값검증용 bindingResult
	 * @param model 화면모델
	 * @return forward:/uss/umt/EgovUserManage.do
	 * @throws Exception
	 */
	@RequestMapping("/uss/umt/EgovUserInsert.do")
	public ModelAndView insertUser(@ModelAttribute("userManageVO") UserManageVO userManageVO, BindingResult bindingResult) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		String encryptflg = globalsProperties.getProperty("ENCRYPTFLG");
		System.out.println("encryptflg : "+encryptflg);
		
		if(encryptflg.equalsIgnoreCase("Y")) {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			messageDigest.update(((String) userManageVO.getPassword()).getBytes("utf8"));
			String changPw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
			
			System.out.println("changPw sha-256 :: " + changPw);
			
			userManageVO.setPassword(changPw);
		}
		
		
		userManageVO.setEmplyrSttusCode("AAA");
		userManageVO.setUseStatus("R");

		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	      def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	      TransactionStatus txStatus = txManager.getTransaction(def); 
	      try{       

	    	  userManageService.insertPartUser(userManageVO);
	            
	            txManager.commit(txStatus); 
	            //정상일경우 COMMIT; 
	            //model.put("result", 0); 
	            //mav.setViewName("/");
	            mav.addObject("data", 1);
	      } catch (Exception e) { 
	            e.printStackTrace();
	            txManager.rollback(txStatus); 
	            //에러날경우 CATCH로 빠져서 ROLLBACK; 
	            //model.put("result", -1); 
	            //mav.setViewName("egovframework/com/uss/umt/EgovUserInsert");
	            mav.addObject("data", 0);
	            
	      }
		return mav;
	}
	
	
	/**
	    * 사용자정보 수정을 위해 사용자정보를 상세조회한다.
	    * @param uniqId 상세조회대상 사용자아이디
	    * @param userSearchVO 검색조건
	    * @param model 화면모델
	    * @return uss/umt/EgovUserSelectUpdt
	    * @throws Exception
	    */
	   @RequestMapping("/mypage.do")
	   public String selectUserUpdtMypage(@ModelAttribute("searchVO") UserDefaultVO userSearchVO,DeptManageVO deptManageVO, Model model) throws Exception {

	      // 미인증 사용자에 대한 보안처리
	      /*Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	      
	      if (!isAuthenticated) {
	         return "index";
	      }
	*/
	      LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	      //UserManageVO user = new UserManageVO();
	       
	      String uniqId = user.getId();
	      System.out.println("-------ESNTL_ID---" + uniqId);
	       
	      UserManageVO myinfo = userManageService.selectUser(uniqId);
	      
	      System.out.println("myinfo :: "+myinfo);
	      //핸드폰 전화번호
	      String moblphonNo = myinfo.getMoblphonNo();
	      String cellphone1 = moblphonNo.substring(0,3);
	      String cellphone2 = moblphonNo.substring(3,moblphonNo.length()-4);
	      String cellphone3 = moblphonNo.substring(moblphonNo.length() - 4, moblphonNo.length());
	      
	      System.out.println("myinfo :: 1. 휴대폰");
	      //집 전화번호
	      String offmTelno = myinfo.getOffmTelno();
	      
	      System.out.println("offmTelno :: "+offmTelno);
	      
	      if(offmTelno !=null) {
	    	  System.out.println("나야나 :: "+offmTelno.substring(0, 2));
	    	  if( offmTelno.substring(0, 2).equals("02") ){
	 	         String phone1 = offmTelno.substring(0,2);
	 	         String phone2 = offmTelno.substring(2,offmTelno.length()-4);
	 	         String phone3 = offmTelno.substring(offmTelno.length() - 4, offmTelno.length());
	 	         
	 	         model.addAttribute("phone1",phone1);
	 	         model.addAttribute("phone2",phone2);
	 	         model.addAttribute("phone3",phone3);

	 	      }else {
	 	         String phone1 = offmTelno.substring(0,3);
	 	         String phone2 = offmTelno.substring(3,offmTelno.length()-4);
	 	         String phone3 = offmTelno.substring(offmTelno.length() - 4, offmTelno.length());
	 	         
	 	         
	 	         model.addAttribute("phone1",phone1);
	 	         model.addAttribute("phone2",phone2);
	 	         model.addAttribute("phone3",phone3);
	 	      }
	      }
	      System.out.println("myinfo :: 2. 집전화");
	                                         
	      model.addAttribute("EmplurId", myinfo.getEmplyrId()); 
	      model.addAttribute("EmplyrNm", myinfo.getEmplyrNm()); 
	      model.addAttribute("OfcpsNm", myinfo.getOfcpsNm());
	      
	      model.addAttribute("OrgnztId", myinfo.getOrgnztId());
	      
	      System.out.println("myinfo :: 3. 개인정보");
	      
	      
	      model.addAttribute("cellphone1",cellphone1);
	      model.addAttribute("cellphone2",cellphone2);
	      model.addAttribute("cellphone3",cellphone3);
	      
	      System.out.println("myinfo :: 4. 나눈 폰번호");
	      
	      //비밀번호 변경
	      model.addAttribute("password",myinfo.getPassword());
	      
	      
	      
	      
	      System.out.println("password:" + myinfo.getPassword());
	      
	      
	      
	      
	      //model.addAttribute("homemiddleTelno",myinfo.getHomemiddleTelno());
	      //model.addAttribute("homeendTelno",myinfo.getHomeendTelno());
	      
	      
	      UserManageVO userManageVO = new UserManageVO();
	      userManageVO = userManageService.selectUser(uniqId);
	      model.addAttribute("userSearchVO", userSearchVO);
	      model.addAttribute("userManageVO", userManageVO);
	       
	      
	      
	      
	      
	      
	       //model.addAttribute("myinfo",myinfo.getEmplyrId());
	       //model.addAttribute("myinfo",myinfo.getEmplyrNm());
	       //model.addAttribute("myinfo",myinfo.getOfcpsNm());

//	      userManageService.selectUser(userId);
	      
	      
	      PasswordSetVO pwSet = pwdConfigService.pwSet();
	      model.addAttribute("pwSet", pwSet);
	      return "egovframework/com/usr/log/EgovMypage";
	      
	   }
	
	
	
	
	   /**
	    * 사용자정보 수정을 위해 사용자정보를 상세조회한다.
	    * @param uniqId 상세조회대상 사용자아이디
	    * @param userSearchVO 검색조건
	    * @param model 화면모델
	    * @return uss/umt/EgovUserSelectUpdt
	    * @throws Exception
	    */
	   @RequestMapping("/mng/mypage.do")
	   public String selectMngUpdtMypage(@ModelAttribute("searchVO") UserDefaultVO userSearchVO,DeptManageVO deptManageVO, Model model) throws Exception {

	      // 미인증 사용자에 대한 보안처리
	      /*Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	      
	      if (!isAuthenticated) {
	         return "index";
	      }
	*/
	      LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	      //UserManageVO user = new UserManageVO();
	       
	      String uniqId = user.getId();
	      System.out.println("-------ESNTL_ID---" + uniqId);
	       
	      UserManageVO myinfo = userManageService.selectUser(uniqId);
	      System.out.println(myinfo.getIp());
	      
	      //핸드폰 전화번호
	      String moblphonNo = myinfo.getMoblphonNo();
	      String cellphone1 = moblphonNo.substring(0,3);
	      String cellphone2 = moblphonNo.substring(3,moblphonNo.length()-4);
	      String cellphone3 = moblphonNo.substring(moblphonNo.length() - 4, moblphonNo.length());
	      
	                                         
	      model.addAttribute("EmplurId", myinfo.getEmplyrId()); 
	      model.addAttribute("EmplyrNm", myinfo.getEmplyrNm()); 
	      model.addAttribute("OfcpsNm", myinfo.getOfcpsNm());
	      
	      model.addAttribute("OrgnztId", myinfo.getOrgnztId());
	      model.addAttribute("ip", myinfo.getIp());
	      
	      
	      model.addAttribute("cellphone1",cellphone1);
	      model.addAttribute("cellphone2",cellphone2); 
	      model.addAttribute("cellphone3",cellphone3);
	      
	      //비밀번호 변경
	      model.addAttribute("password",myinfo.getPassword());
	      
	      
	      System.out.println("password:" + myinfo.getPassword());
	      
	      
	      
	      
	      //model.addAttribute("homemiddleTelno",myinfo.getHomemiddleTelno());
	      //model.addAttribute("homeendTelno",myinfo.getHomeendTelno());
	      
	      
	      UserManageVO userManageVO = new UserManageVO();
	      userManageVO = userManageService.selectUser(uniqId);
	      model.addAttribute("userSearchVO", userSearchVO);
	      model.addAttribute("userManageVO", userManageVO);
	       
	      
	      
	      
	      
	      
	       //model.addAttribute("myinfo",myinfo.getEmplyrId());
	       //model.addAttribute("myinfo",myinfo.getEmplyrNm());
	       //model.addAttribute("myinfo",myinfo.getOfcpsNm());

//	      userManageService.selectUser(userId);
	      return "egovframework/com/mng/log/EgovMngMypage";
	      
	   }
	
	
	
	
	
	
	/**
	 * 사용자정보 수정을 위해 사용자정보를 상세조회한다.
	 * @param uniqId 상세조회대상 사용자아이디
	 * @param userSearchVO 검색조건
	 * @param model 화면모델
	 * @return uss/umt/EgovUserSelectUpdt
	 * @throws Exception
	 */
	@RequestMapping("/mypage_x.do")
	public String selectUserUpdtMypage(@ModelAttribute("searchVO") UserDefaultVO userSearchVO, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (!isAuthenticated) {
			return "index";
		}

    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	String userId = user.getId();
    	
		/* String uniqIdd = EgovUserDetailsHelper.getAuthenticatedUser();  */
		
		/*
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//패스워드힌트목록을 코드정보로부터 조회
		vo.setCodeId("COM022");
		List<?> passwordHint_result = egovCmmUseService.selectCmmCodeDetail(vo);
		//성별구분코드를 코드정보로부터 조회
		vo.setCodeId("COM014");
		List<?> sexdstnCode_result = egovCmmUseService.selectCmmCodeDetail(vo);
		//사용자상태코드를 코드정보로부터 조회
		vo.setCodeId("COM013");
		List<?> emplyrSttusCode_result = egovCmmUseService.selectCmmCodeDetail(vo);
		//소속기관코드를 코드정보로부터 조회 - COM025
		vo.setCodeId("COM025");
		List<?> insttCode_result = egovCmmUseService.selectCmmCodeDetail(vo);
		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("COMTNORGNZTINFO");
		List<?> orgnztId_result = egovCmmUseService.selectOgrnztIdDetail(vo);
		//그룹정보를 조회 - GROUP_ID정보
		vo.setTableNm("COMTNORGNZTINFO");
		List<?> groupId_result = egovCmmUseService.selectGroupIdDetail(vo);

		model.addAttribute("passwordHint_result", passwordHint_result); //패스워트힌트목록
		model.addAttribute("sexdstnCode_result", sexdstnCode_result); //성별구분코드목록
		model.addAttribute("emplyrSttusCode_result", emplyrSttusCode_result);//사용자상태코드목록
		model.addAttribute("insttCode_result", insttCode_result); //소속기관코드목록
		model.addAttribute("orgnztId_result", orgnztId_result); //조직정보 목록
		model.addAttribute("groupId_result", groupId_result); //그룹정보 목록

		UserManageVO userManageVO = new UserManageVO();
		userManageVO = userManageService.selectUser(uniqId);
		model.addAttribute("userSearchVO", userSearchVO);
		model.addAttribute("userManageVO", userManageVO);
		*/

		 
		userManageService.selectUser(userId);
		return "egovframework/com/usr/log/EgovMypage";
	}
	

	/**
	 * 사용자정보 수정을 위해 사용자정보를 상세조회한다.
	 * @param uniqId 상세조회대상 사용자아이디
	 * @param userSearchVO 검색조건
	 * @param model 화면모델
	 * @return uss/umt/EgovUserSelectUpdt
	 * @throws Exception
	 */
	@RequestMapping("/uss/umt/EgovUserSelectUpdtView.do") 
	public String updateUserView(@RequestParam("selectedId") String uniqId, @ModelAttribute("searchVO") UserDefaultVO userSearchVO, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "index";
		}

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//패스워드힌트목록을 코드정보로부터 조회
		vo.setCodeId("COM022");
		List<?> passwordHint_result = egovCmmUseService.selectCmmCodeDetail(vo);
		//성별구분코드를 코드정보로부터 조회
		vo.setCodeId("COM014");
		List<?> sexdstnCode_result = egovCmmUseService.selectCmmCodeDetail(vo);
		//사용자상태코드를 코드정보로부터 조회
		vo.setCodeId("COM013");
		List<?> emplyrSttusCode_result = egovCmmUseService.selectCmmCodeDetail(vo);
		//소속기관코드를 코드정보로부터 조회 - COM025
		vo.setCodeId("COM025");
		List<?> insttCode_result = egovCmmUseService.selectCmmCodeDetail(vo);
		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("COMTNORGNZTINFO");
		List<?> orgnztId_result = egovCmmUseService.selectOgrnztIdDetail(vo);
		//그룹정보를 조회 - GROUP_ID정보
		vo.setTableNm("COMTNORGNZTINFO");
		List<?> groupId_result = egovCmmUseService.selectGroupIdDetail(vo);

		model.addAttribute("passwordHint_result", passwordHint_result); //패스워트힌트목록
		model.addAttribute("sexdstnCode_result", sexdstnCode_result); //성별구분코드목록
		model.addAttribute("emplyrSttusCode_result", emplyrSttusCode_result);//사용자상태코드목록
		model.addAttribute("insttCode_result", insttCode_result); //소속기관코드목록
		model.addAttribute("orgnztId_result", orgnztId_result); //조직정보 목록
		model.addAttribute("groupId_result", groupId_result); //그룹정보 목록

		UserManageVO userManageVO = new UserManageVO();
		userManageVO = userManageService.selectUser(uniqId);
		model.addAttribute("userSearchVO", userSearchVO);
		model.addAttribute("userManageVO", userManageVO);

		return "egovframework/com/uss/umt/EgovUserSelectUpdt"; 
	}
	
	/**
	 * 로그인인증제한 해제 
	 * @param userManageVO 사용자정보
	 * @param model 화면모델
	 * @return uss/umt/EgovUserSelectUpdtView.do
	 * @throws Exception
	 */
	@RequestMapping("/uss/umt/EgovUserLockIncorrect.do")
	public String updateLockIncorrect(UserManageVO userManageVO, Model model)
			throws Exception {
		
		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "index";
		}
		
		userManageService.updateLockIncorrect(userManageVO);
		
		return "forward:/uss/umt/EgovUserSelectUpdtView.do";
	}

	/**
	 * 사용자정보 수정후 목록조회 화면으로 이동한다.
	 * @param userManageVO 사용자수정정보
	 * @param bindingResult 입력값검증용 bindingResult
	 * @param model 화면모델
	 * @return forward:/uss/umt/EgovUserManage.do
	 * @throws Exception
	 */
	@RequestMapping("/uss/umt/EgovUserSelectUpdt.do")
	public String updateUser(@ModelAttribute("userManageVO") UserManageVO userManageVO, BindingResult bindingResult, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "index";
		}

		beanValidator.validate(userManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			model.addAttribute("resultMsg", bindingResult.getAllErrors().get(0).getDefaultMessage());
			return "forward:/uss/umt/EgovUserManage.do";
		} else {
			//업무사용자 수정시 히스토리 정보를 등록한다.
			userManageService.insertUserHistory(userManageVO);
			if ("".equals(userManageVO.getOrgnztId())) {//KISA 보안약점 조치 (2018-10-29, 윤창원)
				userManageVO.setOrgnztId(null);
			}
			if ("".equals(userManageVO.getGroupId())) {//KISA 보안약점 조치 (2018-10-29, 윤창원)
				userManageVO.setGroupId(null);
			}
			userManageService.updateUser(userManageVO);
			//Exception 없이 진행시 수정성공메시지
			model.addAttribute("resultMsg", "success.common.update");
			return "forward:/uss/umt/EgovUserManage.do";
		}
	}

	/**
	 * 사용자정보삭제후 목록조회 화면으로 이동한다.
	 * @param checkedIdForDel 삭제대상아이디 정보
	 * @param userSearchVO 검색조건
	 * @param model 화면모델
	 * @return forward:/uss/umt/EgovUserManage.do
	 * @throws Exception
	 */
	@RequestMapping("/uss/umt/EgovUserDelete.do")
	public String deleteUser(@RequestParam("checkedIdForDel") String checkedIdForDel, @ModelAttribute("searchVO") UserDefaultVO userSearchVO, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "index";
		}

		userManageService.deleteUser(checkedIdForDel);
		//Exception 없이 진행시 등록성공메시지
		model.addAttribute("resultMsg", "success.common.delete");
		return "forward:/uss/umt/EgovUserManage.do";
	}

	/**
	 * 입력한 사용자아이디의 중복확인화면 이동
	 * @param model 화면모델
	 * @return uss/umt/EgovIdDplctCnfirm
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/EgovIdDplctCnfirmView.do")
	public String checkIdDplct(ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "index";
		}

		model.addAttribute("checkId", "");
		model.addAttribute("usedCnt", "-1");
		return "egovframework/com/uss/umt/EgovIdDplctCnfirm";
	}

	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
	 * @param commandMap 파라메터전달용 commandMap
	 * @param model 화면모델
	 * @return uss/umt/EgovIdDplctCnfirm
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/EgovIdDplctCnfirm.do")
	public String checkIdDplct(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "index";
		}

		String checkId = (String) commandMap.get("checkId");
		checkId = new String(checkId.getBytes("ISO-8859-1"), "UTF-8");

		if (checkId == null || checkId.equals(""))
			return "forward:/uss/umt/EgovIdDplctCnfirmView.do";

		int usedCnt = userManageService.checkIdDplct(checkId);
		model.addAttribute("usedCnt", usedCnt);
		model.addAttribute("checkId", checkId);

		return "egovframework/com/uss/umt/EgovIdDplctCnfirm";
	}
	
	
	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
	 * @param commandMap 파라메터전달용 commandMap
	 * @param model 화면모델
	 * @return uss/umt/EgovIdDplctCnfirm
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/EgovIdDplctCnfirmAjax.do")
	public ModelAndView checkIdDplctAjax(@RequestParam Map<String, Object> commandMap) throws Exception {

    	ModelAndView modelAndView = new ModelAndView("jsonView");
    	modelAndView.setViewName("jsonView");

		String checkId = (String) commandMap.get("checkId");
		//checkId = new String(checkId.getBytes("ISO-8859-1"), "UTF-8");

		int usedCnt = userManageService.checkIdDplct(checkId);
		modelAndView.addObject("usedCnt", usedCnt);
		modelAndView.addObject("checkId", checkId);
		if(usedCnt==0) {
			modelAndView.addObject("data",0);
		}else {
			modelAndView.addObject("data",1);
		}

		return modelAndView;
	}

	/**
	 * 업무사용자 암호 수정처리 후 화면 이동
	 * @param model 화면모델
	 * @param commandMap 파라메터전달용 commandMap
	 * @param userSearchVO 검색조 건
	 * @param userManageVO 사용자수정정보(비밀번호)
	 * @return uss/umt/EgovUserPasswordUpdt
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/EgovUserPasswordUpdt.do")
	public String updatePassword(ModelMap model, @RequestParam Map<String, Object> commandMap, @ModelAttribute("searchVO") UserDefaultVO userSearchVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "index";
		}

		String oldPassword = (String) commandMap.get("oldPassword");
		String newPassword = (String) commandMap.get("newPassword");
		String newPassword2 = (String) commandMap.get("newPassword2");
		String uniqId = (String) commandMap.get("uniqId");

		boolean isCorrectPassword = false;
		UserManageVO resultVO = new UserManageVO();
		userManageVO.setPassword(newPassword);
		userManageVO.setOldPassword(oldPassword);
		userManageVO.setUniqId(uniqId);

		String resultMsg = "";
		resultVO = userManageService.selectPassword(userManageVO);
		//패스워드 암호화
		String encryptPass = EgovFileScrty.encryptPassword(oldPassword, userManageVO.getEmplyrId());
		if (encryptPass.equals(resultVO.getPassword())) {
			if (newPassword.equals(newPassword2)) {
				isCorrectPassword = true;
			} else {
				isCorrectPassword = false;
				resultMsg = "fail.user.passwordUpdate2";
			}
		} else {
			isCorrectPassword = false;
			resultMsg = "fail.user.passwordUpdate1";
		}

		if (isCorrectPassword) {
			userManageVO.setPassword(EgovFileScrty.encryptPassword(newPassword, userManageVO.getEmplyrId()));
			userManageService.updatePassword(userManageVO);
			model.addAttribute("userManageVO", userManageVO);
			resultMsg = "success.common.update";
		} else {
			model.addAttribute("userManageVO", userManageVO);
		}
		model.addAttribute("userSearchVO", userSearchVO);
		model.addAttribute("resultMsg", resultMsg);

		return "egovframework/com/uss/umt/EgovUserPasswordUpdt";
	}

	/**
	 * 업무사용자 암호 수정  화면 이동
	 * @param model 화면모델
	 * @param commandMap 파라메터전달용 commandMap
	 * @param userSearchVO 검색조건
	 * @param userManageVO 사용자수정정보(비밀번호)
	 * @return uss/umt/EgovUserPasswordUpdt
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/EgovUserPasswordUpdtView.do")
	public String updatePasswordView(ModelMap model, @RequestParam Map<String, Object> commandMap, @ModelAttribute("searchVO") UserDefaultVO userSearchVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "index";
		}

		String userTyForPassword = (String) commandMap.get("userTyForPassword");
		userManageVO.setUserTy(userTyForPassword);

		model.addAttribute("userManageVO", userManageVO);
		model.addAttribute("userSearchVO", userSearchVO);
		return "egovframework/com/uss/umt/EgovUserPasswordUpdt";
	}

	
	/**
	    * 업데이트 관련 
	    */
	   @RequestMapping(value = "/usr/updateUser.do")
	   public ModelAndView updateUser(UserManageVO userVO, BindingResult bindingResult, ModelMap model) throws Exception{
	            
		  ModelAndView mav = new ModelAndView("jsonView");
	      
	      System.out.println("getOfcpsNm : "+userVO.getOfcpsNm());
	      System.out.println("getMoblphonNo : "+userVO.getMoblphonNo());
	      System.out.println("getNewPw : "+userVO.getNewPw());
	      System.out.println("getPassword : "+userVO.getPassword());
	      
	      String encryptflg = globalsProperties.getProperty("ENCRYPTFLG");
	      
	      if(encryptflg.equalsIgnoreCase("Y")) {
	    	  if(!userVO.getNewPw().equals("")) {
				MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
				messageDigest.update(((String) userVO.getNewPw()).getBytes("utf8"));
				String changPw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
				
				System.out.println("changPw sha-256 :: " + changPw);
				
				userVO.setNewPw(changPw);
	    	  }
	    	  MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
	    	  messageDigest.update(((String) userVO.getPassword()).getBytes("utf8"));
	    	  String checkpw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
				
	    	  System.out.println("changPw sha-256 :: " + checkpw);
				
	    	  userVO.setPassword(checkpw);
	      }
	      String checkPw = userManageService.checkPw(userVO.getEmplyrId());
	      System.out.println("password1 : "+userVO.getPassword());
	      System.out.println("password2 : "+checkPw);
	      
	      if(userVO.getPassword().equals(checkPw)) {
	    	//Transaction
		         DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		         def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		         TransactionStatus txStatus = txManager.getTransaction(def); 
		         try{       

		            userManageService.updateUserM(userVO);
		               
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
	      }else {
	    	  mav.addObject("data", 2);
	      }
	      
	      return mav;
	   }
	
	   @RequestMapping(value = "/searchPw.do")
		public ModelAndView searchPw(UserManageVO userManageVO) throws Exception{
			
			ModelAndView mav = new ModelAndView("jsonView");
			
			System.out.println("searchPw invoked ;;");
			System.out.println("user_name : "+userManageVO.getEmplyrNm());
			System.out.println("user_phone : "+userManageVO.getMoblphonNo());
			
			int a = userManageService.searchPw(userManageVO);
			
			System.out.println(a);
			
			if(a==0) {
				mav.addObject("data",0);
			}else {
				int[] array = new int[6];
				
				for(int i = 0 ; i < 6 ; i++) {
					array[i]=(int)(Math.random()*9)+1;
				}
				
				String rang = array[0]+""+array[1]+""+array[2]+""+array[3]+""+array[4]+""+array[5];
				
				System.out.println(rang);
				
				Map<String, String> sendsms = new HashMap<>();
				
				sendsms.put("call_to", userManageVO.getMoblphonNo());
				//sendsms.put("call_from", userManageVO.getMoblphonNo());
				sendsms.put("sms_txt", "통합민원알리미시스템 본인확인 인증번호 : "+rang);
				
				DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		  		TransactionStatus txStatus = txManager.getTransaction(def); 
		  		try{

		  			userManageService.sendnum(sendsms);
					
					txManager.commit(txStatus); 
					//정상일경우 COMMIT; 
					//model.put("result", 0); 
					mav.addObject("data",1);
		  		} catch (Exception e) { 
					e.printStackTrace();
					txManager.rollback(txStatus); 
					//에러날경우 CATCH로 빠져서 ROLLBACK; 
					//model.put("result", -1); 
					mav.addObject("data",0);
		  		}
				
			}
			
			System.out.println("mav :: " +mav.getModel());
			return mav;
		}
		
		@RequestMapping(value="/chackCer.do")
		public ModelAndView chackCerForm(@RequestParam Map<String, Object> commandMap) throws Exception {
			
			System.out.println("chackCerForm invoked ;;");
			System.out.println("user_name : "+commandMap.get("emplyrNm"));
			System.out.println("user_phone : "+commandMap.get("moblphonNo"));
			System.out.println("chackCerForm :: " + commandMap.get("cer"));
			
			Date today = new Date();
			SimpleDateFormat format = new SimpleDateFormat("YYYYMM");
			String log_table = "MSG_LOG_"+format.format(today);
			System.out.println("log_table :: "+log_table);
			
			Map<String, String> map = new HashMap<>();
			map.put("moblphonNo", (String) commandMap.get("moblphonNo"));
			map.put("log_table", log_table);
			
			String cer = userManageService.searchCer(map);
			
			System.out.println("cer :: "+cer);
			
			ModelAndView mav = new ModelAndView("jsonView");
			if(commandMap.get("cer").equals(cer.substring((cer.length()-6), cer.length()))) {
				mav.addObject("data",1);
			}else {
				mav.addObject("data",0);
			}
			return mav;
		}

		
		
		
		@RequestMapping(value="/updatePw.do")
		public ModelAndView updatePw(@RequestParam Map<String, Object> commandMap) throws Exception {
			
			ModelAndView mav = new ModelAndView("jsonView");
			
			System.out.println("updatePw invoked ;;");
			System.out.println("changPw : "+commandMap.get("changPw"));
			System.out.println("user_name : "+commandMap.get("emplyrNm"));
			System.out.println("user_phone : "+commandMap.get("moblphonNo"));
			
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			messageDigest.update(((String) commandMap.get("changPw")).getBytes("utf8"));
			String changPw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
			
			System.out.println("changPw sha-256 :: " + changPw);
			
			Map<String, String> updatePw = new HashMap<>();
			
			updatePw.put("changPw", changPw);
			updatePw.put("emplyrNm", (String) commandMap.get("emplyrNm"));
			updatePw.put("moblphonNo", (String) commandMap.get("moblphonNo"));
			
			DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	  		TransactionStatus txStatus = txManager.getTransaction(def); 
	  		try{

	  			userManageService.updatePw(updatePw);
				
				txManager.commit(txStatus); 
				mav.addObject("data",1);
				//정상일경우 COMMIT; 
				//model.put("result", 0); 
	  		} catch (Exception e) { 
				e.printStackTrace();
				txManager.rollback(txStatus); 
				mav.addObject("data",0);
				//에러날경우 CATCH로 빠져서 ROLLBACK; 
				//model.put("result", -1); 
	  		}
	  		System.out.println("mav :: " +mav.getModel());
			return mav;
		}

	    @RequestMapping("/mng/updtMsgRole.do")
	    public String updateMessageRole(@ModelAttribute("MessageRoleVO") MessageRoleVO msgvo) throws Exception {
			//Transaction
			DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
			TransactionStatus txStatus = txManager.getTransaction(def); 
			try{ 		 

					userManageService.updateMessageRole(msgvo);
					txManager.commit(txStatus); 
					//정상일경우 COMMIT; 
					//model.put("result", 0); 
			} catch (Exception e) { 
					e.printStackTrace();
					txManager.rollback(txStatus); 
					//에러날경우 CATCH로 빠져서 ROLLBACK; 
					//model.put("result", -1); 
			}
	    	return "jsonView";
	    }
	    

	    @RequestMapping("/mng/updtMsgRolePart.do")
	    public String updateMessageRolePart(MessageRoleVO msgvo) throws Exception {
			//Transaction
			DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
			TransactionStatus txStatus = txManager.getTransaction(def); 
			try{ 
				//userManageService.updateMessageRole(msgvo);
					userManageService.updateMessageRolePart(msgvo);
					txManager.commit(txStatus); 
					//정상일경우 COMMIT; 
					//model.put("result", 0); 
			} catch (Exception e) { 
					e.printStackTrace();
					txManager.rollback(txStatus); 
					//에러날경우 CATCH로 빠져서 ROLLBACK; 
					//model.put("result", -1); 
			} 
	    	return "jsonView";
	    }

	    @RequestMapping("/mng/updtMsgRoleUser.do")
	    public String updateMessageRoleUser(@RequestBody MessageRoleVO msgvo) throws Exception {
			//Transaction
			DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
			TransactionStatus txStatus = txManager.getTransaction(def); 
			try{ 		

				//userManageService.updateMessageRole(msgvo);
					userManageService.updateMessageRoleUser(msgvo);
					txManager.commit(txStatus); 
					//정상일경우 COMMIT; 
					//model.put("result", 0); 
			} catch (Exception e) { 
					e.printStackTrace();
					txManager.rollback(txStatus); 
					//에러날경우 CATCH로 빠져서 ROLLBACK; 
					//model.put("result", -1); 
			} 
			
	    	return "jsonView";
	    }
	    

	    @RequestMapping("/mng/updtMsgCash.do")
	    public String updateMessageCash(@ModelAttribute("MessageRoleVO") MessageRoleVO msgvo) throws Exception {
			DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
			TransactionStatus txStatus = txManager.getTransaction(def); 
			try{ 		
					userManageService.updateMessageCash(msgvo);
					txManager.commit(txStatus); 
			} catch (Exception e) { 
					e.printStackTrace();
					txManager.rollback(txStatus); 
			}
	    	return "jsonView";
	    }
	    @RequestMapping("/mng/updtMsgCashPart.do")
	    public String updateMessageCashPart(@ModelAttribute("MessageRoleVO") MessageRoleVO msgvo) throws Exception {
	    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	    	TransactionStatus txStatus = txManager.getTransaction(def); 
	    	try{ 		
	    		userManageService.updateMessageCashPart(msgvo);
	    		txManager.commit(txStatus); 
	    	} catch (Exception e) { 
	    		e.printStackTrace();
	    		txManager.rollback(txStatus);  
	    	}
	    	return "jsonView";
	    }
	    @RequestMapping("/mng/updtMsgCashUser.do")
	    public String updateMessageCashUser(@RequestBody MessageRoleVO msgvo) throws Exception {
	    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	    	TransactionStatus txStatus = txManager.getTransaction(def); 
	    	try{ 		
	    		userManageService.updateMessageCashUser(msgvo);
	    		txManager.commit(txStatus); 
	    	} catch (Exception e) { 
	    		e.printStackTrace();
	    		txManager.rollback(txStatus); 
	    	}
	    	return "jsonView";
	    }
	    
	    // 사용캐시
	    @RequestMapping("/usr/getCash.do")
	    public ModelAndView getPayFee(HttpSession session) throws Exception{
	    	ModelAndView mav = new ModelAndView("jsonView");
	    	
	    	System.out.println("/getCash.do");
	    	
	    	LoginVO login = (LoginVO) session.getAttribute("loginVO");
	    	
	    	List<CashVO> cashvo = userManageService.getPayFee(login.getId());
	    	
	    	System.out.println(cashvo.get(0));
	    	
	    	HashMap<String, Integer> map = new HashMap<>();
	    	
	    	for(int i=0; i<cashvo.size(); i++) {
	    		map.put(cashvo.get(i).getPay_code(), cashvo.get(i).getPay_fee());
	    	}
	    	
	    	mav.addObject("cash", map);
	    	
	    	return mav;
	    }
	    
	    //남는캐시, 모자라는 캐시 반환
	    @RequestMapping("/usrCashCheck")
	    public ModelAndView usrCashCheck(HttpSession session, CashVO cash) throws Exception{
	    	ModelAndView mav = new ModelAndView("jsonView");
	    	
	    	LoginVO login = (LoginVO) session.getAttribute("loginVO");
	    	
	    	List<CashVO> cashvo = userManageService.getPayFee(login.getId());
	    	HashMap<String, Integer> map = new HashMap<>();
	    	
	    	for(int i=0; i<cashvo.size(); i++) {
	    		map.put(cashvo.get(i).getPay_code(), cashvo.get(i).getPay_fee());
	    	}
	    	
	    	if(cash.getPay_code()=="SMS") {
	    		Integer sms = login.getSms() - map.get("SMS");
	    		sms = sms - cash.getPay_fee();
	    		
	    		if(sms > 0) {
	    			mav.addObject("data", 0);
	    			mav.addObject("cash", sms);
	    		}else {
	    			mav.addObject("data", 1);
	    			mav.addObject("cash", sms);
	    		}
	    	}else if(cash.getPay_code()=="LMS") {
	    		Integer lms = login.getLms() - map.get("LMS");
	    		lms = lms - cash.getPay_fee();
	    		
	    		if(lms > 0) {
	    			mav.addObject("data", 0);
	    			mav.addObject("cash", lms);
	    		}else {
	    			mav.addObject("data", 1);
	    			mav.addObject("cash", lms);
	    		}
	    	}else if(cash.getPay_code()=="MMS") {
	    		Integer mms = login.getMms() - map.get("MMS");
	    		mms = mms - cash.getPay_fee();
	    		
	    		if(mms > 0) {
	    			mav.addObject("data", 0);
	    			mav.addObject("cash", mms);
	    		}else {
	    			mav.addObject("data", 1);
	    			mav.addObject("cash", mms);
	    		}
	    	}else if(cash.getPay_code()=="NOT") {
	    		Integer not = login.getNms() - map.get("NOT");
	    		not = not - cash.getPay_fee();
	    		
	    		if(not > 0) {
	    			mav.addObject("data", 0);
	    			mav.addObject("cash", not);
	    		}else {
	    			mav.addObject("data", 1);
	    			mav.addObject("cash", not);
	    		}
	    	}else if(cash.getPay_code()=="FIT") {
	    		Integer fit = login.getFms() - (map.get("FIT") + map.get("FRI")+ map.get("FRT"));
	    		fit = fit - cash.getPay_fee();
	    		
	    		if(fit > 0) {
	    			mav.addObject("data", 0);
	    			mav.addObject("cash", fit);
	    		}else {
	    			mav.addObject("data", 1);
	    			mav.addObject("cash", fit);
	    		}
	    	}else if(cash.getPay_code()=="FRI") {
	    		Integer fit = login.getFms() - (map.get("FIT") + map.get("FRI")+ map.get("FRT"));
	    		fit = fit - cash.getPay_fee();
	    		
	    		if(fit > 0) {
	    			mav.addObject("data", 0);
	    			mav.addObject("cash", fit);
	    		}else {
	    			mav.addObject("data", 1);
	    			mav.addObject("cash", fit);
	    		}
	    	}else if(cash.getPay_code()=="FRT") {
	    		Integer fir = login.getFms() - (map.get("FIT") + map.get("FRI")+ map.get("FRT"));
	    		fir = fir - cash.getPay_fee();
	    		
	    		if(fir > 0) {
	    			mav.addObject("data", 0);
	    			mav.addObject("cash", fir);
	    		}else {
	    			mav.addObject("data", 1);
	    			mav.addObject("cash", fir);
	    		}
	    	}
	    	
	    	return mav;
	    }
}
