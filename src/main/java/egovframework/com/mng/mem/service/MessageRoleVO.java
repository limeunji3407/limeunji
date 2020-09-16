package egovframework.com.mng.mem.service;

import java.io.Serializable;
import java.util.List;

/*
 * 2020.02.20 
 * By 김수로
 * 사용자메세지권한설정 , MO권한설정    전체기본기준 메세지권한
 * 관리자만 등록수정가능
 */

@SuppressWarnings("serial")
public class MessageRoleVO implements Serializable{

	private Integer seq;
	private Integer sms; /* 0 권한없은  1권한있음  */
	private Integer lms;
	private Integer mms;
	private Integer notice;
	private Integer noticelms;
	private Integer friend;
	private Integer friendlms;
	private Integer friendmms;
	private Integer mo; //
	private Integer partcash; //부서 기본부여캐시
	private Integer usercash; //사용자 기본부여캐시
	private Integer checktype; //전체,부서,사용자
	private List<String> userlist; //사죵자아이디리스트
	private List<String> partlist; //부서명ID목록
	String orgnztId;
	
	public String getOrgnztId() {
		return orgnztId;
	}
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public Integer getSms() {
		return sms;
	}
	public void setSms(Integer sms) {
		this.sms = sms;
	}
	public Integer getLms() {
		return lms;
	}
	public void setLms(Integer lms) {
		this.lms = lms;
	}
	public Integer getMms() {
		return mms;
	}
	public void setMms(Integer mms) {
		this.mms = mms;
	}
	public Integer getNotice() {
		return notice;
	}
	public void setNotice(Integer notice) {
		this.notice = notice;
	}
	public Integer getNoticelms() {
		return noticelms;
	}
	public void setNoticelms(Integer noticelms) {
		this.noticelms = noticelms;
	}
	public Integer getFriend() {
		return friend;
	}
	public void setFriend(Integer friend) {
		this.friend = friend;
	}
	public Integer getFriendlms() {
		return friendlms;
	}
	public void setFriendlms(Integer friendlms) {
		this.friendlms = friendlms;
	}
	public Integer getFriendmms() {
		return friendmms;
	}
	public void setFriendmms(Integer friendmms) {
		this.friendmms = friendmms;
	}
	public Integer getMo() {
		return mo;
	}
	public void setMo(Integer mo) {
		this.mo = mo;
	}
	public Integer getPartcash() {
		return partcash;
	}
	public void setPartcash(Integer partcash) {
		this.partcash = partcash;
	}
	public Integer getUsercash() {
		return usercash;
	}
	public void setUsercash(Integer usercash) {
		this.usercash = usercash;
	}
	public Integer getChecktype() {
		return checktype;
	}
	public void setChecktype(Integer checktype) {
		this.checktype = checktype;
	}
	public List<String> getUserlist() {
		return userlist;
	}
	public void setUserlist(List<String> userlist) {
		this.userlist = userlist;
	}
	public List<String> getPartlist() {
		return partlist;
	}
	public void setPartlist(List<String> partlist) {
		this.partlist = partlist;
	}

}
