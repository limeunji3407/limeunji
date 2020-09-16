package egovframework.com.uss.umt.service;

/**
 * 업무사용자VO클래스로서 업무사용자관리 비지니스로직 처리용 항목을 구성한다.
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *   2017.07.21  장동한 			로그인인증제한 작업
 *
 * </pre>
 */
public class UserManageVO extends UserDefaultVO{

	private static final long serialVersionUID = 3640820362821490939L;

	/** 이전비밀번호 - 비밀번호 변경시 사용*/
    private String oldPassword = "";

    /**
	 * 가입일
	 */
	private String sbscrbDe;
	/**
	 * 사용자고유아이디
	 */
	private String uniqId="";
	/**
	 * 사용자 유형
	 */
	private String userTy;
	/**
	 * 지역번호
	 */
	private String areaNo;
	/**
	 * 생일
	 */
	private String brth;
	/**
	 * 상세주소
	 */
	private String detailAdres;
	/**
	 * 이메일주소
	 */
	private String emailAdres;
	/**
	 * 사원번호
	 */
	private String emplNo;
	/**
	 * 사용자 ID
	 */
	private String emplyrId;
	private String subid;
	
	public String getSubid() {
		return subid;
	}
	public void setSubid(String subid) {
		this.subid = subid;
	}

	/**
	 * 사용자 명
	 */
	private String emplyrNm;
	/**
	 * 사용자 상태
	 */
	private String emplyrSttusCode;
	/**
	 * 팩스번호
	 */
	private String fxnum;
	/**
	 * 그룹 ID
	 */
	private String groupId;
	/**
	 * 집 주소
	 */
	private String homeadres;
	/**
	 * 집끝전화번호
	 */
	private String homeendTelno;
	/**
	 * 집중간전화번호
	 */
	private String homemiddleTelno;
	/**
	 * 주민등록번호
	 */
	private String ihidnum;
	/**
	 * 소속기관코드
	 */
	private String insttCode;
	/**
	 * 검색조건 회원타입
	 */
	private String mberTy;
	/**
	 * 핸드폰번호
	 */
	private String moblphonNo;
	/**
	 * 직위명
	 */
	private String ofcpsNm;
	/**
	 * 사무실전화번호
	 */
	private String offmTelno;
	/**
	 * 조직 ID
	 */
	private String orgnztId;
	/**
	 * 비밀번호
	 */
	private String password;
	private String newPw;
	/**
	 * 비밀번호 정답
	 */
	private String passwordCnsr;
	/**
	 * 비밀번호 힌트
	 */
	private String passwordHint;
	/**
	 * 검색조건 가입일자 시작일
	 */
	private String sbscrbDeBegin;
	/**
	 * 검색조건 가입일자 종료일
	 */
	private String sbscrbDeEnd;
	/**
	 * 성별코드
	 */
	private String sexdstnCode;
	/**
	 * 우편번호
	 */
	private String zip;
	/**
	 * DN 값
	 */
	private String subDn;
	/*
	 * memo
	 */
	private String memo;
	
	private String useStatus;
	private int lvId;
	String lvName;
	
	
	public String getLvName() {
		return lvName;
	}
	public void setLvName(String lvName) {
		this.lvName = lvName;
	}
	public int getLvId() {
		return lvId;
	}
	public void setLvId(int lvId) {
		this.lvId = lvId;
	}
	public String getUseStatus() {
		return useStatus;
	}
	public void setUseStatus(String useStatus) {
		this.useStatus = useStatus;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	private String orgnztNm;

	public String getOrgnztNm() {
		return orgnztNm;
	}
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}

	/**
	 * 사용1 미사용2 승인요청0
	 */
	private String lockAt;
	public String getLockAt() {return lockAt;}
	public void setLockAt(String lockAt) {this.lockAt = lockAt;}
	
	private int sms;
	public int getSms() { return sms; }
	public void setSms(int sms) { this.sms = sms;}
	
	private int lms;
	public int getLms() { return lms; }
	public void setLms(int lms) { this.lms = lms;}
	
	private int mms;
	public int getMms() { return mms; }
	public void setMms(int mms) { this.mms = mms;}
	
	private int nms;
	public int getNms() { return nms; }
	public void setNms(int nms) { this.nms = nms;}
	
	private int fms;
	public int getFms() { return fms; }
	public void setFms(int fms) { this.fms = fms;}
	
	private int smsAdd;
	
	private int lmsAdd;
	
	private int mmsAdd;  
	
