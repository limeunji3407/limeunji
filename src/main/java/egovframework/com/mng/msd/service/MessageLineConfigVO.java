package egovframework.com.mng.msd.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class MessageLineConfigVO implements Serializable{
  
    //private long uid; 
    private String sms; 
    private String lms;
    private String mms;
    private String noti;
    private String renoti;
    private String frit;
    private String refri;
    
	public String getSms() {
		return sms;
	}
	public void setSms(String sms) {
		this.sms = sms;
	}
	public String getLms() {
		return lms;
	}
	public void setLms(String lms) {
		this.lms = lms;
	}
	public String getMms() {
		return mms;
	}
	public void setMms(String mms) {
		this.mms = mms;
	}
	public String getNoti() {
		return noti;
	}
	public void setNoti(String noti) {
		this.noti = noti;
	}
	public String getRenoti() {
		return renoti;
	}
	public void setRenoti(String renoti) {
		this.renoti = renoti;
	}
	public String getFrit() {
		return frit;
	}
	public void setFrit(String frit) {
		this.frit = frit;
	}
	public String getRefri() {
		return refri;
	}
	public void setRefri(String refri) {
		this.refri = refri;
	}

}
