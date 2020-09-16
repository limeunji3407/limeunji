package egovframework.com.usr.add.service;

import java.util.List;

/**
 * 주소록정보를 관리하기 위한 서비스 인터페이스 클래스
 * @author 공통컴포넌트팀 윤성록
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
 * </pre>
 */
public interface EgovAddressBookService {
    
  
    /**
     * 주소록 목록을 조회한다.
     * @param AddressBookVO
     * @return  Map<String, Object>
     * @exception Exception
     */
    public List<AddressBookVO>  selectAddressBookListAll(AddressBookVO addressBookVO) throws Exception;
    /**
     * 주소록 목록을 조회한다.
     * @param AddressBookVO
     * @return  Map<String, Object>
     * @exception Exception
     */
    public List<AddressBookVO> selectAddressBookList(AddressBookVO addressBookVO) throws Exception;
    
    /**
     * 주소록 정보를 삭제한다.
     * @param AddressBook
     * @return 
     * @exception Exception
     */
    public void deleteAddressBook(AddressBook addressBook) throws Exception;
    public void deleteAddressBookAll(AddressBook addressBook) throws Exception;
    public void deleteUserDetail(AddressBook addressBook) throws Exception;
    
    /**
     * 주소록 정보를 등록한다.
     * 
     * @param AddressBook
     * @throws Exception
     */
    public void insertAddressBook(AddressBookVO adbkVO) throws Exception; 
    

    /**
     * 주소록 정보를 수정한다.
     * 
     * @param AddressBook
     * @throws Exception
     */
    public void updateAddressBook(AddressBookVO adbkVO) throws Exception; 
    
    /**
     * 주소록 정보를 수정한다.
     * 
     * @param AddressBook
     * @throws Exception
     */
    public List<AddressBookVO> selectAddressBooks(AddressBookVO adbkVO) throws Exception; 
    public void insertAddressCopyList(AddressBookVO adbkVO) throws Exception; 
    public AddressBookVO serchEmpAddr(AddressBookVO addrVO) throws Exception;
}