package egovframework.com.msg.rcv.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sun.star.io.IOException;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.mng.mem.service.CashVO;
import egovframework.com.mng.msd.service.EgovMessageLinePriceService;
import egovframework.com.mng.msd.service.MessageLinePriceVO;
import egovframework.com.mng.trs.service.EgovSenderKeyService;
import egovframework.com.mng.trs.service.SenderKeyVO;
import egovframework.com.msg.rcv.service.ComtccmmnDetailCode;
import egovframework.com.msg.rcv.service.EgovRcvaddrListService;
import egovframework.com.msg.rcv.service.RcvaddrList;
import egovframework.com.msg.rcv.service.RcvaddrListVO;
import egovframework.com.usr.add.service.AddressBookVO;
import egovframework.com.usr.add.service.EgovAddressBookService;
import egovframework.com.uss.umt.service.DeptManageVO;
import egovframework.com.uss.umt.service.EgovDeptManageService;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import oracle.jdbc.OraclePreparedStatement;
import twitter4j.JSONArray; 
 
@Controller
public class EgovRcvaddrListController {

	@Resource(name = "egovRcvaddrListService")
    private EgovRcvaddrListService rcvaddrListService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;

    @Resource(name="EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name="EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
    
    @Resource(name = "egovSenderKeyService")
    private EgovSenderKeyService senderKeyService;
 

    @Resource(name = "egovMessageLinePriceService")
    private EgovMessageLinePriceService linePriceService;
    
	/* 부서원드옭을 위해 */
	@Resource(name = "egovDeptManageService")
	private EgovDeptManageService egovDeptManageService;
    

	@Resource(name = "userManageService")
	private EgovUserManageService userManageService;
	

    @Resource(name = "egovAddressBookService")
    private EgovAddressBookService adbkService;
	
	
	
	@Autowired Properties globalsProperties;
	
	
	
	
	/*
	 * 
	 * User 전송화면
	 * 
	 * 
	 */
	/* 전송 */
	@IncludedInfo(name="전송", order=1000, gid=100)
	@RequestMapping("/usr/sender.do")
	public String sender(RcvaddrListVO rcvaddrListVO) throws Exception {
        return "egovframework/com/usr/exe/EgovSender";
	}
	

	@RequestMapping("/usr/sendermessage.do")
	public String sendermessage(RcvaddrListVO rcvaddrListVO) throws Exception {
        return "egovframework/com/usr/exe/EgovSenderMsg";
	}

	@RequestMapping("/usr/sendernotice.do")
	public String sendernotice(RcvaddrListVO rcvaddrListVO) throws Exception {
        return "egovframework/com/usr/exe/EgovSenderNotice";
	}
	
	@RequestMapping("/usr/senderfriend.do")
	public String senderfriend(RcvaddrListVO rcvaddrListVO) throws Exception {
        return "egovframework/com/usr/exe/EgovSenderFriend";
	}
	

	@RequestMapping("/usr/sendercongratuation.do")
	public String sendercongratuation(RcvaddrListVO rcvaddrListVO) throws Exception {
        return "egovframework/com/usr/exe/EgovSenderCongratuation";
	}
	

	
	
	/* 내 저장함 */
	@IncludedInfo(name="내저장함", order=1010, gid=110)
	@RequestMapping("/usr/templatebox.do")
	public String templetbox(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/exe/EgovTempBox";
	}
	
	
	@IncludedInfo(name="템플릿관리", order=1020, gid=120)
	@RequestMapping("/usr/template.do")
	public ModelAndView templateU(RcvaddrListVO rcvaddrListVO, SenderKeyVO searchVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		List<SenderKeyVO> list = senderKeyService.selectSenderKeyList(searchVO);
		
		mav.addObject("senderKeyList", list);
		mav.setViewName("egovframework/com/usr/exe/EgovTemplateU");
        return mav;
	}
	
	
	
	/*
	 * USER 전송관리
	 * 
	 * 
	 */
	
	/* 예약목록 */
	@IncludedInfo(name="예약목록", order=1010, gid=110)
	@RequestMapping("/usr/reservation.do")
	public String reservationListAjaxU(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/msg/EgovReservationU";
	}
	
	/* 예약목록 AJAX */
	@RequestMapping("/getReservationU.do")
	public ModelAndView reservationListU(RcvaddrListVO rcvaddrListVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			mav.setViewName("egovframe/com/cmm/EgovUnitMainLogin");

			return mav;
		}
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		rcvaddrListVO.setUserid(user.getId());
		rcvaddrListVO.setRcv_check("0"); //예약

		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrList(rcvaddrListVO);
		System.out.println("----getReservationU : " + rcvaddrList);
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvaddrListVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvaddrListVO.getPageUnit());
        paginationInfo.setPageSize(rcvaddrListVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", rcvaddrList);
        
        return mav;
	}
	
	
	/* 전송타입에 따르는 목록 */
	@IncludedInfo(name="발송단위별목록", order=1010, gid=110)
	@RequestMapping("/usr/listbytype.do")
	public String listByTypeAjaxU(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/msg/EgovListByTypeU";
	}
	
	@RequestMapping("/getlistbytypeU.do")
	public ModelAndView listByTypeU(RcvaddrListVO rcvaddrListVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			mav.setViewName("egovframe/com/cmm/EgovUnitMainLogin");
			return mav;
		}
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		rcvaddrListVO.setUserid(user.getId());
		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrList(rcvaddrListVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvaddrListVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvaddrListVO.getPageUnit());
        paginationInfo.setPageSize(rcvaddrListVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", rcvaddrList);
        
        return mav;
	}
	
	
	
	/* 전송타입에 따르는 목록 */
	@IncludedInfo(name="전송내역", order=1010, gid=110)
	@RequestMapping("/usr/listall.do")
	public String listTotalAjaxU(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/msg/EgovListTotalU";
	}
	
	@RequestMapping("/getlistallU.do")
	public String listTotalU(RcvaddrListVO rcvLst, ModelAndView mav) throws Exception {
	
		rcvLst.setFirstIndex(0);
		rcvLst.setRecordCountPerPage(999);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();


		if (!isAuthenticated) {
	        mav.addObject("data", "/");
			return "jsonView";
		} 
		  
		rcvLst.setUserid(user.getId());
		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrList(rcvLst);
		
		
		System.out.println("----getlistallU----" + rcvaddrList );
		
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvLst.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvLst.getPageUnit());
        paginationInfo.setPageSize(rcvLst.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", rcvaddrList);
        
        return "jsonView";
	}
	
	@RequestMapping("/usr/listallcont.do")
	public ModelAndView listall(RcvaddrList rcvaddrList, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		LoginVO user = (LoginVO)session.getAttribute("loginVO");
		
		rcvaddrList.setUser_id(user.getId());
		
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
		
		if(rcvaddrList.getMonth()==null) {
			System.out.println("month no!!!! =====" + format.format(now));
			rcvaddrList.setMonth(format.format(now));
			System.out.println("month?? :: "+rcvaddrList.getMonth());
		}
		
		List<RcvaddrList> list = rcvaddrListService.userListall(rcvaddrList);
		
		mav.addObject("data", list);
		
		return mav;
	}
	
	@RequestMapping("/mng/listallcont.do")
	public ModelAndView listallM(RcvaddrList rcvaddrList, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
		
		if(rcvaddrList.getMonth()==null) {
			System.out.println("month no!!!! =====" + format.format(now));
			rcvaddrList.setMonth(format.format(now));
			System.out.println("month?? :: "+rcvaddrList.getMonth());
		}
		
		List<RcvaddrList> list = rcvaddrListService.listallM(rcvaddrList);
		
		mav.addObject("data", list);
		
		return mav;
	}
	
	@RequestMapping("/usr/listallcontPartg.do")
	public ModelAndView listallcontPartg(RcvaddrList rcvaddrList, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		LoginVO user = (LoginVO)session.getAttribute("loginVO");
		
		String part_id = user.getOrgnztId();
		part_id = part_id.substring(part_id.length()-3, part_id.length());
		
		rcvaddrList.setUser_part(part_id);
		
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
		
		if(rcvaddrList.getMonth()==null) {
			System.out.println("month no!!!! =====" + format.format(now));
			rcvaddrList.setMonth(format.format(now));
			System.out.println("month?? :: "+rcvaddrList.getMonth());
		}
		
		List<RcvaddrList> list = rcvaddrListService.partgListall(rcvaddrList);
		
		mav.addObject("data", list);
		
		return mav;
	}
	
	@RequestMapping("/usr/reservationU.do")
	public ModelAndView reservationU(RcvaddrList rcvaddrList, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		LoginVO user = (LoginVO)session.getAttribute("loginVO");
		
		rcvaddrList.setUser_id(user.getId());
		
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
		
		if(rcvaddrList.getMonth()==null) {
			System.out.println("month no!!!! =====" + format.format(now));
			rcvaddrList.setMonth(format.format(now));
			System.out.println("month?? :: "+rcvaddrList.getMonth());
		}
		
		List<RcvaddrList> list = rcvaddrListService.reservationU(rcvaddrList);
		
		mav.addObject("data", list);
		
		return mav;
	}
	
	@RequestMapping("/usr/reservationsU.do")
	public ModelAndView reservationsU(RcvaddrList rcvaddrList, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		LoginVO user = (LoginVO)session.getAttribute("loginVO");
		rcvaddrList.setUser_id(user.getId());
		List<RcvaddrList> list = rcvaddrListService.reservationsU(rcvaddrList);
		mav.addObject("data", list);
		return mav;
	}
	@RequestMapping("/usr/reservationsM.do")
	public ModelAndView reservationsM(RcvaddrList rcvaddrList, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		LoginVO user = (LoginVO)session.getAttribute("loginVO");
		rcvaddrList.setUser_id(user.getId());
		List<RcvaddrList> list = rcvaddrListService.reservationsM(rcvaddrList);
		mav.addObject("data", list);
		return mav;
	}
	@RequestMapping("/usr/reservationsTo.do")
	public ModelAndView reservationsTo(RcvaddrList rcvaddrList, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		List<RcvaddrList> list = rcvaddrListService.reservationsTo(rcvaddrList);
		mav.addObject("data", list);
		return mav;
	}
	
	
	@RequestMapping("/mng/reservationU.do")
	public ModelAndView reservationM(RcvaddrList rcvaddrList, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
		
		if(rcvaddrList.getMonth()==null) {
			System.out.println("month no!!!! =====" + format.format(now));
			rcvaddrList.setMonth(format.format(now));
			System.out.println("month?? :: "+rcvaddrList.getMonth());
		}
		
		List<RcvaddrList> list = rcvaddrListService.reservationM(rcvaddrList);
		
		mav.addObject("data", list);
		
		return mav;
	}
	
	@RequestMapping("/getlistallUall.do")
	public ModelAndView listTotalUall(RcvaddrListVO rcvLst) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		rcvLst.setFirstIndex(0); 
		rcvLst.setRecordCountPerPage(999);
		 
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		rcvLst.setOrgnztId(user.getOrgnztId());
		List<UserManageVO> userManageVOList = rcvaddrListService.rcvaddrListUserId(rcvLst);
		mav.addObject("data", userManageVOList);
		
