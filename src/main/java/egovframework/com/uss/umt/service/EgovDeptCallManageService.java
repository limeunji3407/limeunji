package egovframework.com.uss.umt.service;

import java.util.List;

public interface EgovDeptCallManageService {

	/**
	 * 부서대표번호를 관리하기 위해 등록된 부서대표번호목록을 조회한다.
	 * @param deptCallManageVO - 부서대표번호 Vo
	 * @return List - 부서대표번호 목록
	 * 
	 * @param deptCallManageVO
	 */
	public List<DeptCallManageVO> selectDeptCallManageList(DeptCallManageVO deptCallManageVO) throws Exception;

	/**
	 * 부서대표번호목록 총 갯수를 조회한다.
	 * @param deptCallManageVO - 부서대표번호 Vo
	 * @return int - 부서대표번호 카운트 수
	 * 
	 * @param deptCallManageVO
	 */
	public int selectDeptCallManageListTotCnt(DeptCallManageVO deptCallManageVO) throws Exception;
	
	/**
	 * 등록된 부서대표번호의 상세정보를 조회한다.
	 * @param deptCallManageVO - 부서대표번호 Vo
	 * @return deptCallManageVO - 부서대표번호 Vo
	 * 
	 * @param deptCallManageVO
	 */
	public DeptCallManageVO selectDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception;

	/**
	 * 부서대표번호정보를 신규로 등록한다.
	 * @param deptCallManageVO - 부서대표번호 model
	 * 
	 * @param deptCallManageVO
	 */
	public void insertDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception;

	/**
	 * 기 등록된 부서대표번호정보를 수정한다.
	 * @param deptCallManageVO - 부서대표번호 model
	 * 
	 * @param deptCallManageVO
	 */
	public void updateDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception;

	/**
	 * 기 등록된 부서대표번호정보를 삭제한다.
	 * @param deptCallManageVO - 부서대표번호 model
	 * 
	 * @param deptCallManageVO
	 */
	public void deleteDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception;
}
