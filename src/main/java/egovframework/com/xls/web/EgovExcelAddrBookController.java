package egovframework.com.xls.web;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.dsjdf.jdf.DateTime;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.util.EgovResourceCloseHelper;
import egovframework.com.cmm.util.ExcelView;
import egovframework.com.cop.smt.djm.service.DeptJobBx;
import egovframework.com.cop.smt.djm.service.DeptJobBxVO;
import egovframework.com.cop.smt.djm.service.EgovDeptJobService;
import egovframework.com.msg.moc.service.EgovMessagingMoComplainService;
import egovframework.com.msg.moc.service.MessagingMoComplainVO;
import egovframework.com.msg.mop.service.EgovMessagingMoPollService;
import egovframework.com.msg.mop.service.MessagingMoPollVO;
import egovframework.com.msg.rcv.service.EgovRcvaddrListService;
import egovframework.com.msg.rcv.service.RcvaddrListVO;
import egovframework.com.usr.add.service.AddressBookVO;
import egovframework.com.usr.add.service.EgovAddressBookService;
import egovframework.com.uss.umt.service.DeptManageVO;
import egovframework.com.uss.umt.service.EgovDeptManageService;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.com.uss.umt.service.UserDefaultVO;
import egovframework.com.xls.service.EgovExcelAddrBookService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EgovExcelAddrBookController {

    @Resource(name = "egovExcelAddrBookService")
	private EgovExcelAddrBookService egovExcelAddrBookService; 


	@Resource(name = "egovMessagingMoPollService")
    private EgovMessagingMoPollService messagingMoPollService;
	
    @Resource(name = "egovMessagingMoComplainService")
	private EgovMessagingMoComplainService egovMessagingMoComplainService; 
    
    
    

    @Resource(name = "egovDeptJobService")
	private EgovDeptJobService egovDeptJobService; 

    @Resource(name = "egovDeptManageService")
	private EgovDeptManageService egovDeptManageService;

    @Resource(name = "egovRcvaddrListService")
	private EgovRcvaddrListService egovRcvaddrListService;	

    @Resource(name = "egovAddressBookService")
    private EgovAddressBookService egovAddressBookService;
    
    @Resource(name = "userManageService")
	private EgovUserManageService egovUserManageService;	
 
    @Resource(name="egovMessageSource")
    private EgovMessageSource egovMessageSource;
    
    
    
    

    
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService egovPropertyService;
    

	@RequestMapping(value = "/excelUploadAjax.do", method = RequestMethod.POST)
	public String excelUploadAjax(MultipartFile testFile, MultipartHttpServletRequest request)  throws Exception {
		

	    System.out.println("업로드 진행");

	    MultipartFile excelFile = request.getFile("excelFile");

	    if(excelFile==null || excelFile.isEmpty()){

	        throw new RuntimeException("엑셀파일을 선택 해 주세요.");
	    }

	    File destFile = new File("D:\\"+excelFile.getOriginalFilename());

	    try{
	      //내가 설정한 위치에 내가 올린 파일을 만들고
	        excelFile.transferTo(destFile);

	    }catch(Exception e){
	        throw new RuntimeException(e.getMessage(),e);
	    }
 
	    //업로드를 진행하고 다시 지우기
	    egovExcelAddrBookService.excelUpload(destFile);
	    

	    destFile.delete();
		 
		
		return "jsonView";
	}
	  
	  
	  
	   
	/**
	 * 엑셀파일을 업로드 등록한다.
	 * @param loginVO
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/ExcelAddrBookRegist.do")
	public String insertExcelPhoneBook(@ModelAttribute("AddressBookVO") AddressBookVO addrBookVO, final MultipartHttpServletRequest request, @RequestParam Map<String, Object> commandMap, AddressBookVO searchVO, Model model)
			throws Exception {

        String sLocationUrl = null;
        String resultMsg = "";
        String sMessage  = "";
		System.out.println("--------------ExcelAddrBookRegister1--------------" + request );
		//model.addAttribute("searchList", searchVO.getSearchList());

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");
		if (sCmd.equals("")) {
			return "egovframework/mng/gru/EgoMngGrp";
		}

 	    MultipartFile excelFile = request.getFile("ex_filename");
	    System.out.println("----------------엑셀 파일 업로드 컨트롤러-----------------------");
	    
	    if(excelFile==null || excelFile.isEmpty()){
	    	
	            /* throw new RuntimeException("엑셀파일을 선택 해 주세요."); */	
	    	
	    }
	    
	    //File destFile = new File("C:\\"+excelFile.getOriginalFilename());
	    
