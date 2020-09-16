package egovframework.com.msg.sta.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.msg.sta.service.EgovStatisticsService;
import egovframework.com.msg.sta.service.SearchEntity;
import egovframework.com.msg.sta.service.StatisticsVO;
import egovframework.com.msg.sta.service.TableEntity;
import egovframework.com.msg.sta.util.StatisticsCommon;

@Controller
public class EgovStatisticsController {
	
	private static final Logger log = Logger.getLogger(EgovStatisticsController.class);
	
	@Resource(name = "EgovStatisticsService") 
	private EgovStatisticsService egovStatisticsService;
	
	
	/**
	 * 일별 통계
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/usr/dailystatistics.do", method=RequestMethod.GET)
	public ResponseEntity<String> apiV1MemberQuestion(HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("month", request.getParameter("month"));
		paramMap.put("start_dt", request.getParameter("start_dt"));
		paramMap.put("end_dt", request.getParameter("end_dt"));
		paramMap.put("workSeq", request.getParameter("workSeq"));
		paramMap.put("user_id", user.getId());
		
		List<StatisticsVO> list = egovStatisticsService.dataList(paramMap);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try 
		{
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}
		catch (Exception e) 
		{
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("############################# response=" + new Gson().toJson(entity));
		return entity;
	}
	
	@RequestMapping(value="/usr/monthstatistics.do", method=RequestMethod.POST)
	public ResponseEntity<String> monthStatistics(HttpServletRequest request, @RequestBody SearchEntity searchEntity) throws Exception{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		
		ResponseEntity<String> entity = null;
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		searchEntity.setUser_id(user.getId());
		
		Map<String, Object> map = new HashMap<String, Object>();
		searchEntity.setDate_list_size(searchEntity.getDate_list().size());
		
		List<StatisticsVO> list = egovStatisticsService.monthDataList(searchEntity);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try {
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}catch (Exception e) {
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/usr/yearStatistics.do", method=RequestMethod.POST)
	public ResponseEntity<String> yearStatistics(HttpServletRequest request, @RequestBody SearchEntity searchEntity) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		searchEntity.setUser_id(user.getId());
		
		Map<String, Object> map = new HashMap<String, Object>();
		searchEntity.setDate_list_size(searchEntity.getDate_list().size());
		
		List<TableEntity> tabelNameList = egovStatisticsService.tabelList(searchEntity);
		
		for(int i = 0 ; i < tabelNameList.size() ; i++) {
			tabelNameList.get(i).setSize((i+1));
		}
		searchEntity.setTable_list(tabelNameList);
		searchEntity.setDate_list_size(tabelNameList.size());
		
		List<StatisticsVO> list = egovStatisticsService.yearDataList(searchEntity);
		
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try {
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}catch (Exception e) {
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/** 부서장
	 * 일별 통계
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/usr/partDailystatistics.do", method=RequestMethod.GET) 
	public ResponseEntity<String> partDailystatistics(HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		 
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("month", request.getParameter("month"));
		paramMap.put("start_dt", request.getParameter("start_dt"));
		paramMap.put("end_dt", request.getParameter("end_dt"));
		paramMap.put("work_seq", request.getParameter("work_seq"));
		paramMap.put("user_id", request.getParameter("user_id"));
		paramMap.put("orgnztId", user.getOrgnztId());
		
		List<StatisticsVO> list = egovStatisticsService.partDailystatistics(paramMap);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try 
		{
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}
		catch (Exception e) 
		{
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("############################# response=" + new Gson().toJson(entity));
		return entity;
	}
	
	@RequestMapping(value="/usr/partMonthstatistics.do", method=RequestMethod.POST)
	public ResponseEntity<String> partMonthstatistics(HttpServletRequest request, @RequestBody SearchEntity searchEntity) throws Exception{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		
		ResponseEntity<String> entity = null;
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(); 
		searchEntity.setOrgnztId(user.getOrgnztId());
		
		Map<String, Object> map = new HashMap<String, Object>();
		searchEntity.setDate_list_size(searchEntity.getDate_list().size());
		
		List<StatisticsVO> list = egovStatisticsService.partMonthstatistics(searchEntity);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try {
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}catch (Exception e) {
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/usr/partYearStatistics.do", method=RequestMethod.POST)
	public ResponseEntity<String> partYearStatistics(HttpServletRequest request, @RequestBody SearchEntity searchEntity) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		searchEntity.setOrgnztId(user.getOrgnztId());
		
		Map<String, Object> map = new HashMap<String, Object>();
		searchEntity.setDate_list_size(searchEntity.getDate_list().size());
		
		List<TableEntity> tabelNameList = egovStatisticsService.tabelList(searchEntity);
		
		for(int i = 0 ; i < tabelNameList.size() ; i++) {
			tabelNameList.get(i).setSize((i+1));
		}
		searchEntity.setTable_list(tabelNameList);
		searchEntity.setDate_list_size(tabelNameList.size());
		
		List<StatisticsVO> list = egovStatisticsService.partYearStatistics(searchEntity);
		
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try {
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}catch (Exception e) {
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/usr/partStatisticsbyjobSearch.do", method=RequestMethod.GET)
	public ResponseEntity<String> partStatisticsbyjobSearch(HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("month", request.getParameter("month"));
		paramMap.put("start_dt", request.getParameter("start_dt"));
		paramMap.put("end_dt", request.getParameter("end_dt"));
		paramMap.put("user_id", request.getParameter("user_id"));
		paramMap.put("orgnztId", user.getOrgnztId());
		
		List<StatisticsVO> list = egovStatisticsService.partStatisticsbyjobSearch(paramMap); 
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try 
		{
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}
		catch (Exception e) 
		{
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("############################# response=" + new Gson().toJson(entity));
		return entity;
	}
	
	/** 관리자
	 * 일별 통계
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/dailystatistics.do", method=RequestMethod.GET)
	public ResponseEntity<String> mngDailystatistics(HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("month", request.getParameter("month"));
		paramMap.put("start_dt", request.getParameter("start_dt"));
		paramMap.put("end_dt", request.getParameter("end_dt"));
		paramMap.put("work_seq",request.getParameter("work_seq"));
		paramMap.put("part_id",request.getParameter("part_id"));
		paramMap.put("user_id",request.getParameter("user_id"));
		
		List<StatisticsVO> list = egovStatisticsService.mngDailystatistics(paramMap);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try 
		{
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}
		catch (Exception e) 
		{
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("############################# response=" + new Gson().toJson(entity));
		return entity;
	}
	
	@RequestMapping(value="/mng/monthstatistics.do", method=RequestMethod.POST)
	public ResponseEntity<String> mngMonthStatistics(HttpServletRequest request, @RequestBody SearchEntity searchEntity) throws Exception{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		
		ResponseEntity<String> entity = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		searchEntity.setDate_list_size(searchEntity.getDate_list().size());
		
		List<StatisticsVO> list = egovStatisticsService.mngMonthStatistics(searchEntity);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try {
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}catch (Exception e) {
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/mng/yearStatistics.do", method=RequestMethod.POST)
	public ResponseEntity<String> mngYearStatistics(HttpServletRequest request, @RequestBody SearchEntity searchEntity) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		searchEntity.setDate_list_size(searchEntity.getDate_list().size());
		
		List<TableEntity> tabelNameList = egovStatisticsService.tabelList(searchEntity);
		
		for(int i = 0 ; i < tabelNameList.size() ; i++) {
			tabelNameList.get(i).setSize((i+1));
		}
		searchEntity.setTable_list(tabelNameList);
		searchEntity.setDate_list_size(tabelNameList.size());
		
		List<StatisticsVO> list = egovStatisticsService.mngYearStatistics(searchEntity);
		
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try {
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}catch (Exception e) {
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/mng/statisticsbyjobSearch.do", method=RequestMethod.GET)
	public ResponseEntity<String> mngStatisticsbyjob(HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("month", request.getParameter("month"));
		paramMap.put("start_dt", request.getParameter("start_dt"));
		paramMap.put("end_dt", request.getParameter("end_dt"));
		paramMap.put("work_seq",request.getParameter("work_seq"));
		paramMap.put("part_id",request.getParameter("part_id"));
		paramMap.put("user_id",request.getParameter("user_id"));
		
		List<StatisticsVO> list = egovStatisticsService.mngStatisticsbyjob(paramMap);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try 
		{
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}
		catch (Exception e) 
		{
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("############################# response=" + new Gson().toJson(entity));
		return entity;
	}
	
	@RequestMapping(value = "/mng/statisticsbytypesms.do", method=RequestMethod.GET)
	public ResponseEntity<String> mngStatisticsbytypeSms(HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("month", request.getParameter("month"));
		paramMap.put("start_dt", request.getParameter("start_dt"));
		paramMap.put("end_dt", request.getParameter("end_dt"));
		paramMap.put("work_seq",request.getParameter("work_seq"));
		paramMap.put("part_id",request.getParameter("part_id"));
		paramMap.put("user_id",request.getParameter("user_id"));
		
		List<StatisticsVO> list = egovStatisticsService.mngStatisticsbytypeSms(paramMap);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try 
		{
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}
		catch (Exception e) 
		{
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("############################# response=" + new Gson().toJson(entity));
		return entity;
	}
	@RequestMapping(value = "/mng/statisticsbytypeals.do", method=RequestMethod.GET)
	public ResponseEntity<String> mngStatisticsbytypeAls(HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("month", request.getParameter("month"));
		paramMap.put("start_dt", request.getParameter("start_dt"));
		paramMap.put("end_dt", request.getParameter("end_dt"));
		paramMap.put("work_seq",request.getParameter("work_seq"));
		paramMap.put("part_id",request.getParameter("part_id"));
		paramMap.put("user_id",request.getParameter("user_id"));
		
		List<StatisticsVO> list = egovStatisticsService.mngStatisticsbytypeAls(paramMap);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try 
		{
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}
		catch (Exception e) 
		{
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("############################# response=" + new Gson().toJson(entity));
		return entity;
	}
	@RequestMapping(value = "/mng/statisticsbytypefls.do", method=RequestMethod.GET)
	public ResponseEntity<String> mngStatisticsbytypeFls(HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("month", request.getParameter("month"));
		paramMap.put("start_dt", request.getParameter("start_dt"));
		paramMap.put("end_dt", request.getParameter("end_dt"));
		paramMap.put("work_seq",request.getParameter("work_seq"));
		paramMap.put("part_id",request.getParameter("part_id"));
		paramMap.put("user_id",request.getParameter("user_id"));
		
		List<StatisticsVO> list = egovStatisticsService.mngStatisticsbytypeFls(paramMap);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try 
		{
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}
		catch (Exception e) 
		{
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("############################# response=" + new Gson().toJson(entity));
		return entity;
	}
	
	@RequestMapping(value = "/mng/statisticsbyaltSearch.do", method=RequestMethod.GET)
	public ResponseEntity<String> mngStatisticsbyaltSearch(HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("month", request.getParameter("month"));
		paramMap.put("start_dt", request.getParameter("start_dt"));
		paramMap.put("end_dt", request.getParameter("end_dt"));
		paramMap.put("orgnztId", user.getOrgnztId());
		paramMap.put("work_seq",request.getParameter("work_seq"));
		paramMap.put("part_id",request.getParameter("part_id"));
		paramMap.put("user_id",request.getParameter("user_id"));
		
		List<StatisticsVO> list = egovStatisticsService.mngStatisticsbyaltSearch(paramMap);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try 
		{
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}
		catch (Exception e) 
		{
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("############################# response=" + new Gson().toJson(entity));
		return entity;
	}
	
	@RequestMapping(value = "/mng/statisticsbypartSearch.do", method=RequestMethod.GET)
	public ResponseEntity<String> mngStatisticsbypart(HttpServletRequest request) throws Exception{
		ResponseEntity<String> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("month", request.getParameter("month"));
		paramMap.put("start_dt", request.getParameter("start_dt"));
		paramMap.put("end_dt", request.getParameter("end_dt"));
		paramMap.put("work_seq",request.getParameter("work_seq"));
		paramMap.put("part_id",request.getParameter("part_id"));
		paramMap.put("user_id",request.getParameter("user_id"));
		
		List<StatisticsVO> list = egovStatisticsService.mngStatisticsbypart(paramMap);
		map.put("data", list);
		String json = new Gson().toJson(map);
		
		try 
		{
			entity = new ResponseEntity<String>(json,HttpStatus.OK);
			StatisticsCommon.returnPrint(StatisticsCommon.GmakeDynamicValueObject(entity));
		}
		catch (Exception e) 
		{
			log.debug("exception=" + e.getMessage());
			e.printStackTrace();
			entity = new ResponseEntity<String>(json,HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("############################# response=" + new Gson().toJson(entity));
		return entity;
	}
}
