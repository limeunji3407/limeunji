package egovframework.com.uss.umt.service.impl;

import java.util.List;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.uss.umt.service.DeptCallManageVO;

import org.springframework.stereotype.Repository;

@Repository("deptCallManageDAO")
public class DeptCallManageDAO extends EgovComAbstractDAO {

	/**
	 * 부서대표번호를 관리하기 위해 등록된 부서대표번호목록을 조회한다.
	 * @param DeptCallManageVO - 부서대표번호 Vo
	 * @return List - 부서대표번호 목록
	 * @exception Exception
	 */
	public List<DeptCallManageVO> selectDeptCallManageList(DeptCallManageVO deptCallManageVO) throws Exception {
		return selectList("deptCallManageDAO.selectDeptCallManageList", deptCallManageVO);
	}

    /**
	 * 부서대표번호목록 총 갯수를 조회한다.
	 * @param DeptCallManageVO - 부서대표번호 Vo
	 * @return int - 부서대표번호 카운트 수
	 * @exception Exception
	 */
    public int selectDeptCallManageListTotCnt(DeptCallManageVO deptCallManageVO) throws Exception {
        return (Integer)selectOne("deptCallManageDAO.selectDeptCallManageListTotCnt", deptCallManageVO);
    }

	/**
	 * 등록된 부서대표번호의 상세정보를 조회한다.
	 * @param DeptCallManageVO - 부서대표번호 Vo
	 * @return DeptCallManageVO - 부서대표번호 Vo
	 * 
	 * @param bannerVO
	 */
	public DeptCallManageVO selectDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception {
		return (DeptCallManageVO) selectOne("deptCallManageDAO.selectDeptCallManage", deptCallManageVO);
	}

	/**
	 * 부서대표번호정보를 신규로 등록한다.
	 * @param DeptCallManageVO - 부서대표번호 model
	 */
	public void insertDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception {
		insert("deptCallManageDAO.insertDeptCallManage", deptCallManageVO);
	}

	/**
	 * 기 등록된 부서대표번호정보를 수정한다.
	 * @param DeptCallManageVO - 부서대표번호 model
	 */
	public void updateDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception {
        update("deptCallManageDAO.updateDeptCallManage", deptCallManageVO);
	}

	/**
	 * 기 등록된 부서대표번호정보를 삭제한다.
	 * @param DeptCallManageVO - 부서대표번호 model
	 * 
	 * @param banner
	 */
	public void deleteDeptCallManage(DeptCallManageVO deptCallManageVO) throws Exception {
		delete("deptCallManageDAO.deleteDeptCallManage", deptCallManageVO);
	}

}
