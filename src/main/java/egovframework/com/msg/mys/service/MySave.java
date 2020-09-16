package egovframework.com.msg.mys.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class MySave implements Serializable{

	
	// 고유번호
	private int mysaveSeq;
	
	// 제목
	private String title;
	
	// 내용
	private String subject;
	
	// 소유자ID
	private String userId;
	
	// 작성일
	private String regDate;
	
	// 분류
	private String status;
	private String imgFile;
	
	

	// getter & setter


	public String getImgFile() {
		return imgFile;
	}



	public void setImgFile(String imgFile) {
		this.imgFile = imgFile;
	}



	public String getTitle() {
		return title;
	}

	

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}



	public int getMysaveSeq() {
		return mysaveSeq;
	}



	public void setMysaveSeq(int mysaveSeq) {
		this.mysaveSeq = mysaveSeq;
	}



	public String getRegDate() {
		return regDate;
	}



	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}



	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
