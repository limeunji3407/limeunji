package egovframework.com.uss.umt.service.impl;

import java.util.List;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.uss.umt.service.DeptManageVO;
import egovframework.com.uss.umt.service.SendNumberVO;

import org.springframework.stereotype.Repository;

@Repository("deptManageDAO")
public class DeptManageDAO extends EgovComAbstractDAO {

	/**
	 * 부서를 관리하기 위해 등록된 부서목록을 조회한다.
	 * @param deptManageVO - 부서 Vo
	 * @return List - 부서 목록
	 * @exception Exception
	 */
	public List<DeptManageVO> selectDeptManageList(DeptManageVO deptManageVO) throws Exception {
		return selectList("deptManageDAO.selectDeptManageList", deptManageVO);
	}
	public List<SendNumberVO> selectDeptCallList(String orgnztId) throws Exception {
		return selectList("deptManageDAO.selectDeptCallList", orgnztId);
	}

    /**
	 * 부서목록 총 갯수를 조회한다.
	 * @param deptManageVO - 부서 Vo
	 * @return int - 부서 카운트 수
	 * @exception Exception
	 */
    public int selectDeptManageListTotCnt(DeptManageVO deptManageVO) throws Exception {
        return (Integer)selectOne("deptManageDAO.selectDeptManageListTotCnt", deptManageVO);
    }

	/**
	 * 등록된 부서의 상세정보를 조회한다.
	 * @param deptManageVO - 부서 Vo
	 * @return deptManageVO - 부서 Vo
	 * 
	 * @param bannerVO
	 */
	public DeptManageVO selectDeptManage(DeptManageVO deptManageVO) throws Exception {
		return (DeptManageVO) selectOne("deptManageDAO.selectDeptManage", deptManageVO);
	}

	/**
	 * 부서정보를 신규로 등록한다.
	 * @param deptManageVO - 부서 model
	 */
	public void insertDeptManage(DeptManageVO deptManageVO) throws Exception {
		insert("deptManageDAO.insertDeptManage", deptManageVO);
	}
	public void insertDeptManageCall(DeptManageVO deptManageVO) throws Exception {
		insert("deptManageDAO.insertDeptManageCall", deptManageVO);
	}

	/**
	 * 기 등록된 부서정보를 수정한다.
	 * @param deptManageVO - 부서 model
	 */
	public void updateDeptManage(DeptManageVO deptManageVO) throws Exception {
        update("deptManageDAO.updateDeptManage", deptManageVO);
	}
	public void updateDeptManages(List<DeptManageVO> deptManageVO) throws Exception {
		update("deptManageDAO.updateDeptManages", deptManageVO);
	}

	/**
	 * 기 등록된 부서정보를 삭제한다.
	 * @param deptManageVO - 부서 model
	 * 
	 * @param banner
	 */
	public void deleteDeptManage(DeptManageVO deptManageVO) throws Exception {
		delete("deptManageDAO.deleteDeptManage", deptManageVO);
	}
	
	/**
	 * 기 등록된 부서의 발신번호를 삭제한다.
	 * @param deptManageVO - 부서 model
	 * 
	 * @param banner
	 */
	public void deleteDeptManageCall(DeptManageVO deptManageVO) throws Exception {
		delete("deptManageDAO.deleteDeptManageCall", deptManageVO);
	}
	
	public String selectOnePartName(String orgnztId)throws Exception{
		return selectOne("deptManageDAO.selectOnePartName", orgnztId);
	}

	public int codeCheck(String checkCode){
        return selectOne("deptManageDAO.codeCheck", checkCode);
    }
	
	public Integer selectDeptUser(String part_id) {
		return selectOne("deptManageDAO.selectDeptUser", part_id);
	}
}
