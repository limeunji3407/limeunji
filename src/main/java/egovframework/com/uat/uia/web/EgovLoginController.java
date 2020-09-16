package egovframework.com.uat.uia.web;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovComponentChecker;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovMsgLinePriceVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.config.EgovLoginConfig;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.mng.pwd.service.EgovPwdConfigService;
import egovframework.com.mng.pwd.service.PasswordSetVO;
import egovframework.com.sym.log.clg.service.EgovLoginLogService;
import egovframework.com.sym.log.clg.service.LoginLog;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.utl.sim.service.EgovClntInfo;

/*
import com.gpki.gpkiapi.cert.X509Certificate;
import com.gpki.servlet.GPKIHttpServletRequest;
import com.gpki.servlet.GPKIHttpServletResponse;
*/

/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일            수정자          수정내용
 *  ----------  --------  ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.8.26   정진오          IncludedInfo annotation 추가
 *  2011.09.07  서준식          스프링 시큐리티 로그인 및 SSO 인증 로직을 필터로 분리
 *  2011.09.25  서준식          사용자 관리 컴포넌트 미포함에 대한 점검 로직 추가
 *  2011.09.27  서준식          인증서 로그인시 스프링 시큐리티 사용에 대한 체크 로직 추가
 *  2011.10.27  서준식          아이디 찾기 기능에서 사용자 리름 공백 제거 기능 추가
 *  2017.07.21  장동한          로그인인증제한 작업
 *  2018.10.26  신용호          로그인 화면에 message 파라미터 전달 수정
 *  </pre>
 */
@Controller
public class EgovLoginController {

   /** EgovLoginService */
   @Resource(name = "loginService")
   private EgovLoginService loginService;

   /** EgovCmmUseService */
   @Resource(name = "egovCmmUseService")
   private EgovCmmUseService cmmUseService;

   /** EgovMessageSource */
   @Resource(name = "egovMessageSource")
   EgovMessageSource egovMessageSource;

   @Resource(name = "egovLoginConfig")
   EgovLoginConfig egovLoginConfig;
   
   @Value("#{globalsProperties['ENCRYPTFLG']}")
   private String encFlagG;
   
   @Autowired Properties globalsProperties;

   @Resource(name = "egovPwdConfigService")
    private EgovPwdConfigService pwdConfigService;
   

   @Resource(name = "EgovLoginLogService")
   EgovLoginLogService loginLogService;
   
   /** 관리자 접근 권한 패턴 목록 */
   private List<String> adminAuthPatternList;
   
   public List<String> getAdminAuthPatternList() {
      return adminAuthPatternList;
   }

   public void setAdminAuthPatternList(List<String> adminAuthPatternList) {
      this.adminAuthPatternList = adminAuthPatternList;
   }

   
   /** log */
   private static final Logger LOGGER = LoggerFactory.getLogger(EgovLoginController.class);

   /**
    * 로그인 화면으로 들어간다
    * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
    * @return 로그인 페이지
    * @exception Exception
    */
   @IncludedInfo(name = "로그인", listUrl = "/uat/uia/egovLoginUsr.do", order = 10, gid = 10)
   @RequestMapping(value = "/uat/uia/egovLoginUsr.do")
   public ModelAndView loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
      ModelAndView mav = new ModelAndView("jsonView");
      
      if (EgovComponentChecker.hasComponent("mberManageService")) {
         model.addAttribute("useMemberManage", "true");
      }
            
      //권한체크시 에러 페이지 이동
      String auth_error =  request.getParameter("auth_error") == null ? "" : (String)request.getParameter("auth_error");
      if(auth_error != null && auth_error.equals("1")){
         mav.setViewName("egovframework/com/cmm/error/accessDenied");
         return mav;
      }