		return mav;
	}
	
	@RequestMapping("/deletelistallU.do")
	public ModelAndView deleteTotalU(RcvaddrListVO rcvLst) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		System.out.println(rcvLst.getRcv_id());
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	  	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	  	TransactionStatus txStatus = txManager.getTransaction(def); 
	  	try{
	  		//for(int i=0; i<rcvaddrList.size(); i++) {
	  			rcvaddrListService.resDelete(rcvLst);
	  			txManager.commit(txStatus);
	  		//}
				//정상일경우 COMMIT; 
	  			mav.addObject("data", 0);
	  			
	  	} catch (Exception e) { 
				e.printStackTrace();
				txManager.rollback(txStatus); 
				//에러날경우 CATCH로 빠져서 ROLLBACK; 
				mav.addObject("data", 1);
	  	}
		
		return mav;
	}
	@RequestMapping("/deletelistallsU.do")
	public ModelAndView deleteTotalsU(RcvaddrListVO rcvLst) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		System.out.println(rcvLst.getRcv_id());
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
	  	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
	  	TransactionStatus txStatus = txManager.getTransaction(def); 
	  	try{
	  		//for(int i=0; i<rcvaddrList.size(); i++) {
	  			rcvaddrListService.resDeletes(rcvLst);
	  			txManager.commit(txStatus);
	  		//}
				//정상일경우 COMMIT; 
	  			mav.addObject("data", 0);
	  			
	  	} catch (Exception e) { 
				e.printStackTrace();
				txManager.rollback(txStatus); 
				//에러날경우 CATCH로 빠져서 ROLLBACK; 
				mav.addObject("data", 1);
	  	}
		
		return mav;
	}
	
	/* 통계용 쿼리 
	 * */
	@IncludedInfo(name="통계", order=1010, gid=110)
	@RequestMapping("/usr/statistics.do")
	public String statisticAjaxU(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/msg/EgovStatisticsU";
	}
	
	@RequestMapping("/getstaticsU.do")
	public ModelAndView statisticU(RcvaddrListVO rcvaddrListVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrList(rcvaddrListVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvaddrListVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvaddrListVO.getPageUnit());
        paginationInfo.setPageSize(rcvaddrListVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", rcvaddrList);
        
        return mav;
	}
	
	
	/* 
	 * 
	 * USER 부서발송단위별전송   /  부서전송내역  / 부서업무별통계
	 * 
	 */
	
	@RequestMapping(value = "/usr/translistbytype.do")
	public String usrtranslistbytype(@ModelAttribute("RcvaddrListVO") RcvaddrListVO deptManageVO, ModelMap model) throws Exception {
 
		return "egovframework/com/usr/prt/EgovTransListByType";
	}	
	
	
	@RequestMapping(value = "/usr/translist.do")
	public String usrtranslist(@ModelAttribute("RcvaddrListVO") RcvaddrListVO deptManageVO, ModelMap model) throws Exception {
 
		return "egovframework/com/usr/prt/EgovTransList";
	}	
	
	
	@RequestMapping(value = "/usr/statisticsbyjob.do")
	public String usrstatisticsbyjob(@ModelAttribute("RcvaddrListVO") RcvaddrListVO deptManageVO, ModelMap model) throws Exception {
 
		return "egovframework/com/usr/prt/EgovStatisticsByJob";
	}	
	
	@RequestMapping("/usr/partstatistics.do")
	public String partstatistics(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/prt/EgovStatisticsByPart";
	}
	
	@RequestMapping("/usr/partstatdaily.do")
	public String partstatdaily(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/prt/EgovStatisticsDailyPart";
	}
	
	@RequestMapping("/usr/partstatmonth.do")
	public String partstatmonth(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/prt/EgovStatisticsMonthPart";
	}

	@RequestMapping("/usr/partstatyear.do")
	public String partstatyear(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/prt/EgovStatisticsYearPart";
	} 
	
	/* 경조사관리 */
	@IncludedInfo(name="경조사관리", order=1020, gid=120)
	@RequestMapping("/mng/congratuation.do")
	public String congratusationAjax(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/mng/trs/EgovCongratuation";
	}
	
	@RequestMapping("/getcongratuation.do")
	public ModelAndView congratuation(RcvaddrListVO rcvaddrListVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrList(rcvaddrListVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvaddrListVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvaddrListVO.getPageUnit());
        paginationInfo.setPageSize(rcvaddrListVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", rcvaddrList);
        
        return mav;
	}
	
	/* 예약목록 */
	@IncludedInfo(name="예약목록", order=1010, gid=110)
	@RequestMapping("/mng/reservation.do")
	public ModelAndView reservationListAjax(RcvaddrListVO rcvaddrListVO, DeptManageVO deptManageVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);
		
		
		mav.setViewName("egovframework/com/mng/trs/EgovReservation");
		mav.addObject("partIdList", list);
		return mav;
	}
	
	@RequestMapping("/getReservation.do")
	public ModelAndView reservationList(RcvaddrListVO rcvaddrListVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrList(rcvaddrListVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvaddrListVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvaddrListVO.getPageUnit());
        paginationInfo.setPageSize(rcvaddrListVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", rcvaddrList);
        
        return mav;
	}
	
	
	/* 전송타입에 따르는 목록 */
	@IncludedInfo(name="발송단위별목록", order=1010, gid=110)
	@RequestMapping("/mng/lstbytype.do")
	public String listByTypeAjax(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/mng/trs/EgovListByType";
	}
	
	@RequestMapping("/getlistbytype.do")
	public String listByType(ModelAndView mav,RcvaddrListVO rcvaddrListVO) throws Exception {
		 
		
		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrList(rcvaddrListVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvaddrListVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvaddrListVO.getPageUnit());
        paginationInfo.setPageSize(rcvaddrListVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", rcvaddrList);
        
        return "jsonView";
	}
	
	
	
	/* 전송타입에 따르는 목록 */
	@IncludedInfo(name="전송내역", order=1010, gid=110)
	@RequestMapping("/mng/listall.do")
	public String listTotalAjax(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/mng/trs/EgovListTotal";
	}
	
	
	/*
	 * 
	 * 전송전체내역 
	 * mng/trs/EgovListTotal
	 * mng/trs/EgovListByType
	 *  
	 */
	@RequestMapping("/getlistall.do")
	public String listTotal(RcvaddrListVO rcvaddrListVO, ModelAndView mav) throws Exception {

		//LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (!isAuthenticated) {
	        mav.addObject("data", "index.do");
			return "jsonView";
		}
		
		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrList(rcvaddrListVO);
		System.out.println("--getlistall--:" + rcvaddrList);
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvaddrListVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvaddrListVO.getPageUnit());
        paginationInfo.setPageSize(rcvaddrListVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", rcvaddrList);
        
        return "jsonView";
	}
	
	@RequestMapping("/usr/getlistall.do")
	public String usrGetlistall(RcvaddrListVO rcvaddrListVO, ModelAndView mav) throws Exception {

		//LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (!isAuthenticated) {
	        mav.addObject("data", "index.do");
			return "jsonView";
		}
		
		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrListUser(rcvaddrListVO);
		System.out.println("--getlistall--:" + rcvaddrList);
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvaddrListVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvaddrListVO.getPageUnit());
        paginationInfo.setPageSize(rcvaddrListVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", rcvaddrList);
        
        return "jsonView";
	}
	
	/* 
	 * 
	 * 통계용 쿼리  
	 *  
	 * 
	 */
	//기간별
	@IncludedInfo(name="전송내역", order=1010, gid=110)
	@RequestMapping("/mng/statistics.do")
	public ModelAndView statisticAjax(RcvaddrListVO rcvaddrListVO, DeptManageVO deptManageVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		 
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);


        mav.setViewName("egovframework/com/mng/trs/EgovStatistics");
		mav.addObject("partIdList", list);
		return mav;
	}
	
	//유형별
	@RequestMapping("/mng/statisticsbytype.do")
	public ModelAndView statisticsbytype(RcvaddrListVO rcvaddrListVO, DeptManageVO deptManageVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		 
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);


        mav.setViewName("egovframework/com/mng/trs/EgovStatisticsByType");
		mav.addObject("partIdList", list);
		return mav;
	}
	
	//문자메세지
	@RequestMapping("/mng/statsms.do")
	public String statsms(RcvaddrListVO rcvaddrListVO) throws Exception {
		
        return "egovframework/com/mng/trs/EgovStatSms";
	}
	
	//알림톡
	@RequestMapping("/mng/statalt.do")
	public String statalt(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/mng/trs/EgovStatAlt";
	}
	
	//친구톡
	@RequestMapping("/mng/statfrt.do")
	public String statfrt(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/mng/trs/EgovStatFrt";
	}
	
	//업무별
	@RequestMapping("/mng/statisticsbyjob.do")
	public ModelAndView statisticsbyjob(RcvaddrListVO rcvaddrListVO, DeptManageVO deptManageVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		 
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);


        mav.setViewName("egovframework/com/mng/trs/EgovStatJob");
		mav.addObject("partIdList", list);
		return mav;
	}
	
	//알림톡템플릿별
	@RequestMapping("/mng/statisticsbyalt.do")
	public ModelAndView statisticsbyalt(RcvaddrListVO rcvaddrListVO, DeptManageVO deptManageVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		 
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);


        mav.setViewName("egovframework/com/mng/trs/EgovStatAlarm");
		mav.addObject("partIdList", list);
		return mav;
	}
	
	//부서별
	@RequestMapping("/mng/statisticsbypart.do")
	public ModelAndView statisticsbypart(RcvaddrListVO rcvaddrListVO, DeptManageVO deptManageVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		 
		List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(deptManageVO);


        mav.setViewName("egovframework/com/mng/trs/EgovStatPart");
		mav.addObject("partIdList", list);
		
		return mav;
	}
	
	@RequestMapping("/getstatics.do")
	public ModelAndView statistic(RcvaddrListVO rcvaddrListVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrList(rcvaddrListVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvaddrListVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvaddrListVO.getPageUnit());
        paginationInfo.setPageSize(rcvaddrListVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", rcvaddrList);
        
        return mav;
	}
	
	@RequestMapping("/mng/statdaily.do")
	public String statisticDailyAjax(RcvaddrListVO rcvaddrListVO) throws Exception {
		
		return "egovframework/com/mng/trs/EgovStatDaily";
	}
	
	@RequestMapping("/mng/statmonth.do")
	public String statisticMonthAjax(RcvaddrListVO rcvaddrListVO) throws Exception {
		
        return "egovframework/com/mng/trs/EgovStatMonth";
	}

	@RequestMapping("/mng/statyear.do")
	public String statisticYearAjax(RcvaddrListVO rcvaddrListVO) throws Exception {
		
        return "egovframework/com/mng/trs/EgovStatYear";
	} 
	
	
	
	/****** USER STATISTIC  ***********/
	@RequestMapping("/usr/work.do")
	public ModelAndView statisticDailyWork() throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		

        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(); 
        
        
		List<ComtccmmnDetailCode> rcvaddrList = rcvaddrListService.workList();
        mav.addObject("data", rcvaddrList);
        
        MessageLinePriceVO linePrice = linePriceService.selectMessageLinePrice();
        System.out.println(linePrice);
        
        mav.addObject("price",linePrice);



    	HashMap<String, Integer> map = new HashMap<>();
    	List<CashVO> cashvo = userManageService.getPayFee(user.getId());
    	for(int i=0; i<cashvo.size(); i++) {
    		map.put(cashvo.get(i).getPay_code(), cashvo.get(i).getPay_fee());
    	}
    	
    	mav.addObject("cash", map); 
        
        return mav;
	}
	
	@RequestMapping("/usr/statdaily.do") 
	public String statisticDailyU(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/msg/EgovStatisticsDailyU";
	}
	
	@RequestMapping("/usr/statmonth.do")
	public String statisticMonthU(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/msg/EgovStatisticsMonthU";
	}

	@RequestMapping("/usr/statyear.do")
	public String statisticYearU(RcvaddrListVO rcvaddrListVO) throws Exception {

        return "egovframework/com/usr/msg/EgovStatisticsYearU";
	} 	
	
	
	
	/* 수신자명단에 대한 목록을 조회한다. */
	@IncludedInfo(name="수신자명단관리", order=380, gid=40)
	@RequestMapping("/msg/rcv/RcvaddrList.do")
	public ModelAndView rcvaddrList(RcvaddrListVO rcvaddrListVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<RcvaddrListVO> rcvaddrList = rcvaddrListService.rcvaddrList(rcvaddrListVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(rcvaddrListVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(rcvaddrListVO.getPageUnit());
        paginationInfo.setPageSize(rcvaddrListVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("rcvaddrList", rcvaddrList);
        
        return mav;
	}
	 
	private JSONArray mArray;
	@RequestMapping("/sendSMSBySmall.do")
	public String sendSMSBySmall(HttpServletRequest request, @RequestBody String paramData, Model model) throws Exception {  //RcvaddrList rcvaddrList
	     
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(); 
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
        /*ModelAndView mav = new ModelAndView("jsonView");*/

        if(!isAuthenticated) {
        	model.addAttribute("data", "index.do");
            return "jsonView";
        } 

		mArray = new JSONArray(paramData);  
		RcvaddrList rcvAddr = new RcvaddrList(); 
		/* 100개 미만 */ 
		for (int i = 0; i < mArray.length(); i ++){
			twitter4j.JSONObject jsonObj; 
			jsonObj = mArray.getJSONObject(i);
			
			rcvAddr.setUserid(user.getId());
			rcvAddr.setRcv_check("0"); //전송여부 
			rcvAddr.setRcv_emply_chk("0"); //1 직원
			rcvAddr.setRcv_type("0");  //SMS
			rcvAddr.setRcv_etc(jsonObj.getString("rcv_etc"));
			rcvAddr.setColumn1(jsonObj.getString("column1"));
			rcvAddr.setRcv_number(jsonObj.getString("rcv_number"));
			rcvAddr.setRcv_title(jsonObj.getString("title"));
			rcvAddr.setRcv_content(jsonObj.getString("content"));

		  	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		  	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		  	TransactionStatus txStatus = txManager.getTransaction(def); 
		  	try{
		  		//for(int i=0; i<rcvaddrList.size(); i++) {
		  			rcvaddrListService.rcvaddrInsert(rcvAddr);
		  			txManager.commit(txStatus);
		  		//}
					//정상일경우 COMMIT; 
					model.addAttribute("result", "1"); 
		  			
		  	} catch (Exception e) { 
					e.printStackTrace();
					txManager.rollback(txStatus); 
					//에러날경우 CATCH로 빠져서 ROLLBACK; 
					model.addAttribute("result", "0"); 
					return "jsonView";
		  	}
		}  
		return "jsonView";
	}
	
	
	
	
	@RequestMapping("/sendSMS.do")
	public ModelAndView sendSMS(HttpServletRequest request) throws Exception {  //RcvaddrList rcvaddrList

  
		
	    ModelAndView mav = new ModelAndView("jsonView");
	    
		
	    StringBuffer jb = new StringBuffer();
	    String line = null;
	    try {
	    	BufferedReader reader = request.getReader();
	        while ((line = reader.readLine()) != null) {
	        	jb.append(line);
	        }
	    } catch (Exception e) {
	    }

		System.out.println(jb); 
	    JSONObject jsonObj = new JSONObject(jb.toString()); 
		System.out.println(jsonObj);
		
		
		//System.out.println(param);
		//System.out.println(rcvaddrList);
	    //ObjectMapper mapper = new ObjectMapper();
        //mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false); //파라미터Map에서 DTO에 들어있지 않는 변수가 있어도 무시함.
        //List<testDTO> testDtoList = mapper.convertValue(paramData.get("testDtoList"), TypeFactory.defaultInstance().constructCollectionType(List.class, testDTO.class));
	 
	    
	    
		//System.out.println(request);  
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(); 
        
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
        /*ModelAndView mav = new ModelAndView("jsonView"); */
        if(!isAuthenticated) {
        	//model.addAttribute("data", "index.do");
            //return "jsonView";
        	
        	mav.addObject("data", "index.do");
        	return mav;
        }
         
          
        JSONArray mArray = new JSONArray(jsonObj.getString("data"));
        JSONArray mArrayGroup = new JSONArray(jsonObj.getString("group"));
        
		System.out.println(mArray);
		
		
		//로그인시 처리할 필요한 user 변수처리 OR 세션처리  
		//유저가 속한 부서코드 user.PartCode  uPartKey
		//유저가 속한 부서사무실대표번호 user.SenderTel  uSTel
		//유저가 속한 부서사무실휴대폰 user.SenderMobile uSMobile
		//유저가 속한 부서의 SendKey user.SenderKey uSKey
		//유저가 속한 부서의 발송라인 user.SenderLine  uSLine   ( properties 설정된 sendLine )
        //유저 IP  user.RemoteAddr  uIp

		
		//HttpSession session = request.getSession();
		//String name = (String) session.getAttribute("ssVar");
		
		
		
		/********* SENDER_KEY 가져오기  / 부서별 ID별 설정 ************/
		String senderKey = "92da360a25f7aaceedb33b446f8c5d59ff4d9dce";	
		
		
		int workSeq =  Integer.parseInt(jsonObj.getString("rcv_work_seq")); /* 업무분류 */
		int partNo =  Integer.parseInt(user.getOrgnztId().replace("ORGNZT_", "")); /* 부서번호 */

		int sendLine = 1; //"I-Heart(친구톡)";
		int sendPrice = jsonObj.getInt("price");;
		String reTitle = jsonObj.getString("title");
		String reContents = jsonObj.getString("content");
		int sendLineRe = 2; //재전송라인
		int sendTypeRe = 4; //4재전송다문 5장문멀티
		int sendPriceRe = 10; //재전송가격
		
		int groupSeq = 1;
		
		String title = jsonObj.getString("title");
		String contents = jsonObj.getString("content");		
		String sendType = jsonObj.getString("rcv_type"); /* 0 SMS 1 LMS 2 MMS 3 친구톡  4 알람톡  5 경조사  */
		
		//String sendNumber = jsonObj.getString("snd_number");
		//String sendNumber = jsonObj.getString("snd_number");
		
     	String sendDate = jsonObj.getString("snd_date");
	    if(sendDate != null && !sendDate.equals("")) {
	    	sendDate = sendDate.replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "");
	    	sendDate = "to_date('"+sendDate+"', 'YYYYMMDDHH24MISS')"; /* , '"+UUID.randomUUID().toString().replaceAll("-", "").substring(0,30)+"'"; */
	    }else {
	    	sendDate = "SYSDATE, null";
	    }
     	
		String remoteAddr = "233.111.111.111";
		String userSubId = "leanauto";
		String sendNumber = "01056351595";
		
		/***************** MMS 친구톡  ****************/ 
		/* 대체문자 */		
		reContents = jsonObj.getString("reContents"); 
		sendTypeRe = jsonObj.getInt("reType"); 
		
		/* Button JSON */
		String btnList = jsonObj.getString("btnList");  /* 친구톡 버튼 리스트 */ 
		
		/*********  알림톡일때  *********/ 
		/* 템플릿 변수 */
		String tmpVars = jsonObj.getString("tmpVars");
		
		
		System.out.println("----- title:" + title);
		System.out.println("----- contents:" + contents);
		
		 
		 List<RcvaddrList> list = new ArrayList<RcvaddrList>(); 
	     int length = mArray.length(); 
	     int length2 = mArrayGroup.length(); 

	     List<String> chkPhoneNum = new ArrayList<String>(); 
	     
	     for( int i = 0 ; i< length2 ; i++ ) { 
	    	 

	    	//그룹코드
	    	String groupId = mArrayGroup.getJSONObject(i).getString("grp_category");
	    	String groupName = mArrayGroup.getJSONObject(i).getString("grp_name");
	    	String groupType = mArrayGroup.getJSONObject(i).getString("grp_type");
	    	String rcv_etc = mArrayGroup.getJSONObject(i).getString("rcv_etc");
	    	int groupCount = mArrayGroup.getJSONObject(i).getInt("grp_cnt");
	    	String rcv_rsvt_chk = jsonObj.getString("rcv_rsvt_chk");
	    	
	    	
	    	System.out.println(groupId + ":" + groupName + ":" + groupType + ":" + rcv_etc + ":" + groupCount);
	    	if(groupCount > 0 ) {

		    	AddressBookVO adbkVO = new AddressBookVO();
		        adbkVO.setUser_id(user.getId());
		        adbkVO.setPart_id(user.getOrgnztId());
		    	adbkVO.setAddress_category(groupId.toString());
		    	adbkVO.setAddress_name(groupName.toString());
		    	adbkVO.setAddress_type(groupType.toString());

		     	List<AddressBookVO> addressList  = adbkService.selectAddressBookList(adbkVO); 
		     	
		     	addressList.forEach((temp) -> {   
			    	 RcvaddrList dto = new RcvaddrList(); 
			    	 dto.setColumn1(temp.getAddress_name());
			    	 dto.setRcv_number(temp.getAddress_num()); /* 받을 사람 */
			    	 dto.setUserid(user.getId());  
			    	 dto.setRcv_check("0"); //전송여부 
			    	 dto.setRcv_emply_chk("0"); //1 직원
			    	 //dto.setSend_date(sendDate);
			    	 dto.setRcv_title(title);  
			    	 dto.setRcv_content(contents); 
			    	 dto.setRcv_type(sendType);  //SMS
			    	 dto.setSnd_number(sendNumber);  
			    	 dto.setRcv_etc(rcv_etc);
			    	 dto.setRcv_rsvt_chk(rcv_rsvt_chk); 
			    	 /* RF_047_02 입력번호체크
			    	  * 
			    	  *
			    	  *
			    	 String rcvNum = mArray.getJSONObject(i).getString("rcv_number"); 
			    	 if(rcvNum.length() != 11 || rcvNum.substring(3).equals("010") ) {
			    		 System.out.println("-------" +rcvNum.length() + ":"  + rcvNum.substring(3).equals("010") );
			    		 chkPhoneNum.add(rcvNum);
			    	 }
			    	 */
			    	 list.add(dto);
				}); 
	    	}
	    	 //그룹에 속한 사람의 이름과 전번 얻어오기    getGroupUserList()  return 이름과 전번 
	    	 // mArrayUser	   
	     }
	     
	     
	     //다중 insert할 객체 list에 담기
	     for( int i = 0 ; i< length ; i++ ) {
	    	 RcvaddrList dto = new RcvaddrList(); 
	    	 dto.setUserid(user.getId());
	    	 
	    	 /* 경조사 옵션 : 지정계정발송  경조사 전송하기 에서 처리*/
	    	 /*
	    	 if( familyEventMasterId != "") {
	    		 String optId = mArray.getJSONObject(i).getString("optId");
	    		 if(optId.length() > 0) {
	    			 dto.setUserid(optId);
	    		 }
	    	 }
	    	 */	    	 
	    	 
	    	 dto.setRcv_check("0"); //전송여부 
	    	 dto.setRcv_emply_chk("0"); //1 직원
	    	 dto.setSend_date(sendDate);
	    	 dto.setRcv_title(title);
	    	 
	    	 

	         /* RF_046_12 메시지내용 가공   RF_046_13 이름/비고 데이터 대입
	         *  20200906 none 그룹전송/엑셀전송시는 서버에서 가공처리
	         *
	         */
	         /* 이름,비고 개별문자입력  */
	/*         if(contents.indexOf("#[이름]") != -1 ){
	        	 contents = contents.replace("#[이름]", mArray.getJSONObject(i).getString("column1"));  //이름
	         }
	         if(contents.indexOf("#[비고]") != -1 ){
	        	 contents = contents.replace("#[비고]", mArray.getJSONObject(i).getString("rcv_etc"));  //비고
	         } 
	         if(contents.indexOf("#[허수림]") != -1 ){
	        	 contents = contents.replace("#[허수림]", mArray.getJSONObject(i).getString("column1"));  //비고
	         } 
	         */
	         
	         
	         
	         
	    	 dto.setRcv_content(contents);  
	    	 
	    	 dto.setRcv_rsvt_chk(jsonObj.getString("rcv_rsvt_chk"));

	    	 dto.setRcv_type(sendType);  //SMS
	    	 dto.setSnd_number(sendNumber); /* 보내는 번호 */
	    	 
	    	 dto.setRcv_etc(mArray.getJSONObject(i).getString("rcv_etc"));
	    	 dto.setColumn1(mArray.getJSONObject(i).getString("column1"));
	    	 dto.setRcv_number(mArray.getJSONObject(i).getString("rcv_number")); /* 받을 사람 */
	    	 
	    	 
	    	 /* RF_047_02 입력번호체크
	    	  * 
	    	  */
	    	 String rcvNum = mArray.getJSONObject(i).getString("rcv_number"); 
	    	 if(rcvNum.length() != 11 || rcvNum.substring(3).equals("010") ) {
	    		 System.out.println("-------" +rcvNum.length() + ":"  + rcvNum.substring(3).equals("010") );
	    		 chkPhoneNum.add(rcvNum);
	    	 }
	    	 
	    	 list.add(dto);
	     }
	     
	     /*
	      * 
	      * RF_047_01 입력 번호 유효성 체크
	      * 
	      */
/*	     
		int chkPhoNumSize = 0;
	     if(chkPhoneNum != null) { chkPhoNumSize = chkPhoneNum.size(); }
	     
		 System.out.println("-------" + chkPhoNumSize + ":"  + chkPhoneNum.toString() );
*/
	     if( !chkPhoneNum.isEmpty()) {
	    	 mav.addObject("error", "0");
	    	 mav.addObject("errorcode", "잘못된 수신번호가 " + chkPhoneNum.size() + "개 있습니다");
	    	 mav.addObject("data", chkPhoneNum);
	    	 System.out.println("-----------------return-----------------");
	    	 return mav;
	     }
	  /*   	
		 System.out.println("-----#[이름] change contents indexOf:" + contents.indexOf("#[이름]") + contents);
		 System.out.println("-----[비고] change contents indexOf:" + contents.indexOf("[비고]") + contents);
		 System.out.println("-----비고 change contents indexOf:" + contents.indexOf("비고") + contents);
		 System.out.println("-----#[이름] change contents indexOf:" + contents.contains("#[이름]") + contents);*/
	     
	     double retTime = 0;
 
	     try {  
	    	 
	    	 if(sendType.equals("0")) {
	    		 retTime = insertBatchFileToDB_SMS(list, title, contents, partNo, user.getId(), workSeq, sendLine,
		            	sendPrice, sendDate, sendNumber, remoteAddr, groupSeq, userSubId);
	    	 };
	    	 

	    	 if(sendType.equals("1")) {
	    		 retTime = insertBatchFileToDB_LMS(list, title, contents, partNo, user.getId(), workSeq, sendLine,
		            	sendPrice, sendDate, sendNumber, remoteAddr, groupSeq, userSubId);
	    	 };
	    	 

	    	 if(sendType.equals("2")) {
	    			/* 이미지파일  */ 
	    			String imgFileName =  jsonObj.getString("imgFileName"); 
	    			String fileType =  jsonObj.getString("fileType"); 
	    		 retTime = insertBatchFileToDB_MMS(list, title, contents, partNo, user.getId(), workSeq, sendLine,
		            	sendPrice, sendDate, sendNumber, remoteAddr, groupSeq, userSubId, imgFileName, fileType);
	    	 };
	    	 if(sendType.equals("3")) {
	    			/* 이미지파일  */ 
	    			String imgFileName =  jsonObj.getString("imgFileName");  
	    			String fileType =  jsonObj.getString("fileType"); 
	    			String payCode = jsonObj.getString("payCode");
	    			System.out.println("----------payCode--------:" +payCode);
			     retTime = insertBatchFileToDB_FTALK(list, 
		    			partNo, user.getId(), workSeq, user.getIp(), groupSeq,
				        title, contents, imgFileName, btnList, reContents, tmpVars, reTitle, 
		    			senderKey, sendLine, sendPrice, sendDate, sendNumber, userSubId,
	 		        	sendTypeRe,  		sendLineRe,      		sendPriceRe,  payCode, fileType
			     );
	    	 };
	    	 if(sendType.equals("4")) {	 	
	    		 	String templateKey = jsonObj.getString("templateKey");
	    		 
	    		 System.out.println("---------tmpVars------" + tmpVars.length());
	    		 
	    		 if(tmpVars.length() > 0) { 
		    		 	retTime = insertBatchFileToDB_ATALK_Template(list, 
		    				partNo, user.getId(), workSeq, user.getIp(), groupSeq,
				        	title, contents, btnList, reContents, tmpVars, reTitle,
		    				senderKey, sendLine, sendPrice, sendDate, sendNumber, userSubId,
	 		        		sendTypeRe,  		sendLineRe,      		sendPriceRe,  templateKey 
		    		 	);
		    		 	
	    		 }else {
	    		 		retTime = insertBatchFileToDB_ATALK(list, 
	    		 				partNo, user.getId(), workSeq, user.getIp(), groupSeq,
	    		 				title, contents, btnList, reContents, tmpVars, reTitle,
	    		 				senderKey, sendLine, sendPrice, sendDate, sendNumber, userSubId,
	    		 				sendTypeRe,  		sendLineRe,      		sendPriceRe,  templateKey 
	    		 		);
	    		 }
	    		 	
	    			
	    		 	
	    		 	
	    	 };
	    	 /*switch (sendType) {
	            case "0":  
	                     break;
	            case "1":  
	                     break;
	            case "2":   
	                     break;
	            case "3":  
	                     break;
	            case "4": 
	                     break;
	            default: 
	                     break;
	        }*/
	    	 
	    	 	  
	        	mav.addObject("result", retTime);
	        	mav.addObject("result_msg", "ok");
		        //model.addAttribute("result", retTime); 
		        //model.addAttribute("result_msg", "ok");
		 } catch (IOException e) { 
		        //model.addAttribute("result_msg", e);
		       //return "jsonView";
	        	mav.addObject("data", e);
				return mav; 
		 } finally {  
			 
		 }  
		 

	   //model.addAttribute("result_msg", "ok");
	    
	    
	    
	    mav.addObject("data", "ok");
		return mav;
		
		
		
	}
	

	
	
	/* 수신자명단에 대한 항목을 insert한다.*/
	@RequestMapping(value="/msg/rcv/RcvaddrInsertBulk.do", method=RequestMethod.POST)
    public String rcvaddrInsertBulk_S(@RequestBody HashMap<String, Object> map) throws Exception {    	 
        System.out.println(map);        
        /* 	
    	Map<String, Object> result = new HashMap<String, Object>();
        Map<String, Object> paramMap = new HashMap<String, Object>();  
       
        JSONArray array = new JSONArray(jsonData);  //직렬화 시켜 가져온 오브젝트 배열을 JSONArray 형식으로 바꿔준다
        
        List<Map<String, Object>> resendList = new ArrayList<Map<String, Object>>();            
            
        for( JSONArray arr : array ){           
            
            JSONObject obj = (JSONObject)array.get(i); //JSONArray 형태의 값을 가져와 JSONObject 로 풀어준다 
                    
            Map<String, Object> resendMap = new HashMap<String, Object>();
                
            resendMap.put("memberId", obj.get("memberId"));
            resendMap.put("memberIdSeq", obj.get("memberIdSeq"));
            resendMap.put("resendToken", obj.get("resendToken"));
            resendMap.put("serverId", obj.get("serverId"));
                
            resendList.add(resendMap);
        }

		double retTime;		
	    try {
	    	
	        retTime = insertBatchFileToDB(jsonData); 
	        
	    } catch (IOException e) {
	    	
	       return "jsonView";
	    		   
	    } finally {
	    	
	    }	    
	    */ 	 
		return "jsonView";
    }
	
	
	@SuppressWarnings("unused")
	private static HashMap<String, String> setRequestToData(List<RcvaddrList> vo) throws Exception {
	   
		 
		double retTime;
		
 
	/*    try {
	    	
	         retTime = insertBatchFileToDB_SMS(vo); 
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    } finally {
	    }*/
	 
	    HashMap<String, String> retMap = new HashMap<String, String>();    // 필요값 리턴
	 
	    //retMap.put("retFileName", fileName);
	    //retMap.put("retTime", String.valueOf(retTime));
	    retMap.put("retSize", String.valueOf(vo.size()));
	    
	    return retMap;
	} 

	private static Connection getOrclConn() throws Exception {
	    Class.forName("oracle.jdbc.OracleDriver");
	    return DriverManager.getConnection("jdbc:oracle:thin:@igov.cpx2uec8lywv.ap-northeast-2.rds.amazonaws.com:1521:orcl", "leanauto", "09092019");
	}

	
	private static double insertBatchFileToDB_SMS(List<RcvaddrList> list, String title, String contents, int usrPart, String usrId, int workSeq, int sendLine,
			int sendPrice, String sendDate, String sendNumber, String remoteAddr, int boxSeq, String usrSubId) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용
		 
		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    PreparedStatement ps = null;    // 통상 PreparedStatement로 선언  

		    // sendLine = 1
		    /* 단문 */
		    StringBuffer sql = new StringBuffer("INSERT INTO MSG_DATA (")
					.append(" msg_seq")
	                .append(", req_date")
	                .append(", msg_id")
	                .append(", cur_state")
	                .append(", CENTER_SEQ")
	                
	                .append(", call_from")
	                .append(", call_to")
	                .append(", sms_txt")
	                .append(", msg_type")
	                .append(", cont_seq")
	                .append(", USER_PART")
	                .append(", USER_ID")
	                
	                .append(", WORK_SEQ")
	                .append(", PAY_CODE")
	                .append(", PAY_FEE")
	                .append(", SUB_ID")
	                .append(", BOXSEQ")
	                .append(") VALUES(MSG_DATA_SEQ.NEXTVAL, " + sendDate + ", 0, " + sendLine 
	                		+ ", ?, ?, ?, 4, 0," + usrPart + ",'" + usrId 
	                		+ "'," + workSeq + ", 'SMS'," + sendPrice + ",'" + usrSubId +"'," + boxSeq +" )"); 
		   
		    try{
		    	
		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
		        conn.setAutoCommit(false);                    // 자동 commit 끔
		 
		        // prepareStatement를 PreparedStatement으로 형변환
		        ps = (PreparedStatement) conn.prepareStatement(sql.toString());
		 
		        int cnt = 0;    // row Count
		 
		        for(RcvaddrList obj : list){

		            ps.setString(1, sendNumber);
		            ps.setString(2, obj.getRcv_number());
		            ps.setString(3, contents);
		            System.out.println("----------sndNumber:rev_number:contents:" + sendNumber + ":" + obj.getRcv_number() + ":" + contents );
    		        printSqlStatement(ps, sql.toString());
    		        
    		        
		            ps.addBatch();    // PreparedStatement에 batch로 완성된 SQL 추가
		            ps.clearParameters();    // PreparedStatement에 지정된 Parameter값 초기화
		            
		            cnt++;
		            if((cnt % 100) == 0){    // batch에 누적된 건수가 1만건
		                cnt = 0;
		                ps.executeBatch();    // 누적된 batch 실행
		                ps.clearBatch();    // 누적된 batch 초기화
		                conn.commit();        // Commit하여 적용
		            }
		        }
		 
		        // 최종적으로 누적된 채 남은 batch 작업(위의 if문) 실행
		        ps.executeBatch();
		        ps.clearBatch();
		        conn.commit();
		 
		    }catch(Exception e){	    	
		        e.printStackTrace();
		        ps.close();
		        conn.close();
		        return 0;	        
		    }finally{
		        ps.close();
		        conn.close();
		        
		    }
		 
		    long end = System.currentTimeMillis();    // 작동시간 측정용
		 
		    return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}
	
 
	private static double insertBatchFileToDB_LMS(List<RcvaddrList> list, String title, String contents, int usrPart, String usrId, int workSeq, int sendLine,
			int sendPrice, String sendDate, String sendNumber, String remoteAddr, int boxSeq, String usrSubId) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용
		 
System.out.println("-----------LMS Start---------------");
		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    PreparedStatement ps = null;    // 통상 PreparedStatement로 선언	
		    PreparedStatement preps = null;    // 통상 PreparedStatement로 선언	
		    
		    /* 알림톡 */
		    StringBuffer presql = new StringBuffer("") 
		    	.append(" INSERT INTO MMS_CONTENTS_INFO (")
				.append(" CONT_SEQ")
	            .append(", FILE_CNT") /* 1 메세지내용만 이미지만  2 이미지+메세지 */
	            .append(", MMS_SUBJECT") /* 대체문자 제목 */
	            .append(", MMS_BODY")  /* 대체문자 메세지내용 */
	            .append(", MMS_REQ_DATE") /*  */
	            .append(") VALUES(MMS_CONTENTS_INFO_SEQ.NEXTVAL, 1, ?, ?, SYSDATE) ");  //, 'Y','Y'
	                
	    		    int contSeq=0;
	    		    
	    		    try{
	    		    	
	    		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
	    		        conn.setAutoCommit(false);                    // 자동 commit 끔 
	    		        preps = (PreparedStatement) conn.prepareStatement(presql.toString());
	    		         
	    		        
	    		        preps.setString(1, title);  /* 대체문자 메세지내용 */
	    		        preps.setString(2, contents);  /* 대체문자 제목 */ 

	    		        /* PrepareStatement에서 SQL을 인쇄 */
	    		        printSqlStatement(preps, presql.toString());
	    		        
	    		        preps.executeUpdate();
	    		        System.out.println("------executeUpdate---");
	    		        preps.clearParameters();
	    		        conn.commit();	    		  		
	    		  		preps.close(); 
	    		        

	    		        preps = (PreparedStatement) conn.prepareStatement("SELECT MMS_CONTENTS_INFO_SEQ.CURRVAL AS CONT_SEQ FROM MMS_CONTENTS_INFO");
	    		        ResultSet rs = preps.executeQuery();
	    		        //rs.last();
	    		        //System.out.println("--------next--------" + rs.next());
	    		        if(rs.next()) { 
		    		        contSeq = rs.getInt("CONT_SEQ"); 
		    		        System.out.println("-----rs OK------" + contSeq);
	    		        } else {
	    		        	conn.rollback();
		    		        System.out.println("-----rollback------" + contSeq);
	    		        	return 0;
	    		        }
	      		         
	    		        System.out.println("contSeq= " + contSeq);
	    		        
	    		  	}catch(Exception e){	    	
	    		  		e.printStackTrace();	    		  		
	    		  		preps.close();
	    		  		conn.close();
	    		  		return 0;	        
	    			}finally{
	    				preps.close();
	    		  		conn.close();
	    		  	} 		    
		      
	    		    
	    		    
		    StringBuffer sql = new StringBuffer("")
		    		.append(" INSERT INTO MSG_DATA (")
					.append(" MSG_SEQ")
	                .append(", CUR_STATE")
	                .append(", USER_PART")
	                .append(", USER_ID")
	                .append(", WORK_SEQ")
	                .append(", CENTER_SEQ")
	                
	                .append(", PAY_CODE")
	                .append(", PAY_FEE")
	                .append(", CALL_FROM")
	                .append(", CALL_TO")
	                .append(", REQ_DATE")
	                .append(", msg_id")
	                .append(", REMOTE_ADDR")
	                
	                .append(", SMS_TXT")
	                .append(", MSG_TYPE")
	                .append(", CONT_SEQ")
	                .append(", SUB_ID")
	                .append(", BOXSEQ")
	                .append(") VALUES (MSG_DATA_SEQ.NEXTVAL,  0, " + usrPart + ",'" + usrId + "'," + workSeq + "," + sendLine + 
	                		", 'LMS', " + sendPrice + ", '" + sendNumber + "', ?, "+sendDate+", '" + remoteAddr + "', " +
	                		"NULL,  6, " + contSeq + ",'"+ usrSubId + "'," + boxSeq + ")");
		   
		    try{
		    	
		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
		        conn.setAutoCommit(false);                    // 자동 commit 끔
		 
		        // prepareStatement를 PreparedStatement으로 형변환
		        ps = (PreparedStatement) conn.prepareStatement(sql.toString());
		 
		        int cnt = 0;    // row Count
		 
		        for(RcvaddrList obj : list){
		        	 
		            ps.setString(1, obj.getRcv_number());  
		            
    		        printSqlStatement(ps, sql.toString());
		            
		            ps.addBatch();    // PreparedStatement에 batch로 완성된 SQL 추가
		            ps.clearParameters();    // PreparedStatement에 지정된 Parameter값 초기화
		            
		            cnt++;
		            if((cnt % 100) == 0){    // batch에 누적된 건수가 1만건
		                cnt = 0;
		                ps.executeBatch();    // 누적된 batch 실행
		                ps.clearBatch();    // 누적된 batch 초기화
		                conn.commit();        // Commit하여 적용
		            }
		        }
		 
		        // 최종적으로 누적된 채 남은 batch 작업(위의 if문) 실행
		        ps.executeBatch();
		        ps.clearBatch();
		        conn.commit();
		 
		    }catch(Exception e){	    	
		        e.printStackTrace();
		        ps.close();
		        conn.close();
		        return 0;	        
		    }finally{
		        ps.close();
		        conn.close();
		        
		    }
		 
		    long end = System.currentTimeMillis();    // 작동시간 측정용
		 
		    return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}
	
	private static double insertBatchFileToDB_MMS(List<RcvaddrList> list, String title, String contents, int usrPart, String usrId, int workSeq, int sendLine,
			int sendPrice, String sendDate, String sendNumber, String remoteAddr, int boxSeq, String usrSubId, String imgFileName, String fileType) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용
		 

