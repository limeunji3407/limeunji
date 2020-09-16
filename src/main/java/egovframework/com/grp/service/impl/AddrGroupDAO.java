package egovframework.com.grp.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.grp.service.AddrGroupVO;

@Repository("AddrGroupDAO")
public class AddrGroupDAO extends EgovComAbstractDAO {


	public List<AddrGroupVO> addrGroupList(AddrGroupVO addrGroupVO) throws Exception {
        return selectList("AddrGroupDAO.addrGroupList", addrGroupVO);
    }
	
	public AddrGroupVO addrGroupSelectOne(AddrGroupVO addrGroupVO) throws Exception {
		
		return (AddrGroupVO) selectOne("AddrGroupDAO.addrGroupSelectOne", addrGroupVO);
    }
	
	public String addrGroupInsert(AddrGroupVO addrGroupVO) throws Exception {
		
		return String.valueOf((int)insert("AddrGroupDAO.addrGroupInsert", addrGroupVO));
    }

	public String addrGroupUpdate(AddrGroupVO addrGroupVO) throws Exception {
		
		return String.valueOf((int)update("AddrGroupDAO.addrGroupUpdate", addrGroupVO));
	}
	public String addrGroupUpdateName(AddrGroupVO addrGroupVO) throws Exception {
		
		return String.valueOf((int)update("AddrGroupDAO.addrGroupUpdateName", addrGroupVO));
	}
	public String addrGroupUpdateSequence(AddrGroupVO addrGroupVO) throws Exception {
		
		return String.valueOf((int)update("AddrGroupDAO.addrGroupUpdateSequence", addrGroupVO));
	}
	
	public String addrGroupDelete(AddrGroupVO addrGroupVO) throws Exception {
		return String.valueOf((int)delete("AddrGroupDAO.addrGroupDelete", addrGroupVO));
	}
	
	public String addrGroupDeletes(AddrGroupVO addrGroupVO) throws Exception {
		return String.valueOf((int)delete("AddrGroupDAO.addrGroupDeletes", addrGroupVO));
	}


 
}
