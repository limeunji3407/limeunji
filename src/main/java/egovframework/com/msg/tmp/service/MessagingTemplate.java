package egovframework.com.msg.tmp.service;

public class MessagingTemplate {

	/* 템플릿 고유 번호 */
	private Integer template_data_seq;
	
	/* 발신 프로필키 */
	private String sender_key;
	
	/* 템플릿 코드 */
	private String template_code;
	
	/* 템플릿 이름 */
	private String template_name;
	
	/* 템플릿 내용 */
	private String template_content;
	
	/* 템흘릿 버튼 */
	private String template_buttons;
	
	/* 템플릿 변수 */
	private String template_variables;
	
	/* 템플릿 수정 요청할 이름 */
	private String template_modify_name;
	
	/* 템플릿 수정 요청할 내용 */
	private String template_modify_content;
	
	/* 템플릿 수정 요청할 버튼 */
	private String template_modify_buttons;
	
	/* 템플릿 수정 요청할 변수 */
	private String template_modify_variables;
	
	/* 검수상태 (REG:등록,REQ:검수요청,APR:승인,KRR:등록거절,REJ:승인반려,DEL:삭제) (insert시 REG로) */
	private String inspection_status;
	
	/* MTS가 당사에서 요청한 데이터를 받은 시간 */
	private String created_at;
	
	/* MTS가 당사에서 받은 수정 요청을 받은 시간 */
	private String modified_at;
	
	/* MTS에서 받은 상태(S:중단, A:정상, R:대기) */
	private String status;
	
	/* 템플릿 상태값 */
	private Integer cur_status;
	
	/* 모듈처리중상태여부(Y:처리중,N:아님) */
	private String process_ing;
	
	/* 문의하기(댓글) 총수량 */
	private Integer comment_count;
	
	/* 제목 (igov 자체 제목) */
	private String subject;
	
	/* 최초등록일자 */
	private String reg_date;
	
	/* 최종 처리일자 */
	private String mod_date;
	
	/* 등록자 */
	private String reg_id;
	
	/* 수정자 */
	private String mod_id;
	
	/* 업무분류  */
	private Integer work_seq;
	
	/* 사용여부 */
	private String use_yn;
	
	/* 템플릿 종류(N:일반, F:프리템플릿, K:경조사템플릿) */
	private String template_type;
	
	private String content;

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getTemplate_data_seq() {
		return template_data_seq;
	}

	public void setTemplate_data_seq(Integer template_data_seq) {
		this.template_data_seq = template_data_seq;
	}

	public String getSender_key() {
		return sender_key;
	}

	public void setSender_key(String sender_key) {
		this.sender_key = sender_key;
	}

	public String getTemplate_code() {
		return template_code;
	}

	public void setTemplate_code(String template_code) {
		this.template_code = template_code;
	}

	public String getTemplate_name() {
		return template_name;
	}

	public void setTemplate_name(String template_name) {
		this.template_name = template_name;
	}

	public String getTemplate_content() {
		return template_content;
	}

	public void setTemplate_content(String template_content) {
		this.template_content = template_content;
	}

	public String getTemplate_buttons() {
		return template_buttons;
	}

	public void setTemplate_buttons(String template_buttons) {
		this.template_buttons = template_buttons;
	}

	public String getTemplate_variables() {
		return template_variables;
	}

	public void setTemplate_variables(String template_variables) {
		this.template_variables = template_variables;
	}

	public String getTemplate_modify_name() {
		return template_modify_name;
	}

	public void setTemplate_modify_name(String template_modify_name) {
		this.template_modify_name = template_modify_name;
	}

	public String getTemplate_modify_content() {
		return template_modify_content;
	}

	public void setTemplate_modify_content(String template_modify_content) {
		this.template_modify_content = template_modify_content;
	}

	public String getTemplate_modify_buttons() {
		return template_modify_buttons;
	}

	public void setTemplate_modify_buttons(String template_modify_buttons) {
		this.template_modify_buttons = template_modify_buttons;
	}

	public String getTemplate_modify_variables() {
		return template_modify_variables;
	}

	public void setTemplate_modify_variables(String template_modify_variables) {
		this.template_modify_variables = template_modify_variables;
	}

	public String getInspection_status() {
		return inspection_status;
	}

	public void setInspection_status(String inspection_status) {
		this.inspection_status = inspection_status;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	public String getModified_at() {
		return modified_at;
	}

	public void setModified_at(String modified_at) {
		this.modified_at = modified_at;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getCur_status() {
		return cur_status;
	}

	public void setCur_status(Integer cur_status) {
		this.cur_status = cur_status;
	}

	public String getProcess_ing() {
		return process_ing;
	}

	public void setProcess_ing(String process_ing) {
		this.process_ing = process_ing;
	}

	public Integer getComment_count() {
		return comment_count;
	}

	public void setComment_count(Integer comment_count) {
		this.comment_count = comment_count;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
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

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public Integer getWork_seq() {
		return work_seq;
	}

	public void setWork_seq(Integer work_seq) {
		this.work_seq = work_seq;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public String getTemplate_type() {
		return template_type;
	}

	public void setTemplate_type(String template_type) {
		this.template_type = template_type;
	}
}
