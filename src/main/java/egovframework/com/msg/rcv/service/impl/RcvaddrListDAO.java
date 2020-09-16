package egovframework.com.msg.rcv.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.msg.rcv.service.ComtccmmnDetailCode;
import egovframework.com.msg.rcv.service.RcvaddrList;
import egovframework.com.msg.rcv.service.RcvaddrListVO;
import egovframework.com.uss.umt.service.UserManageVO;

@Repository("RcvaddrListDAO")
public class RcvaddrListDAO extends EgovComAbstractDAO{
 
	public List<ComtccmmnDetailCode> workList() throws Exception {
		return selectList("RcvaddrListDAO.workList");
	}
	public List<RcvaddrListVO> rcvaddrList(RcvaddrListVO rcvaddrListVO) throws Exception {
        return selectList("RcvaddrListDAO.rcvaddrList", rcvaddrListVO);
    }
	
	public List<RcvaddrListVO> rcvaddrListUser(RcvaddrListVO rcvaddrListVO) throws Exception {
        return selectList("RcvaddrListDAO.rcvaddrListUser", rcvaddrListVO);
    }
	public List<UserManageVO> rcvaddrListUserId(RcvaddrListVO rcvaddrListVO) throws Exception {
		return selectList("RcvaddrListDAO.rcvaddrListUserId", rcvaddrListVO);
	}
 
	
	public void rcvaddrInsert(RcvaddrList rcvaddrList) throws Exception {
		
		insert("RcvaddrListDAO.rcvaddrInsert", rcvaddrList);
    }
	
	public void resDelete(RcvaddrList rcvaddrList) throws Exception{
		delete("RcvaddrListDAO.resDelete", rcvaddrList);
	}
	public void resDeletes(RcvaddrList rcvaddrList) throws Exception{
		delete("RcvaddrListDAO.resDeletes", rcvaddrList);
	}
	
	public List<RcvaddrList> userListall(RcvaddrList rcvaddrList) throws Exception{
		return selectList("RcvaddrListDAO.userListall", rcvaddrList);
	}
	
	public List<RcvaddrList> reservationU(RcvaddrList rcvaddrList) throws Exception{
		return selectList("RcvaddrListDAO.reservationU", rcvaddrList);
	}
	
	public List<RcvaddrList> partgListall(RcvaddrList rcvaddrList) throws Exception{
		return selectList("RcvaddrListDAO.partgListall", rcvaddrList);
	}
	
	public List<RcvaddrList> listallM(RcvaddrList rcvaddrList) throws Exception{
		return selectList("RcvaddrListDAO.listallM", rcvaddrList);
	}
	
	public List<RcvaddrList> reservationM(RcvaddrList rcvaddrList) throws Exception{
		return selectList("RcvaddrListDAO.reservationM", rcvaddrList);
	}
	public List<RcvaddrList> reservationsU(RcvaddrList rcvaddrList) throws Exception{
		return selectList("RcvaddrListDAO.reservationsU", rcvaddrList);
	}
	public List<RcvaddrList> reservationsM(RcvaddrList rcvaddrList) throws Exception{
		return selectList("RcvaddrListDAO.reservationsM", rcvaddrList);
	}
	public List<RcvaddrList> reservationsTo(RcvaddrList rcvaddrList) throws Exception{
		return selectList("RcvaddrListDAO.reservationsTo", rcvaddrList);
	}
}
