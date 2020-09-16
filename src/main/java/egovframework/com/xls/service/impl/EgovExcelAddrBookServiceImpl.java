package egovframework.com.xls.service.impl;

import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.com.usr.add.service.AddressBookVO;
import egovframework.com.usr.add.service.impl.AddressBookDAO;
import egovframework.com.xls.service.EgovExcelAddrBookService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.excel.EgovExcelService;
import javax.annotation.Resource;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;


/**
 *
 *
 *
 */
@Service("egovExcelAddrBookService")
public class EgovExcelAddrBookServiceImpl extends EgovAbstractServiceImpl implements EgovExcelAddrBookService {

	@Resource(name="AddressBookDAO")
	private AddressBookDAO addrBookDAO;
 
	@Resource(name = "excelAddrBookService")
    private EgovExcelService excelAddrBookService; 

  
    private EgovExcelAddrBookMapping excelMapper;
    
    private EgovExcelService excelBasicService; 
	/*@Override
	public List<Map> selectRow() throws Exception {
	    return excelMapper.selectRow();
	}*/

	@Override
	public void excelUpload(File destFile) {

	    ExcelReadOption excelReadOption = new ExcelReadOption();

	    //파일경로 추가
	    excelReadOption.setFilePath(destFile.getAbsolutePath());
	    //추출할 컬럼 명 추가
	    excelReadOption.setOutputColumns("A","B","C","D");
	    // 시작 행
	    excelReadOption.setStartRow(2);

	    List<Map<String, String>>excelContent = ExcelRead.read(excelReadOption);

	    for(Map<String, String> article: excelContent){
	    	System.out.println(article.get("A"));
	        System.out.println(article.get("B"));
	        System.out.println(article.get("C"));
	        System.out.println(article.get("D"));
	    }
 
	    /* 멀티 insert */ 
	    
	    
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("excelContent", excelContent);

	    try {
	       	excelMapper.insertExcel(paramMap);
	    } catch (Exception e) {
	       	e.printStackTrace();
	    }
	    
	    
	}
	  
	  
	  
	  
	  
	/**
	 *  엑셀파일을 등록한다.
	 * @param InputStream
	 * @throws Exception
	 */
	@Override
	public void insertExcelSharePhoneBook(InputStream file) throws Exception {
		/*//addrBookDAO.insertExcelAddress();*/	 
		excelAddrBookService.uploadExcel("AddressBookDAO.insertExcelAddressBook", file, 1, 5000);
		 
	}

	
	/**
	 * 주소록일괄등록 프로세스
	 * @param  vo PhoneBookVO  주소록
	 * @param  inputStream InputStream
	 * @exception Exception
	 */
	public String PhoneBookRegist(AddressBookVO vo, InputStream inputStream) throws Exception {

		String message = bndeRegist(inputStream);
		String sMessage = null;

		switch (Integer.parseInt(message)) {
			case 99: 
				sMessage = "테이블 데이타 존재오류";
				break;
			case 90:
				sMessage = "파일없음";
				break;
			case 91: 
				sMessage = "cell 갯수 오류.";
				break;
			case 92:
				sMessage = " cell 갯수 오류.";
				break;
			case 93:
				sMessage = "엑셀 시트갯수 오류.";
				break;
			case 95:
				sMessage = "정보 입력시 에러.";
				break;
			case 96:
				sMessage = "목록입력시 에러.";
				break;
			default:
				sMessage = "일괄배치처리 완료.";
				break;
		}
		return sMessage;
	}

	/**
	 * 목록 일괄생성
	 * @param  inputStream InputStream
	 * @return  String
	 * @exception Exception
	 */
	private String bndeRegist(InputStream inputStream) throws Exception {
		boolean success = false;
		String requestValue = null;
		int progrmSheetRowCnt = 0;
		//String xlsFile = null;
		try {
			/*
			오류 메세지 정보
			message = "99";	// 데이타 존재오류.
			message = "90";	//파일존재하지 않음.
			message = "91";	//시트의 cell 갯수 오류
			message = "92";	//시트의 cell 갯수 오류
			message = "93";	//엑셀 시트갯수 오류
			message = "95";	//정보 입력시 에러
			message = "96";	//목록입력시 에러
			message = "0";	//일괄배치처리 완료
			*/
 
			
			HSSFWorkbook hssfWB = (HSSFWorkbook) excelBasicService.loadWorkbook(inputStream);
			
			//갯수 확인  
			//if (hssfWB.getNumberOfSheets() == 2) {
				
				
				
				HSSFSheet progrmSheet = hssfWB.getSheetAt(0); // 시트 가져오기 
				HSSFRow progrmRow = progrmSheet.getRow(1); //프로그램 row 가져오기 
				progrmSheetRowCnt = progrmRow.getPhysicalNumberOfCells(); //cell Cnt 

				//시트 파일 데이타 검증 cell = 5개
				if (progrmSheetRowCnt != 5) {
					return requestValue = "91"; //프로그램시트의 cell 갯수 오류
				}

		 

				/* sheet1번 = 프로그램목록 ,  sheet2번 = 메뉴정보 */
				success = progrmRegist(progrmSheet);
				if (success) { 
						return requestValue = "0"; // 일괄배치처리 완료 
				} else {
					return requestValue = "96"; // 목록입력시 에러
				}
				
				
				
				
			//} else {
			//	return requestValue = "93"; // 엑셀 시트갯수 오류
			//}

		} catch (Exception e) {
			//시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754] 
			requestValue = "99";
		}
		return requestValue;
	}
	
	/**
	 * 등록
	 * @param  vo AddressBookVO
	 * @return boolean
	 * @exception Exception
	 */
	private boolean insertProgrm(AddressBookVO vo) throws Exception {
		addrBookDAO.insertAddressBook(vo);
		return true;
	}
	
	/**
	 * 목록 일괄등록
	 * @param  progrmSheet HSSFSheet
	 * @return  boolean
	 * @exception Exception
	 */
	private boolean progrmRegist(HSSFSheet progrmSheet) {
		int count = 0;
		boolean success = false;
		try {
			int rows = progrmSheet.getPhysicalNumberOfRows(); //행 갯수 가져오기
			for (int j = 1; j < rows; j++) { //row 루프
				AddressBookVO vo = new AddressBookVO();
				HSSFRow row = progrmSheet.getRow(j); //row 가져오기
				if (row != null) {
					//int cells = row.getPhysicalNumberOfCells(); //cell 갯수 가져오기
					HSSFCell cell = null;
					cell = row.getCell(0); //수신자명
					if (cell != null) {
						vo.setAddress_name("" + cell.getStringCellValue());
					}
					cell = row.getCell(1); //수신자번호
					if (cell != null) {
						vo.setAddress_num("" + cell.getStringCellValue());
					}
					cell = row.getCell(2); //2 공유
					if (cell != null) {
						vo.setAddress_type("2");
					}
					cell = row.getCell(3); //등록자ID
					if (cell != null) {
						vo.setUser_id("" + cell.getStringCellValue());
					} 
				}
				
				if (insertProgrm(vo)) {
					count++;
				}
				
			}
			if (count == rows - 1) {
				success = true;
			} else {
				success = false;
			}
		} catch (Exception e) {
			//시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
			System.out.println("["+ e.getClass() +"] : " + e.getMessage());

			success = false;
		}
		return success;
	}

	 
	
	
	
	
	
	
	
	
}
