package egovframework.com.grp.service;

import java.util.List;


public interface EgovAddrGroupService {
	
	public List<AddrGroupVO> addrGroupList(AddrGroupVO addrGroupVO) throws Exception;
    
	public String addrGroupInsert(AddrGroupVO addrGroupVO) throws Exception;
	
	public AddrGroupVO addrGroupSelectOne(AddrGroupVO addrGroupVO) throws Exception;
	
	public String addrGroupUpdate(AddrGroupVO addrGroupVO) throws Exception;
	public String addrGroupUpdateName(AddrGroupVO addrGroupVO) throws Exception;
	public String addrGroupUpdateSequence(AddrGroupVO addrGroupVO) throws Exception;
	
	public String addrGroupDelete(AddrGroupVO addrGroupVO) throws Exception;
	
	public String addrGroupDeletes(AddrGroupVO addrGroupVO) throws Exception;

}