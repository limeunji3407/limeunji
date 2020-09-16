package egovframework.com.msg.mop.service;

import java.io.Serializable;


@SuppressWarnings("serial")
public class MessagingMoListVO implements Serializable{

	/** 타입  */
    private String type;

    /** 수신일시 */
    private String receive_date;

    /** 발신번호 */
    private String mo_callback;

    /** #번호 */
    private String mo_recipient;
    
    /* 제목 */
    private String subject; 

    /** 내용 */
    private String content;

    
 

	public String getType() {
		return type;
	}
	public String getReceive_date() {
		return receive_date;
	}
	public String getMo_callback() {
		return mo_callback;
	}
	public String getMo_recipient() {
		return mo_recipient;
	}
	public String getSubject() {
		return subject;
	}
	public String getContent() {
		return content;
	}

 

	public void setType(String Type) {
		this.type = Type;
	}
	public void setReceive_date(String receive_date) {
		this.receive_date = receive_date;
	}
	public void setMo_callback(String mo_callback) {
		this.mo_callback = mo_callback;
	}
	public void setMo_recipient(String mo_recipient) {
		this.mo_recipient = mo_recipient;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public void setContent(String subject) {
		this.content = subject;
	}
 
}
