package egovframework.com.usr.add.service;

import java.io.Serializable;
import java.util.List;
/**
 * 주소록 관리를 위한 모델 클래스
 * @author 공통컴포넌트개발팀 윤성록
 * @since 2009.09.25
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.9.25  윤성록          최초 생성
 *   2016.12.13 최두영          클래스명 변경
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class AddressBook implements Serializable{
  
    /** 주소록 아이디 */
    private String address_id;
    
    /** 주소록 소유자 아이디 */
    private String user_id;
    
    /** 주소록 그룹타입 (0:개인, 1:부서, 2:공유, 3:직원) */
    private String address_type;
    
    /** 주소록 이름 */
    private String address_name = "";
    
    /** 주소록 번호 */
    private String address_num = "";
    
    /** 주소록 메모*/
    private String address_ect = "";
    
    /** 주소록 등록일 */
    private String address_date = "";
    
    /** 주소록 복사여부 */
    private String address_capy = "";
    
    /** 주소록 소유 부서 아이디 */
    private String part_id = "";
    
    /** 주소록 대분류 */
    private String address_category;
    
    /** 주소록 소분류*/
    private String address_group;
    
    
    /** 그룹 소유타입*/
    private String category_type;
    
    /** 주소록 그룹명 **/
    private String address_grp_name;
    
    List<AddressBookVO> addressBookVoList;

	public List<AddressBookVO> getAddressBookVoList() {
		return addressBookVoList;
	}

	public void setAddressBookVoList(List<AddressBookVO> addressBookVoList) {
		this.addressBookVoList = addressBookVoList;
	}

	/** Getter & Setter */
	public String getAddress_id() {
		return address_id;
	}

	public void setAddress_id(String address_id) {
		this.address_id = address_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getAddress_type() {
		return address_type;
	}

	public void setAddress_type(String address_type) {
		this.address_type = address_type;
	}

	public String getAddress_name() {
		return address_name;
	}

	public void setAddress_name(String address_name) {
		this.address_name = address_name;
	}

	public String getAddress_num() {
		return address_num;
	}

	public void setAddress_num(String address_num) {
		this.address_num = address_num;
	}

	public String getAddress_ect() {
		return address_ect;
	}

	public void setAddress_ect(String address_ect) {
		this.address_ect = address_ect;
	}

	public String getAddress_date() {
		return address_date;
	}

	public void setAddress_date(String address_date) {
		this.address_date = address_date;
	}

	public String getAddress_capy() {
		return address_capy;
	}

	public void setAddress_capy(String address_capy) {
		this.address_capy = address_capy;
	}

	public String getPart_id() {
		return part_id;
	}

	public void setPart_id(String part_id) {
		this.part_id = part_id;
	}

	public String getAddress_category() {
		return address_category;
	}

	public void setAddress_category(String address_category) {
		this.address_category = address_category;
	}

	public String getAddress_group() {
		return address_group;
	}

	public void setAddress_group(String address_group) {
		this.address_group = address_group;
	}

	public String getCategory_type() {
		return category_type;
	}

	public void setCategory_type(String category_type) {
		this.category_type = category_type;
	}

	public String getAddress_grp_name() {
		return address_grp_name;
	}

	public void setAddress_grp_name(String address_grp_name) {
		this.address_grp_name = address_grp_name;
	}
    
	
}
