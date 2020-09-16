package egovframework.com.mng.pwd.service;

public class PasswordSetVO {

	private Integer pwdCycle;	// pw 변경주기
	private Integer pwdPattern; // 패턴
	private String pwdFirst; 	// 초기화 pw
	private String dentcheck; 	// 금지어 체크여부
	private String adminid;		// 관리자
	private String denyword;	// 금지어
	
	
	public Integer getPwdCycle() {
		return pwdCycle;
	}
	public void setPwdCycle(Integer pwdCycle) {
		this.pwdCycle = pwdCycle;
	}
	public Integer getPwdPattern() {
		return pwdPattern;
	}
	public void setPwdPattern(Integer pwdPattern) {
		this.pwdPattern = pwdPattern;
	}
	public String getPwdFirst() {
		return pwdFirst;
	}
	public void setPwdFirst(String pwdFirst) {
		this.pwdFirst = pwdFirst;
	}
	public String getDentcheck() {
		return dentcheck;
	}
	public void setDentcheck(String dentcheck) {
		this.dentcheck = dentcheck;
	}
	public String getAdminid() {
		return adminid;
	}
	public void setAdminid(String adminid) {
		this.adminid = adminid;
	}
	public String getDenyword() {
		return denyword;
	}
	public void setDenyword(String denyword) {
		this.denyword = denyword;
	}
}
