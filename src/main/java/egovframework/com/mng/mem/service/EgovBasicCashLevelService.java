package egovframework.com.mng.mem.service;

import java.util.List;

/**
 * 등급관리에 관한 인터페이스클래스를 정의한다.
 * @author 김수로
 * @since 2020.02
 * @version 1.0
 * @see
 *
 * 
 */
public interface EgovBasicCashLevelService {

	/**
	 *  
	 * @param adminId 관리자아이디
	 * @return BasicCashLevelVO 등급상세정보
	 * @throws Exception
	 */
	public List<BasicCashLevelVO> selectBasicCashLevelList(String adminId) throws Exception;
	public List<BasicCashLevelVO> selectBasicCashLevelListAll(String uids) throws Exception;
	
	
	/**
	 * @param BasicCashLevelVO 등급등록
	 * @return 등록결과
	 * @throws Exception
	 */
	public String insertBasicCashLevel(BasicCashLevelVO basicCashLvVO) throws Exception;
	public String updateLevel(BasicCashLevelVO basicCashLvVO) throws Exception;
	public String deleteBasicCashLevel(int lvid) throws Exception;

 
	
	public String updateCashLevel(long lvid) throws Exception;

	/**
	 * 화면에 조회된 등급정보를 데이터베이스에서 삭제
	 * @param checkedIdForDel 삭제대상 등급아이디
	 * @throws Exception
	 */
	public String deleteCashLevel(long lvid) throws Exception; 
 
  

}