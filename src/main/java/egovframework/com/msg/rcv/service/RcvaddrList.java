package egovframework.com.msg.rcv.service;

import java.util.List;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.uss.umt.service.UserManageVO;

public class RcvaddrList  extends ComDefaultVO {
	
	private static final long serialVersionUID = 6036244040184842281L;
	
	/* 수신목록 ID */
	/*
	private String fileName;
	

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	*/
	String partgRole;
	String orgnztId;
	List<UserManageVO> userManageVOList;
	int cnt;
	
	String msg_id;
	
	
	
	public String getMsg_id() {
		return msg_id;
	}

	public void setMsg_id(String msg_id) {
		this.msg_id = msg_id;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	private String pay_code;
	private String sent_date;
	private String call_from;
	private String call_to;
	private String sms_txt;
	private String cur_state;
	private String msg_type_resend;
	private String rslt_code;
	private String rslt_code2;
	private String mms_noticetalk_body;
	private String mms_body;
	private String mms_friend_body;
	private String mms_noticetalk_subject;
	private String mms_subject;
	private String mms_friend_subject;
	private String user_id;
	private String start_dt;
	private String end_dt;
	private String month;
	private String excel_seq;
	private String req_date;
	private String user_part;
	private String user_name;
	private String msg_seq;

	public String getMsg_seq() {
		return msg_seq;
	}

	public void setMsg_seq(String msg_seq) {
		this.msg_seq = msg_seq;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_part() {
		return user_part;
	}

	public void setUser_part(String user_part) {
		this.user_part = user_part;
	}

	public String getReq_date() {
		return req_date;
	}

	public void setReq_date(String req_date) {
		this.req_date = req_date;
	}

	public String getExcel_seq() {
		return excel_seq;
	}

	public void setExcel_seq(String excel_seq) {
		this.excel_seq = excel_seq;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getStart_dt() {
		return start_dt;
	}

	public void setStart_dt(String start_dt) {
		this.start_dt = start_dt;
	}

	public String getEnd_dt() {
		return end_dt;
	}

	public void setEnd_dt(String end_dt) {
		this.end_dt = end_dt;
	}

	public String getPay_code() {
		return pay_code;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setPay_code(String pay_code) {
		this.pay_code = pay_code;
	}

	public String getSent_date() {
		return sent_date;
	}

	public void setSent_date(String sent_date) {
		this.sent_date = sent_date;
	}

	public String getCall_from() {
		return call_from;
	}

	public void setCall_from(String call_from) {
		this.call_from = call_from;
	}

	public String getCall_to() {
		return call_to;
	}

	public void setCall_to(String call_to) {
		this.call_to = call_to;
	}

	public String getSms_txt() {
		return sms_txt;
	}

	public void setSms_txt(String sms_txt) {
		this.sms_txt = sms_txt;
	}

	public String getCur_state() {
		return cur_state;
	}

	public void setCur_state(String cur_state) {
		this.cur_state = cur_state;
	}

	public String getMsg_type_resend() {
		return msg_type_resend;
	}

	public void setMsg_type_resend(String msg_type_resend) {
		this.msg_type_resend = msg_type_resend;
	}

	public String getRslt_code() {
		return rslt_code;
	}

	public void setRslt_code(String rslt_code) {
		this.rslt_code = rslt_code;
	}

	public String getRslt_code2() {
		return rslt_code2;
	}

	public void setRslt_code2(String rslt_code2) {
		this.rslt_code2 = rslt_code2;
	}

	public String getMms_noticetalk_body() {
		return mms_noticetalk_body;
	}

	public void setMms_noticetalk_body(String mms_noticetalk_body) {
		this.mms_noticetalk_body = mms_noticetalk_body;
	}

	public String getMms_body() {
		return mms_body;
	}

	public void setMms_body(String mms_body) {
		this.mms_body = mms_body;
	}

	public String getMms_friend_body() {
		return mms_friend_body;
	}

	public void setMms_friend_body(String mms_friend_body) {
		this.mms_friend_body = mms_friend_body;
	}

	public String getMms_noticetalk_subject() {
		return mms_noticetalk_subject;
	}

	public void setMms_noticetalk_subject(String mms_noticetalk_subject) {
		this.mms_noticetalk_subject = mms_noticetalk_subject;
	}

	public String getMms_subject() {
		return mms_subject;
	}

	public void setMms_subject(String mms_subject) {
		this.mms_subject = mms_subject;
	}

	public String getMms_friend_subject() {
		return mms_friend_subject;
	}

	public void setMms_friend_subject(String mms_friend_subject) {
		this.mms_friend_subject = mms_friend_subject;
	}

	public String getRcvId() {
		return rcvId;
	}

	public void setRcvId(String rcvId) {
		this.rcvId = rcvId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRcvNumber() {
		return rcvNumber;
	}

	public void setRcvNumber(String rcvNumber) {
		this.rcvNumber = rcvNumber;
	}

	public String getSndNumber() {
		return sndNumber;
	}

	public void setSndNumber(String sndNumber) {
		this.sndNumber = sndNumber;
	}

	public String getSendDate() {
		return sendDate;
	}

	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}

	public String getRcvEmplyChk() {
		return rcvEmplyChk;
	}

	public void setRcvEmplyChk(String rcvEmplyChk) {
		this.rcvEmplyChk = rcvEmplyChk;
	}

	public String getRcvType() {
		return rcvType;
	}

	public void setRcvType(String rcvType) {
		this.rcvType = rcvType;
	}

	public String getRcvCheck() {
		return rcvCheck;
	}

	public void setRcvCheck(String rcvCheck) {
		this.rcvCheck = rcvCheck;
	}

	public String getRcvRsvtChk() {
		return rcvRsvtChk;
	}

	public void setRcvRsvtChk(String rcvRsvtChk) {
		this.rcvRsvtChk = rcvRsvtChk;
	}

	public String getRcvEtc() {
		return rcvEtc;
	}

	public void setRcvEtc(String rcvEtc) {
		this.rcvEtc = rcvEtc;
	}

	public String getRcvTitle() {
		return rcvTitle;
	}

	public void setRcvTitle(String rcvTitle) {
		this.rcvTitle = rcvTitle;
	}

	public String getRcvContent() {
		return rcvContent;
	}

	public void setRcvContent(String rcvContent) {
		this.rcvContent = rcvContent;
	}

	public List<UserManageVO> getUserManageVOList() {
		return userManageVOList;
	}

	public void setUserManageVOList(List<UserManageVO> userManageVOList) {
		this.userManageVOList = userManageVOList;
	}

	public String getOrgnztId() {
		return orgnztId;
	}

	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}

	public String getPartgRole() {
		return partgRole;
	}

	public void setPartgRole(String partgRole) {
		this.partgRole = partgRole;
	}

	/* 수신목록 ID */
	private String rcvId;
	
	/* 전송한 유저ID */
	private String userId;
	
	/* 수신자명 */
	private String column1;
	
	/* 핸드폰번호 */
	private String rcvNumber;
	
	/* 보낸 번호 */
	private String sndNumber;
	
	/* 보낸 일시 */
	private String sendDate;
	
	/* 직원여부 0, 1:직원 */
	private String rcvEmplyChk;
	
	/* 메세지 타입 0:SMS 1:LMS 2:MMS 3:알림톡 4:친구톡 5:경조사 */
	private String rcvType;
	
	/* 전송여부체크 0:MSG_DATA 1:완료 2:미완료 */
	private String rcvCheck;
	
	/* 0:예약 1:즉시 2:테스트 */
	private String rcvRsvtChk;
	
	/* 비고메모 */
	private String rcvEtc;
	
	/* 제목 */
	private String rcvTitle;
	
	/* 내용 */
	private String rcvContent;
	
	
	/* Getter & Setter */
	public String getRcv_id() {
		return rcvId;
	}

	public void setRcv_id(String rcvId) {
		this.rcvId = rcvId;
	}

	public String getUserid() {
		return userId;
	}

	public void setUserid(String userId) {
		this.userId = userId;
	}

	public String getColumn1() {
		return column1;
	}

	public void setColumn1(String column1) {
		this.column1 = column1;
	}

	public String getRcv_number() {
		return rcvNumber;
	}

	public void setRcv_number(String rcvNumber) {
		this.rcvNumber = rcvNumber;
	}


	public String getSnd_number() {
		return sndNumber;
	}

	public void setSnd_number(String sndNumber) {
		this.sndNumber = sndNumber;
	}
	

	public String getSend_date() {
		return sendDate;
	}

	public void setSend_date(String sendDate) {
		this.sendDate = sendDate;
	}
		
	
	public String getRcv_emply_chk() {
		return rcvEmplyChk;
	}

	public void setRcv_emply_chk(String rcvEmplyChk) {
		this.rcvEmplyChk = rcvEmplyChk;
	}

	public String getRcv_type() {
		return rcvType;
	}

	public void setRcv_type(String rcvType) {
		this.rcvType = rcvType;
	}

	public String getRcv_check() {
		return rcvCheck;
	}

	public void setRcv_check(String rcvCheck) {
		this.rcvCheck = rcvCheck;
	}

	public String getRcv_rsvt_chk() {
		return rcvRsvtChk;
	}

	public void setRcv_rsvt_chk(String rcvRsvtChk) {
		this.rcvRsvtChk = rcvRsvtChk;
	}

	public String getRcv_etc() {
		return rcvEtc;
	}

	public void setRcv_etc(String rcvEtc) {
		this.rcvEtc = rcvEtc;
	}
	

	public String getRcv_title() {
		return rcvTitle;
	}

	public void setRcv_title(String rcvTitle) {
		this.rcvTitle = rcvTitle;
	}
	public String getRcv_content() {
		return rcvContent;
	}

	public void setRcv_content(String rcvContent) {
		this.rcvContent = rcvContent;
	}
}