System.out.println("-----------MMS Start---------------");
		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    PreparedStatement ps = null;    // 통상 PreparedStatement로 선언	
		    PreparedStatement preps = null;    // 통상 PreparedStatement로 선언	
		    
		    /* MMS */
		    StringBuffer presql = new StringBuffer("") 
		    		.append(" INSERT INTO MMS_CONTENTS_INFO (")
					.append(" CONT_SEQ")
	                .append(", FILE_CNT") /* 1 메세지내용만 이미지만  2 이미지+메세지 */
	                .append(", MMS_SUBJECT") /* 대체문자 제목 */
	                .append(", MMS_BODY")  /* 대체문자 메세지내용 */
	                .append(", FILE_TYPE1") /* 첨부파일 타입 */
	                .append(", FILE_NAME1") /* 파일명1 */
	                .append(", MMS_REQ_DATE") /*  */
	                .append(") VALUES(MMS_CONTENTS_INFO_SEQ.NEXTVAL, ?, ?, ?, ?, ?, SYSDATE) ");
	                
	    		    int contSeq=0;
	    		    
	    		    try{
	    		    	
	    		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
	    		        conn.setAutoCommit(false);                    // 자동 commit 끔 
	    		        preps = (PreparedStatement) conn.prepareStatement(presql.toString());
	    		         
	    		        /*
	    		         * 메세지만 이미지만 있으면 1  메세지+이미지 2
	    		         */
	    		        int fileCnt = 1;
	    		        //JSONObject imgJsonObj = new JSONObject(imgFileName.toString());
	    		        //imgFileName = imgJsonObj.get("string").toString();
	    		        
	    		        if( imgFileName.length() > 0 && contents.length() > 0) {
	    		        	fileCnt = 2;  /* 이미지도 있고 내용도 있고 */
	    		        }else {
	    		        	fileCnt = 1;  /* 대체문자 메세지내용 */
	    		        }
	    		        preps.setInt(1, fileCnt);  /* 대체문자 메세지내용 */
	    		        preps.setString(2, title);  /* 제목 */
	    		        preps.setString(3, contents);  /* 대체문자 메세지내용 */ 
	    		        
	    		        
	    		        if( imgFileName.length() > 0 ) { 
	    		        	imgFileName = "52d790d7057b4809a39d25ab60241cbc.jpg"; 
	    		        	String fileName = "C:\\tmp\\userImg\\" + imgFileName.toString(); 
		    		        preps.setString(4, fileType);  /* 첨부파일 타입 */
		    		        preps.setString(5, fileName);  /* 파일명1 */
	    		        } else {
		    		        preps.setString(4, null);  /* 첨부파일 타입 */
		    		        preps.setString(5, null);  /* 파일명1 */
	    		        }
	    		        
	    		        /* PrepareStatement에서 SQL을 인쇄 */
	    		        printSqlStatement(preps, presql.toString());
	    		        
	    		        preps.executeUpdate();
	    		        System.out.println("------executeUpdate---");
	    		        preps.clearParameters();
	    		        conn.commit();	    		  		
	    		  		preps.close(); 
	    		        

	    		        preps = (PreparedStatement) conn.prepareStatement("SELECT MMS_CONTENTS_INFO_SEQ.CURRVAL AS CONT_SEQ FROM MMS_CONTENTS_INFO");
	    		        ResultSet rs = preps.executeQuery();
	    		        //rs.last();
	    		        //System.out.println("--------next--------" + rs.next());
	    		        if(rs.next()) { 
		    		        contSeq = rs.getInt("CONT_SEQ"); 
		    		        System.out.println("-----rs OK------" + contSeq);
	    		        } else {
	    		        	conn.rollback();
		    		        System.out.println("-----rollback------" + contSeq);
	    		        	return 0;
	    		        }
	      		         
	    		        System.out.println("contSeq= " + contSeq);
	    		        
	    		  	}catch(Exception e){	    	
	    		  		e.printStackTrace();	    		  		
	    		  		preps.close();
	    		  		conn.close();
	    		  		return 0;	        
	    			}finally{
	    				preps.close();
	    		  		conn.close();
	    		  	} 
		   
	    		    
	    		    
	    		    
		    /* 친구톡 */
	    		    //sendLine = 3; /* center_seq */
	    		    
	    		    StringBuffer sql = new StringBuffer("")
	    		    		.append("INSERT INTO MSG_DATA (")
	    					.append(" MSG_SEQ")
	    	                .append(", CUR_STATE")
	    	                .append(", USER_PART")
	    	                .append(", USER_ID")
	    	                .append(", WORK_SEQ")
	    	                .append(", CENTER_SEQ")
	    	                
	    	                .append(", PAY_CODE")
	    	                .append(", PAY_FEE")
	    	                .append(", CALL_FROM")
	    	                .append(", CALL_TO")
	    	                .append(", REQ_DATE")
	    	                .append(", msg_id")
	    	                .append(", REMOTE_ADDR")
	    	                
	    	                .append(", SMS_TXT")
	    	                .append(", MSG_TYPE")
	    	                .append(", CONT_SEQ")
	    	                .append(", SUB_ID")
	    	                .append(", BOXSEQ")
	    	                .append(") VALUES(MSG_DATA_SEQ.NEXTVAL,  0, " + usrPart + ",'" + usrId + "'," + workSeq + "," + sendLine + 
	    	                		", 'MMS', " + sendPrice + ", '" + sendNumber + "', ?, "+sendDate+", '" +  remoteAddr + "', " +
	    	                		"NULL,  6, " + contSeq + ",'"+ usrSubId + "'," + boxSeq + ")");
		   
		    try{
		    	
		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
		        conn.setAutoCommit(false);                    // 자동 commit 끔
		 
		        // prepareStatement를 PreparedStatement으로 형변환
		        ps = (PreparedStatement) conn.prepareStatement(sql.toString());
		 
		        int cnt = 0;    // row Count
		 
		        for(RcvaddrList obj : list){ 
		            ps.setString(1, obj.getRcv_number()); 
		            
		            
		            ps.addBatch();    // PreparedStatement에 batch로 완성된 SQL 추가
		            ps.clearParameters();    // PreparedStatement에 지정된 Parameter값 초기화
		            
		            cnt++;
		            if((cnt % 100) == 0){    // batch에 누적된 건수가 1만건
		                cnt = 0;
		                ps.executeBatch();    // 누적된 batch 실행
		                ps.clearBatch();    // 누적된 batch 초기화
		                conn.commit();        // Commit하여 적용
		            }
		        }
		 
		        // 최종적으로 누적된 채 남은 batch 작업(위의 if문) 실행
		        ps.executeBatch();
		        ps.clearBatch();
		        conn.commit();
		 
		    }catch(Exception e){	    	
		        e.printStackTrace();
		        ps.close();
		        conn.close();
		        return 0;	        
		    }finally{
		        ps.close();
		        conn.close();
		        
		    }
		 
		    long end = System.currentTimeMillis();    // 작동시간 측정용
		 
		    return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}
	
	
	
	
	/*********************************** PrepareStatement에서 SQL을 인쇄 **********************************************/
	private static void printSqlStatement(PreparedStatement preparedStatement, String sql) throws SQLException{
        String[] sqlArrya= new String[preparedStatement.getParameterMetaData().getParameterCount()];
        try {
               Pattern pattern = Pattern.compile("\\?");
               Matcher matcher = pattern.matcher(sql);
               StringBuffer sb = new StringBuffer();
               int indx = 1;  // Parameter begin with index 1
               while (matcher.find()) {
             matcher.appendReplacement(sb,String.valueOf(sqlArrya[indx]));
               }
               matcher.appendTail(sb);
              System.out.println("Executing Query [" + sb.toString() + "] with Database[" + "] ...");
               } catch (Exception ex) {
                   System.out.println("Executing Query [" + sql + "] with Database[" +  "] ...");
            }

    }
	/******************************************************************************************************/
	
	private static double insertBatchFileToDB_FTALK(List<RcvaddrList> list, 
			int usrPart, String usrId, int workSeq, String remoteAddr, int groupSeq,
			String title, String contents, String imgFileName,  String btnList, String reContents, String tmpVars, String reTitle, 
			String senderKey, int sendLine, int sendPrice, String sendDate, String sendNumber, String usrSubId,
			int sendTypeRe, int sendLineRe, int sendPriceRe, String payCode, String fileType
	) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용

