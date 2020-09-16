package egovframework.com.grp.service;

public class AddrGroup {

	/* 그룹 유일코드 */
	private Integer code;
	
	/* 그룹명 */
	private String title;
	
	/* 상위 카테고리 */
	private Integer parent;
	
	/* 순서 */
	private Integer sequence;
	
	/* 깊이 */
	private Integer depth;
	
	/* 타입(0:개인, 1:부서, 2:공용, 3:직원) */
	private String type;
	
	/* 그룹생성 유저 ID */
	private String userid;
	
	/* 그룹생성 유저명 */
	private String usernm;
	
	private String orgnzt_id;

	
	public String getOrgnzt_id() {
		return orgnzt_id;
	}

	public void setOrgnzt_id(String orgnzt_id) {
		this.orgnzt_id = orgnzt_id;
	}

	public String getUsernm() {
		return usernm;
	}

	public void setUsernm(String usernm) {
		this.usernm = usernm;
	}

	/* Getter & Setter */
	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getParent() {
		return parent;
	}

	public void setParent(Integer parent) {
		this.parent = parent;
	}

	public Integer getSequence() {
		return sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}

	public Integer getDepth() {
		return depth;
	}

	public void setDepth(Integer depth) {
		this.depth = depth;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
}