/*	    try{
	    	excelFile.transferTo(destFile);
	    }catch(Exception e) {
	        throw new RuntimeException(e.getMessage(),e);
	    } */ 
	    
		
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		InputStream fis = null;

		//String sResult = "";
		System.out.println("--------------ExcelAddrBookRegister2--------------" + files );

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			if (!"".equals(file.getOriginalFilename())) {
				// 업로드 파일에 대한 확장자를 체크
				if (file.getOriginalFilename().endsWith(".xls") || file.getOriginalFilename().endsWith(".xlsx") || file.getOriginalFilename().endsWith(".XLS")
						|| file.getOriginalFilename().endsWith(".XLSX")) {

					//Service.deleteAllZip();
					//excelService.uploadExcel("DAO.insertExcel", file.getInputStream(), 2);
					try {
						fis = file.getInputStream();
						//if (searchVO.getSearchList().equals("1")) {						
						//egovExcelAddrBookService.excelUpload(fis);
						/*egovExcelAddrBookService.insertExcelSharePhoneBook(fis);*/				
						
						AddressBookVO vo = new AddressBookVO ();
						sMessage = egovExcelAddrBookService.PhoneBookRegist(vo, fis);
			    	    resultMsg = sMessage;
						
						//} else {
						//	xlsService.insertExcelSharePhoneBook(fis);
						//}
					} finally {
						EgovResourceCloseHelper.close(fis);
						resultMsg = egovMessageSource.getMessage("fail.common.msg");
						model.addAttribute("resultMsg", resultMsg);
					}

				} else {
					//LOGGER.info("xls, xlsx 파일 타입만 등록이 가능합니다.");
					resultMsg = egovMessageSource.getMessage("fail.common.msg");
					model.addAttribute("resultMsg", resultMsg);
					sLocationUrl = "egovframework/com/mng/adr/EgovAddrBookShare";
					return sLocationUrl;
				} 

			}
		}
		model.addAttribute("resultMsg", resultMsg);
		sLocationUrl = "egovframework/com/mng/adr/EgovAddrBookShare";
		
		return sLocationUrl;
	}


	
/* 다운로드 */
	
	
/* xlsx */

	@RequestMapping(value="/ExcelUserManageX.do")  /* UserDefaultVO userVO,*/
	public void ExcelPoiX(@RequestParam String fileName, HttpServletResponse response, Model model) throws Exception {

		   XSSFWorkbook objWorkBook = new XSSFWorkbook();
		    XSSFSheet objSheet = null;
		    XSSFRow objRow = null;
		    XSSFCell objCell = null; // 셀 생성

		    // 제목 폰트
		    XSSFFont font = objWorkBook.createFont();
		    font.setFontHeightInPoints((short) 9);
		    font.setBoldweight((short) Font.BOLDWEIGHT_BOLD);
		    font.setFontName("맑은고딕");

		    // 제목 스타일에 폰트 적용, 정렬
		    XSSFCellStyle styleHd = objWorkBook.createCellStyle(); // 제목 스타일
		    styleHd.setFont(font);
		    styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		    styleHd.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		    objSheet = objWorkBook.createSheet("첫번째 시트"); // 워크시트 생성


		    // 행으로 제작을 하네
		    // 1행
		    objRow = objSheet.createRow(0);
		    objRow.setHeight((short) 0x150);

		    objCell = objRow.createCell(0);
		    objCell.setCellValue("아이디");
		    objCell.setCellStyle(styleHd);

		    objCell = objRow.createCell(1);
		    objCell.setCellValue("이름");
		    objCell.setCellStyle(styleHd);

		    objCell = objRow.createCell(2);
		    objCell.setCellValue("나이");
		    objCell.setCellStyle(styleHd);

		    objCell = objRow.createCell(3);
		    objCell.setCellValue("이메일");
		    objCell.setCellStyle(styleHd);

		    /*List<Map> rowList = excelService.selectRow();*/
			List<Map> rowList = egovUserManageService.selectUserExcelList(); 
		    int index = 1;
		    for (Map map : rowList) {
		      objRow = objSheet.createRow(index);
		      objRow.setHeight((short) 0x150);

		      objCell = objRow.createCell(0);
		      objCell.setCellValue((String)map.get("EmplyId"));
		      objCell.setCellStyle(styleHd);

		      objCell = objRow.createCell(1);
		      objCell.setCellValue((String)map.get("EmplyNm"));
		      objCell.setCellStyle(styleHd);

		      objCell = objRow.createCell(2);
		      objCell.setCellValue((String)map.get("custAge"));
		      objCell.setCellStyle(styleHd);

		      objCell = objRow.createCell(3);
		      objCell.setCellValue((String)map.get("custEmail"));
		      objCell.setCellStyle(styleHd);
		      index++;
		    }

		    for (int i = 0; i < rowList.size(); i++) {
		      objSheet.autoSizeColumn(i);
		    }

		    response.setContentType("Application/Msexcel");
		    response.setHeader("Content-Disposition", "ATTachment; Filename="
		        + URLEncoder.encode(fileName, "UTF-8") + ".xlsx");

		    OutputStream fileOut = response.getOutputStream();
		    objWorkBook.write(fileOut);
		    fileOut.close();

		    response.getOutputStream().flush();
		    response.getOutputStream().close();
	  
	}	
	
	
	
