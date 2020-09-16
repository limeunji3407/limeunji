package egovframework.com.msg.mol.service;

import java.io.Serializable;


@SuppressWarnings("serial")
public class MessagingMoPoll implements Serializable{
	
	/* 설문순번 */
	private Integer survey_seq;
	
	/* #번호 */
	private String mo_recipient;
	
	/* #예비번호 */
	private String emo_recipient;
	
	/* 업무분류코드*/
	private Integer work_seq;
	
	/* 제목*/
	private String subject;
	
	/* 투표 시작일*/
	private String start_date;
	
	/* 투표 종료일 */
	private String end_date;
	
	/* 상태*/
	private Integer status;
	
	/* 응답률 */
	private Integer request_rate;
	
	/* 강제종료 여부 */
	private String shutdown_flag;
	
	/* 전송일 */
	private String send_date;
	
	/* 등록일 */
	private String reg_date;
	
	/* 수정일 */
	private String mod_date;
	
	/* 수정자 부서 */
	private String mod_part_name;
	
	/* 수정자 */
	private String mod_user_name;
	
	/* 수정자 ID */
	private String mod_user_id;
	
	/* 작성자 */
	private String reg_user_name;
	
	/* 작성자 ID*/
	private String reg_user_id;
	
	/* 작성자 부서*/
	private String reg_part_name;
	
	/* 시작안내문 */
	private String start_notice;

	/* 종료안내문 */
	private String end_notice;
	
	/* 질문 */
	private String question;
	
	/* 보기내용1 */
	private String example1;
	
	/* 키워드 1 */
	private String example1_keyword;
	
	/* 투표건수 1 */
	private Integer example1_total_cnt;
	
	/* 득표율 1 */
	private Integer example1_total_rate;

	/* 보기내용2 */
	private String example2;
	
	/* 키워드 2 */
	private String example2_keyword;
	
	/* 투표건수 2 */
	private Integer example2_total_cnt;
	
	/* 득표율 2 */
	private Integer example2_total_rate;
	
	/* 보기내용3 */
	private String example3;
	
	/* 키워드 3 */
	private String example3_keyword;
	
	/* 투표건수 3 */
	private Integer example3_total_cnt;
	
	/* 득표율 3 */
	private Integer example3_total_rate;
	
	/* 보기내용4 */
	private String example4;
	
	/* 키워드 4 */
	private String example4_keyword;
	
	/* 투표건수 4 */
	private Integer example4_total_cnt;
	
	/* 득표율 4 */
	private Integer example4_total_rate;

	/* 응답율 */
	private Integer etc_total_rate;
	
	
	/* Getter & Setter*/
	
	public String getMo_recipient() {
		return mo_recipient;
	}

	public String getEmo_recipient() {
		return emo_recipient;
	}

	public void setEmo_recipient(String emo_recipient) {
		this.emo_recipient = emo_recipient;
	}

	public Integer getSurvey_seq() {
		return survey_seq;
	}

	public void setSurvey_seq(Integer survey_seq) {
		this.survey_seq = survey_seq;
	}

	public void setMo_recipient(String mo_recipient) {
		this.mo_recipient = mo_recipient;
	}

	public Integer getWork_seq() {
		return work_seq;
	}

	public void setWork_seq(Integer work_seq) {
		this.work_seq = work_seq;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getRequest_rate() {
		return request_rate;
	}

	public void setRequest_rate(Integer request_rate) {
		this.request_rate = request_rate;
	}

	public String getSend_date() {
		return send_date;
	}

	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getMod_date() {
		return mod_date;
	}

	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}

	public String getMod_part_name() {
		return mod_part_name;
	}

	public void setMod_part_name(String mod_part_name) {
		this.mod_part_name = mod_part_name;
	}

	public String getMod_user_name() {
		return mod_user_name;
	}

	public void setMod_user_name(String mod_user_name) {
		this.mod_user_name = mod_user_name;
	}

	public String getMod_user_id() {
		return mod_user_id;
	}

	public void setMod_user_id(String mod_user_id) {
		this.mod_user_id = mod_user_id;
	}

