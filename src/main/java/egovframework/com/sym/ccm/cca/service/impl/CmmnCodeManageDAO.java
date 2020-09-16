package egovframework.com.sym.ccm.cca.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.sym.ccm.cca.service.CmmnCode;
import egovframework.com.sym.ccm.cca.service.CmmnCodeDetail;
import egovframework.com.sym.ccm.cca.service.CmmnCodeVO;

/**
*
* 공통코드에 대한 데이터 접근 클래스를 정의한다
* @author 공통서비스 개발팀 이중호
* @since 2009.04.01
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일      수정자           수정내용
*  -------    --------    ---------------------------
*   2009.04.01  이중호          최초 생성
*
* </pre>
*/

@Repository("CmmnCodeManageDAO")
public class CmmnCodeManageDAO extends    EgovComAbstractDAO {

   /**
	 * 공통코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통코드 총 갯수)
     */
	public int selectCmmnCodeListTotCnt(CmmnCodeVO searchVO) throws Exception{
		return (Integer)selectOne("CmmnCodeManage.selectCmmnCodeListTotCnt", searchVO);
	}

   /**
	 * 공통코드 목록을 조회한다.
     * @param searchVO
     * @return List(공통코드 목록)
     * @throws Exception
     */
	public List<?> selectCmmnCodeList(CmmnCodeVO searchVO) throws Exception{
		 return selectList("CmmnCodeManage.selectCmmnCodeList", searchVO);
	}
	public List<?> selectCmmCodeDetails(String codeId) throws Exception{
		return selectList("CmmnCodeManage.selectCmmCodeDetails", codeId);
	}

	/**
	 * 공통코드 상세항목을 조회한다.
	 * @param cmmnCode
	 * @return CmmnCode(공통코드)
	 */
	public CmmnCodeVO selectCmmnCodeDetail(CmmnCodeVO cmmnCodeVO) throws Exception{
		return selectOne("CmmnCodeManage.selectCmmnCodeDetail", cmmnCodeVO);
}

	/**
	 * 공통코드를 수정한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void updateCmmnCode(CmmnCode cmmnCode) throws Exception{
		update("CmmnCodeManage.updateCmmnCode", cmmnCode);
	}
	public void updateCmmnCodeDetail(CmmnCodeDetail cmmnCode) throws Exception{
		update("CmmnCodeManage.updateCmmnCodeDetail", cmmnCode);
	}
	/**
	 * 기준정보 하위 삭제
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void deleteCmmnCodeDetail(CmmnCodeDetail cmmnCode) throws Exception{
		update("CmmnCodeManage.deleteCmmnCodeDetail", cmmnCode);
	}

	/**
	 * 공통코드를 등록한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void insertCmmnCode(CmmnCode cmmnCode) throws Exception{
		insert("CmmnCodeManage.insertCmmnCode", cmmnCode);
	}
	
	public void insertCmmnCodeDetail(CmmnCodeDetail cmmnCode) throws Exception{
		insert("CmmnCodeManage.insertCmmnCodeDetail", cmmnCode);
	}

	/**
	 * 공통코드를 삭제한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void deleteCmmnCode(CmmnCode cmmnCode) {
		delete("CmmnCodeManage.deleteCmmnCode", cmmnCode);
	}

	public Integer checkComCode(CmmnCode cmmnCode) throws Exception{
		return selectOne("CmmnCodeManage.checkComCode",cmmnCode);
	}
	
	public Integer checkCcmCode(CmmnCode cmmnCode) throws Exception{
		return selectOne("CmmnCodeManage.checkCcmCode",cmmnCode);
	}
	
	public Integer checkCcmName(CmmnCode cmmnCode) throws Exception{
		return selectOne("CmmnCodeManage.checkCcmName",cmmnCode);
	}
}
