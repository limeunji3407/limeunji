package egovframework.com.msg.rcv.service;

import egovframework.com.cmm.ComDefaultVO;

public class ComtccmmnDetailCode  extends ComDefaultVO {
	
	private static final long serialVersionUID = 6036244040184842281L;
	
	String code;
	String codeNm;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCodeNm() {
		return codeNm;
	}
	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}
	
	
}
