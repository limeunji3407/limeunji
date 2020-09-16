package egovframework.com.uss.umt.service;

import java.util.List;

import egovframework.com.cmm.ComDefaultVO;

public class DeptManageVO extends ComDefaultVO {

	private static final long serialVersionUID = 1L;
	private String orgnztId; //조직ID  부서코드
	private String orgnztNm; //부서명
	private String orgnztDc; //부서DC		
	private String status;
	private String partCode;
	
	private Integer cashlimitMonth;  //월한도
	private Integer cashlimitTemp;   //임시한도 
	private String orgnztTel; //대표번호 or 번호ID
	private int sortNum; //대표번호 or 번호ID
	
	
	
	List<SendNumberVO> sendNumberVOList;
	
	
	public List<SendNumberVO> getSendNumberVOList() {
		return sendNumberVOList;
	}
	public void setSendNumberVOList(List<SendNumberVO> sendNumberVOList) {
		this.sendNumberVOList = sendNumberVOList;
	}
	public int getSortNum() {
		return sortNum;
	}
	public void setSortNum(int sortNum) {
		this.sortNum = sortNum;
	}
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
	/**
	 * @return the orgnztDc
	 */
	public String getOrgnztDc() {
		return orgnztDc;
	}
	/**
	 * @param orgnztDc the orgnztDc to set
	 */
	public void setOrgnztDc(String orgnztDc) {
		this.orgnztDc = orgnztDc;
	}

	public Integer getCashlimitMonth() {
		return cashlimitMonth;
	}
	public void setCashlimitMonth(Integer cashlimitMonth) {
		this.cashlimitMonth = cashlimitMonth;
	}
	public Integer getCashlimitTemp() {
		return cashlimitTemp;
	}
	public void setCashlimitTemp(Integer cashlimitTemp) {
		this.cashlimitTemp = cashlimitTemp;
	}
	public void setOrgnztTel(String orgnztTel) {
		this.orgnztTel = orgnztTel;
	}
	public String getPartCode() {
		return partCode;
	}
	public void setPartCode(String partCode) {
		this.partCode = partCode;
	}
	//대표번호
	/**
	 * @return the orgnztDc
	 */
	public String getOrgnztTel() {
		return orgnztTel;
	}
	/**
	 * @param orgnztDc the orgnztDc to set
	 */
	public void setOorgnztTel(String orgnztTel) {
		this.orgnztTel = orgnztTel;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
