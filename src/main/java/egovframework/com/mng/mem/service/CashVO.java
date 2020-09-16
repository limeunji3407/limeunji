package egovframework.com.mng.mem.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class CashVO implements Serializable{

	private String pay_code;
	private Integer pay_fee;
	
	public String getPay_code() {
		return pay_code;
	}
	public void setPay_code(String pay_code) {
		this.pay_code = pay_code;
	}
	public Integer getPay_fee() {
		return pay_fee;
	}
	public void setPay_fee(Integer pay_fee) {
		this.pay_fee = pay_fee;
	}
}
