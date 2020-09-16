package egovframework.com.msg.rcv.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.msg.rcv.service.ComtccmmnDetailCode;
import egovframework.com.msg.rcv.service.EgovRcvaddrListService;
import egovframework.com.msg.rcv.service.RcvaddrList;
import egovframework.com.msg.rcv.service.RcvaddrListVO;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("egovRcvaddrListService")
public class EgovRcvaddrListServiceImpl extends EgovAbstractServiceImpl implements EgovRcvaddrListService{

	@Resource(name = "RcvaddrListDAO")
    private RcvaddrListDAO rcvaddrListDAO;
    
    @Resource(name = "egovAdbkIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "egovAdbkUserIdGnrService")
    private EgovIdGnrService idgenService2;
    
    @Override
    public List<ComtccmmnDetailCode> workList() throws Exception {
    	List<ComtccmmnDetailCode> result = rcvaddrListDAO.workList();
    	return result;
    } 
    
    @Override
	public List<RcvaddrListVO> rcvaddrList(RcvaddrListVO rcvaddrListVO) throws Exception {
		List<RcvaddrListVO> result = rcvaddrListDAO.rcvaddrList(rcvaddrListVO);
		return result;
	} 
    
    @Override
	public List<RcvaddrListVO> rcvaddrListUser(RcvaddrListVO rcvaddrListVO) throws Exception {
		List<RcvaddrListVO> result = rcvaddrListDAO.rcvaddrListUser(rcvaddrListVO);
		return result;
	} 
    
    @Override
    public List<UserManageVO> rcvaddrListUserId(RcvaddrListVO rcvaddrListVO) throws Exception {
    	List<UserManageVO> result = rcvaddrListDAO.rcvaddrListUserId(rcvaddrListVO);
    	return result;
    } 
    
    @Override
	public void rcvaddrInsert(RcvaddrList rcvaddrList) throws Exception {
		
    	rcvaddrListDAO.rcvaddrInsert(rcvaddrList);
	}

	@Override
	public void resDelete(RcvaddrListVO rcvaddrList) throws Exception {
		rcvaddrListDAO.resDelete(rcvaddrList);
	}
	@Override
	public void resDeletes(RcvaddrListVO rcvaddrList) throws Exception {
		rcvaddrListDAO.resDeletes(rcvaddrList);
	}

	@Override
	public List<RcvaddrList> userListall(RcvaddrList rcvaddrList) throws Exception {
		return rcvaddrListDAO.userListall(rcvaddrList);
	}


	@Override
	public List<RcvaddrList> partgListall(RcvaddrList rcvaddrList) throws Exception {
		return rcvaddrListDAO.partgListall(rcvaddrList);
	}

	@Override
	public List<RcvaddrList> listallM(RcvaddrList rcvaddrList) throws Exception {
		return rcvaddrListDAO.listallM(rcvaddrList);
	}

	@Override
	public List<RcvaddrList> reservationU(RcvaddrList rcvaddrList) throws Exception {
		return rcvaddrListDAO.reservationU(rcvaddrList);
	}
	@Override
	public List<RcvaddrList> reservationM(RcvaddrList rcvaddrList) throws Exception {
		return rcvaddrListDAO.reservationM(rcvaddrList);
	}
	@Override
	public List<RcvaddrList> reservationsU(RcvaddrList rcvaddrList) throws Exception {
		return rcvaddrListDAO.reservationsU(rcvaddrList);
	}
	@Override
	public List<RcvaddrList> reservationsM(RcvaddrList rcvaddrList) throws Exception {
		return rcvaddrListDAO.reservationsM(rcvaddrList);
	}
	@Override
	public List<RcvaddrList> reservationsTo(RcvaddrList rcvaddrList) throws Exception {
		return rcvaddrListDAO.reservationsTo(rcvaddrList);
	}
}