System.out.println("-----------Friend Talk Start---------------"); 	 

		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    PreparedStatement preps = null;    // 통상 PreparedStatement로 선언 
		    PreparedStatement ps = null;    // 통상 PreparedStatement로 선언 
		    
		    /* 친구톡 */
		    StringBuffer presql = new StringBuffer("") 
		    		.append(" INSERT INTO MMS_CONTENTS_INFO (")
					.append(" CONT_SEQ")
	                .append(", MMS_BODY")  /* 대체문자 메세지내용 */
	                .append(", MMS_SUBJECT") /* 대체문자 제목 */
	                .append(", FILE_TYPE1") /* 첨부파일 타입 */
	                .append(", FILE_NAME1") /* 데체문자 파일명 */
	                .append(", MMS_FRIEND_BUTTON") /* 친구톡 버튼 */
	                .append(", MMS_FRIEND_SUBJECT") /* 친구톡 제목 */
	                .append(", MMS_FRIEND_BODY") /* 친구톡 내용 */
	                .append(", MMS_FRIEND_FILE_NAME1") /* 친구톡 파일명 */
	                .append(", FILE_CNT") /* 1 메세지내용만 이미지만  2 이미지+메세지 */
	                .append(", MMS_REQ_DATE") /*  */
	                .append(") VALUES(MMS_CONTENTS_INFO_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE) ");
	                
	    		    int contSeq=0;
	    		    
	    		    try{
	    		    	
	    		    	//btnList = "";
	    		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
	    		        conn.setAutoCommit(false);                    // 자동 commit 끔 
	    		        preps = (PreparedStatement) conn.prepareStatement(presql.toString());
	    		        //mms_title = "제목";
	    		        //mms_contents = "내용";
	    		         
	    		        preps.setString(1, reContents);  /* 대체문자 메세지내용 */
	    		        preps.setString(2, title);  /* 대체문자 제목 */
	    		        
	    		        

	    		        if( imgFileName.length() > 0 ) { 
	    		        	imgFileName = "52d790d7057b4809a39d25ab60241cbc.jpg"; 
	    		        	String fileName = "C:\\tmp\\userImg\\" + imgFileName.toString(); 
		    		        preps.setString(3, fileType);  /* 첨부파일 타입 */
		    		        preps.setString(4, fileName);  /* 파일명1 */
		    		        preps.setString(8, fileName);  /* 친구톡 파일명 */
	    		        } else {
		    		        preps.setString(3, null);  /* 첨부파일 타입 */
		    		        preps.setString(4, null);  /* 파일명1 */
		    		        preps.setString(8, null);  /* 파일명1 */
	    		        }    
	    		        preps.setString(5, btnList);  /* 친구톡 버튼 */
	    		        preps.setString(6, title);  /* 친구톡 제목 */
	    		        preps.setString(7, contents);  /* 친구톡 내용 */
	    		        
	    		        if(payCode.equals("FIT")) {
		    		        preps.setInt(9, 2);  /* 2 파일과 텍스트 */
	    		        }else {
		    		        preps.setInt(9, 1);  /* 1 텍스트 */
	    		        }

	    		        /* PrepareStatement에서 SQL을 인쇄 */
	    		        printSqlStatement(preps, presql.toString());
	    		        
	    		        preps.executeUpdate();
	    		        System.out.println("------executeUpdate---");
	    		        preps.clearParameters();
	    		        conn.commit();	    		  		
	    		  		preps.close(); 
	    		        

	    		        preps = (PreparedStatement) conn.prepareStatement("SELECT MMS_CONTENTS_INFO_SEQ.CURRVAL AS CONT_SEQ FROM MMS_CONTENTS_INFO");
	    		        ResultSet rs = preps.executeQuery();
	    		        //rs.last();
	    		        //System.out.println("--------next--------" + rs.next());
	    		        if(rs.next()) { 
		    		        contSeq = rs.getInt("CONT_SEQ"); 
	    		        } else {
	    		        	conn.rollback();
	    		        	return 0;
	    		        }
	      		         
	    		        System.out.println("contSeq= " + contSeq);
	    		        
	    		  	}catch(Exception e){	    	
	    		  		e.printStackTrace();	    		  		
	    		  		preps.close();
	    		  		conn.close();
	    		  		return 0;	        
	    			}finally{
	    				preps.close();
	    		  		conn.close();
	    		  	}   
	                 
