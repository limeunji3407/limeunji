package egovframework.com.bil.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class CashBilling implements Serializable{

	/* 고유번호 */
	private Integer seq;
	
	/* 사용자ID */
	private String userid;
	
	/* 현재캐시 */
	private Integer cash;
	
	/* 남은캐시 */
	private Integer leftcash;
	
	/* 캐시주문형태 */
	private Integer ordercash;
	
	/* 충전차감 유형 */
	private String msgtype;
	
	/* 캐시 충전일 */
	private String create_dt;
	
	/* 완료상태 */
	private String status;
	
	
	/* Getter & Setter*/
	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public Integer getCash() {
		return cash;
	}

	public void setCash(Integer cash) {
		this.cash = cash;
	}

	public Integer getLeftcash() {
		return leftcash;
	}

	public void setLeftcash(Integer leftcash) {
		this.leftcash = leftcash;
	}

	public Integer getOrdercash() {
		return ordercash;
	}

	public void setOrdercash(Integer ordercash) {
		this.ordercash = ordercash;
	}

	public String getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(String msgtype) {
		this.msgtype = msgtype;
	}

	public String getCreate_dt() {
		return create_dt;
	}

	public void setCreate_dt(String create_dt) {
		this.create_dt = create_dt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
