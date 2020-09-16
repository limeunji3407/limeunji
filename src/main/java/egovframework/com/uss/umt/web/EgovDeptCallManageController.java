package egovframework.com.uss.umt.web;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.uss.umt.service.DeptCallManageVO;
import egovframework.com.uss.umt.service.EgovDeptCallManageService;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 * 부서대표번호관련 처리를  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 공통서비스 개발팀 조재영
 * @since 2009.00.00
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.02.01    lee.m.j     최초 생성
 *   2015.06.16	 조정국	  서비스 화면 접근시 조회결과를 표시하도록 수정
 * </pre>
 */

@Controller
public class EgovDeptCallManageController {

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "egovDeptCallManageService")
	private EgovDeptCallManageService egovDeptCallManageService;

	/** Message ID Generation */
	@Resource(name = "egovDeptManageIdGnrService")
	private EgovIdGnrService egovDeptManageIdGnrService;

	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 부서대표번호 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
	@IncludedInfo(name = "부서대표번호관리", order = 461, gid = 50)
	@RequestMapping("/uss/umt/dpt/selectDeptCallManageListView.do")
	public String selectDeptCallManageListView() throws Exception {

		return "forward:/uss/umt/dpt/selectDeptCallManageList.do";
//		return "egovframework/com/uss/umt/EgovDeptCallManageList";
	}

	/**
	 * 부서대표번호를 관리하기 위해 등록된 부서대표번호목록을 조회한다.
	 * @param bannerVO - 배너 VO
	 * @return String - 리턴 URL
	 * @throws Exception
	 */

	//@RequestMapping(value = "/uss/umt/dpt/selectDeptCallManageList.do")
	@RequestMapping(value = "/mng/departmentcall.do")
	public String selectDeptCallManageList(@ModelAttribute("deptCallManageVO") DeptCallManageVO deptCallManageVO, ModelMap model) throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(deptCallManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(deptCallManageVO.getPageUnit());
		paginationInfo.setPageSize(deptCallManageVO.getPageSize());

		deptCallManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		deptCallManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		deptCallManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		model.addAttribute("deptCallManageList", egovDeptCallManageService.selectDeptCallManageList(deptCallManageVO));

		int totCnt = egovDeptCallManageService.selectDeptCallManageListTotCnt(deptCallManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
		//return "egovframework/com/uss/umt/EgovDeptCallManageList";
		return "egovframework/com/mng/sts/EgovDepartmentCall";
	}

	/**
	 * 등록된 부서대표번호의 상세정보를 조회한다.
	 * @param bannerVO - 부서대표번호 Vo
	 * @return String - 리턴 Url
	 */

	@RequestMapping(value = "/uss/umt/dpt/getDeptCallManage.do")
	public String selectDeptCallManage(@RequestParam("orgnztId") String orgnztId, @ModelAttribute("deptCallManageVO") DeptCallManageVO deptCallManageVO, ModelMap model) throws Exception {

		deptCallManageVO.setOrgnztId(orgnztId);

		model.addAttribute("deptCallManage", egovDeptCallManageService.selectDeptCallManage(deptCallManageVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
		return "egovframework/com/uss/umt/EgovDeptCallManageUpdt";
	}

	/**
	 * 부서대표번호등록 화면으로 이동한다.
	 * @param banner - 부서대표번호 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping(value = "/uss/umt/dpt/addViewDeptCallManage.do")
	public String insertViewDeptCallManage(@ModelAttribute("deptCallManageVO") DeptCallManageVO deptCallManageVO, ModelMap model) throws Exception {

		model.addAttribute("deptCallManage", deptCallManageVO);
		return "egovframework/com/uss/umt/EgovDeptCallManageInsert";
	}

	/**
	 * 부서대표번호정보를 신규로 등록한다.
	 * @param banner - 부서대표번호 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping(value = "/uss/umt/dpt/addDeptCallManage.do")
	public String insertDeptCallManage(@ModelAttribute("deptCallManageVO") DeptCallManageVO deptCallManageVO, BindingResult bindingResult,  ModelMap model) throws Exception {

		beanValidator.validate(deptCallManageVO, bindingResult); //validation 수행

		deptCallManageVO.setOrgnztId(egovDeptManageIdGnrService.getNextStringId());

		if (bindingResult.hasErrors()) {
			return "egovframework/com/uss/umt/EgovDeptCallManageInsert";
		} else {
			egovDeptCallManageService.insertDeptCallManage(deptCallManageVO);
			model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
			return "forward:/uss/umt/dpt/selectDeptCallManageList.do";
		}
	}

	/**
	 * 기 등록된 부서대표번호정보를 수정한다.
	 * @param banner - 부서대표번호 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping(value = "/uss/umt/dpt/updtDeptCallManage.do")
	public String updateDeptCallManage(@ModelAttribute("deptCallManageVO") DeptCallManageVO deptCallManageVO, BindingResult bindingResult, ModelMap model) throws Exception {
		beanValidator.validate(deptCallManageVO, bindingResult); //validation 수행

		if (bindingResult.hasErrors()) {
			return "egovframework/com/uss/umt/EgovDeptCallManageUpdt";
		} else {
			egovDeptCallManageService.updateDeptCallManage(deptCallManageVO);
			model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
			return "forward:/uss/umt/dpt/selectDeptCallManageList.do";
		}
	}

	/**
	 * 기 등록된 부서대표번호정보를 삭제한다.
	 * @param banner Banner
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/uss/umt/dpt/removeDeptCallManage.do")
	public String deleteDeptCallManage(@ModelAttribute("deptCallManageVO") DeptCallManageVO deptCallManageVO, Model model) throws Exception {

		egovDeptCallManageService.deleteDeptCallManage(deptCallManageVO);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/uss/umt/dpt/selectDeptCallManageList.do";
	}

	/**
	 * 기 등록된 부서대표번호정보목록을 일괄 삭제한다.
	 * @param banners String
	 * @param banner Banner
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/uss/umt/dpt/removeDeptCallManageList.do")
	public String deleteDeptCallManageList(@RequestParam("deptCallManages") String deptCallManages, @ModelAttribute("deptCallManageVO") DeptCallManageVO deptCallManageVO, ModelMap model) throws Exception {

		String[] strDeptCallManages = deptCallManages.split(";");
		for (int i = 0; i < strDeptCallManages.length; i++) {
			deptCallManageVO.setOrgnztId(strDeptCallManages[i]);
			egovDeptCallManageService.deleteDeptCallManage(deptCallManageVO);
		}
		
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/uss/umt/dpt/selectDeptCallManageList.do";
	}

}
