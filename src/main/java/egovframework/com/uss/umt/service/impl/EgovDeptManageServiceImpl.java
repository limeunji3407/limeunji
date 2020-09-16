package egovframework.com.uss.umt.service.impl;

import java.util.List;

import egovframework.com.uss.umt.service.DeptManageVO;
import egovframework.com.uss.umt.service.EgovDeptManageService;
import egovframework.com.uss.umt.service.SendNumberVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("egovDeptManageService")
public class EgovDeptManageServiceImpl extends EgovAbstractServiceImpl implements EgovDeptManageService {
	
	@Resource(name="deptManageDAO")
    private DeptManageDAO deptManageDAO;

	/**
	 * 부서를 관리하기 위해 등록된 부서목록을 조회한다.
	 * @param deptManageVO - 부서 Vo
	 * @return List - 부서 목록
	 * 
	 * @param deptManageVO
	 */
	public List<DeptManageVO> selectDeptManageList(DeptManageVO deptManageVO) throws Exception {
		return deptManageDAO.selectDeptManageList(deptManageVO);
	}
	public List<SendNumberVO> selectDeptCallList(String orgnztId) throws Exception {
		return deptManageDAO.selectDeptCallList(orgnztId);
	}

	/**
	 * 부서목록 총 갯수를 조회한다.
	 * @param deptManageVO - 부서 Vo
	 * @return int - 부서 카운트 수
	 * 
	 * @param deptManageVO
	 */
	public int selectDeptManageListTotCnt(DeptManageVO deptManageVO) throws Exception {
		return deptManageDAO.selectDeptManageListTotCnt(deptManageVO);
	}

	/**
	 * 등록된 부서의 상세정보를 조회한다.
	 * @param deptManageVO - 부서 Vo
	 * @return deptManageVO - 부서 Vo
	 * 
	 * @param deptManageVO
	 */
	public DeptManageVO selectDeptManage(DeptManageVO deptManageVO) throws Exception {
		return deptManageDAO.selectDeptManage(deptManageVO);
	}

	/**
	 * 부서정보를 신규로 등록한다.
	 * @param deptManageVO - 부서 model
	 * 
	 * @param deptManageVO
	 */
	public void insertDeptManage(DeptManageVO deptManageVO) throws Exception {
		deptManageDAO.insertDeptManage(deptManageVO);
	}
	public void insertDeptManageCall(DeptManageVO deptManageVO) throws Exception {
		deptManageDAO.insertDeptManageCall(deptManageVO);
	}

	/**
	 * 기 등록된 부서정보를 수정한다.
	 * @param deptManageVO - 부서 model
	 * 
	 * @param deptManageVO
	 */
	public void updateDeptManage(DeptManageVO deptManageVO) throws Exception {
		deptManageDAO.updateDeptManage(deptManageVO);
	}
	public void updateDeptManages(List<DeptManageVO> deptManageVO) throws Exception {
		deptManageDAO.updateDeptManages(deptManageVO);
	}

	/**
	 * 기 등록된 부서정보를 삭제한다.
	 * @param deptManageVO - 부서 model
	 * 
	 * @param deptManageVO
	 */
	public void deleteDeptManage(DeptManageVO deptManageVO) throws Exception {
		deptManageDAO.deleteDeptManage(deptManageVO);
	}
	
	/**
	 * 기 등록된 부서의 발신번호를 전부 삭제한다.
	 * @param deptManageVO - 부서 model
	 * 
	 * @param deptManageVO
	 */
	public void deleteDeptManageCall(DeptManageVO deptManageVO) throws Exception {
		deptManageDAO.deleteDeptManageCall(deptManageVO);
	}

	@Override
	public String selectOnePartName(String orgnztId) throws Exception {
		return deptManageDAO.selectOnePartName(orgnztId);
	}
	
	@Override
	public int codeCheck(String checkCode) {
		return deptManageDAO.codeCheck(checkCode);
	}
	@Override
	public Integer selectDeptUser(String part_code) throws Exception {
		
		return deptManageDAO.selectDeptUser(part_code);
	}
}