/* xls */
	/* 관리자 5. 사용자관리 */
	@RequestMapping(value="/ExcelUserManage.do")  /* UserDefaultVO userVO,*/
	public void ExcelPoi51(@ModelAttribute  UserDefaultVO uVo,  HttpServletResponse response, Model model) throws Exception {

	     HSSFWorkbook objWorkBook = new HSSFWorkbook();
	     HSSFSheet objSheet = null;
	     HSSFRow objRow = null;
	     HSSFCell objCell = null;       //셀 생성
	       
	        //제목 폰트
	    HSSFFont font = objWorkBook.createFont();
	    font.setFontHeightInPoints((short)9);
	    font.setBoldweight((short)Font.BOLDWEIGHT_BOLD);
	    font.setFontName("맑은고딕");
	  
	  	//제목 스타일에 폰트 적용, 정렬
	  	HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
	  	styleHd.setFont(font);
	  	styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	  	styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

	  	objSheet = objWorkBook.createSheet("첫번째 시트");     //워크시트 생성
	  
	  	
	  	
	  	// 1행
	  	objRow = objSheet.createRow(0);
	  	objRow.setHeight ((short) 0x150);
	       
	  	objCell = objRow.createCell(0);
	  	objCell.setCellValue("이름");
	  	objCell.setCellStyle(styleHd);
	  
	  	objCell = objRow.createCell(1);
	  	objCell.setCellValue("번호");
	  	objCell.setCellStyle(styleHd);
	  
	  
	   
		List<Map> rowList = egovUserManageService.selectUserExcelList(); 
	  
	  int index = 1;
	  for (Map map : rowList) {
	    objRow = objSheet.createRow(index);
	    objRow.setHeight((short) 0x150);

	    objCell = objRow.createCell(0);
	    objCell.setCellValue((String)map.get("EmplyId"));
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(1);
	    objCell.setCellValue((String)map.get("EmplyNm"));
	    objCell.setCellStyle(styleHd);
 
	    index++;
	  }

	  for (int i = 0; i < rowList.size(); i++) {
	    objSheet.autoSizeColumn(i);
	  } 	  
	  
	  response.setContentType("Application/Msexcel");
	  response.setHeader("Content-Disposition", "ATTachment; Filename="+URLEncoder.encode("테스트","UTF-8")+".xls");

	  OutputStream fileOut  = response.getOutputStream(); 
	  objWorkBook.write(fileOut);
	  fileOut.close();
	       
	  response.getOutputStream().flush();
	  response.getOutputStream().close();
	}
	
	
	/* 관리자  4. 공유주소록 */
	@RequestMapping(value="/ExcelAddrBookShare.do")
	public void ExcelPoi2(@ModelAttribute AddressBookVO addressBookVO, HttpServletResponse response, Model model) throws Exception {

	     HSSFWorkbook objWorkBook = new HSSFWorkbook();
	     HSSFSheet objSheet = null;
	     HSSFRow objRow = null;
	     HSSFCell objCell = null;       //셀 생성
	       
	        //제목 폰트
	  HSSFFont font = objWorkBook.createFont();
	  font.setFontHeightInPoints((short)9);
	  font.setBoldweight((short)Font.BOLDWEIGHT_BOLD);
	  font.setFontName("맑은고딕");
	  
	  //제목 스타일에 폰트 적용, 정렬
	        HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
	  styleHd.setFont(font);
	  styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	  styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

	  objSheet = objWorkBook.createSheet("첫번째 시트");     //워크시트 생성
	  
	  // 1행
	  objRow = objSheet.createRow(0);
	  objRow.setHeight ((short) 0x150);
	       
	  objCell = objRow.createCell(0);
	  objCell.setCellValue("이름");
	  objCell.setCellStyle(styleHd);
	  
	  objCell = objRow.createCell(1);
	  objCell.setCellValue("번호");
	  objCell.setCellStyle(styleHd);
	  
	  
	  
	  List<AddressBookVO> rowList = egovAddressBookService.selectAddressBookList(addressBookVO);
	  
	  int index = 1;
	  for (AddressBookVO abVO : rowList) {
	    objRow = objSheet.createRow(index);
	    objRow.setHeight((short) 0x150);

	    objCell = objRow.createCell(0);
	    objCell.setCellValue((String)abVO.getAddress_name());
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(1);
	    objCell.setCellValue((String)abVO.getAddress_num());
	    objCell.setCellStyle(styleHd);
 
	    index++;
	  }

	  for (int i = 0; i < rowList.size(); i++) {
	    objSheet.autoSizeColumn(i);
	  } 	  
	  
	  response.setContentType("Application/Msexcel");
	  response.setHeader("Content-Disposition", "ATTachment; Filename="+URLEncoder.encode("테스트","UTF-8")+".xls");

	  OutputStream fileOut  = response.getOutputStream(); 
	  objWorkBook.write(fileOut);
	  fileOut.close();
	       
	  response.getOutputStream().flush();
	  response.getOutputStream().close();
	}
	

	
	/* 관리자  3-1. 전송기준설정 - 수신거부 */
	@RequestMapping(value="/ExcelRcvReject.do")
	public void ExcelPoi31(@ModelAttribute RcvaddrListVO rcvAddrVO, HttpServletResponse response, Model model) throws Exception {

	     HSSFWorkbook objWorkBook = new HSSFWorkbook();
	     HSSFSheet objSheet = null;
	     HSSFRow objRow = null;
	     HSSFCell objCell = null;       //셀 생성
	       
	        //제목 폰트
	  HSSFFont font = objWorkBook.createFont();
	  font.setFontHeightInPoints((short)9);
	  font.setBoldweight((short)Font.BOLDWEIGHT_BOLD);
	  font.setFontName("맑은고딕");
	  
	  //제목 스타일에 폰트 적용, 정렬
	        HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
	  styleHd.setFont(font);
	  styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	  styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

	  objSheet = objWorkBook.createSheet("첫번째 시트");     //워크시트 생성
	  
	  // 1행
	  objRow = objSheet.createRow(0);
	  objRow.setHeight ((short) 0x150);
	       
	  objCell = objRow.createCell(0);
	  objCell.setCellValue("이름");
	  objCell.setCellStyle(styleHd);
	  
	  objCell = objRow.createCell(1);
	  objCell.setCellValue("번호");
	  objCell.setCellStyle(styleHd);
	  
	  
	  
	  List<RcvaddrListVO> rowList = egovRcvaddrListService.rcvaddrList(rcvAddrVO);
	  
	  int index = 1;
	  for (RcvaddrListVO vo : rowList) {
	    objRow = objSheet.createRow(index);
	    objRow.setHeight((short) 0x150);

	    objCell = objRow.createCell(0);
	    objCell.setCellValue((String)vo.getRcv_title());
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(1);
	    objCell.setCellValue((String)vo.getRcv_number());
	    objCell.setCellStyle(styleHd);
 
	    index++;
	  }

	  for (int i = 0; i < rowList.size(); i++) {
	    objSheet.autoSizeColumn(i);
	  } 	  
	  
	  response.setContentType("Application/Msexcel");
	  response.setHeader("Content-Disposition", "ATTachment; Filename="+URLEncoder.encode("테스트","UTF-8")+".xls");

	  OutputStream fileOut  = response.getOutputStream(); 
	  objWorkBook.write(fileOut);
	  fileOut.close();
	       
	  response.getOutputStream().flush();
	  response.getOutputStream().close();
	}
	
	/* 관리자  3-2-1. 기준정보관리 - 부서정보관리 */
	@RequestMapping(value="/ExcelDeptManage.do")
	public void ExcelPoi321(@ModelAttribute DeptManageVO deptVO, HttpServletResponse response, Model model) throws Exception {

	     HSSFWorkbook objWorkBook = new HSSFWorkbook();
	     HSSFSheet objSheet = null;
	     HSSFRow objRow = null;
	     HSSFCell objCell = null;       //셀 생성
	       
	        //제목 폰트
	  HSSFFont font = objWorkBook.createFont();
	  font.setFontHeightInPoints((short)9);
	  font.setBoldweight((short)Font.BOLDWEIGHT_BOLD);
	  font.setFontName("맑은고딕");
	  
	  //제목 스타일에 폰트 적용, 정렬
	        HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
	  styleHd.setFont(font);
	  styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	  styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

	  objSheet = objWorkBook.createSheet("첫번째 시트");     //워크시트 생성
	  
	  // 1행
	  objRow = objSheet.createRow(0);
	  objRow.setHeight ((short) 0x150);
	       
	  objCell = objRow.createCell(0);
	  objCell.setCellValue("이름");
	  objCell.setCellStyle(styleHd);
	  
	  objCell = objRow.createCell(1);
	  objCell.setCellValue("번호");
	  objCell.setCellStyle(styleHd);
	  
	  
	  
	  List<DeptManageVO> rowList = egovDeptManageService.selectDeptManageList(deptVO);
	  
	  int index = 1;
	  for (DeptManageVO vo : rowList) {
	    objRow = objSheet.createRow(index);
	    objRow.setHeight((short) 0x150);

	    objCell = objRow.createCell(0);
	    objCell.setCellValue((String)vo.getOrgnztNm());
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(1);
	    objCell.setCellValue((String)vo.getOrgnztTel());
	    objCell.setCellStyle(styleHd);
 
	    index++;
	  }

	  for (int i = 0; i < rowList.size(); i++) {
	    objSheet.autoSizeColumn(i);
	  } 	  
	  
	  response.setContentType("Application/Msexcel");
	  response.setHeader("Content-Disposition", "ATTachment; Filename="+URLEncoder.encode("테스트","UTF-8")+".xls");

	  OutputStream fileOut  = response.getOutputStream(); 
	  objWorkBook.write(fileOut);
	  fileOut.close();
	       
	  response.getOutputStream().flush();
	  response.getOutputStream().close();
	}
	
	
	/* 관리자  3-2-2. 기준정보관리 - 기준정보설정 */
	@RequestMapping(value="/ExcelBasicInfo.do")
	public void ExcelPoi322(@ModelAttribute DeptJobBx deptJobVO, HttpServletResponse response, Model model) throws Exception {

	     HSSFWorkbook objWorkBook = new HSSFWorkbook();
	     HSSFSheet objSheet = null;
	     HSSFRow objRow = null;
	     HSSFCell objCell = null;       //셀 생성
	       
	        //제목 폰트
	  HSSFFont font = objWorkBook.createFont();
	  font.setFontHeightInPoints((short)9);
	  font.setBoldweight((short)Font.BOLDWEIGHT_BOLD);
	  font.setFontName("맑은고딕");
	  
	  //제목 스타일에 폰트 적용, 정렬
	        HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
	  styleHd.setFont(font);
	  styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	  styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

	  objSheet = objWorkBook.createSheet("첫번째 시트");     //워크시트 생성
	  
	  // 1행
	  objRow = objSheet.createRow(0);
	  objRow.setHeight ((short) 0x150);
	       
	  objCell = objRow.createCell(0);
	  objCell.setCellValue("이름");
	  objCell.setCellStyle(styleHd);
	  
	  objCell = objRow.createCell(1);
	  objCell.setCellValue("번호");
	  objCell.setCellStyle(styleHd);
	  
	  
	  
	  List<DeptJobBxVO> rowList = egovDeptJobService.selectDeptJobBxListAll();
	  
	  int index = 1;
	  for (DeptJobBxVO vo : rowList) {
	    objRow = objSheet.createRow(index);
	    objRow.setHeight((short) 0x150);

	    objCell = objRow.createCell(0);
	    objCell.setCellValue((String)vo.getDeptNm());
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(1);
	    objCell.setCellValue((String)vo.getDeptJobBxNm());
	    objCell.setCellStyle(styleHd);
 
	    index++;
	  }

	  for (int i = 0; i < rowList.size(); i++) {
	    objSheet.autoSizeColumn(i);
	  } 	  
	  
	  response.setContentType("Application/Msexcel");
	  response.setHeader("Content-Disposition", "ATTachment; Filename="+URLEncoder.encode("테스트","UTF-8")+".xls");

	  OutputStream fileOut  = response.getOutputStream(); 
	  objWorkBook.write(fileOut);
	  fileOut.close();
	       
	  response.getOutputStream().flush();
	  response.getOutputStream().close();
	}
	
	
	
	
	/* 관리자  2-1. 민원관리 */
	@RequestMapping(value="/ExcelComplain.do")
	public void ExcelPoi21(@ModelAttribute MessagingMoComplainVO moCompVO, HttpServletResponse response, Model model) throws Exception {

	     HSSFWorkbook objWorkBook = new HSSFWorkbook();
	     HSSFSheet objSheet = null;
	     HSSFRow objRow = null;
	     HSSFCell objCell = null;       //셀 생성
	       
	        //제목 폰트
	  HSSFFont font = objWorkBook.createFont();
	  font.setFontHeightInPoints((short)9);
	  font.setBoldweight((short)Font.BOLDWEIGHT_BOLD);
	  font.setFontName("맑은고딕");
	  
	  //제목 스타일에 폰트 적용, 정렬
	        HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
	  styleHd.setFont(font);
	  styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	  styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

	  objSheet = objWorkBook.createSheet("첫번째 시트");     //워크시트 생성
	  
	  // 1행
	  objRow = objSheet.createRow(0);
	  objRow.setHeight ((short) 0x150);
	       
	  objCell = objRow.createCell(0);
	  objCell.setCellValue("이름");
	  objCell.setCellStyle(styleHd);
	  
	  objCell = objRow.createCell(1);
	  objCell.setCellValue("번호");
	  objCell.setCellStyle(styleHd);
	  
	  
	  
	  List<MessagingMoComplainVO> rowList = egovMessagingMoComplainService.messagingMoComplainList(moCompVO);
	  
	  int index = 1;
	  for (MessagingMoComplainVO vo : rowList) {
	    objRow = objSheet.createRow(index);
	    objRow.setHeight((short) 0x150);

	    objCell = objRow.createCell(0);
	    objCell.setCellValue((String)vo.getMo_originator());
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(1);
	    objCell.setCellValue((String)vo.getMo_recipient());
	    objCell.setCellStyle(styleHd);
 
	    index++;
	  }

	  for (int i = 0; i < rowList.size(); i++) {
	    objSheet.autoSizeColumn(i);
	  } 	  
	  
	  response.setContentType("Application/Msexcel");
	  response.setHeader("Content-Disposition", "ATTachment; Filename="+URLEncoder.encode("테스트","UTF-8")+".xls");

	  OutputStream fileOut  = response.getOutputStream(); 
	  objWorkBook.write(fileOut);
	  fileOut.close();
	       
	  response.getOutputStream().flush();
	  response.getOutputStream().close();
	}
	

	/*2-2-1 문자투표결과 ExcelPollResult  /mng/*/
	@RequestMapping(value="/ExcelPollResult.do")
	public void ExcelPoi221(@ModelAttribute MessagingMoPollVO pollVO, HttpServletResponse response, Model model) throws Exception {

	     HSSFWorkbook objWorkBook = new HSSFWorkbook();
	     HSSFSheet objSheet = null;
	     HSSFRow objRow = null;
	     HSSFCell objCell = null;       //셀 생성
	       
	        //제목 폰트
	  HSSFFont font = objWorkBook.createFont();
	  font.setFontHeightInPoints((short)9);
	  font.setBoldweight((short)Font.BOLDWEIGHT_BOLD);
	  font.setFontName("맑은고딕");
	  
	  //제목 스타일에 폰트 적용, 정렬
	        HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
	  styleHd.setFont(font);
	  styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	  styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

	  objSheet = objWorkBook.createSheet("첫번째 시트");     //워크시트 생성
	  
	  // 1행
	  objRow = objSheet.createRow(0);
	  objRow.setHeight ((short) 0x150);
	       
	  objCell = objRow.createCell(0);
	  objCell.setCellValue("이름");
	  objCell.setCellStyle(styleHd);
	  
	  objCell = objRow.createCell(1);
	  objCell.setCellValue("번호");
	  objCell.setCellStyle(styleHd);
	  
	  
	  
	  List<MessagingMoPollVO> rowList = messagingMoPollService.selectSmsPollNewList(pollVO);
	  
	  int index = 1;
	  for (MessagingMoPollVO vo : rowList) {
	    objRow = objSheet.createRow(index);
	    objRow.setHeight((short) 0x150);

	    objCell = objRow.createCell(0);
	    objCell.setCellValue((String)vo.getReg_user_name());
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(1);
	    objCell.setCellValue((String)vo.getMo_recipient());
	    objCell.setCellStyle(styleHd);
 
	    index++;
	  }

	  for (int i = 0; i < rowList.size(); i++) {
	    objSheet.autoSizeColumn(i);
	  } 	  
	  
	  response.setContentType("Application/Msexcel");
	  response.setHeader("Content-Disposition", "ATTachment; Filename="+URLEncoder.encode("테스트","UTF-8")+".xls");

	  OutputStream fileOut  = response.getOutputStream(); 
	  objWorkBook.write(fileOut);
	  fileOut.close();
	       
	  response.getOutputStream().flush();
	  response.getOutputStream().close();
	}
	
	