	private int nmsAdd;

	private int fmsAdd;
	
	public int getSmsAdd() {
		return smsAdd;
	}
	public void setSmsAdd(int smsAdd) {
		this.smsAdd = smsAdd;
	}
	public int getLmsAdd() {
		return lmsAdd;
	}
	public void setLmsAdd(int lmsAdd) {
		this.lmsAdd = lmsAdd;
	}
	public int getMmsAdd() {
		return mmsAdd;
	}
	public void setMmsAdd(int mmsAdd) {
		this.mmsAdd = mmsAdd;
	}
	public int getNmsAdd() {
		return nmsAdd;
	}
	public void setNmsAdd(int nmsAdd) {
		this.nmsAdd = nmsAdd;
	}
	public int getFmsAdd() {
		return fmsAdd;
	}
	public void setFmsAdd(int fmsAdd) {
		this.fmsAdd = fmsAdd;
	}

	private String ip;
	
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getNewPw() {
		return newPw;
	}
	public void setNewPw(String newPw) {
		this.newPw = newPw;
	}
	
	// 권한모음
	private Integer smsRole;
	private Integer lmsRole;
	private Integer mmsRole;
	private Integer notiRole;
	private Integer notilmsRole;
	private Integer friRole;
	private Integer frilmsRole;
	private Integer frimmsRole;
	
	private String moRole;
	private String partgRole;
	private String subiduse;
	private String adrRole;
	
	public String getSubiduse() {
		return subiduse;
	}
	public void setSubiduse(String subiduse) {
		this.subiduse = subiduse;
	}
	public String getAdrRole() {
		return adrRole;
	}
	public void setAdrRole(String adrRole) {
		this.adrRole = adrRole;
	}
	public Integer getSmsRole() {
		return smsRole;
	}
	public void setSmsRole(Integer smsRole) {
		this.smsRole = smsRole;
	}
	public Integer getLmsRole() {
		return lmsRole;
	}
	public void setLmsRole(Integer lmsRole) {
		this.lmsRole = lmsRole;
	}
	public Integer getMmsRole() {
		return mmsRole;
	}
	public void setMmsRole(Integer mmsRole) {
		this.mmsRole = mmsRole;
	}
	public Integer getNotiRole() {
		return notiRole;
	}
	public void setNotiRole(Integer notiRole) {
		this.notiRole = notiRole;
	}
	public Integer getNotilmsRole() {
		return notilmsRole;
	}
	public void setNotilmsRole(Integer notilmsRole) {
		this.notilmsRole = notilmsRole;
	}
	public Integer getFriRole() {
		return friRole;
	}
	public void setFriRole(Integer friRole) {
		this.friRole = friRole;
	}
	public Integer getFrilmsRole() {
		return frilmsRole;
	}
	public void setFrilmsRole(Integer frilmsRole) {
		this.frilmsRole = frilmsRole;
	}
	public Integer getFrimmsRole() {
		return frimmsRole;
	}
	public void setFrimmsRole(Integer frimmsRole) {
		this.frimmsRole = frimmsRole;
	}
	public String getMoRole() {
		return moRole;
	}
	public void setMoRole(String moRole) {
		this.moRole = moRole;
	}
	public String getPartgRole() {
		return partgRole;
	}
	public void setPartgRole(String partgRole) {
		this.partgRole = partgRole;
	}
	//직원주소록 추가 여부
	private String staffAdr;
	
