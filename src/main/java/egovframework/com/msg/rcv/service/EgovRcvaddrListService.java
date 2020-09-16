package egovframework.com.msg.rcv.service;

import java.util.List;

import egovframework.com.uss.umt.service.UserManageVO;

public interface EgovRcvaddrListService {
	public List<ComtccmmnDetailCode> workList() throws Exception;	 
	public List<RcvaddrListVO> rcvaddrList(RcvaddrListVO rcvaddrListVO) throws Exception;	 
	public List<RcvaddrListVO> rcvaddrListUser(RcvaddrListVO rcvaddrListVO) throws Exception;	
	public List<UserManageVO> rcvaddrListUserId(RcvaddrListVO rcvaddrListVO) throws Exception;	 
	public void rcvaddrInsert(RcvaddrList rcvaddrList) throws Exception;
	public void resDelete(RcvaddrListVO rcvaddrList) throws Exception; 
	public void resDeletes(RcvaddrListVO rcvaddrList) throws Exception; 
	
	public List<RcvaddrList> userListall(RcvaddrList rcvaddrList) throws Exception;
	public List<RcvaddrList> listallM(RcvaddrList rcvaddrList) throws Exception;
	
	public List<RcvaddrList> reservationU(RcvaddrList rcvaddrList) throws Exception;
	public List<RcvaddrList> reservationM(RcvaddrList rcvaddrList) throws Exception;

	public List<RcvaddrList> reservationsU(RcvaddrList rcvaddrList) throws Exception;
	public List<RcvaddrList> reservationsM(RcvaddrList rcvaddrList) throws Exception;
	
	public List<RcvaddrList> partgListall(RcvaddrList rcvaddrList) throws Exception;
	public List<RcvaddrList> reservationsTo(RcvaddrList rcvaddrList) throws Exception;
}