      /*
       * 
      GPKIHttpServletResponse gpkiresponse = null;
      GPKIHttpServletRequest gpkirequest = null;

      try{

         gpkiresponse=new GPKIHttpServletResponse(response);
          gpkirequest= new GPKIHttpServletRequest(request);
          gpkiresponse.setRequest(gpkirequest);
          model.addAttribute("challenge", gpkiresponse.getChallenge());
          return "egovframework/com/uat/uia/EgovLoginUsr";

      }catch(Exception e){
          return "egovframework/com/cmm/egovError";
      }
      
      */
      String message = (String)request.getParameter("message");
      if (message!=null) model.addAttribute("message", message);
      mav.setViewName("egovframework/com/uat/uia/EgovLoginUsr");
      return mav;
   }

   /**
    * 일반(세션) 로그인을 처리한다
    * @param vo - 아이디, 비밀번호가 담긴 LoginVO
    * @param request - 세션처리를 위한 HttpServletRequest
    * @return result - 로그인결과(세션정보)
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/actionLogin.do")
   public ModelAndView actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model, HttpSession session, LoginLog loginLog) throws Exception {
      ModelAndView mav = new ModelAndView("jsonView");
      
      System.out.println("login id :: "+loginVO.getId());
      System.out.println("login pw :: "+loginVO.getPassword());
      // 1. 로그인인증제한 활성화시 

      loginLog.setLoginId(loginVO.getId());
      /*      
       * if( egovLoginConfig.isLock()){
          Map<?,?> mapLockUserInfo = (EgovMap)loginService.selectLoginIncorrect(loginVO);
          if(mapLockUserInfo != null){         
            //2.1 로그인인증제한 처리
            String sLoginIncorrectCode = loginService.processLoginIncorrect(loginVO, mapLockUserInfo);
            if(!sLoginIncorrectCode.equals("E")){
               if(sLoginIncorrectCode.equals("L")){
                  model.addAttribute("message", egovMessageSource.getMessageArgs("fail.common.loginIncorrect", new Object[] {egovLoginConfig.getLockCount(),request.getLocale()}));
               }else if(sLoginIncorrectCode.equals("C")){
                  model.addAttribute("message", egovMessageSource.getMessage("fail.common.login",request.getLocale()));
               }
               return "egovframework/com/uat/uia/EgovLoginUsr";
            }
          }else{
             model.addAttribute("message", egovMessageSource.getMessage("fail.common.login",request.getLocale()));
             return "egovframework/com/uat/uia/EgovLoginUsr";
          }
      }*/
      String encryptflg = globalsProperties.getProperty("ENCRYPTFLG");
      System.out.println("encryptflg : "+encryptflg);
      
      if(encryptflg.equalsIgnoreCase("Y")) {
         MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
         messageDigest.update(((String) loginVO.getPassword()).getBytes("utf8"));
         String changPw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
         
         System.out.println("changPw sha-256 :: " + changPw);
         
         loginVO.setPassword(changPw);
      }
      System.out.println("login pw :: "+loginVO.getId());
      System.out.println("login pw :: "+loginVO.getPassword());
      
      // 2. 로그인 처리
      
      
      LoginVO resultVO = loginService.actionLogin(loginVO);


      System.out.println("login id :: "+loginVO.getId());
      System.out.println("login pw :: "+loginVO.getPassword());
      System.out.println("resultVO id :: "+resultVO.getId());
      System.out.println("resultVO pw :: "+resultVO.getPassword()); 
      // 3. 일반 로그인 처리
      if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
         
         
         /**
          * 로그인 처리전 계정 잠금상태인지 체크
          */
         LoginVO resultVO2 = loginService.getLockDt(loginVO);
         if(resultVO2 != null &&  resultVO2.getLock_dt().equals("Y")) {
        	loginLog.setLoginMthd("로그인 실패");
			loginLogService.logInsertLoginLog(loginLog);
            mav.addObject("data", 8);
            return mav;
         }

         if(resultVO.getUse_status().equalsIgnoreCase("R")) {
        	 loginLog.setLoginMthd("로그인 실패");
 			loginLogService.logInsertLoginLog(loginLog);
            mav.addObject("data", 4);
            return mav;
         }else {

            // 3-1. 로그인 정보를 세션에 저장
            //request.getSession().setAttribute("loginVO", resultVO);   
            resultVO.setuSLine((String)globalsProperties.get("SENDLINE"));
            resultVO.setuSubid((String)globalsProperties.get("subid"));
            resultVO.setSendline_alt((String)globalsProperties.get("SENDLINE_ALT"));
            resultVO.setSendline_frd((String)globalsProperties.get("SENDLINE_FRD"));
            
            
            EgovMsgLinePriceVO egovMsgLinePriceVO = loginService.getMsgPrice();
            session.setAttribute("egovMsgLinePriceVO", egovMsgLinePriceVO);
            
            session.setAttribute("loginVO", resultVO);  
            session.setAttribute("userId", resultVO.getId());
            session.setAttribute("userName", resultVO.getName());
            
            String pwdupdateflag = globalsProperties.getProperty("PWDUPDATEFLAG");
            System.out.println("pwdupdateflag :: "+pwdupdateflag);
            
            
            
            
            if(pwdupdateflag.equalsIgnoreCase("Y2")) {
               PasswordSetVO pwSet = pwdConfigService.pwSet();
               String cheackpw = pwSet.getPwdFirst();
               if(encryptflg.equalsIgnoreCase("Y")) {
                  MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
                  messageDigest.update(cheackpw.getBytes("utf8"));
                  String changPw = String.format("%064x", new BigInteger(1, messageDigest.digest()));
                  
                  if(resultVO.getPassword().equalsIgnoreCase(changPw)) {
                     if(resultVO.getOrgnztId().equals("ORGNZT_0000000000000")) {
                    	 loginLog.setLoginMthd("로그인 성공");
						loginLogService.logInsertLoginLog(loginLog);
                        mav.addObject("data", 9);
                        return mav;
                     }else {
                    	 loginLog.setLoginMthd("로그인 성공");
						loginLogService.logInsertLoginLog(loginLog);
                        mav.addObject("data", 6);
                        return mav;
                     }
                  }else {
                     String g_bLoginFailinit = globalsProperties.getProperty("g_bLoginFailinit");
                     if(g_bLoginFailinit.equalsIgnoreCase("Y")) {
                        loginService.passwordFailReset(loginVO);
                     }
                     
                     //관리자 권한 체크
                     if(resultVO.getOrgnztId().equals("ORGNZT_0000000000000")) {
                    	 loginLog.setLoginMthd("로그인 성공");
							loginLogService.logInsertLoginLog(loginLog);
                        LoginVO resultVO3 = loginService.getPasswordDt(loginVO);
                        mav.addObject("datas", resultVO3.getPassword_dt());
                        mav.addObject("data", 2);
                        return mav;
                     } else {
                        /* 클라이언트에 필요한 세션넘기기 */
                        mav.addObject("sessionLogin", resultVO);       
                        mav.addObject("uSTel",resultVO.getCallnum());
                        mav.addObject("uSMobile",resultVO.getPhonnum());
                        loginLog.setLoginMthd("로그인 성공");
						loginLogService.logInsertLoginLog(loginLog);
                        LoginVO resultVO3 = loginService.getPasswordDt(loginVO);
                        mav.addObject("datas", resultVO3.getPassword_dt());
                        mav.addObject("data", 1);
                        return mav;
                     }
                     
                     
                     
                     
                  }
               }else {
                  if(resultVO.getPassword().equalsIgnoreCase(cheackpw)) {
                     if(resultVO.getOrgnztId().equals("ORGNZT_0000000000000")) {
                    	 loginLog.setLoginMthd("로그인 성공");
						loginLogService.logInsertLoginLog(loginLog);
                        mav.addObject("data", 9);
                        return mav;
                     }else {
                    	 loginLog.setLoginMthd("로그인 성공");
							loginLogService.logInsertLoginLog(loginLog);
                        mav.addObject("data", 6);
                        return mav;
                     }
                  }else {
                     String g_bLoginFailinit = globalsProperties.getProperty("g_bLoginFailinit");
                     if(g_bLoginFailinit.equalsIgnoreCase("Y")) {
                        loginService.passwordFailReset(loginVO);
                     }
                     
                     //관리자 권한 체크
                     if(resultVO.getOrgnztId().equals("ORGNZT_0000000000000")) {
                    	 loginLog.setLoginMthd("로그인 성공");
							loginLogService.logInsertLoginLog(loginLog);
                        LoginVO resultVO3 = loginService.getPasswordDt(loginVO);
                        mav.addObject("datas", resultVO3.getPassword_dt());
                        mav.addObject("data", 2);
                        return mav;
                     } else {
                        /* 클라이언트에 필요한 세션넘기기 */
                        mav.addObject("sessionLogin", resultVO);       
                        mav.addObject("uSTel",resultVO.getCallnum());
                        mav.addObject("uSMobile",resultVO.getPhonnum());
                        loginLog.setLoginMthd("로그인 성공");
						loginLogService.logInsertLoginLog(loginLog);
                        LoginVO resultVO3 = loginService.getPasswordDt(loginVO);
                        mav.addObject("datas", resultVO3.getPassword_dt());
                        mav.addObject("data", 1);
                        return mav;
                     }
                     
                     
                     
                     
                  }
               }
            }else {
                
               String g_bLoginFailinit = globalsProperties.getProperty("g_bLoginFailinit");
               if(g_bLoginFailinit.equalsIgnoreCase("Y")) {
                  loginService.passwordFailReset(loginVO);
               }
               
               //관리자 권한 체크
               if(resultVO.getOrgnztId().equals("ORGNZT_0000000000000")) {
            	   loginLog.setLoginMthd("로그인 성공");
					loginLogService.logInsertLoginLog(loginLog);
                  mav.addObject("data", 2);
                  return mav;
               } else {
                  /* 클라이언트에 필요한 세션넘기기 */
            	   loginLog.setLoginMthd("로그인 성공");
					loginLogService.logInsertLoginLog(loginLog);
                  mav.addObject("sessionLogin", resultVO);       
                  mav.addObject("uSTel",resultVO.getCallnum());
                  mav.addObject("uSMobile",resultVO.getPhonnum());
                  mav.addObject("data", 1);
                  return mav;
               }
               // 2. 로그인로그 생성
               
               /*
                * ROLE_USER_MANAGER
                * ROLE_USER
                * ROLE_MO
                * ROLE_ADMIN
                */
               
               
               /*
               if (user.getUserSe().equals("GNR")) {
                  //return Globals.MAIN_PAGE;
                  return "redirect:/usr/index.do";
               } else {
                  return "egovframework/mng/EgovUnitMain";
               }
               */ 
            }
            
            
            
            
            
         }

      } else {
         loginService.passwordFail(loginVO);
         String pwFailCount = loginService.pwFailSerch(loginVO);
         
         
         Integer mngCheck = loginService.mngCheck(loginVO);
         
         if(mngCheck.equals(0)) {
            //if(adminAuthUrlPatternMatcher && !authList.contains("ROLE_ADMIN")){
        	 loginLog.setLoginMthd("로그인 실패");
				loginLogService.logInsertLoginLog(loginLog);
            mav.addObject("data", 5);
            mav.addObject("pwFailCount", pwFailCount);
            System.out.println("pwFailCount :: "+pwFailCount);
         }else {
        	 loginLog.setLoginMthd("로그인 실패");
				loginLogService.logInsertLoginLog(loginLog);
            mav.addObject("data", 3);
            mav.addObject("pwFailCount", pwFailCount);
            System.out.println("pwFailCount :: "+pwFailCount);
         }
         
         if(Integer.parseInt(pwFailCount) >= 5) {
        	 loginLog.setLoginMthd("로그인 실패");
				loginLogService.logInsertLoginLog(loginLog);
            loginService.lockChange(loginVO);
            mav.addObject("data", 7);
            mav.addObject("pwFailCount", pwFailCount);
         }
         
      }
      return mav;
   }

   /**
    * 인증서 로그인을 처리한다
    * @param vo - 주민번호가 담긴 LoginVO
    * @return result - 로그인결과(세션정보)
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/actionCrtfctLogin.do")
   public String actionCrtfctLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

      // 접속IP
      String userIp = EgovClntInfo.getClntIP(request);
      LOGGER.debug("User IP : {}", userIp);

      /*
      // 1. GPKI 인증
      GPKIHttpServletResponse gpkiresponse = null;
      GPKIHttpServletRequest gpkirequest = null;
      String dn = "";
      try{
         gpkiresponse = new GPKIHttpServletResponse(response);
          gpkirequest = new GPKIHttpServletRequest(request);
          gpkiresponse.setRequest(gpkirequest);
          X509Certificate cert = null;

          byte[] signData = null;
          byte[] privatekey_random = null;
          String signType = "";
          String queryString = "";

          cert = gpkirequest.getSignerCert();
          dn = cert.getSubjectDN();

          java.math.BigInteger b = cert.getSerialNumber();
          b.toString();
          int message_type =  gpkirequest.getRequestMessageType();
          if( message_type == gpkirequest.ENCRYPTED_SIGNDATA || message_type == gpkirequest.LOGIN_ENVELOP_SIGN_DATA ||
              message_type == gpkirequest.ENVELOP_SIGNDATA || message_type == gpkirequest.SIGNED_DATA){
              signData = gpkirequest.getSignedData();
              if(privatekey_random != null) {
                  privatekey_random   = gpkirequest.getSignerRValue();
              }
              signType = gpkirequest.getSignType();
          }
          queryString = gpkirequest.getQueryString();
      }catch(Exception e){
         return "cmm/egovError";
      }

      // 2. 업무사용자 테이블에서 dn값으로 사용자의 ID, PW를 조회하여 이를 일반로그인 형태로 인증하도록 함
      if (dn != null && !dn.equals("")) {

         loginVO.setDn(dn);
         LoginVO resultVO = loginService.actionCrtfctLogin(loginVO);
          if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {

             //스프링 시큐리티패키지를 사용하는지 체크하는 로직
             if(EgovComponentChecker.hasComponent("egovAuthorManageService")){
                // 3-1. spring security 연동
                  return "redirect:/j_spring_security_check?j_username=" + resultVO.getUserSe() + resultVO.getId() + "&j_password=" + resultVO.getUniqId();

             }else{
                // 3-2. 로그인 정보를 세션에 저장
                 request.getSession().setAttribute("loginVO", resultVO);
                return "redirect:/uat/uia/actionMain.do";
             }


          } else {
             model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
             return "egovframework/com/uat/uia/EgovLoginUsr";
          }
      } else {
         model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
         return "egovframework/com/uat/uia/EgovLoginUsr";
      }
      */
      return "egovframework/com/uat/uia/EgovLoginUsr";
   }

   /**
    * 로그인 후 메인화면으로 들어간다
    * @param
    * @return 로그인 페이지
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/actionMain.do")
   public String actionMain(ModelMap model) throws Exception {

      // 1. Spring Security 사용자권한 처리
      Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
      if (!isAuthenticated) {
         model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
         //return "egovframework/com/uat/uia/EgovLoginUsr";
         return "index";
      }
      LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
      
      LOGGER.debug("User Id : {}", user.getId());

      /*
      // 2. 메뉴조회
      MenuManageVO menuManageVO = new MenuManageVO();
      menuManageVO.setTmp_Id(user.getId());
      menuManageVO.setTmp_UserSe(user.getUserSe());
      menuManageVO.setTmp_Name(user.getName());
      menuManageVO.setTmp_Email(user.getEmail());
      menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
      menuManageVO.setTmp_UniqId(user.getUniqId());
      List list_headmenu = menuManageService.selectMainMenuHead(menuManageVO);
      model.addAttribute("list_headmenu", list_headmenu);
      */

      // 3. 메인 페이지 이동
      
      
      /*
      String main_page = Globals.MAIN_PAGE;

      LOGGER.debug("Globals.MAIN_PAGE > " + Globals.MAIN_PAGE);
      LOGGER.debug("main_page > {}", main_page);

      if (main_page.startsWith("/")) {
         return "forward:" + main_page;
      } else {
         return main_page;
      }
      */
      

      // 3-2. 설정된 메인화면이 없는 경우
      if (user.getUserSe().equals("GNR")) {
         //return Globals.MAIN_PAGE;
         return "forward:egovframework/usr/EgovUnitMain";
      } else if (user.getUserSe().equals("USR")) {
         return "forward:egovframework/mng/EgovUnitMain";
      } else {
         return Globals.MAIN_PAGE;
      }
      
      

      /*
      if (main_page != null && !main_page.equals("")) {

         // 3-1. 설정된 메인화면이 있는 경우
         return main_page;

      } else {

         // 3-2. 설정된 메인화면이 없는 경우
         if (user.getUserSe().equals("USR")) {
            return "egovframework/com/EgovMainView";
         } else {
            return "egovframework/com/EgovMainViewG";
         }
      }
      */
   }

   /**
    * 로그아웃한다.
    * @return String
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/actionLogout.do")
   public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {

      /*String userIp = EgovClntInfo.getClntIP(request);

      // 1. Security 연동
      return "redirect:/j_spring_security_logout";*/

      request.getSession().setAttribute("loginVO", null);

      //return "redirect:/egovDevIndex.jsp";
      return "redirect:/";
   }

   /**
    * 아이디/비밀번호 찾기 화면으로 들어간다
    * @param
    * @return 아이디/비밀번호 찾기 페이지
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/egovIdPasswordSearch.do")
   public String idPasswordSearchView(ModelMap model) throws Exception {

      // 1. 비밀번호 힌트 공통코드 조회
      ComDefaultCodeVO vo = new ComDefaultCodeVO();
      vo.setCodeId("COM022");
      List<?> code = cmmUseService.selectCmmCodeDetail(vo);
      model.addAttribute("pwhtCdList", code);

      return "egovframework/com/uat/uia/EgovIdPasswordSearch";
   }

   /**
    * 인증서안내 화면으로 들어간다
    * @return 인증서안내 페이지
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/egovGpkiIssu.do")
   public String gpkiIssuView(ModelMap model) throws Exception {
      return "egovframework/com/uat/uia/EgovGpkiIssu";
   }

   /**
    * 아이디를 찾는다.
    * @param vo - 이름, 이메일주소, 사용자구분이 담긴 LoginVO
    * @return result - 아이디
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/searchId.do")
   public String searchId(@ModelAttribute("loginVO") LoginVO loginVO, ModelMap model) throws Exception {

      if (loginVO == null || loginVO.getName() == null || loginVO.getName().equals("") && loginVO.getEmail() == null || loginVO.getEmail().equals("")
            && loginVO.getUserSe() == null || loginVO.getUserSe().equals("")) {
         return "egovframework/com/cmm/egovError";
      }

      // 1. 아이디 찾기
      loginVO.setName(loginVO.getName().replaceAll(" ", ""));
      LoginVO resultVO = loginService.searchId(loginVO);

      if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {

         model.addAttribute("resultInfo", "아이디는 " + resultVO.getId() + " 입니다.");
         return "egovframework/com/uat/uia/EgovIdPasswordResult";
      } else {
         model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.idsearch"));
         return "egovframework/com/uat/uia/EgovIdPasswordResult";
      }
   }

   /**
    * 비밀번호를 찾는다.
    * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
    * @return result - 임시비밀번호전송결과
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/searchPassword.do")
   public String searchPassword(@ModelAttribute("loginVO") LoginVO loginVO, ModelMap model) throws Exception {

      //KISA 보안약점 조치 (2018-10-29, 윤창원)
      if (loginVO == null || loginVO.getId() == null || loginVO.getId().equals("") && loginVO.getName() == null || "".equals(loginVO.getName()) && loginVO.getEmail() == null
            || loginVO.getEmail().equals("") && loginVO.getPasswordHint() == null || "".equals(loginVO.getPasswordHint()) && loginVO.getPasswordCnsr() == null
            || "".equals(loginVO.getPasswordCnsr()) && loginVO.getUserSe() == null || "".equals(loginVO.getUserSe())) {
         return "egovframework/com/cmm/egovError";
      }

      // 1. 비밀번호 찾기
      boolean result = loginService.searchPassword(loginVO);

      // 2. 결과 리턴
      if (result) {
         model.addAttribute("resultInfo", "임시 비밀번호를 발송하였습니다.");
         return "egovframework/com/uat/uia/EgovIdPasswordResult";
      } else {
         model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.pwsearch"));
         return "egovframework/com/uat/uia/EgovIdPasswordResult";
      }
   }

   /**
    * 개발 시스템 구축 시 발급된 GPKI 서버용인증서에 대한 암호화데이터를 구한다.
    * 최초 한번만 실행하여, 암호화데이터를 EgovGpkiVariables.js의 ServerCert에 넣는다.
    * @return String
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/getEncodingData.do")
   public void getEncodingData() throws Exception {

      /*
      X509Certificate x509Cert = null;
      byte[] cert = null;
      String base64cert = null;
      try {
         x509Cert = Disk.readCert("/product/jeus/egovProps/gpkisecureweb/certs/SVR1311000011_env.cer");
         cert = x509Cert.getCert();
         Base64 base64 = new Base64();
         base64cert = base64.encode(cert);
         log.info("+++ Base64로 변환된 인증서는 : " + base64cert);

      } catch (GpkiApiException e) {
         e.printStackTrace();
      }
      */
   }

   /**
    * 인증서 DN추출 팝업을 호출한다.
    * @return 인증서 등록 페이지
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/EgovGpkiRegist.do")
   public String gpkiRegistView(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

      /** GPKI 인증 부분 */
      // OS에 따라 (local NT(로컬) / server Unix(서버)) 구분
      String os = System.getProperty("os.arch");
      LOGGER.debug("OS : {}", os);
      
      //String virusReturn = null;

      /*
      // 브라우저 이름을 받기위한 처리
      String webKind = EgovClntInfo.getClntWebKind(request);
      String[] ss = webKind.split(" ");
      String browser = ss[1];
      model.addAttribute("browser",browser);
      // -- 여기까지
      if (os.equalsIgnoreCase("x86")) {
          //Local Host TEST 진행중
      } else {
          if (browser.equalsIgnoreCase("Explorer")) {
      GPKIHttpServletResponse gpkiresponse = null;
      GPKIHttpServletRequest gpkirequest = null;

      try {
          gpkiresponse = new GPKIHttpServletResponse(response);
          gpkirequest = new GPKIHttpServletRequest(request);

          gpkiresponse.setRequest(gpkirequest);
          model.addAttribute("challenge", gpkiresponse.getChallenge());

          return "egovframework/com/uat/uia/EgovGpkiRegist";

      } catch (Exception e) {
          return "egovframework/com/cmm/egovError";
      }
      }
      }
      */
      return "egovframework/com/uat/uia/EgovGpkiRegist";
   }

   /**
    * 인증서 DN값을 추출한다
    * @return result - dn값
    * @exception Exception
    */
   @RequestMapping(value = "/uat/uia/actionGpkiRegist.do")
   public String actionGpkiRegist(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

      /** GPKI 인증 부분 */
      // OS에 따라 (local NT(로컬) / server Unix(서버)) 구분
      String os = System.getProperty("os.arch");
      LOGGER.debug("OS : {}", os);
      
      // String virusReturn = null;
      @SuppressWarnings("unused")
      String dn = "";

      // 브라우저 이름을 받기위한 처리
      String webKind = EgovClntInfo.getClntWebKind(request);
      String[] ss = webKind.split(" ");
      String browser = ss[1];
      model.addAttribute("browser", browser);
      /*
      // -- 여기까지
      if (os.equalsIgnoreCase("x86")) {
         // Local Host TEST 진행중
      } else {
         if (browser.equalsIgnoreCase("Explorer")) {
            GPKIHttpServletResponse gpkiresponse = null;
            GPKIHttpServletRequest gpkirequest = null;
            try {
               gpkiresponse = new GPKIHttpServletResponse(response);
               gpkirequest = new GPKIHttpServletRequest(request);
               gpkiresponse.setRequest(gpkirequest);
               X509Certificate cert = null;

               // byte[] signData = null;
               // byte[] privatekey_random = null;
               // String signType = "";
               // String queryString = "";

               cert = gpkirequest.getSignerCert();
               dn = cert.getSubjectDN();

               model.addAttribute("dn", dn);
               model.addAttribute("challenge", gpkiresponse.getChallenge());

               return "egovframework/com/uat/uia/EgovGpkiRegist";
            } catch (Exception e) {
               return "egovframework/com/cmm/egovError";
            }
         }
      }
      */
      return "egovframework/com/uat/uia/EgovGpkiRegist";
   }
   
   
   @RequestMapping(value = "/agreeU")
   public String agreeU2(ModelMap model) throws Exception {
      String page = "/agreeU.do";
      model.addAttribute("page", page);
      return "egovframework/com/usr/EgovUnitMain";
   }
   @RequestMapping(value = "/agree")
   public String agree2(ModelMap model) throws Exception {
      String page = "/agree.do";
      model.addAttribute("page", page);
      return "egovframework/com/mng/EgovUnitMain";
   }
   @RequestMapping(value = "/agreeU.do")
   public String agreeU(ModelMap model) throws Exception {
      return "egovframework/com/uat/uia/EgovAgreeU";
   }
   @RequestMapping(value = "/agree.do")
   public String agree(ModelMap model) throws Exception {
      return "egovframework/com/uat/uia/EgovAgree";
   }
   
}