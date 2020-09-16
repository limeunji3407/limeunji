package egovframework.com.msg.moc.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ComplainMemo implements Serializable{

	private String mo_key;
	private Integer memo_seq;
	private String create_at;
	private String user_name;
	private String user_id;
	private String content;
	private String check_name;
	
	public String getCheck_name() {
		return check_name;
	}
	public void setCheck_name(String check_name) {
		this.check_name = check_name;
	}
	public String getMo_key() {
		return mo_key;
	}
	public void setMo_key(String mo_key) {
		this.mo_key = mo_key;
	}
	public Integer getMemo_seq() {
		return memo_seq;
	}
	public void setMemo_seq(Integer memo_seq) {
		this.memo_seq = memo_seq;
	}
	public String getCreate_at() {
		return create_at;
	}
	public void setCreate_at(String create_at) {
		this.create_at = create_at;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
