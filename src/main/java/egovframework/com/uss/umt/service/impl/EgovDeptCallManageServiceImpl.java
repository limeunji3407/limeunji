package egovframework.com.uss.umt.service.impl;

import java.util.List;

import egovframework.com.uss.umt.service.DeptCallManageVO;
import egovframework.com.uss.umt.service.EgovDeptCallManageService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("egovDeptCallManageService")
public class EgovDeptCallManageServiceImpl extends EgovAbstractServiceImpl implements EgovDeptCallManageService {
	
	@Resource(name="deptCallManageDAO")
    private DeptCallManageDAO deptCallManageDAO;

	/**
	 * 부서를 관리하기 위해 등록된 부서목록을 조회한다.
	 * @param deptCallManageVO - 부서 Vo
	 * @return List - 부서 목록
	 * 
	 * @param deptCallManageVO
	 */
	public List<DeptCallManageVO> selectDeptCallManageList(DeptCallManageVO deptCallManageVO) throws Exception {
		return deptCallManageDAO.selectDeptCallManageList(deptCallManageVO);
	}

	/**
	 * 부서목록 총 갯수를 조회한다.
	 * @param deptCallManageVO - 부서 Vo
	 * @return int - 부서 카운트 수
	 * 
	 * @param deptCallManageVO
	 */
	public int selectDeptCallManageListTotCnt(DeptCallManageVO deptCallManageVO) throws Exception {
		return deptCallManageDAO.selectDeptCallManageListTotCnt(deptCallManageVO);
	}

	/**
	 * 등록된 부서의 상세정보를 조회한다.
	 * @param deptCallManageVO - 부서 Vo
	 * @return deptCallManageVO - 부서 Vo
	 * 
	 * @param deptCallManageVO
	 */
	public DeptCallManageVO selectDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception {
		return deptCallManageDAO.selectDeptCallManage(deptCallManageVO);
	}

	/**
	 * 부서정보를 신규로 등록한다.
	 * @param deptCallManageVO - 부서 model
	 * 
	 * @param deptCallManageVO
	 */
	public void insertDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception {
		deptCallManageDAO.insertDeptCallManage(deptCallManageVO);
	}

	/**
	 * 기 등록된 부서정보를 수정한다.
	 * @param deptCallManageVO - 부서 model
	 * 
	 * @param deptCallManageVO
	 */
	public void updateDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception {
		deptCallManageDAO.updateDeptCallManage(deptCallManageVO);
	}

	/**
	 * 기 등록된 부서정보를 삭제한다.
	 * @param deptCallManageVO - 부서 model
	 * 
	 * @param deptCallManageVO
	 */
	public void deleteDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception {
		deptCallManageDAO.deleteDeptCallManage(deptCallManageVO);
	}
}
