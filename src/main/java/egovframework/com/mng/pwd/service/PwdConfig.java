package egovframework.com.mng.pwd.service;

public class PwdConfig {

	/* 변경주기 */
	private Integer pwd_cycle;

	/* 패턴 0-5 */
	private Integer pwd_pattern;
	
	/* 초기화 패스워드 */
	private String pwd_first;
	
	/* 금지어 체크 */
	private String denycheck;
	
	/* 관리자 ID */
	private String adminid;
	
	/* 금지어 */
	private String denyword;

	
	/* Getter & Setter */
	public Integer getPwd_cycle() {
		return pwd_cycle;
	}

	public void setPwd_cycle(Integer pwd_cycle) {
		this.pwd_cycle = pwd_cycle;
	}

	public Integer getPwd_pattern() {
		return pwd_pattern;
	}

	public void setPwd_pattern(Integer pwd_pattern) {
		this.pwd_pattern = pwd_pattern;
	}

	public String getPwd_first() {
		return pwd_first;
	}

	public void setPwd_first(String pwd_first) {
		this.pwd_first = pwd_first;
	}

	public String getDenycheck() {
		return denycheck;
	}

	public void setDenycheck(String denycheck) {
		this.denycheck = denycheck;
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
