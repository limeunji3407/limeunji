package egovframework.com.uss.umt.service;

import egovframework.com.cmm.ComDefaultVO;

public class DeptCallManageVO extends ComDefaultVO {

	private static final long serialVersionUID = 1L;

	private String orgnztId; //부서코드	
	private String orgnztTel; //대표번호 or 번호ID
	private String orgnztTelSeq; //대표번호 seq 순서
	private String orgnztTelChk; //대표번호 check	
	private String create_dt;  //등록일
	private String userId;   //등록자ID 
	
	/**
	 * @return the orgnztId
	 */
	public String getOrgnztId() {
		return orgnztId;
	}
	/**
	 * @param orgnztId the orgnztId to set
	 */
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	/**
	 * @return the orgnztTel
	 */
	public String getOrgnztTel() {
		return orgnztTel;
	}
	/**
	 * @param orgnztNm the orgnztTel to set
	 */
	public void setOrgnztTel(String orgnztTel) {
		this.orgnztTel = orgnztTel;
	}
	

	//대표번호정렬오더
	/**
	 * @return the orgnztDc
	 */
	public String getOrgnztTelSeq() {
		return orgnztTelSeq;
	}
	/**
	 * @param orgnztDc the orgnztDc to set
	 */
	public void setOorgnztTelSeq(String orgnztTelSeq) {
		this.orgnztTelSeq = orgnztTelSeq;
	}
	
	
	//체크
	/**
	 * @return the orgnztChk
	 */
	public String getOrgnztTelChk() {
		return orgnztTelChk;
	}
	/**
	 * @param orgnztDc the orgnztChk to set
	 */
	public void setOrgnztTelChk(String orgnztTelChk) {
		this.orgnztTelChk = orgnztTelChk;
	}
	

	//생성일
	/**
	 * @return the create_dt
	 */
	public String getCreate_Dt() {
		return create_dt;
	}
	/**
	 * @param create_dt the create_dt to set
	 */
	public void setCreate_Dt(String create_dt) {
		this.create_dt = create_dt;
	}
	 
	
	
	//사용자ID
	/**
	 * @return the orgnztDc
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param orgnztDc the orgnztDc to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

}
