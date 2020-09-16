package egovframework.com.msg.mol.service;

import java.io.Serializable;


@SuppressWarnings("serial")
public class molistVO implements Serializable{

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
	public void setReceive_date(String Receive_date) {
		this.receive_date = Receive_date;
	}
	public void setMo_callback(String Mo_callback) {
		this.mo_callback = Mo_callback;
	}
	public void setMo_recipient(String Mo_recipient) {
		this.mo_recipient = Mo_recipient;
	}
	public void setSubject(String Subject) {
		this.subject = Subject;
	}
	public void setContent(String Content) {
		this.content = Content;
	}
 
}
