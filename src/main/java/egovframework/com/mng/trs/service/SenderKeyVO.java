package egovframework.com.mng.trs.service;

/**
 * @Class Name : SenderKeyVO.java
 * @Description : SenderKey VO class
 * @Modification Information
 *
 * @author Kim SuRo
 * @since 2020/03/21
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class SenderKeyVO extends SenderKeyDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SENDER_KEY_SEQ */
    private Integer senderKeySeq;
    
    /** SENDER_KEY */
    private String senderKey;
    
    /** SENDER_KEY_TYPE */
    private String senderKeyType;
    
    /** PROFILE_NAME */
    private String profileName;
    
    /** PROFILE_UUID */
    private String profileUuid;
    
    /** REG_DATE */
    private String regDate;
    
    /** USE_YN */
    private String useYn;
    
    /** use part id */
    private String partId;
    private String partName;

	public String getPartId() {
		return partId;
	}

	public void setPartId(String partId) {
		this.partId = partId;
	}

	public String getPartName() {
		return partName;
	}

	public void setPartName(String partName) {
		this.partName = partName;
	}

	public Integer getSenderKeySeq() {
		return senderKeySeq;
	}

	public void setSenderKeySeq(Integer senderKeySeq) {
		this.senderKeySeq = senderKeySeq;
	}

	public String getSenderKey() {
		return senderKey;
	}

	public void setSenderKey(String senderKey) {
		this.senderKey = senderKey;
	}

	public String getSenderKeyType() {
		return senderKeyType;
	}

	public void setSenderKeyType(String senderKeyType) {
		this.senderKeyType = senderKeyType;
	}

	public String getProfileName() {
		return profileName;
	}

	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}

	public String getProfileUuid() {
		return profileUuid;
	}

	public void setProfileUuid(String profileUuid) {
		this.profileUuid = profileUuid;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}    
}