package egovframework.com.xls.service;

import java.io.File;
import java.io.InputStream;
import egovframework.com.usr.add.service.AddressBookVO;


/**
 *
 * 우편번호에 관한 서비스 인터페이스 클래스를 정의한다
 * @author 공통서비스 김수로
 *
 * </pre>
 */
public interface EgovExcelAddrBookService {

	/**
	 * 공유주소록 엑셀파일을 등록한다.
	 * @param phonebook
	 * @throws Exception
	 */
	void insertExcelSharePhoneBook(InputStream file) throws Exception;
/*
	List<Map> selectRow() throws Exception;*/

	void excelUpload(File destFile) throws Exception;
 
	String PhoneBookRegist(AddressBookVO vo, InputStream inputStream) throws Exception;


}
