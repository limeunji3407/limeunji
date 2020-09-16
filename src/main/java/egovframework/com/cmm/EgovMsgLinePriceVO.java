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
public class EgovMsgLinePriceVO implements Serializable{  
	
	int sms;
	int lms;
	int mms;
	int notice;
	int friendTxt;
	int friendImg;
	public int getSms() {
		return sms;
	}
	public void setSms(int sms) {
		this.sms = sms;
	}
	public int getLms() {
		return lms;
	}
	public void setLms(int lms) {
		this.lms = lms;
	}
	public int getMms() {
		return mms;
	}
	public void setMms(int mms) {
		this.mms = mms;
	}
	public int getNotice() {
		return notice;
	}
	public void setNotice(int notice) {
		this.notice = notice;
	}
	public int getFriendTxt() {
		return friendTxt;
	}
	public void setFriendTxt(int friendTxt) {
		this.friendTxt = friendTxt;
	}
	public int getFriendImg() {
		return friendImg;
	}
	public void setFriendImg(int friendImg) {
		this.friendImg = friendImg;
	}
	
	
}
