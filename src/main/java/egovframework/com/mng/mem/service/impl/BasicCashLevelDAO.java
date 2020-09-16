package egovframework.com.mng.mem.service.impl;

import java.util.List;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.mng.mem.service.BasicCashLevelVO;


@Repository("BasicCashLevelDAO")
public class BasicCashLevelDAO extends EgovComAbstractDAO { 
	
	
	public List<BasicCashLevelVO> selectBasicCashLevelList(String userid) throws Exception {
        return selectList("BasicCashLevelDAO.selectBasicCashLevelList", userid);
	};
	public List<BasicCashLevelVO> selectBasicCashLevelListAll(String uids) throws Exception {
		return selectList("BasicCashLevelDAO.selectBasicCashLevelListAll", uids);
	};
	public String insertBasicCashLevel(BasicCashLevelVO basicCashLvVO) throws Exception {
        return String.valueOf((int)insert("BasicCashLevelDAO.insertBasicCashLevel", basicCashLvVO));
	}
	public String updateLevel(BasicCashLevelVO basicCashLvVO) throws Exception {
		return String.valueOf((int)insert("BasicCashLevelDAO.updateBasicCashLevel", basicCashLvVO));
	}
	public String updateCashLevel(long lvid) throws Exception {
    	return String.valueOf((int)update("BasicCashLevelDAO.updateBasicCashLevel", lvid));
	}
	public String deleteBasicCashLevel(int lvid) throws Exception {
		return String.valueOf((int)delete("BasicCashLevelDAO.deleteBasicCashLevel", lvid));
	}
	public String deleteCashLevel(long lvid) throws Exception {
    	return String.valueOf((int)delete("BasicCashLevelDAO.deleteBasicCashLevel", lvid));
	}
	
	 
}

