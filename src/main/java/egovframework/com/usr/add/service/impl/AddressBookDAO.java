package egovframework.com.usr.add.service.impl;

import java.util.List;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.usr.add.service.AddressBook;
import egovframework.com.usr.add.service.AddressBookVO;


/**
 * @Class Name : AddressBookDAO.java
 * @Description : 주소록을 관리하는 서비스를 정의하기위한 데이터 접근 클래스
 * @Modification Information
 *
 *    수정일          수정자         수정내용
 *   -------        -------     -------------------
 *    2009.9.25.    윤성록       최초 생성
 *    2016.12.13    최두영       클래스명 변경
 * @author 공통 컴포넌트 개발팀 윤성록
 * @since 2009. 9. 25.
 * @version
 * @see
 *
 */
@Repository("AddressBookDAO")
public class AddressBookDAO extends EgovComAbstractDAO{
    
    /**
     * 주어진 조건에 따른 주소록목록을 불러온다.
     * 
     * @param AddressBookVO
     * @return
     * @throws Exception
     */
	public List<AddressBookVO> selectAddressBookList(AddressBookVO adbkVO) throws Exception {
        return selectList("AddressBookDAO.selectAddressBookList", adbkVO);
    }

	
	public List<AddressBookVO> selectAddressBookListAll(AddressBookVO adbkVO) throws Exception {
        return selectList("AddressBookDAO.selectAddressBookListAll", adbkVO);
    }
    
    /**
     * 주소록 정보를 등록한다.
     * 
     * @param AddressBook
     * @throws Exception
     */
    public void insertAddressBook(AddressBook addressBook) throws Exception {
        insert("AddressBookDAO.insertAddressBook", addressBook);
    }
    
    /**
     * 주소록 정보를 수정한다.
     * 
     * @param AddressBook
     * @throws Exception
     */
    public void updateAddressBook(AddressBook addressBook) throws Exception {
        update("AddressBookDAO.updateAddressBook", addressBook);
    }
    /**
     * 주소록 삭제한다.
     * 
     * @param AddressBookUser
     * @throws Exception
     */
    public void deleteAddressBook(AddressBook adbkUser) throws Exception {
        delete("AddressBookDAO.addressDelete", adbkUser);
    }    
    /**
     * 주소록 전체삭제
     * @param adbkUser
     * @throws Exception
     */
    public void deleteAddressBookAll(AddressBook adbkUser) throws Exception {
    	delete("AddressBookDAO.addressDeleteAll", adbkUser);
    }    
    public void deleteUserDetail(AddressBook adbkUser) throws Exception {
    	delete("AddressBookDAO.deleteUserDetail", adbkUser);
    }    
    
    /**
     * 주소록 목록에 대한 전체 건수를 조회한다.
     * 
     * @param AddressBookUser
     * @throws Exception
     */
    public int selectAddressBookListCnt(AddressBookVO adbkVO) throws Exception {
        return (Integer)selectOne("AddressBookDAO.selectAddressBookListCnt", adbkVO);
    }
    
    
    /**
     * 주소록 엑셀등록
     * 
     * @param AddressBookUser
     * @throws Exception
     */  
	public void insertExcelAddressBook() throws Exception {
        insert("AddressBookDAO.insertExcelAddressBook");
	}
	
	/**
	 * 주소록 in 으로 가져오기
	 * 
	 * @param AddressBookUser
	 * @throws Exception
	 */  
	public List<AddressBookVO> selectAddressBooks(AddressBookVO adbkVO) throws Exception {
		return selectList("AddressBookDAO.selectAddressBookListCopy", adbkVO);
	}
	/**
	 * 주소록 데이터 저장
	 * 
	 * @param AddressBookUser
	 * @throws Exception
	 */  
	public void insertAddressCopyList(AddressBookVO adbkVO) throws Exception {
		insert("AddressBookDAO.insertAddressCopyList", adbkVO);
	}
	
	public AddressBookVO serchEmpAddr(AddressBookVO addrVO) throws Exception{
		return selectOne("AddressBookDAO.serchEmpAddr",addrVO);
	}
}

