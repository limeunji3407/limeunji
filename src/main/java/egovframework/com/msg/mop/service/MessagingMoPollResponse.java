package egovframework.com.msg.mop.service;

public class MessagingMoPollResponse {

	private Integer survey_seq;
	private String mo_originator;
	private String reple_keyword;
	private String reple_date;
	private Integer rownum;
	
	public Integer getRownum() {
		return rownum;
	}
	public void setRownum(Integer rownum) {
		this.rownum = rownum;
	}
	public Integer getSurvey_seq() {
		return survey_seq;
	}
	public void setSurvey_seq(Integer survey_seq) {
		this.survey_seq = survey_seq;
	}
	public String getMo_originator() {
		return mo_originator;
	}
	public void setMo_originator(String mo_originator) {
		this.mo_originator = mo_originator;
	}
	public String getReple_keyword() {
		return reple_keyword;
	}
	public void setReple_keyword(String reple_keyword) {
		this.reple_keyword = reple_keyword;
	}
	public String getReple_date() {
		return reple_date;
	}
	public void setReple_date(String reple_date) {
		this.reple_date = reple_date;
	}
}
