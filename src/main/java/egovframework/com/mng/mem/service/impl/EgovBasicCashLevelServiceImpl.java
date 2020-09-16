package egovframework.com.mng.mem.service.impl;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.mng.mem.service.BasicCashLevelVO;
import egovframework.com.mng.mem.service.EgovBasicCashLevelService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;




@Service("egovBasicCashLevelService")
public class EgovBasicCashLevelServiceImpl extends EgovAbstractServiceImpl implements EgovBasicCashLevelService{

    @Resource(name = "BasicCashLevelDAO")
    private BasicCashLevelDAO bCashLvDAO;
    
  
	public List<BasicCashLevelVO> selectBasicCashLevelList(String adminId) throws Exception {
		List<BasicCashLevelVO> basicList = bCashLvDAO.selectBasicCashLevelList(adminId);
		return basicList;
	};
	public List<BasicCashLevelVO> selectBasicCashLevelListAll(String uids) throws Exception {
		List<BasicCashLevelVO> basicList = bCashLvDAO.selectBasicCashLevelListAll(uids);
		return basicList;
	};

 
	public String insertBasicCashLevel(BasicCashLevelVO basicCashLvVO) throws Exception {
		String result = bCashLvDAO.insertBasicCashLevel(basicCashLvVO);
		return result;
	} 
	public String updateLevel(BasicCashLevelVO basicCashLvVO) throws Exception {
		String result = bCashLvDAO.updateLevel(basicCashLvVO);
		return result;
	} 
	public String deleteBasicCashLevel(int lvid) throws Exception {
		String result = bCashLvDAO.deleteBasicCashLevel(lvid);
		return result;
	} 

	public String updateCashLevel(long lvid) throws Exception {
		String result = bCashLvDAO.updateCashLevel(lvid);
		return result;
	}

 
	public String deleteCashLevel(long lvid) throws Exception {
		String result = bCashLvDAO.updateCashLevel(lvid);
		return result;
		
	} 
	 
}