	public String getStaffAdr() {
		return staffAdr;
	}
	public void setStaffAdr(String staffAdr) {
		this.staffAdr = staffAdr;
	}
	/**
	 * oldPassword attribute 값을  리턴한다.
	 * @return String
	 */
	public String getOldPassword() {
		return oldPassword;
	}
	/**
	 * oldPassword attribute 값을 설정한다.
	 * @param oldPassword String
	 */
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	/**
	 * sbscrbDe attribute 값을  리턴한다.
	 * @return String
	 */
	public String getSbscrbDe() {
		return sbscrbDe;
	}
	/**
	 * sbscrbDe attribute 값을 설정한다.
	 * @param sbscrbDe String
	 */
	public void setSbscrbDe(String sbscrbDe) {
		this.sbscrbDe = sbscrbDe;
	}
	/**
	 * uniqId attribute 값을  리턴한다.
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
	 * userTy attribute 값을  리턴한다.
	 * @return String
	 */
	public String getUserTy() {
		return userTy;
	}
	/**
	 * userTy attribute 값을 설정한다.
	 * @param userTy String
	 */
	public void setUserTy(String userTy) {
		this.userTy = userTy;
	}
	/**
	 * areaNo attribute 값을  리턴한다.
	 * @return String
	 */
	public String getAreaNo() {
		return areaNo;
	}
	/**
	 * areaNo attribute 값을 설정한다.
	 * @param areaNo String
	 */
	public void setAreaNo(String areaNo) {
		this.areaNo = areaNo;
	}
	/**
	 * brth attribute 값을  리턴한다.
	 * @return String
	 */
	public String getBrth() {
		return brth;
	}
	/**
	 * brth attribute 값을 설정한다.
	 * @param brth String
	 */
	public void setBrth(String brth) {
		this.brth = brth;
	}
	/**
	 * detailAdres attribute 값을  리턴한다.
	 * @return String
	 */
	public String getDetailAdres() {
		return detailAdres;
	}
	/**
	 * detailAdres attribute 값을 설정한다.
	 * @param detailAdres String
	 */
	public void setDetailAdres(String detailAdres) {
		this.detailAdres = detailAdres;
	}
	/**
	 * emailAdres attribute 값을  리턴한다.
	 * @return String
	 */
	public String getEmailAdres() {
		return emailAdres;
	}
	/**
	 * emailAdres attribute 값을 설정한다.
	 * @param emailAdres String
	 */
	public void setEmailAdres(String emailAdres) {
		this.emailAdres = emailAdres;
	}
	/**
	 * emplNo attribute 값을  리턴한다.
	 * @return String
	 */
	public String getEmplNo() {
		return emplNo;
	}
	/**
	 * emplNo attribute 값을 설정한다.
	 * @param emplNo String
	 */
	public void setEmplNo(String emplNo) {
		this.emplNo = emplNo;
	}
	/**
	 * emplyrId attribute 값을  리턴한다.
	 * @return String
	 */
	public String getEmplyrId() {
		return emplyrId;
	}
	/**
	 * emplyrId attribute 값을 설정한다.
	 * @param emplyrId String
	 */
	public void setEmplyrId(String emplyrId) {
		this.emplyrId = emplyrId;
	}
	/**
	 * emplyrNm attribute 값을  리턴한다.
	 * @return String
	 */
	public String getEmplyrNm() {
		return emplyrNm;
	}
	/**
	 * emplyrNm attribute 값을 설정한다.
	 * @param emplyrNm String
	 */
	public void setEmplyrNm(String emplyrNm) {
		this.emplyrNm = emplyrNm;
	}
	/**
	 * emplyrSttusCode attribute 값을  리턴한다.
	 * @return String
	 */
	public String getEmplyrSttusCode() {
		return emplyrSttusCode;
	}
	/**
	 * emplyrSttusCode attribute 값을 설정한다.
	 * @param emplyrSttusCode String
	 */
	public void setEmplyrSttusCode(String emplyrSttusCode) {
		this.emplyrSttusCode = emplyrSttusCode;
	}
	/**
	 * fxnum attribute 값을  리턴한다.
	 * @return String
	 */
	public String getFxnum() {
		return fxnum;
	}
	/**
	 * fxnum attribute 값을 설정한다.
	 * @param fxnum String
	 */
	public void setFxnum(String fxnum) {
		this.fxnum = fxnum;
	}
	/**
	 * groupId attribute 값을  리턴한다.
	 * @return String
	 */
	public String getGroupId() {
		return groupId;
	}
	/**
	 * groupId attribute 값을 설정한다.
	 * @param groupId String
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	/**
	 * homeadres attribute 값을  리턴한다.
	 * @return String
	 */
	public String getHomeadres() {
		return homeadres;
	}
	/**
	 * homeadres attribute 값을 설정한다.
	 * @param homeadres String
	 */
	public void setHomeadres(String homeadres) {
		this.homeadres = homeadres;
	}
	/**
	 * homeendTelno attribute 값을  리턴한다.
	 * @return String
	 */
	public String getHomeendTelno() {
		return homeendTelno;
	}
	/**
	 * homeendTelno attribute 값을 설정한다.
	 * @param homeendTelno String
	 */
	public void setHomeendTelno(String homeendTelno) {
		this.homeendTelno = homeendTelno;
	}
	/**
	 * homemiddleTelno attribute 값을  리턴한다.
	 * @return String
	 */
	public String getHomemiddleTelno() {
		return homemiddleTelno;
	}
	/**
	 * homemiddleTelno attribute 값을 설정한다.
	 * @param homemiddleTelno String
	 */
	public void setHomemiddleTelno(String homemiddleTelno) {
		this.homemiddleTelno = homemiddleTelno;
	}
	/**
	 * ihidnum attribute 값을  리턴한다.
	 * @return String
	 */
	public String getIhidnum() {
		return ihidnum;
	}
	/**
	 * ihidnum attribute 값을 설정한다.
	 * @param ihidnum String
	 */
	public void setIhidnum(String ihidnum) {
		this.ihidnum = ihidnum;
	}
	/**
	 * insttCode attribute 값을  리턴한다.
	 * @return String
	 */
	public String getInsttCode() {
		return insttCode;
	}
	/**
	 * insttCode attribute 값을 설정한다.
	 * @param insttCode String
	 */
	public void setInsttCode(String insttCode) {
		this.insttCode = insttCode;
	}
	/**
	 * mberTy attribute 값을  리턴한다.
	 * @return String
	 */
	public String getMberTy() {
		return mberTy;
	}
	/**
	 * mberTy attribute 값을 설정한다.
	 * @param mberTy String
	 */
	public void setMberTy(String mberTy) {
		this.mberTy = mberTy;
	}
	/**
	 * moblphonNo attribute 값을  리턴한다.
	 * @return String
	 */
	public String getMoblphonNo() {
		return moblphonNo;
	}
	/**
	 * moblphonNo attribute 값을 설정한다.
	 * @param moblphonNo String
	 */
	public void setMoblphonNo(String moblphonNo) {
		this.moblphonNo = moblphonNo;
	}
	/**
	 * ofcpsNm attribute 값을  리턴한다.
	 * @return String
	 */
	public String getOfcpsNm() {
		return ofcpsNm;
	}
	/**
	 * ofcpsNm attribute 값을 설정한다.
	 * @param ofcpsNm String
	 */
	public void setOfcpsNm(String ofcpsNm) {
		this.ofcpsNm = ofcpsNm;
	}
	/**
	 * offmTelno attribute 값을  리턴한다.
	 * @return String
	 */
	public String getOffmTelno() {
		return offmTelno;
	}
	/**
	 * offmTelno attribute 값을 설정한다.
	 * @param offmTelno String
	 */
	public void setOffmTelno(String offmTelno) {
		this.offmTelno = offmTelno;
	}
	/**
	 * orgnztId attribute 값을  리턴한다.
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
	 * password attribute 값을  리턴한다.
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
	 * passwordCnsr attribute 값을  리턴한다.
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
	 * passwordHint attribute 값을  리턴한다.
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
	 * sbscrbDeBegin attribute 값을  리턴한다.
	 * @return String
	 */
	public String getSbscrbDeBegin() {
		return sbscrbDeBegin;
	}
	/**
	 * sbscrbDeBegin attribute 값을 설정한다.
	 * @param sbscrbDeBegin String
	 */
	public void setSbscrbDeBegin(String sbscrbDeBegin) {
		this.sbscrbDeBegin = sbscrbDeBegin;
	}
	/**
	 * sbscrbDeEnd attribute 값을  리턴한다.
	 * @return String
	 */
	public String getSbscrbDeEnd() {
		return sbscrbDeEnd;
	}
	/**
	 * sbscrbDeEnd attribute 값을 설정한다.
	 * @param sbscrbDeEnd String
	 */
	public void setSbscrbDeEnd(String sbscrbDeEnd) {
		this.sbscrbDeEnd = sbscrbDeEnd;
	}
	/**
	 * sexdstnCode attribute 값을  리턴한다.
	 * @return String
	 */
	public String getSexdstnCode() {
		return sexdstnCode;
	}
	/**
	 * sexdstnCode attribute 값을 설정한다.
	 * @param sexdstnCode String
	 */
	public void setSexdstnCode(String sexdstnCode) {
		this.sexdstnCode = sexdstnCode;
	}
	/**
	 * zip attribute 값을  리턴한다.
	 * @return String
	 */
	public String getZip() {
		return zip;
	}
	/**
	 * zip attribute 값을 설정한다.
	 * @param zip String
	 */
	public void setZip(String zip) {
		this.zip = zip;
	}
	/**
	 * subDn attribute 값을  리턴한다.
	 * @return String
	 */
	public String getSubDn() {
		return subDn;
	}
	/**
	 * subDn attribute 값을 설정한다.
	 * @param subDn String
	 */
	public void setSubDn(String subDn) {
		this.subDn = subDn;
	}

}