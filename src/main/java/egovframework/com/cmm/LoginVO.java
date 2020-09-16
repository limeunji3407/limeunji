package egovframework.com.cmm;

import java.io.Serializable;

/**
 * @Class Name : LoginVO.java
 * @Description : Login VO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.03.03    박지욱          최초 생성
 *
 *  @author 공통서비스 개발팀 박지욱
 *  @since 2009.03.03
 *  @version 1.0
 *  @see
 *  
 */
public class LoginVO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8274004534207618049L;
	
	/** 아이디 */
	private String id;
	/** 이름 */
	private String name;
	/** 주민등록번호 */
	private String ihidNum;
	/** 이메일주소 */
	private String email;
	/** 비밀번호 */
	private String password;
	/** 비밀번호 힌트 */
	private String passwordHint;
	/** 비밀번호 정답 */
	private String passwordCnsr;
	/** 사용자구분 */
	private String userSe;
	/** 조직(부서)ID */
	private String orgnztId;
	/** 조직(부서)명 */
	private String orgnztNm;
	/** 고유아이디 */
	private String uniqId;
	/** 로그인 후 이동할 페이지 */
	private String url;
	/** 사용자 IP정보 */
	private String ip;
	/** GPKI인증 DN */
	private String dn;
	
	private String adr_role;
	
	private String callnum;
	
	private String phonnum;
	
	private String sender_key;
	
	private String uSLine;
	
	private String uSubid;
	
	private String sendline_alt;
	
	private String sendline_frd;
	
	String lock_dt;
	String password_dt;
	
	public String getPassword_dt() {
		return password_dt;
	}
	public void setPassword_dt(String password_dt) {
		this.password_dt = password_dt;
	}
	public String getLock_dt() {
		return lock_dt;
	}
	public void setLock_dt(String lock_dt) {
		this.lock_dt = lock_dt;
	}
	public String getCallnum() {
		return callnum;
	}
	public void setCallnum(String callnum) {
		this.callnum = callnum;
	}
	public String getPhonnum() {
		return phonnum;
	}
	public void setPhonnum(String phonnum) {
		this.phonnum = phonnum;
	}
	public String getSender_key() {
		return sender_key;
	}
	public void setSender_key(String sender_key) {
		this.sender_key = sender_key;
	}
	public String getuSLine() {
		return uSLine;
	}
	public void setuSLine(String uSLine) {
		this.uSLine = uSLine;
	}
	public String getSendline_alt() {
		return sendline_alt;
	}
	public void setSendline_alt(String sendline_alt) {
		this.sendline_alt = sendline_alt;
	}
	public String getSendline_frd() {
		return sendline_frd;
	}
	public void setSendline_frd(String sendline_frd) {
		this.sendline_frd = sendline_frd;
	}
	public String getuSubid() {
		return uSubid;
	}
	public void setuSubid(String uSubid) {
		this.uSubid = uSubid;
	}

	private Integer sms;
	public Integer getSms() { return sms; }
	public void setSms(Integer sms) { this.sms = sms;}
	
	private Integer lms;
	public Integer getLms() { return lms; }
	public void setLms(Integer lms) { this.lms = lms;}
	
	private Integer mms;
	public Integer getMms() { return mms; }
	public void setMms(Integer mms) { this.mms = mms;}
	
	private Integer nms;
	public Integer getNms() { return nms; }
	public void setNms(Integer nms) { this.nms = nms;}
	
	private Integer fms;
	public Integer getFms() { return fms; }
	public void setFms(Integer fms) { this.fms = fms;}
	
	private Integer sms_role;
	private Integer lms_role;
	private Integer mms_role;
	private Integer noti_role;
	private Integer notilms_role;
	private Integer fri_role;
	private Integer frilms_role;
	private Integer frimms_role;
	
	private String mo_role;
	private String partg_role;
	private String use_status;
	
	public String getAdr_role() {
		return adr_role;
	}
	public void setAdr_role(String adr_role) {
		this.adr_role = adr_role;
	}
	public String getMo_role() {
		return mo_role;
	}
	public void setMo_role(String mo_role) {
		this.mo_role = mo_role;
	}
	public String getPartg_role() {
		return partg_role;
	}
	public void setPartg_role(String partg_role) {
		this.partg_role = partg_role;
	}
	public String getUse_status() {
		return use_status;
	}
	public void setUse_status(String use_status) {
		this.use_status = use_status;
	}
	public Integer getSms_role() {
		return sms_role;
	}
	public void setSms_role(Integer sms_role) {
		this.sms_role = sms_role;
	}
	public Integer getLms_role() {
		return lms_role;
	}
	public void setLms_role(Integer lms_role) {
		this.lms_role = lms_role;
	}
	public Integer getMms_role() {
		return mms_role;
	}
	public void setMms_role(Integer mms_role) {
		this.mms_role = mms_role;
	}
	public Integer getNoti_role() {
		return noti_role;
	}
	public void setNoti_role(Integer noti_role) {
		this.noti_role = noti_role;
	}
	public Integer getNotilms_role() {
		return notilms_role;
	}
	public void setNotilms_role(Integer notilms_role) {
		this.notilms_role = notilms_role;
	}
	public Integer getFri_role() {
		return fri_role;
	}
	public void setFri_role(Integer fri_role) {
		this.fri_role = fri_role;
	}
	public Integer getFrilms_role() {
		return frilms_role;
	}
	public void setFrilms_role(Integer frilms_role) {
		this.frilms_role = frilms_role;
	}
	public Integer getFrimms_role() {
		return frimms_role;
	}
	public void setFrimms_role(Integer frimms_role) {
		this.frimms_role = frimms_role;
	}
	/**
	 * id attribute 를 리턴한다.
	 * @return String
	 */
	public String getId() {
		return id;
	}
	/**
	 * id attribute 값을 설정한다.
	 * @param id String
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * name attribute 를 리턴한다.
	 * @return String
	 */
	public String getName() {
		return name;
	}
	/**
	 * name attribute 값을 설정한다.
	 * @param name String
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * ihidNum attribute 를 리턴한다.
	 * @return String
	 */
	public String getIhidNum() {
		return ihidNum;
	}
	/**
	 * ihidNum attribute 값을 설정한다.
	 * @param ihidNum String
	 */
	public void setIhidNum(String ihidNum) {
		this.ihidNum = ihidNum;
	}
	/**
	 * email attribute 를 리턴한다.
	 * @return String
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * email attribute 값을 설정한다.
	 * @param email String
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * password attribute 를 리턴한다.
	 * @return String
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * password attribute 값을 설정한다.
	 * @param password String
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * passwordHint attribute 를 리턴한다.
	 * @return String
	 */
	public String getPasswordHint() {
		return passwordHint;
	}
	/**
	 * passwordHint attribute 값을 설정한다.
	 * @param passwordHint String
	 */
	public void setPasswordHint(String passwordHint) {
		this.passwordHint = passwordHint;
	}
	/**
	 * passwordCnsr attribute 를 리턴한다.
	 * @return String
	 */
	public String getPasswordCnsr() {
		return passwordCnsr;
	}
	/**
	 * passwordCnsr attribute 값을 설정한다.
	 * @param passwordCnsr String
	 */
	public void setPasswordCnsr(String passwordCnsr) {
		this.passwordCnsr = passwordCnsr;
	}
	/**
	 * userSe attribute 를 리턴한다.
	 * @return String
	 */
	public String getUserSe() {
		return userSe;
	}
	/**
	 * userSe attribute 값을 설정한다.
	 * @param userSe String
	 */
	public void setUserSe(String userSe) {
		this.userSe = userSe;
	}
	/**
	 * orgnztId attribute 를 리턴한다.
	 * @return String
	 */
	public String getOrgnztId() {
		return orgnztId;
	}
	/**
	 * orgnztId attribute 값을 설정한다.
	 * @param orgnztId String
	 */
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	/**
	 * uniqId attribute 를 리턴한다.
	 * @return String
	 */
	public String getUniqId() {
		return uniqId;
	}
	/**
	 * uniqId attribute 값을 설정한다.
	 * @param uniqId String
	 */
	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}
	/**
	 * url attribute 를 리턴한다.
	 * @return String
	 */
	public String getUrl() {
		return url;
	}
	/**
	 * url attribute 값을 설정한다.
	 * @param url String
	 */
	public void setUrl(String url) {
		this.url = url;
	}
	/**
	 * ip attribute 를 리턴한다.
	 * @return String
	 */
	public String getIp() {
		return ip;
	}
	/**
	 * ip attribute 값을 설정한다.
	 * @param ip String
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}
	/**
	 * dn attribute 를 리턴한다.
	 * @return String
	 */
	public String getDn() {
		return dn;
	}
	/**
	 * dn attribute 값을 설정한다.
	 * @param dn String
	 */
	public void setDn(String dn) {
		this.dn = dn;
	}
	/**
	 * @return the orgnztNm
	 */
	public String getOrgnztNm() {
		return orgnztNm;
	}
	/**
	 * @param orgnztNm the orgnztNm to set
	 */
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	
}
