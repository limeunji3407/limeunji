package egovframework.com.grp.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.grp.service.AddrGroupVO;
import egovframework.com.grp.service.EgovAddrGroupService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("egovAddrGroupService")
public class EgovAddrGroupServiceImpl extends EgovAbstractServiceImpl implements EgovAddrGroupService {

	@Resource(name = "AddrGroupDAO")
    private AddrGroupDAO addrGroupDAO;
    
    @Resource(name = "egovAdbkIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "egovAdbkUserIdGnrService")
    private EgovIdGnrService idgenService2;

	@Override
	public List<AddrGroupVO> addrGroupList(AddrGroupVO addrGroupVO) throws Exception {
		
		List<AddrGroupVO> result = addrGroupDAO.addrGroupList(addrGroupVO);
		
		return result;
	}

	@Override
	public String addrGroupInsert(AddrGroupVO addrGroupVO) throws Exception {
		
		String result = addrGroupDAO.addrGroupInsert(addrGroupVO);
		
		return result;
	}

	@Override
	public AddrGroupVO addrGroupSelectOne(AddrGroupVO addrGroupVO) throws Exception {
		
		AddrGroupVO result = addrGroupDAO.addrGroupSelectOne(addrGroupVO);
		
		return result;
	}

	@Override
	public String addrGroupUpdate(AddrGroupVO addrGroupVO) throws Exception {
		
		String result = addrGroupDAO.addrGroupUpdate(addrGroupVO);
		
		return result;
	}
	@Override
	public String addrGroupUpdateName(AddrGroupVO addrGroupVO) throws Exception {
		
		String result = addrGroupDAO.addrGroupUpdateName(addrGroupVO);
		
		return result;
	}
	@Override
	public String addrGroupUpdateSequence(AddrGroupVO addrGroupVO) throws Exception {
		
		String result = addrGroupDAO.addrGroupUpdateSequence(addrGroupVO);
		
		return result;
	}

	@Override
	public String addrGroupDelete(AddrGroupVO addrGroupVO) throws Exception {
		String result = addrGroupDAO.addrGroupDelete(addrGroupVO);
		return result;
	}
	
	@Override
	public String addrGroupDeletes(AddrGroupVO addrGroupVO) throws Exception {
		String result = addrGroupDAO.addrGroupDeletes(addrGroupVO);
		return result;
	}
	 
}