System.out.println(
"usrPart:" + usrPart + "," +
"usrId:" + usrId + "," +
"workSeq:" + workSeq + "," +
"sendLine:" + sendLine + "," +
"curDate:" + sendDate + "," +
"sendPrice:" + sendPrice + "," +
"remoteAddr:" + remoteAddr + "," +
"groupSeq:" + groupSeq + "," +
"senderKey:" + senderKey + "," +
"sendTypeRe:" + sendTypeRe + "," +
"sendLineRe:" + sendLineRe + "," +
"sendPrice:" + sendPrice + ","  +
"payCode:" + payCode + ","
);                
	                    
					sendLine = 4;
	    		    StringBuffer sql = new StringBuffer("")     
	    		    		.append(" INSERT INTO MSG_DATA (")
	    					.append(" MSG_SEQ")
	    					.append(", CONT_SEQ") /* MMS_CONTENTS_INFO.CONT_SEQ */
	    	                .append(", CUR_STATE") /* 0 */
	    					
	    	                .append(", USER_PART") /* 부서코드 */
	    					.append(", USER_ID") /* 사용자 ID */
	    					.append(", WORK_SEQ") /* 업무구분코드 */
	    					
	    					.append(", CENTER_SEQ") /* 발송라인 */
	    	                .append(", REQ_DATE") /* 즉시(예약)발송 일시 */
	    	                .append(", msg_id")
	    					.append(", PAY_CODE") /* 친구톡 FRT텍스트만 FRI이미지만 FIT 텍스트+이미지 */
	    					.append(", PAY_FEE") /* 발송단가 */
	    	                .append(", CALL_TO") /* 수신번호 */					
	    	                .append(", CALL_FROM") /* 발신번호 */
	    	                .append(", REMOTE_ADDR") /* 사용자IP */				
	    	                	
	    	                .append(", MSG_TYPE") /* 8 알림톡/친구톡 */	
	    	                .append(", MSG_TYPE_RESEND") /* 대체문자 발송타입 */
	    	                .append(", SMS_TXT") /* SMS용 메세지 내용 */
	    	                .append(", CENTER_SEQ_RESEND") /* 대체문자 발송라인 */
	    	                .append(", BOXSEQ")	/* 발송그룹 테이블 PK값 */
	    	                .append(", SUB_ID") /* 사용자 서브아이디 */
	    	                .append(", msg_noticetalk_sender_key")
	    	                .append(") VALUES(MSG_DATA_SEQ.NEXTVAL, " + contSeq + ", 0, " + usrPart + ", '" + usrId + "',  " + workSeq + 
	    	                		", " + sendLine + ", "+sendDate+", '" + payCode + "', " + sendPrice + ", ?, '" + sendNumber + "',  '" + remoteAddr + 
	    	                		"', 8, "+ sendTypeRe + ",'" +  reContents + "',1," + groupSeq + ",'" + usrSubId + "','" + senderKey + "' ) "); 
		        

	    	try{
	    		    	
	    		conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
	    		conn.setAutoCommit(false);                    // 자동 commit 끔 
		 
		        // prepareStatement를 z으로 형변환 
		        ps = conn.prepareStatement(sql.toString());
		 
		        int cnt = 0;    // row Count

		        Calendar cal = Calendar.getInstance();
		        Date curDate = new java.sql.Date(cal.getTimeInMillis()); 
		        System.out.println("date :" + curDate);
		        
		        for(RcvaddrList obj : list){ 
		        	
		            ps.setString(1, obj.getRcv_number()); /* 수신번호 */	 
		                        
		            
		            
		            ps.addBatch();    // OraclePreparedStatement에 batch로 완성된 SQL 추가
		            ps.clearParameters();    // OraclePreparedStatement에 지정된 Parameter값 초기화
		            
		            System.out.println(sql);
		            
    		        /* PrepareStatement에서 SQL을 인쇄 */
    		        printSqlStatement(ps, sql.toString());
		            
		            cnt++;
		            if((cnt % 100) == 0){    // batch에 누적된 건수가 1만건
		                cnt = 0;
		                ps.executeBatch();    // 누적된 batch 실행
		                ps.clearBatch();    // 누적된 batch 초기화
		                conn.commit();        // Commit하여 적용
		            }
		        }
		 
		        // 최종적으로 누적된 채 남은 batch 작업(위의 if문) 실행
		        ps.executeBatch();
		        ps.clearBatch();
		        conn.commit();
		 
		    }catch(Exception e){	    	
		        e.printStackTrace();
		        ps.close();
		        conn.close();
		        return 0;	        
		    }finally{
		        ps.close();
		        conn.close();
		        
		    }
		 
		    long end = System.currentTimeMillis();    // 작동시간 측정용
		 
		    return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}


	
	private static double insertBatchFileToDB_ATALK(List<RcvaddrList> list, 
			int usrPart, String usrId, int workSeq, String remoteAddr, int groupSeq,
			String title, String contents, String btnList, String reContents, String tmpVars, String reTitle, 
			String senderKey, int sendLine, int sendPrice, String sendDate, String sendNumber, String usrSubId,
			int sendTypeRe, int sendLineRe, int sendPriceRe, String templateKey
) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용