	public String getReg_user_name() {
		return reg_user_name;
	}

	public void setReg_user_name(String reg_user_name) {
		this.reg_user_name = reg_user_name;
	}
	
	public String getReg_user_id() {
		return reg_user_id;
	}

	public void setReg_user_id(String reg_user_id) {
		this.reg_user_id = reg_user_id;
	}

	public String getReg_part_name() {
		return reg_part_name;
	}

	public void setReg_part_name(String reg_part_name) {
		this.reg_part_name = reg_part_name;
	}

	public String getStart_notice() {
		return start_notice;
	}

	public void setStart_notice(String start_notice) {
		this.start_notice = start_notice;
	}

	public String getEnd_notice() {
		return end_notice;
	}

	public void setEnd_notice(String end_notice) {
		this.end_notice = end_notice;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getExample1() {
		return example1;
	}

	public void setExample1(String example1) {
		this.example1 = example1;
	}

	public String getExample1_keyword() {
		return example1_keyword;
	}

	public void setExample1_keyword(String example1_keyword) {
		this.example1_keyword = example1_keyword;
	}

	public Integer getExample1_total_cnt() {
		return example1_total_cnt;
	}

	public void setExample1_total_cnt(Integer example1_total_cnt) {
		this.example1_total_cnt = example1_total_cnt;
	}

	public Integer getExample1_total_rate() {
		return example1_total_rate;
	}

	public void setExample1_total_rate(Integer example1_total_rate) {
		this.example1_total_rate = example1_total_rate;
	}

	public String getExample2() {
		return example2;
	}

	public void setExample2(String example2) {
		this.example2 = example2;
	}

	public String getExample2_keyword() {
		return example2_keyword;
	}

	public void setExample2_keyword(String example2_keyword) {
		this.example2_keyword = example2_keyword;
	}

	public Integer getExample2_total_cnt() {
		return example2_total_cnt;
	}

	public void setExample2_total_cnt(Integer example2_total_cnt) {
		this.example2_total_cnt = example2_total_cnt;
	}

	public Integer getExample2_total_rate() {
		return example2_total_rate;
	}

	public void setExample2_total_rate(Integer example2_total_rate) {
		this.example2_total_rate = example2_total_rate;
	}

	public String getExample3() {
		return example3;
	}

	public void setExample3(String example3) {
		this.example3 = example3;
	}

	public String getExample3_keyword() {
		return example3_keyword;
	}

	public Integer getEtc_total_rate() {
		return etc_total_rate;
	} 
	
	
	public void setExample3_keyword(String example3_keyword) {
		this.example3_keyword = example3_keyword;
	}

	public Integer getExample3_total_cnt() {
		return example3_total_cnt;
	}

	public void setExample3_total_cnt(Integer example3_total_cnt) {
		this.example3_total_cnt = example3_total_cnt;
	}

	public Integer getExample3_total_rate() {
		return example3_total_rate;
	}

	public void setExample3_total_rate(Integer example3_total_rate) {
		this.example3_total_rate = example3_total_rate;
	}

	public String getExample4() {
		return example4;
	}

	public void setExample4(String example4) {
		this.example4 = example4;
	}

	public String getExample4_keyword() {
		return example4_keyword;
	}

	public void setExample4_keyword(String example4_keyword) {
		this.example4_keyword = example4_keyword;
	}

	public Integer getExample4_total_cnt() {
		return example4_total_cnt;
	}

	public void setExample4_total_cnt(Integer example4_total_cnt) {
		this.example4_total_cnt = example4_total_cnt;
	}

	public Integer getExample4_total_rate() {
		return example4_total_rate;
	}

	public void setExample4_total_rate(Integer example4_total_rate) {
		this.example4_total_rate = example4_total_rate;
	}

	public String getShutdown_flag() {
		return shutdown_flag;
	}

	public void setShutdown_flag(String shutdown_flag) {
		this.shutdown_flag = shutdown_flag;
	} 

	public void setEtc_total_rate(Integer Etc_total_rate) {
		this.etc_total_rate = Etc_total_rate;
	}

}
