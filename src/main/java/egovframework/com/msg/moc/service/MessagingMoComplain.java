package egovframework.com.msg.moc.service;

import java.io.Serializable;
import java.util.Date;

@SuppressWarnings("serial")
public class MessagingMoComplain implements Serializable{

	/* 메세지 키 */
	private String mo_key;
	
	/* 수신일시 */
	private String date_mo;
	
	/* #번호 */
	private String mo_recipient;
	
	/* 민원인 원래 번호 */
	private String mo_originator;
	
	/* 민원인 입력 회신번호 */
	private String mo_callback;
	
	/* 제목 */
	private String subject;
	
	/* 내용 */
	private String content;
	
	/* 답변 seq */
	private Integer answer_seq;
	
	/* 답변 내용 */
	private String answer_subject;
	
	/* 답변 제목 */
	private String answer_content;
	
	/* 답변 날짜 */
	private String answer_at;
	
	/* 답변 번호 */
	private String answer_num;
	
	/* 답변 수신 번호 */
	private String answer_to_num;
	
	/* 답변 id */
	private String answer_id;
	
	/* 답변 작성자 */
	private String answer_name;
	
	/* 답변 부서 */
	private String orgnzt_nm;
	
	private String answer_partname;

	public String getAnswer_partname() {
		return answer_partname;
	}

	public void setAnswer_partname(String answer_partname) {
		this.answer_partname = answer_partname;
	}

	public Integer getAnswer_seq() {
		return answer_seq;
	}

	public void setAnswer_seq(Integer answer_seq) {
		this.answer_seq = answer_seq;
	}

	public String getAnswer_subject() {
		return answer_subject;
	}

	public void setAnswer_subject(String answer_subject) {
		this.answer_subject = answer_subject;
	}

	public String getAnswer_content() {
		return answer_content;
	}

	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}

	public String getAnswer_at() {
		return answer_at;
	}

	public void setAnswer_at(String answer_at) {
		this.answer_at = answer_at;
	}

	public String getAnswer_num() {
		return answer_num;
	}

	public void setAnswer_num(String answer_num) {
		this.answer_num = answer_num;
	}

	public String getAnswer_to_num() {
		return answer_to_num;
	}

	public void setAnswer_to_num(String answer_to_num) {
		this.answer_to_num = answer_to_num;
	}

	public String getAnswer_id() {
		return answer_id;
	}

	public void setAnswer_id(String answer_id) {
		this.answer_id = answer_id;
	}

	public String getAnswer_name() {
		return answer_name;
	}

	public void setAnswer_name(String answer_name) {
		this.answer_name = answer_name;
	}

	public String getOrgnzt_nm() {
		return orgnzt_nm;
	}

	public void setOrgnzt_nm(String orgnzt_nm) {
		this.orgnzt_nm = orgnzt_nm;
	}

	public String getMo_key() {
		return mo_key;
	}

	public void setMo_key(String mo_key) {
		this.mo_key = mo_key;
	}


	public String getDate_mo() {
		return date_mo;
	}

	public void setDate_mo(String date_mo) {
		this.date_mo = date_mo;
	}

	public String getMo_recipient() {
		return mo_recipient;
	}

	public void setMo_recipient(String mo_recipient) {
		this.mo_recipient = mo_recipient;
	}

	public String getMo_originator() {
		return mo_originator;
	}

	public void setMo_originator(String mo_originator) {
		this.mo_originator = mo_originator;
	}

	public String getMo_callback() {
		return mo_callback;
	}

	public void setMo_callback(String mo_callback) {
		this.mo_callback = mo_callback;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