/*2-2-2 문자투표현황조회 ExcelPollList  /mng/*/

	@RequestMapping(value="/ExcelPollList.do")
	public void ExcelPoi222(@ModelAttribute MessagingMoPollVO pollVO, HttpServletResponse response, Model model) throws Exception {

	     HSSFWorkbook objWorkBook = new HSSFWorkbook();
	     HSSFSheet objSheet = null;
	     HSSFRow objRow = null;
	     HSSFCell objCell = null;       //셀 생성
	       
	        //제목 폰트
	  HSSFFont font = objWorkBook.createFont();
	  font.setFontHeightInPoints((short)9);
	  font.setBoldweight((short)Font.BOLDWEIGHT_BOLD);
	  font.setFontName("맑은고딕");
	  
	  //제목 스타일에 폰트 적용, 정렬
	        HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
	  styleHd.setFont(font);
	  styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	  styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

	  objSheet = objWorkBook.createSheet("첫번째 시트");     //워크시트 생성
	  
	  // 1행
	  objRow = objSheet.createRow(0);
	  objRow.setHeight ((short) 0x150);
	       
	  objCell = objRow.createCell(0);
	  objCell.setCellValue("이름");
	  objCell.setCellStyle(styleHd);
	  
	  objCell = objRow.createCell(1);
	  objCell.setCellValue("번호");
	  objCell.setCellStyle(styleHd);
	  
	  
	  
	  List<MessagingMoPollVO> rowList = messagingMoPollService.selectSmsPollNewList(pollVO);
	  
	  int index = 1;
	  for (MessagingMoPollVO vo : rowList) {
	    objRow = objSheet.createRow(index);
	    objRow.setHeight((short) 0x150);

	    objCell = objRow.createCell(0);
	    objCell.setCellValue((String)vo.getReg_user_name());
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(1);
	    objCell.setCellValue((String)vo.getMo_recipient());
	    objCell.setCellStyle(styleHd);
 
	    index++;
	  }

	  for (int i = 0; i < rowList.size(); i++) {
	    objSheet.autoSizeColumn(i);
	  } 	  
	  
	  response.setContentType("Application/Msexcel");
	  response.setHeader("Content-Disposition", "ATTachment; Filename="+URLEncoder.encode("테스트","UTF-8")+".xls");

	  OutputStream fileOut  = response.getOutputStream(); 
	  objWorkBook.write(fileOut);
	  fileOut.close();
	       
	  response.getOutputStream().flush();
	  response.getOutputStream().close();
	}
	
	
	