System.out.println("-----------Alarm Talk Start---------------"); 
		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    PreparedStatement ps = null;    // 통상 PreparedStatement로 선언	
		    PreparedStatement preps = null;    // 통상 PreparedStatement로 선언	
		    PreparedStatement psU = null;    // 통상 PreparedStatement로 선언	
		    
		    /* 알림톡 */
		    StringBuffer presql = new StringBuffer("") 
		    		.append(" INSERT INTO MMS_CONTENTS_INFO (")
					.append(" CONT_SEQ")
	                .append(", FILE_CNT") /* 1 메세지내용만 이미지만  2 이미지+메세지 */
	                .append(", MMS_BODY")  /* 대체문자 메세지내용 */
	                .append(", MMS_SUBJECT") /* 대체문자 제목 */
	                .append(", MMS_NOTICETALK_SUBJECT") /* 알림톡 제목 */
	                .append(", MMS_NOTICETALK_BODY") /* 알림톡 내용 */
	                .append(", MMS_NOTICETALK_BUTTON") /* 알림톡 버튼 */
	                //.append(", FILE_TYPE1") /* 첨부파일 타입 */
	                //.append(", FILE_NAME1") /* 파일명1 */
	                //.append(", FILE_NAME2") /* 파일명2 */
	                .append(", MMS_REQ_DATE") /*  */
	                //.append(", BUILD_YN") /*  */
	                //.append(", REUSE_YN") /*  */
	                .append(") VALUES(MMS_CONTENTS_INFO_SEQ.NEXTVAL, 1, ?, ?, ?, ?, ?, SYSDATE) ");  //, 'Y','Y'
	                
	    		    int contSeq=0;
	    		    
	    		    try{
	    		    	
	    		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
	    		        conn.setAutoCommit(false);                    // 자동 commit 끔 
	    		        preps = (PreparedStatement) conn.prepareStatement(presql.toString());
	    		        
	    		        String buttons = null;
	    		        buttons ="{\"name\":\"홈페이지\",\"type\":\"WL\",\"url_pc\":\"http://www.leanauto.kr\",\"url_mobile\":\"http://www.leanauto.kr\"}";
	    		        
	    		        
	    		        preps.setString(1, reContents);  /* 대체문자 메세지내용 */
	    		        preps.setString(2, title);  /* 대체문자 제목 */
	    		        preps.setString(3, title);  /* 친구톡 제목 */
	    		        preps.setString(4, contents);  /* 친구톡 내용 */
	    		        preps.setString(5, btnList);  /* 친구톡 버튼 */ 
	    		        
	    		        /* PrepareStatement에서 SQL을 인쇄 */
	    		        printSqlStatement(preps, presql.toString());
	    		        
	    		        preps.executeUpdate();
	    		        System.out.println("------executeUpdate---");
	    		        preps.clearParameters();
	    		        conn.commit();	    		  		
	    		  		preps.close(); 
	    		        

	    		        preps = (PreparedStatement) conn.prepareStatement("SELECT MMS_CONTENTS_INFO_SEQ.CURRVAL AS CONT_SEQ FROM MMS_CONTENTS_INFO");
	    		        ResultSet rs = preps.executeQuery();
	    		        //rs.last();
	    		        //System.out.println("--------next--------" + rs.next());
	    		        if(rs.next()) { 
		    		        contSeq = rs.getInt("CONT_SEQ"); 
		    		        System.out.println("-----rs OK------" + contSeq);
	    		        } else {
	    		        	conn.rollback();
		    		        System.out.println("-----rollback------" + contSeq);
	    		        	return 0;
	    		        }
	      		         
	    		        System.out.println("contSeq= " + contSeq);
	    		        
	    		  	}catch(Exception e){	    	
	    		  		e.printStackTrace();	    		  		
	    		  		preps.close();
	    		  		conn.close();
	    		  		return 0;	        
	    			}finally{
	    				preps.close();
	    		  		conn.close();
	    		  	} 
		   

	    		    /* 테스트 템플릿 */
	    		    //senderKey = "db57de057c64e69eeb2a065f7bff62092a9d5f84";
	    		    //String templateKey = "ta012701";
	    		    
	    		    senderKey = "92da360a25f7aaceedb33b446f8c5d59ff4d9dce";
	    		    //templateKey = "L003";
	    		    
	    		    System.out.println(
	    		    	    "usrPart:" + usrPart + "," +
	    		    	    "usrId:" + usrId + "," +
	    		    	    "workSeq:" + workSeq + "," +
	    		    	    "sendLine:" + sendLine + "," +
	    		    	    "curDate:" + sendDate + "," +
	    		    	    "sendPrice:" + sendPrice + "," +
	    		    	    "remoteAddr:" + remoteAddr + "," +
	    		    	    "groupSeq:" + groupSeq + "," +
	    		    	    "senderKey:" + senderKey + "," +
	    		    	    "sendTypeRe:" + sendTypeRe + "," +
	    		    	    "sendLineRe:" + sendLineRe + "," +
	    		    	    "sendPrice:" + sendPrice + "," 
	    		    	    );   
	    		    sendLine = 3;
	    		    StringBuffer sql = new StringBuffer("")     
	    		    		.append(" INSERT INTO MSG_DATA (")
	    					.append(" MSG_SEQ")
	    					.append(", CONT_SEQ") /* MMS_CONTENTS_INFO.CONT_SEQ */
	    	                .append(", CUR_STATE") /* 0 */
	    					
	    	                .append(", USER_PART") /* 부서코드 */
	    					.append(", USER_ID") /* 사용자 ID */
	    					.append(", WORK_SEQ") /* 업무구분코드 */
	    					
	    					.append(", CENTER_SEQ") /* 발송라인 */
	    	                .append(", REQ_DATE") /* 즉시(예약)발송 일시 */
	    	                .append(", msg_id")
	    					.append(", PAY_CODE") /* 알림톡 */
	    					.append(", PAY_FEE") /* 발송단가 */
	    	                .append(", CALL_TO") /* 수신번호 */					
	    	                .append(", CALL_FROM") /* 발신번호 */
	    	                .append(", REMOTE_ADDR") /* 사용자IP */				
	    	                
	    	                //.append(", SMS_TXT") /* SMS용 메세지 내용 */	
	    	                .append(", MSG_TYPE") /* 8 알림톡/친구톡 */		
	    	                .append(", SMS_TXT") 	
	    	                .append(", MSG_TYPE_RESEND")
	    	                .append(", MSG_NOTICETALK_SENDER_KEY")	/* SENDER KEY */		
	    	                .append(", MSG_NOTICETALK_TMP_KEY") /* NULL */ 
	    	                //.append(", CENTER_SEQ_RESEND") /* 대체문자 발송라인 */
	    	                //.append(", RSLT_NET") /* 친구톡 발송결과  1 */
	    	                //.append(", MSG_RESEND_COUNT") /*발송싶패하여 재전송한 카운트 */
	    	                .append(", BOXSEQ")	/* 발송그룹 테이블 PK값 */
	    	                .append(", SUB_ID") /* 사용자 서브아이디 */
	    	                .append(") VALUES(MSG_DATA_SEQ.NEXTVAL, " + contSeq + ", 0, " + 
	    	                		usrPart + ", '" + usrId + "',  " + workSeq + 
	    	                		", " + sendLine + ", "+sendDate+", 'NOT', " + sendPrice + ", ?, '" + sendNumber + "',  '" + remoteAddr + 
	    	                		"', 8,'" + reContents + "'," + sendTypeRe + ",'" + senderKey + "', '" + templateKey + "', " + groupSeq + ",'" + usrSubId + "' ) "); 
/*
            		", " + sendLine + ", SYSDATE, 'NOT', " + sendPrice + ", ?, '" + sendNumber + "',  '" + remoteAddr +  
	    	                		"', 8," + sendTypeRe + ",'" + senderKey + "', '" + templateKey + "', " + groupSeq + ",'" + usrSubId + "' ) "); 
*/          
 
	    					
	    		    
	    	    	try{
	    	    		    	
	    	    		conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
	    	    		conn.setAutoCommit(false);                    // 자동 commit 끔 
	    		 
	    		        // prepareStatement를 PreparedStatement으로 형변환
	    		        ps = (PreparedStatement) conn.prepareStatement(sql.toString());
	    		        psU = (PreparedStatement) conn.prepareStatement(sql.toString());
	    		 
	    		        int cnt = 0;    // row Count +

	    		        Calendar cal = Calendar.getInstance();
	    		        Date curDate = new java.sql.Date(cal.getTimeInMillis()); 
	    		        System.out.println("date :" + curDate);
	    		        
	    		        for(RcvaddrList obj : list){  
	    		        	
	    		            ps.setString(1, obj.getRcv_number()); /* 수신번호 */	 
	    		            
	    		            String[] k = tmpVars.split("||");
	    		            for( int t=0; t < k.length ; t++) {
	    		            	reContents = contents.replace(k[t],obj.getColumn1());
	    		            }
	    		            
	    		            ps.addBatch();    // PreparedStatement에 batch로 완성된 SQL 추가
	    		            ps.clearParameters();    // PreparedStatement에 지정된 Parameter값 초기화
	    		            
	    		            System.out.println(sql);
	    		            
	        		        /* PrepareStatement에서 SQL을 인쇄 */
	        		        printSqlStatement(ps, sql.toString());
	    		            
	    		            cnt++;
	    		            if((cnt % 100) == 0){    // batch에 누적된 건수가 1만건
	    		                cnt = 0;
	    		                ps.executeBatch();    // 누적된 batch 실행
	    		                ps.clearBatch();    // 누적된 batch 초기화
	    		                conn.commit();        // Commit하여 적용
	    		            }
	    		        }
	    		 
	    		        // 최종적으로 누적된 채 남은 batch 작업(위의 if문) 실행
	    		        ps.executeBatch();
	    		        ps.clearBatch();
	    		        conn.commit();
	    		 
	    		    }catch(Exception e){	    	
	    		        e.printStackTrace();
	    		        ps.close();
	    		        conn.close();
	    		        return 0;	        
	    		    }finally{
	    		        ps.close();
	    		        conn.close();
	    		        
	    		    }
	    		 
	    		    long end = System.currentTimeMillis();    // 작동시간 측정용
	    		 
	    		    return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}


	private static double insertBatchFileToDB_ATALK_Template(List<RcvaddrList> list, 
			int usrPart, String usrId, int workSeq, String remoteAddr, int groupSeq,
			String title, String contents, String btnList, String reContents, String tmpVars, String reTitle, 
			String senderKey, int sendLine, int sendPrice, String sendDate, String sendNumber, String usrSubId,
			int sendTypeRe, int sendLineRe, int sendPriceRe, String templateKey
) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용

System.out.println("-----------Alarm Talk Start---------------"); 
		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    PreparedStatement ps = null;    // 통상 PreparedStatement로 선언	
		    PreparedStatement preps = null;    // 통상 PreparedStatement로 선언	
		    PreparedStatement psU = null;    // 통상 PreparedStatement로 선언	
		    
		    
		    
		    String RefContent = contents;
		    
		    
	        for(RcvaddrList obj : list){  
		    
		    
		    
		    /* 알림톡 */
		    StringBuffer presql = new StringBuffer("") 
		    		.append(" INSERT INTO MMS_CONTENTS_INFO (")
					.append(" CONT_SEQ")
	                .append(", FILE_CNT") /* 1 메세지내용만 이미지만  2 이미지+메세지 */
	                .append(", MMS_BODY")  /* 대체문자 메세지내용 */
	                .append(", MMS_SUBJECT") /* 대체문자 제목 */
	                .append(", MMS_NOTICETALK_SUBJECT") /* 알림톡 제목 */
	                .append(", MMS_NOTICETALK_BODY") /* 알림톡 내용 */
	                .append(", MMS_NOTICETALK_BUTTON") /* 알림톡 버튼 */
	                //.append(", FILE_TYPE1") /* 첨부파일 타입 */
	                //.append(", FILE_NAME1") /* 파일명1 */
	                //.append(", FILE_NAME2") /* 파일명2 */
	                .append(", MMS_REQ_DATE") /*  */
	                //.append(", BUILD_YN") /*  */
	                //.append(", REUSE_YN") /*  */
	                .append(") VALUES(MMS_CONTENTS_INFO_SEQ.NEXTVAL, 1, ?, ?, ?, ?, ?, SYSDATE) ");  //, 'Y','Y'
	                
	    		    int contSeq=0;
	    		    
	    		    try{
	    		    	
	    		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
	    		        conn.setAutoCommit(false);                    // 자동 commit 끔 
	    		        preps = (PreparedStatement) conn.prepareStatement(presql.toString());
	    		        
	    		        /* 테스트용 템플릿 */
//	    		        title = "111";
//	    		        contents = "홍길동님이 신청하신 민원 (1004번)이 시스템과에 접수되었습니다.";
	    		        
	    		        //title = "린오토 회원가입안내 L003";
	    		        //contents = "안녕하세요 #{허수림}님 회원가입 축하드립니다";
	    		         
	    		        
	    		        String buttons = null;
	    		        buttons ="{\"name\":\"홈페이지\",\"type\":\"WL\",\"url_pc\":\"http://www.leanauto.kr\",\"url_mobile\":\"http://www.leanauto.kr\"}";
	    		        
	    		        
	    		        /*
	    		        buttons = 	"{\"ordering\":1,\"name\":\"홈페이지\"," + 
	    		        			"\"linkType\":\"WL\",\"linkTypeName\":\"웹링크\"," + 
	    		        		    "\"linkMo\":\"http://www.leanauto.kr\",\"linkPc\":\"http://www.leanauto.kr\"}"; 
	    		         */

    		            String[] k = tmpVars.split("\\|\\|");
    		            
    		            for(String s:k){
    		            	if(s.equals("#{이름}"))    	contents = RefContent.replace(s,obj.getColumn1());
    		            	if(s.equals("#{비고}"))    	contents = RefContent.replace(s,obj.getRcv_etc());
    		            	if(s.equals("#{허수림}"))    	contents = RefContent.replace(s,obj.getColumn1());
    		            }
    		            
	    		        System.out.println("+++++++ name : " + obj.getColumn1());
	    		        preps.setString(1, reContents);  /* 대체문자 메세지내용 */
	    		        preps.setString(2, title);  /* 대체k문자 제목 */
	    		        preps.setString(3, title);  /* 친구톡 제목 */
	    		        preps.setString(4, contents);  /* 친구톡 내용 */
	    		        preps.setString(5, btnList);  /* 친구톡 버튼 */ 
	    		        
	    		        /* PrepareStatement에서 SQL을 인쇄 */
	    		        printSqlStatement(preps, presql.toString());
	    		        
	    		        preps.executeUpdate();
	    		        System.out.println("------executeUpdate---");
	    		        preps.clearParameters();
	    		        conn.commit();	    		  		
	    		  		preps.close(); 
	    		        

	    		        preps = (PreparedStatement) conn.prepareStatement("SELECT MMS_CONTENTS_INFO_SEQ.CURRVAL AS CONT_SEQ FROM MMS_CONTENTS_INFO");
	    		        ResultSet rs = preps.executeQuery();
	    		        //rs.last();
	    		        //System.out.println("--------next--------" + rs.next());
	    		        if(rs.next()) { 
		    		        contSeq = rs.getInt("CONT_SEQ"); 
		    		        System.out.println("-----rs OK------" + contSeq);
	    		        } else {
	    		        	conn.rollback();
		    		        System.out.println("-----rollback------" + contSeq);
	    		        	return 0;
	    		        }
	      		         
	    		        System.out.println("contSeq= " + contSeq);
	    		        
	    		  	}catch(Exception e){	    	
	    		  		e.printStackTrace();	    		  		
	    		  		preps.close();
	    		  		conn.close();
	    		  		return 0;	        
	    			}finally{
	    				preps.close();
	    		  		conn.close();
	    		  	} 
		   
 
	    		    sendLine = 3;
	    		    StringBuffer sql = new StringBuffer("")     
	    		    		.append(" INSERT INTO MSG_DATA (")
	    					.append(" MSG_SEQ")
	    					.append(", CONT_SEQ") /* MMS_CONTENTS_INFO.CONT_SEQ */
	    	                .append(", CUR_STATE") /* 0 */
	    					
	    	                .append(", USER_PART") /* 부서코드 */
	    					.append(", USER_ID") /* 사용자 ID */
	    					.append(", WORK_SEQ") /* 업무구분코드 */
	    					
	    					.append(", CENTER_SEQ") /* 발송라인 */
	    	                .append(", REQ_DATE") /* 즉시(예약)발송 일시 */
	    	                .append(", msg_id")
	    					.append(", PAY_CODE") /* 알림톡 */
	    					.append(", PAY_FEE") /* 발송단가 */
	    	                .append(", CALL_TO") /* 수신번호 */					
	    	                .append(", CALL_FROM") /* 발신번호 */
	    	                .append(", REMOTE_ADDR") /* 사용자IP */				
	    	                
	    	                //.append(", SMS_TXT") /* SMS용 메세지 내용 */	
	    	                .append(", MSG_TYPE") /* 8 알림톡/친구톡 */		
	    	                .append(", SMS_TXT") 	
	    	                .append(", MSG_TYPE_RESEND")
	    	                .append(", MSG_NOTICETALK_SENDER_KEY")	/* SENDER KEY */		
	    	                .append(", MSG_NOTICETALK_TMP_KEY") /* NULL */ 
	    	                //.append(", CENTER_SEQ_RESEND") /* 대체문자 발송라인 */
	    	                //.append(", RSLT_NET") /* 친구톡 발송결과  1 */
	    	                //.append(", MSG_RESEND_COUNT") /*발송싶패하여 재전송한 카운트 */
	    	                .append(", BOXSEQ")	/* 발송그룹 테이블 PK값 */
	    	                .append(", SUB_ID") /* 사용자 서브아이디 */
	    	                .append(") VALUES(MSG_DATA_SEQ.NEXTVAL, " + contSeq + ", 0, " + 
	    	                		usrPart + ", '" + usrId + "',  " + workSeq + 
	    	                		", " + sendLine + ", "+sendDate+", 'NOT', " + sendPrice + ", ?, '" + sendNumber + "',  '" + remoteAddr + 
	    	                		"', 8,'" + reContents + "'," + sendTypeRe + ",'" + senderKey + "', '" + templateKey + "', " + groupSeq + ",'" + usrSubId + "' ) "); 
/*
            		", " + sendLine + ", SYSDATE, 'NOT', " + sendPrice + ", ?, '" + sendNumber + "',  '" + remoteAddr +  
	    	                		"', 8," + sendTypeRe + ",'" + senderKey + "', '" + templateKey + "', " + groupSeq + ",'" + usrSubId + "' ) "); 
*/          
 
	    					
	    		    
	    	    	try{
	    	    		    	
	    	    		conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
	    	    		conn.setAutoCommit(false);                    // 자동 commit 끔 
	    		 
	    		        // prepareStatement를 PreparedStatement으로 형변환
	    		        ps = (PreparedStatement) conn.prepareStatement(sql.toString());
	    		        psU = (PreparedStatement) conn.prepareStatement(sql.toString());
	    		 
	    		        int cnt = 0;    // row Count +

	    		        Calendar cal = Calendar.getInstance();
	    		        Date curDate = new java.sql.Date(cal.getTimeInMillis()); 
	    		        System.out.println("date :" + curDate);
	    		         
	    		        	
	    		        ps.setString(1, obj.getRcv_number()); /* 수신번호 */	 
	    		            
	    		        ps.execute();  
		                conn.commit(); 
	    		    }catch(Exception e){	    	
	    		        e.printStackTrace();
	    		        ps.close();
	    		        conn.close();
	    		        return 0;	        
	    		    }finally{
	    		        ps.close();
	    		        conn.close();
	    		        
	    		    }
	    	
	        }
	    	    	
	        long end = System.currentTimeMillis();    // 작동시간 측정용
	    		 
	        return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}

	
	

	@RequestMapping(value="/msg/excelFileupload.do")
    public ModelAndView excelFileUpload(MultipartHttpServletRequest req) throws Exception {
    	   System.out.println(" > paramMap : " + req);
    	   

   	    	ModelAndView mav = new ModelAndView("jsonView"); 
    	   
    	   
    	   //MultipartFile mpf = req.getFile(itr.next()); 
    	   MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
    	   CommonsMultipartFile file = (CommonsMultipartFile) multipartRequest.getFile("excelFile");
    	   
    	   String result = saveFile(file);
    	   mav.addObject("data", result);
    	   //model.addAttribute(result);
    	   //model.addAllAttributes(paramMap);
 
		return mav;
    }
	
	private String saveFile(MultipartFile file) throws IllegalStateException, java.io.IOException{
	    // 파일 이름 변경
	    UUID uuid = UUID.randomUUID();
	    String saveName = uuid + "_" + file.getOriginalFilename();

	    System.out.println("saveName: {}" + saveName);

	    String UPLOAD_PATH = "C:///tmp///userExcel///";
		// 저장할 File 객체를 생성(껍데기 파일)ㄴ
	    File saveFile = new File(UPLOAD_PATH,saveName); // 저장할 폴더 이름, 저장할 파일 이름

	    try {
	        
	    	file.transferTo(saveFile); // 업로드 파일에 saveFile이라는 껍데기 입힘
	        
	    } catch (Exception e){	    	
	        e.printStackTrace(); 
	        return null;	        
	    }finally{  
	    }

	    return saveName;
	} // end saveFile(
	
	
	@SuppressWarnings("unused")
	private static double insertBatchExcelToDB_EXCEL(List<RcvaddrList> list) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용
		 
		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    OraclePreparedStatement ps = null;    // 통상 PreparedStatement로 선언  
		 

