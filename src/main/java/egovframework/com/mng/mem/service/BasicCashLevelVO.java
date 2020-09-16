package egovframework.com.mng.mem.service;

import java.io.Serializable;

/*
 * By 김수로
 * 전송형태별 허용캐쉬제한 (건수제한 ) 등급생성시 등급에 허용된 캐쉬적용
 * 기본 5가지 
 */

@SuppressWarnings("serial")
public class BasicCashLevelVO implements Serializable{
String uids;

	public String getUids() {
	return uids;
}

public void setUids(String uids) {
	this.uids = uids;
}

	private int lvid;
	private String userid; //매니저ID
	private String lvname;
	private int sms; 
	private int lms;
	private int mms;
	private int notice;
	private int friend;
	private String regdate;
	private String updatedate;    
	
	
	
	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}

	public void setLvid(int lvid) {
		this.lvid = lvid;
	}

	public void setUid(int lvid) {
	   this.lvid = lvid;
	}

    public void setUserid(String userid) {
        this.userid = userid;
    }
	
	public void setLvname(String lvname) {
	   this.lvname = lvname;
	}

    public void setSms(int sms) {
        this.sms = sms;
    }

    public void setLms(int lms) {
        this.lms = lms;
    }

    public void setMms(int mms) {
        this.mms = mms;
    }

    public void setNotice(int notice) {
        this.notice = notice;
    }

    public void setFriend(int friend) {
        this.friend = friend;
    }
    
    public void setRegDate(String regdate) {
        this.regdate = regdate;
    }

    public void setUpdateDate(String updatedate) {
        this.updatedate = updatedate;
    }
    
    public int getLvid() {
        return this.lvid;
    }    
    
    public String getUserid() {
        return this.userid;
    }   
    
    public String getLvname() {
        return this.lvname;
    }

    public int getSms() {
        return this.sms;
    }

    public int getLms() {
        return this.lms;
    }

    public int getMms() {
        return this.mms;
    }
    
    public int getNotice() {
        return this.notice;
    }

    public int getFriend() {
        return this.friend;
    }

    public String getRegDate() {
        return this.regdate;
    }
    
    public String getUpdateDate() {
        return this.updatedate;
    }

 
}