/*2-3  전체수신내역 ExcelMoRcvList   /mng/*/

	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value="/excelGetAddrBook.do")
	public ExcelView Excel1(@ModelAttribute AddressBookVO adbkVO, ModelMap model) throws Exception {


        adbkVO.setPageUnit(egovPropertyService.getInt("pageUnit"));
        adbkVO.setPageSize(egovPropertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(adbkVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(adbkVO.getPageUnit());
        paginationInfo.setPageSize(adbkVO.getPageSize());

        adbkVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        adbkVO.setLastIndex(paginationInfo.getLastRecordIndex());
        adbkVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		

        List<AddressBookVO> adbklst = egovAddressBookService.selectAddressBookList(adbkVO);
       
        String[] excel_title = {"휴대전화"};
        String[] excel_column = {"address_num"};
        
        String filename = "휴대폰목록_" + DateTime.getDateString();
        model.addAttribute("file_name", filename);
        model.addAttribute("excel_title", excel_title);
        model.addAttribute("excel_column", excel_column);
        model.addAttribute("data_list", adbklst);
       
        return new ExcelView();
    }
	
	

	@RequestMapping(value="/excelGetAddrBook2.do")
	public ModelAndView excelAddrBookList(DeptManageVO paramVO, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
	    
		ModelAndView mav = new ModelAndView("excelView");
	    Map<String, Object> dataMap = new HashMap<String, Object>();

	    //dataMap = addrBookService.selectAddressBookList(paramVO); 
	    List<DeptManageVO> list = egovDeptManageService.selectDeptManageList(paramVO);
	    String filename = "공유주소록_" + DateTime.getDateString();
	    String[] columnArr = {"아이디", "소유자아이디", "그룹타입", "이름"};
	    String[] columnVarArr = {"address_id", "user_id", "address_type", "address_name"};
	            
	    dataMap.put("columnArr", columnArr);
	    dataMap.put("columnVarArr", columnVarArr);
	    dataMap.put("sheetNm", "공유주소록");    
	    dataMap.put("lists", list);
	    
	    mav.addObject("dataMap", dataMap);
	    mav.addObject("filename", filename);
	    
	    return mav;
	    
	    
	    
	    /****** MAP *********/
/*		List<Map> lists = new ArrayList<Map>(); 
		Map<String, String> mapUser = new HashMap<String, String>();
		mapUser = addrBookService.selectAddressBookList(AddressBookVO);
		lists.add(mapUser);
	 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category", lists);*/
		/*******************************/
		
		
		

/*		List<AddressBookVO> lists = new ArrayList<AddressBookVO>();
	 
		AddressBookVO users = new AddressBookVO();
	 
		//Map<String, String> mapCategory = new HashMap<String, String>();
		users.setId("0000000001");
		users.setName("Sample Test");
		users.setDescription("This is initial test data.");
		users.setUseYn("Y");
		users.setRegUser("test");
	 
		lists.add(users);
	 
		users.setId("0000000002");
		users.setName("test Name");
		users.setDescription("test Deso1111");
		users.setUseYn("Y");
		users.setRegUser("test");
	 
		lists.add(users);
	 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category", lists);
	 
		return new ModelAndView("categoryExcelView", "categoryMap", map); */
	    
	    
	}	
} 
