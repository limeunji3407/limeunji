package egovframework.com.usr.mal.service;

import java.io.Serializable;
import java.util.List;

import egovframework.com.uss.umt.service.UserManageVO;


@SuppressWarnings("serial")
public class ReceiptRefusal implements Serializable{
	
	
	String partgRole;
	String orgnztId;
	List<UserManageVO> userManageVOList;
	
	
	
	public String getPartgRole() {
		return partgRole;
	}

	public void setPartgRole(String partgRole) {
		this.partgRole = partgRole;
	}

	public String getOrgnztId() {
		return orgnztId;
	}

	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}

	public List<UserManageVO> getUserManageVOList() {
		return userManageVOList;
	}

	public void setUserManageVOList(List<UserManageVO> userManageVOList) {
		this.userManageVOList = userManageVOList;
	}

	/***/
	private Integer id;

	/** 등록일시 */
	private String regist_date;
	
	/** 등록자 ID */
	private String register_id;
	
	/** 해지일시 */
	private String cancel_date;
	
	/** 해지자 ID */
	private String cancel_id;
	
	/** 수신거부 번호 */
	private String reject_phone;
	
	/** 발신번호 */
	private String sending_number;
	
	/** 상태 (0:해지, 1:등록) */
	private Integer status;
	
	
	/** Getter & Setter */

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getRegist_date() {
		return regist_date;
	}

	public void setRegist_date(String regist_date) {
		this.regist_date = regist_date;
	}

	public String getRegister_id() {
		return register_id;
	}

	public void setRegister_id(String register_id) {
		this.register_id = register_id;
	}

	public String getCancel_date() {
		return cancel_date;
	}

	public void setCancel_date(String cancel_date) {
		this.cancel_date = cancel_date;
	}

	public String getCancel_id() {
		return cancel_id;
	}

	public void setCancel_id(String cancel_id) {
		this.cancel_id = cancel_id;
	}

	public String getReject_phone() {
		return reject_phone;
	}

	public void setReject_phone(String reject_phone) {
		this.reject_phone = reject_phone;
	}

	public String getSending_number() {
		return sending_number;
	}

	public void setSending_number(String sending_number) {
		this.sending_number = sending_number;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}
