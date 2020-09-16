package egovframework.com.msg.moc.service;

import java.io.Serializable;
import java.math.BigDecimal;

public class MoNumber  implements Serializable{

    private static final long serialVersionUID = 1L;
    
	private BigDecimal mo_seq;
	private String mo_number;
	private String mo_number_sub;
	private String mo_type;  /* 민원  , 문자투표  */ 
	private String mo_status; /* '0' delete  '1' 사용중 */	
	private String mo_date;
	
	
	public BigDecimal getMo_seq() {
		return mo_seq;
	}
	public void setMo_seq(BigDecimal mo_seq) {
		this.mo_seq = mo_seq;
	}
	public String getMo_number() {
		return mo_number;
	}
	public void setMo_number(String mo_number) {
		this.mo_number = mo_number;
	}
	public String getMo_number_sub() {
		return mo_number_sub;
	}
	public void setMo_number_sub(String mo_number_sub) {
		this.mo_number_sub = mo_number_sub;
	}
	public String getMo_type() {
		return mo_type;
	}
	public void setMo_type(String mo_type) {
		this.mo_type = mo_type;
	}
	public String getMo_status() {
		return mo_status;
	}
	public void setMo_status(String mo_status) {
		this.mo_status = mo_status;
	}
	public String getMo_date() {
		return mo_date;
	}
	public void setMo_date(String mo_date) {
		this.mo_date = mo_date;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

		
}