//            oracle.sql.NUMBER msgSEQ = new oracle.sql.NUMBER(6); 
//            oracle.sql.NUMBER msgCNT = new oracle.sql.NUMBER(60); 
		    
		    /* 단문 */
		    StringBuffer sql = new StringBuffer("INSERT INTO EXCEL_TRAN (")
					.append(" seq")
	                .append(", loginid")
	                .append(", indate")
	                .append(", boxseq")
	                .append(", filename")
	                .append(", sheetname")
	                .append(", fieldname")
	                .append(", cancel_yn")
	                .append(", reserdate")
	                .append(", receivenum")
	                .append(", msgtype")
	                .append(", subject")
	                .append(", msgdata")
	                .append(", mms_file1")
	                .append(", resend_yn")
	                .append(", totcnt")
	                .append(", nowstatus")
	                .append(", center_seq")
	                .append(") VALUES(EXCEL_TRAN_SEQ.NEXTVAL, ?, sysdate, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"); 
		   
		    try{
		    	
		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
		        conn.setAutoCommit(false);                    // 자동 commit 끔
		 
		        // prepareStatement를 OraclePreparedStatement으로 형변환
		        ps = (OraclePreparedStatement) conn.prepareStatement(sql.toString());
		 
		        int cnt = 0;    // row Count
		 
		        for(RcvaddrList obj : list){

		            ps.setString(1, "TEST1"); 
		            ps.setInt(2, 1); //메시지그룹seq
		            ps.setString(3, "1.xls"); //엑셀파일명
		            ps.setString(4, "sheet1"); //엑셀시트명
		            ps.setString(5, "수신번호"); //휴대폰번호필드명
		            ps.setString(6, "N"); 
		            ps.setString(7, "202007230900");
		            ps.setString(8, obj.getSnd_number());  //보내는 사람번호
		            ps.setString(9, "MMS"); //MMS
		            ps.setString(10, obj.getRcv_number()); //제목 
		            ps.setString(11, obj.getRcv_content());
		            ps.setString(12, "image.jpg"); //이미지ㅍ1파일명
		            ps.setString(13, "N"); 
		            ps.setInt(14, 1); //총전송건수
		            ps.setString(15, "0"); 
		            ps.setString(16, ""); //발송라인seq
		            
		            ps.addBatch();    // OraclePreparedStatement에 batch로 완성된 SQL 추가
		            ps.clearParameters();    // OraclePreparedStatement에 지정된 Parameter값 초기화
		            
		            cnt++;
		            if((cnt % 100) == 0){    // batch에 누적된 건수가 1만건
		                cnt = 0;
		                ps.executeBatch();    // 누적된 batch 실행
		                ps.clearBatch();    // 누적된 batch 초기화
		                conn.commit();        // Commit하여 적용
		            }
		        }
		 
		        // 최종적으로 누적된 채 남은 batch 작업(위의 if문) 실행
		        ps.executeBatch();
		        ps.clearBatch();
		        conn.commit();
		 
		    }catch(Exception e){	    	
		        e.printStackTrace();
		        ps.close();
		        conn.close();
		        return 0;	        
		    }finally{
		        ps.close();
		        conn.close();
		        
		    }
		 
		    long end = System.currentTimeMillis();    // 작동시간 측정용
		 
		    return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}
	
	
	@SuppressWarnings("unused")
	private static double insertBatchExcelToDB_LMS(List<RcvaddrList> list) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용
		 
		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    OraclePreparedStatement ps = null;    // 통상 PreparedStatement로 선언 		    
 
		    /* 장문 */
		    StringBuffer sql = new StringBuffer("INSERT ALL")
		    		.append(" INTO MSG_DATA (")
					.append(" msg_seq")
	                .append(", req_date")
	                .append(", msg_id")
	                .append(", cur_state")
	                .append(", call_from")
	                .append(", call_to")
	                .append(", msg_type")
	                .append(", cont_seq")
	                .append(") VALUES(MSG_DATA_SEQ.NEXTVAL,sysdate, 0, ?, ?, 6, MMS_CONTENTS_INFO_SEQ.CURRVAL)")   
		    		.append(" INTO MMS_CONTENTS_INFO (")
					.append(" CONT_SEQ")
	                .append(", FILE_CNT")
	                .append(", MMS_SUBJECT")
	                .append(", MMS_BODY")
	                .append(", SERVICE_DEP1")
	                .append(") VALUES(MMS_CONTENTS_INFO_SEQ.NEXTVAL, 1,  ?, ?, 'ALL')")
	                .append(" SELECT * FROM DUAL " );
		   
		    try{
		    	
		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
		        conn.setAutoCommit(false);                    // 자동 commit 끔
		 
		        // prepareStatement를 OraclePreparedStatement으로 형변환
		        ps = (OraclePreparedStatement) conn.prepareStatement(sql.toString());
		 
		        int cnt = 0;    // row Count
		 
		        for(RcvaddrList obj : list){
		        	
		            ps.setString(1, obj.getSnd_number());
		            ps.setString(2, obj.getRcv_number());
		            ps.setString(3, obj.getRcv_title());
		            ps.setString(4, obj.getRcv_content()); 
		            
		            ps.addBatch();    // OraclePreparedStatement에 batch로 완성된 SQL 추가
		            ps.clearParameters();    // OraclePreparedStatement에 지정된 Parameter값 초기화
		            
		            cnt++;
		            if((cnt % 100) == 0){    // batch에 누적된 건수가 1만건
		                cnt = 0;
		                ps.executeBatch();    // 누적된 batch 실행
		                ps.clearBatch();    // 누적된 batch 초기화
		                conn.commit();        // Commit하여 적용
		            }
		        }
		 
		        // 최종적으로 누적된 채 남은 batch 작업(위의 if문) 실행
		        ps.executeBatch();
		        ps.clearBatch();
		        conn.commit();
		 
		    }catch(Exception e){	    	
		        e.printStackTrace();
		        ps.close();
		        conn.close();
		        return 0;	        
		    }finally{
		        ps.close();
		        conn.close();
		        
		    }
		 
		    long end = System.currentTimeMillis();    // 작동시간 측정용
		 
		    return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}
	
	@SuppressWarnings("unused")
	private static double insertBatchExcelToDB_MMS(List<RcvaddrList> list) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용
		 
		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    OraclePreparedStatement ps = null;    // 통상 PreparedStatement로 선언 		    
		    /*
INSERT INTO MMS_CONTENTS_INFO (CONT_SEQ, FILE_CNT, MMS_SUBJECT, MMS_BODY, FILE_TYPE1, FILE_NAME1, SERVICE_DEP1 ) VALUES (MMS_CONTENTS_INFO_SEQ.nextval, 2, '메시지 제목', '메세지 내용', 'IMG', '이미지 경로', 'ALL');
INSERT INTO MSG_DATA (MSG_SEQ,REQ_DATE,CUR_STATE,CALL_TO,CALL_FROM,MSG_TYPE,CONT_SEQ) VALUES (MSG_DATA_SEQ.NEXTVAL,SYSDATE,0,'수신번호','발신번호',6,MMS_CONTENTS_INFO_SEQ.CURRVAL);
		     */
		   
		    /* 멀티 */
		    StringBuffer sql = new StringBuffer("INSERT ALL")
		    		.append(" INTO MSG_DATA (")
					.append(" msg_seq")
	                .append(", req_date")
	                .append(", msg_id")
	                .append(", cur_state")
	                .append(", call_from")
	                .append(", call_to")
	                .append(", msg_type")
	                .append(", cont_seq")
	                .append(") VALUES(MSG_DATA_SEQ.NEXTVAL,sysdate, 0, ?, ?, 6, MMS_CONTENTS_INFO_SEQ.CURRVAL)")   
		    		.append(" INTO MMS_CONTENTS_INFO (")
					.append(" CONT_SEQ")
	                .append(", MMS_SUBJECT")
	                .append(", MMS_BODY")
	                .append(", FILE_TYPE1")
	                .append(", MMS_BODY")
	                .append(", FILE_NAME1")
	                .append(") VALUES(MMS_CONTENTS_INFO_SEQ.NEXTVAL, 2, ?, ?, 'IMG', ?, 'ALL')")
	                .append(" SELECT * FROM DUAL " );
		   
		    try{
		    	
		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
		        conn.setAutoCommit(false);                    // 자동 commit 끔
		 
		        // prepareStatement를 OraclePreparedStatement으로 형변환
		        ps = (OraclePreparedStatement) conn.prepareStatement(sql.toString());
		 
		        int cnt = 0;    // row Count
		 
		        for(RcvaddrList obj : list){
		            ps.setString(1, obj.getSnd_number());
		            ps.setString(2, obj.getRcv_number());
		            ps.setString(3, obj.getRcv_content());
		            ps.setString(4, obj.getRcv_type());
		            ps.setString(5, obj.getRcv_etc());  
		            
		            ps.addBatch();    // OraclePreparedStatement에 batch로 완성된 SQL 추가
		            ps.clearParameters();    // OraclePreparedStatement에 지정된 Parameter값 초기화
		            
		            cnt++;
		            if((cnt % 100) == 0){    // batch에 누적된 건수가 1만건
		                cnt = 0;
		                ps.executeBatch();    // 누적된 batch 실행
		                ps.clearBatch();    // 누적된 batch 초기화
		                conn.commit();        // Commit하여 적용
		            }
		        }
		 
		        // 최종적으로 누적된 채 남은 batch 작업(위의 if문) 실행
		        ps.executeBatch();
		        ps.clearBatch();
		        conn.commit();
		 
		    }catch(Exception e){	    	
		        e.printStackTrace();
		        ps.close();
		        conn.close();
		        return 0;	        
		    }finally{
		        ps.close();
		        conn.close();
		        
		    }
		 
		    long end = System.currentTimeMillis();    // 작동시간 측정용
		 
		    return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}
	
	
	@SuppressWarnings("unused")
	private static double insertBatchExcelToDB_ATALK(List<RcvaddrList> list) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용
		 
		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    OraclePreparedStatement ps = null;    // 통상 PreparedStatement로 선언		    
		    /*
INSERT INTO MSG_DATA (MSG_SEQ, CUR_STATE, REQ_DATE, CALL_TO, CALL_FROM, SMS_TXT, MSG_TYPE, CONT_SEQ, MSG_NOTICETALK_SENDER_KEY, MSG_NOTICETALK_TMP_KEY ) VALUES 
(MSG_DATA_SEQ.NEXTVAL, 1, SYSDATE, '수신번호', '회신번호', '알림톡 테스트', 8, MMS_CONTENTS_INFO_SEQ.currval, '센더키', '템플릿 키');
INSERT INTO MMS_CONTENTS_INFO  CONT_SEQ, FILE_CNT, MMS_NOTICETALK_SUBJECT, MMS_NOTICETALK_BODY) VALUES 
( MMS_CONTENTS_INFO_SEQ.NEXTVAL, 1,'임시 제목', '알림톡 템플릿 코드에 등록되어 있는 발송 문구');
		     */
		   
		    /* 알림톡 */
		    StringBuffer sql = new StringBuffer("INSERT ALL")
		    		.append(" INTO MSG_DATA (")
					.append(" MSG_SEQ")
	                .append(", CUR_STATE")
	                .append(", REQ_DATE")
	                .append(", msg_id")
	                .append(", CALL_FROM")
	                .append(", CALL_TO")
	                .append(", SMS_TXT")
	                .append(", MSG_TYPE")
	                .append(", CONT_SEQ")
	                .append(", MSG_NOTICETALK_SENDER_KEY")
	                .append(", MSG_NOTICETALK_TMP_KEY")
	                .append(") VALUES(MSG_DATA_SEQ.NEXTVAL, 1, sysdate, ?, ?, ?, 8, MMS_CONTENTS_INFO_SEQ.CURRVAL, ?, ?)")   
		    		.append(" INTO MMS_CONTENTS_INFO (")
					.append(" CONT_SEQ")
	                .append(", FILE_CNT")
	                .append(", MMS_NOTICETALK_SUBJECT")
	                .append(", MMS_NOTICETALK_BODY")
	                .append(") VALUES(MMS_CONTENTS_INFO_SEQ.NEXTVAL, 1, ?, ?)")
	                .append(" SELECT * FROM DUAL " );
		   
		   
		    try{
		    	
		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
		        conn.setAutoCommit(false);                    // 자동 commit 끔
		 
		        // prepareStatement를 OraclePreparedStatement으로 형변환
		        ps = (OraclePreparedStatement) conn.prepareStatement(sql.toString());
		 
		        int cnt = 0;    // row Count
		 
		        for(RcvaddrList obj : list){
		            ps.setString(1, obj.getRcv_number()); //수신
		            ps.setString(2, obj.getSnd_number()); //회신
		            ps.setString(3, obj.getRcv_title());//알림톡테스트
		            ps.setString(4, obj.getRcv_etc()); //샌더키
		            ps.setString(5, obj.getRcv_etc());  //템플릿키
		            ps.setString(6, obj.getRcv_title());  //임시제목
		            ps.setString(7, obj.getRcv_content()); //알림톡 템플릿 코드에 등록되어 있는 발송 문구
		            
		            ps.addBatch();    // OraclePreparedStatement에 batch로 완성된 SQL 추가
		            ps.clearParameters();    // OraclePreparedStatement에 지정된 Parameter값 초기화
		            
		            cnt++;
		            if((cnt % 100) == 0){    // batch에 누적된 건수가 1만건
		                cnt = 0;
		                ps.executeBatch();    // 누적된 batch 실행
		                ps.clearBatch();    // 누적된 batch 초기화
		                conn.commit();        // Commit하여 적용
		            }
		        }
		 
		        // 최종적으로 누적된 채 남은 batch 작업(위의 if문) 실행
		        ps.executeBatch();
		        ps.clearBatch();
		        conn.commit();
		 
		    }catch(Exception e){	    	
		        e.printStackTrace();
		        ps.close();
		        conn.close();
		        return 0;	        
		    }finally{
		        ps.close();
		        conn.close();
		        
		    }
		 
		    long end = System.currentTimeMillis();    // 작동시간 측정용
		 
		    return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}
	
	@SuppressWarnings("unused")
	private static double insertBatchExcelToDB_FTALK(List<RcvaddrList> list) throws Exception{
		 long start = System.currentTimeMillis();    // 작동 시간 측정용
		 
		    // ojdbc6.jar 사용. import는 oracle.jdbc.*  
		    Connection conn = null;        // 통상 Connection으로 선언
		    OraclePreparedStatement ps = null;    // 통상 PreparedStatement로 선언
		    /* 
INSERT INTO MSG_DATA (MSG_SEQ, CUR_STATE, REQ_DATE, CALL_TO, CALL_FROM, MSG_TYPE, CONT_SEQ, MSG_NOTICETALK_SENDER_KEY) VALUES
(MSG_DATA_SEQ.NEXTVAL, 1, SYSDATE, '수신번호', '발신번호' , 8, MMS_CONTENTS_INFO_SEQ.currval,'센더키');

INSERT INTO MMS_CONTENTS_INFO 
(CONT_SEQ, FILE_CNT, MMS_FRIEND_BODY, MMS_FRIEND_SUBJECT) 
VALUES
(MMS_CONTENTS_INFO_SEQ.NEXTVAL, 1, '친구톡 내용', '친구톡 제목'); 
		     */
		    /* 친구톡 */
		    StringBuffer sql = new StringBuffer("INSERT ALL")
		    		.append(" INTO MSG_DATA (")
					.append(" MSG_SEQ")
	                .append(", CUR_STATE")
	                .append(", REQ_DATE")
	                .append(", msg_id")
	                .append(", CALL_FROM")
	                .append(", CALL_TO")
	                .append(", MSG_TYPE")
	                .append(", CONT_SEQ")
	                .append(", MSG_NOTICETALK_SENDER_KEY")
	                .append(") VALUES(MSG_DATA_SEQ.NEXTVAL, 1, sysdate, ?, ?, 8, MMS_CONTENTS_INFO_SEQ.CURRVAL, ?)")   
		    		.append(" INTO MMS_CONTENTS_INFO (")
					.append(" CONT_SEQ")
	                .append(", FILE_CNT")
	                .append(", MMS_FRIEND_BODY")
	                .append(", MMS_FRIEND_SUBJECT")
	                .append(") VALUES(MMS_CONTENTS_INFO_SEQ.NEXTVAL, 1, ?, ?)")
	                .append(" SELECT * FROM DUAL " ); 
		   
		    try{
		    	
		        conn =  getOrclConn();    // Connection 생성 시 Connection으로 형변환
		        conn.setAutoCommit(false);                    // 자동 commit 끔
		 
		        // prepareStatement를 OraclePreparedStatement으로 형변환
		        ps = (OraclePreparedStatement) conn.prepareStatement(sql.toString());
		 
		        int cnt = 0;    // row Count
		 
		        for(RcvaddrList obj : list){
		            ps.setString(1, obj.getRcv_number());
		            ps.setString(2, obj.getSnd_number());
		            ps.setString(3, obj.getRcv_etc()); // SENDER KEY
		            ps.setString(4, obj.getRcv_content());
		            ps.setString(5, obj.getRcv_title());  
		            
		            ps.addBatch();    // OraclePreparedStatement에 batch로 완성된 SQL 추가
		            ps.clearParameters();    // OraclePreparedStatement에 지정된 Parameter값 초기화
		            
		            cnt++;
		            if((cnt % 100) == 0){    // batch에 누적된 건수가 1만건
		                cnt = 0;
		                ps.executeBatch();    // 누적된 batch 실행
		                ps.clearBatch();    // 누적된 batch 초기화
		                conn.commit();        // Commit하여 적용
		            }
		        }
		 
		        // 최종적으로 누적된 채 남은 batch 작업(위의 if문) 실행
		        ps.executeBatch();
		        ps.clearBatch();
		        conn.commit();
		 
		    }catch(Exception e){	    	
		        e.printStackTrace();
		        ps.close();
		        conn.close();
		        return 0;	        
		    }finally{
		        ps.close();
		        conn.close();
		        
		    }
		 
		    long end = System.currentTimeMillis();    // 작동시간 측정용
		 
		    return (end - start) / 1000.0;    // insertBatchFileToDB 실행에 걸린 시간 
	}

    /* 전송이미지 업로드   문자보내기/친구톡/알림톡/ */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/msg/imgFileupload.do")
	public String imageFileUpload(final MultipartHttpServletRequest multiRequest, Model model) throws Exception {
	
		/* 테스트 코드
		Iterator<String> itr = multiRequest.getFileNames(); 
		System.out.println(" > itr : " + itr);
		if(itr.hasNext()) { 
			MultipartFile mpf = multiRequest.getFile(itr.next());
			System.out.println(mpf.getOriginalFilename() +" uploaded!"); 
			System.out.println("file length : " + mpf.getBytes().length); 
			System.out.println("file name : " + mpf.getOriginalFilename());  
		
		} else {  
			
		} 
		System.out.println(" > multiRequest : " + multiRequest);
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		System.out.println(files);
		*/
	   
	   //String result = ImageSaveFile(file);
	   //model.addAttribute(result);
	   //model.addAllAttributes(paramMap);
		//서버이미지PATH
		String imgPath = globalsProperties.getProperty("PUSERIMAGEPATH");
		String maxSize = globalsProperties.getProperty("FILEMAXSIZE"); 
		String fileExt = globalsProperties.getProperty("PUSERIMAGEPATH"); 
		
		
		
		System.out.println(" > imgPath : " + imgPath);
		System.out.println(" > maxSize : " + maxSize);
		System.out.println(" > fileExt : " + fileExt);		
        String path = imgPath; //multiRequest.getSession().getServletContext().getRealPath("/resources/");
         
        System.out.println("path : " + path);
        
        
        String FileName = "";
        
        Map returnObject = new HashMap(); 
        try { 
            // MultipartHttpServletRequest 생성 
            //MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) multiRequest; 
            //Iterator iter = mhsr.getFileNames(); 
            MultipartFile mfile = null; 
            String fieldName = ""; 
            List resultList = new ArrayList(); 
            
            // 디레토리가 없다면 생성 
            File dir = new File(path); 
            if (!dir.isDirectory()) { 
                dir.mkdirs(); 
            } 
            
        	Iterator<String> iter =  multiRequest.getFileNames();
        	System.out.println(" > getFileNames : " + multiRequest.getFileNames() );

            // 값이 나올때까지 
            while (iter.hasNext()) { 
                fieldName = (String) iter.next(); // 내용을 가져와서 
                mfile = multiRequest.getFile(fieldName); 
                String origName; 
                origName = new String(mfile.getOriginalFilename().getBytes("8859_1"), "UTF-8"); //한글꺠짐 방지 
                
                System.out.println("origName: " + origName);
                // 파일명이 없다면 
                if ("".equals(origName)) {
                    continue; 
                } 
                
                // 파일 명 변경(uuid로 암호화) 
                String ext = origName.substring(origName.lastIndexOf('.')); // 확장자 
                String saveFileName = getUuid() + ext;
                FileName = saveFileName;
                //String saveFileName = origName;
                
                System.out.println("saveFileName : " + saveFileName);
                
                // 설정한 path에 파일저장 
                File serverFile = new File(path + File.separator + saveFileName);
                mfile.transferTo(serverFile);
                
                Map file = new HashMap();
                file.put("origName", origName); 
                file.put("sfile", serverFile);
                resultList.add(file);
            }
            
            returnObject.put("files", resultList); 
            returnObject.put("params", multiRequest.getParameterMap()); 
            
        } catch (UnsupportedEncodingException e) { 
            model.addAttribute(e); 
                e.printStackTrace(); 
            	return "jsonView";
        } catch (IllegalStateException e) {
            model.addAttribute(e);    
                e.printStackTrace();
            	return "jsonView";
        }
		
        model.addAttribute(FileName);
		
		
    	/*List<FileVO> result = null; 

    	String uploadFolder = "";
    	String bannerImage = "";
    	String bannerImageFile = "";
    	String atchFileId = "";

    	final Map<String, MultipartFile> files = multiRequest.getMultiFileMap();
    	System.out.println(files);

    	if(!files.isEmpty()){
    		
    	    result = fileUtil.parseFileInf(files, "SEND_", 0, "", uploadFolder);
    	    atchFileId = fileMngService.insertFileInfs(result);

        	FileVO vo = result.get(0);
        	Iterator<FileVO> iter = result.iterator();

        	while (iter.hasNext()) {
        	    vo = iter.next();
        	    bannerImage = vo.getOrignlFileNm();
        	    bannerImageFile = vo.getStreFileNm();
        	}
    	}

    	model.addAttribute(result.get(0));*/
	   
    	return "jsonView";
	}
	 //uuid생성
    public static String getUuid() { 
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

 	@SuppressWarnings("unused")
	private String ImageSaveFile(MultipartFile file) throws IllegalStateException, java.io.IOException {
		// 파일 이름 변경
		UUID uuid = UUID.randomUUID();
		String saveName = uuid + "_" + file.getOriginalFilename();

		System.out.println("saveName: {}" + saveName);

		String UPLOAD_PATH = "C:///tmp";
		// 저장할 File 객체를 생성(껍데기 파일)ㄴ
		File saveFile = new File(UPLOAD_PATH,saveName); // 저장할 폴더 이름, 저장할 파일 이름
    
		try {
        
			file.transferTo(saveFile); // 업로드 파일에 saveFile이라는 껍데기 입힘
        
		} catch (Exception e){	    	
			e.printStackTrace(); 
			return null;	        
		}finally{  
		}

		return saveName;
	} // end saveFile( 
	
	
	
	

}
