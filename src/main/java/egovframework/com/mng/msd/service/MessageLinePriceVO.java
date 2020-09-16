package egovframework.com.mng.msd.service;

import java.io.Serializable;
@SuppressWarnings("serial")
public class MessageLinePriceVO implements Serializable{

	private int sms;
	private int lms;
	private int mms;
	private int notice;
	private int friend_txt;
	private int friend_img;
	private int sms_g;
	private int lms_g;
	private int mms_g;
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
	public int getFriend_txt() {
		return friend_txt;
	}
	public void setFriend_txt(int friend_txt) {
		this.friend_txt = friend_txt;
	}
	public int getFriend_img() {
		return friend_img;
	}
	public void setFriend_img(int friend_img) {
		this.friend_img = friend_img;
	}
	public int getSms_g() {
		return sms_g;
	}
	public void setSms_g(int sms_g) {
		this.sms_g = sms_g;
	}
	public int getLms_g() {
		return lms_g;
	}
	public void setLms_g(int lms_g) {
		this.lms_g = lms_g;
	}
	public int getMms_g() {
		return mms_g;
	}
	public void setMms_g(int mms_g) {
		this.mms_g = mms_g;
	}
   
}
