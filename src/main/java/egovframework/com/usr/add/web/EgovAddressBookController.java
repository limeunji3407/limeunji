package egovframework.com.usr.add.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.grp.service.AddrGroupVO;
import egovframework.com.grp.service.EgovAddrGroupService;
import egovframework.com.usr.add.service.AddressBook;
import egovframework.com.usr.add.service.AddressBookVO;
import egovframework.com.usr.add.service.EgovAddressBookService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 주소록정보를 관리하기 위한 컨트롤러 클래스
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
 *   2009.9.25  윤성록         최초 생성
 *   2011.8.26	정진오		  IncludedInfo annotation 추가
 *   2016.12.13 최두영         클래스명 변경
 * </pre>
 */

@Controller
public class EgovAddressBookController { 
 
    @Resource(name = "egovAddressBookService")
    private EgovAddressBookService adbkService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    

    @Resource(name = "egovAddrGroupService")
    private EgovAddrGroupService groupService;
    
    @Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;
    /**
     * 주소록 정보에 대한 목록을 조회한다.
     *
     * @param adbkVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @IncludedInfo(name="주소록관리", order = 1500, gid = 500)
    @RequestMapping("/usr/adkbU.do")
    public String addressMain(@ModelAttribute("searchVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
    	return "egovframework/com/usr/adr/EgovAddressBook";
    }
    /* 탭1 */
    @RequestMapping("/usr/addressbookmy.do")
    public String addressMy(@ModelAttribute("searchVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
    	return "egovframework/com/usr/adr/EgovAddressMy";
    }
    /* 탭2 */
    @RequestMapping("/usr/addressbookpart.do")
    public String addressPart(@ModelAttribute("searchVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
    	return "egovframework/com/usr/adr/EgovAddressPart";
    }
    /* 탭3 */
    @RequestMapping("/usr/addressbookshare.do")
    public String addressShare(@ModelAttribute("searchVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
    	return "egovframework/com/usr/adr/EgovAddressShare";
    }
    /* 탭4 */
    @RequestMapping("/usr/addressbookemploy.do")
    public String addressEmploy(@ModelAttribute("searchVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
    	return "egovframework/com/usr/adr/EgovAddressEmploy";
    }

    @RequestMapping("/getaddressbook.do")
    public String usrGetAddress(@ModelAttribute("searchVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
    	List<AddressBookVO> list = adbkService.selectAddressBookListAll(adbkVO); 
        System.out.println("----getaddresss:------" + list);
        model.addAttribute("data", list);
    	return "jsonView";
    } 
   
    /* 그룹별주소록 */
    
    /* 그룹명으로 검색 */
    @RequestMapping("/getaddressbookgroup.do")
    public String usrGetAddressMGroup(@ModelAttribute("AddressBookVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
        /* USERID */
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	adbkVO.setAddress_type("0");
    	adbkVO.setUser_id(user.getId());
    	System.out.println("--------client data:" + adbkVO.getAddress_grp_name() + adbkVO.getAddress_type());
    	List<AddressBookVO> list  = adbkService.selectAddressBookList(adbkVO); 
        System.out.println("----getaddresss group:------" + list);
        model.addAttribute("data", list);
    	return "jsonView";
    } 
    
    
    /* 개인주소록 */
    @RequestMapping("/getaddressbookmy.do")
    public String usrGetAddressMy(@ModelAttribute("searchVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
        /* USERID */
    	System.out.println("--------client data:" + adbkVO.getAddress_group());
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	adbkVO.setAddress_type("0");
    	adbkVO.setUser_id(user.getId());
    	List<AddressBookVO> list  = adbkService.selectAddressBookList(adbkVO); 
        System.out.println("----getaddresss my:------" + list);
        model.addAttribute("data", list);
    	return "jsonView";
    } 

    /* 부서주소록 */
    @RequestMapping("/getaddressbookpart.do")
    public String usrGetAddressPart(@ModelAttribute("searchVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
        /* USER가 속한 부서*/
    	System.out.println("--------client data:" + adbkVO.getAddress_group() + ":" + adbkVO.getPart_id());
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	adbkVO.setAddress_type("1");
    	adbkVO.setUser_id(user.getId());
    	List<AddressBookVO> list  = adbkService.selectAddressBookList(adbkVO); 
        System.out.println("----getaddresss part:------" + list);
        model.addAttribute("data", list);
    	return "jsonView";
    }   

    /* 공유주소록 */
    @RequestMapping("/getaddressbookshare.do")
    public String usrGetAddressShare(@ModelAttribute("searchVO")  AddressBookVO adbkVO, ModelMap model) throws Exception {
    
    	
        /* 관리자가 올린 공유주소록 */
    	System.out.println("--------client data:" + adbkVO.getAddress_group());
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	adbkVO.setAddress_type("2");
    	adbkVO.setUser_id(user.getId());
    	List<AddressBookVO> list  = adbkService.selectAddressBookList(adbkVO); 
        System.out.println("----getaddresss share:------" + list);
        model.addAttribute("data", list);
    	return "jsonView";
    }  
    
    /* 직원주소록 */
    @RequestMapping("/getaddressbookemploy.do")
    public String usrGetAddressEmploy(@ModelAttribute("searchVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
        /* 직원의 주소록 */
    	System.out.println("--------client data:" + adbkVO.getAddress_group());
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	adbkVO.setAddress_type("3");
    	adbkVO.setUser_id(user.getId());
    	List<AddressBookVO> list  = adbkService.selectAddressBookList(adbkVO); 
        System.out.println("----getaddresss employ:------" + list);
        model.addAttribute("data", list);
    	return "jsonView";
    }  
    
    
    
    @IncludedInfo(name="주소록관리", order = 380, gid = 40)
    @RequestMapping("/usr/addressbookS.do")
    public ModelAndView selectAdressBookList(@ModelAttribute("searchVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
    	
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        ModelAndView mav = new ModelAndView();

        if(!isAuthenticated) {
        	mav.setViewName("egovframework/com/uat/uia/EgovLoginUsr");
            return mav;
        }

        adbkVO.setPageUnit(propertyService.getInt("pageUnit"));
        adbkVO.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(adbkVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(adbkVO.getPageUnit());
        paginationInfo.setPageSize(adbkVO.getPageSize());

        adbkVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        adbkVO.setLastIndex(paginationInfo.getLastRecordIndex());
        adbkVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        adbkVO.setUser_id(user.getId());
        adbkVO.setPart_id(user.getOrgnztId());

        List<AddressBookVO> adbklst = adbkService.selectAddressBookList(adbkVO);

        Map<String, Object> map = new HashMap<String, Object>(); 
        
        int totCnt = Integer.parseInt((String)map.get("resultCnt"));


        paginationInfo.setTotalRecordCount(totCnt);

        mav.addObject("resultList1", map.get("resultList1"));
        mav.addObject("resultList2", map.get("resultList2"));
        mav.addObject("resultList3", map.get("resultList3"));
        mav.addObject("resultList4", map.get("resultList4"));
        mav.addObject("resultCnt", map.get("resultCnt"));
        mav.addObject("userId", user.getId());
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data",adbklst);
        mav.setViewName("egovframework/com/usr/add/EgoInsAddr");

        return mav;
    }
    



    @RequestMapping("/mng/adr/EgovAddrBookShare.do")
    public ModelAndView selectAdressBookListMng(@ModelAttribute("AddressBookVO") AddressBookVO adbkVO, ModelMap model) throws Exception {
    	 LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

         Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
         
         ModelAndView mav = new ModelAndView();

         if(!isAuthenticated) {
         	mav.setViewName("egovframework/com/uat/uia/EgovLoginUsr");
             return mav;
         }
 		
         adbkVO.setPageUnit(propertyService.getInt("pageUnit"));
         adbkVO.setPageSize(propertyService.getInt("pageSize"));

         PaginationInfo paginationInfo = new PaginationInfo();

         paginationInfo.setCurrentPageNo(adbkVO.getPageIndex());
         paginationInfo.setRecordCountPerPage(adbkVO.getPageUnit());
         paginationInfo.setPageSize(adbkVO.getPageSize());

         adbkVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
         adbkVO.setLastIndex(paginationInfo.getLastRecordIndex());
         adbkVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
         adbkVO.setUser_id(user.getId());
         adbkVO.setPart_id(user.getOrgnztId());
         
         
         List<AddressBookVO> adbkLst = adbkService.selectAddressBookList(adbkVO);
         
         mav.addObject("paginationInfo", paginationInfo); 
         mav.addObject("data", adbkLst); 
         System.out.println("-------mng/share:" + adbkLst);
         
         

         AddrGroupVO grVO = new AddrGroupVO();
         List<AddrGroupVO> groupList = groupService.addrGroupList(grVO);
         mav.addObject("groupList", groupList);
         
         
         
         mav.setViewName("egovframework/com/mng/adr/EgovAddrBookShare");
         return mav;
    }
    
    

    /**
     * 주소록의 구성원을 추가한다.
     *
     * @param userVO
     * @param adbkVO
     * @param checkCnd
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping("/usr/add/addUser.do")
    public ModelAndView addUser(AddressBookVO adbkVO,  HttpServletRequest request) throws Exception {

    	ModelAndView mav = new ModelAndView("jsonView");
    	
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        if(!isAuthenticated) {
            mav.setViewName("egovframework/com/uat/uia/EgovLoginUsr");
            
            return mav;
        }
        
        System.out.println(adbkVO.getAddress_name());
        
        Date today = new Date();
        DateFormat format = new SimpleDateFormat("yy/MM/dd");
    	
        adbkVO.setUser_id(user.getId());
        adbkVO.setAddress_date(format.format(today));
    	
		System.out.println("-------insertNumber : " + adbkVO.getAddress_num());
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			adbkService.insertAddressBook(adbkVO);
			txManager.commit(txStatus);
			//정상일경우 COMMIT; 
			//model.addAttribute("", 0); 
			mav.addObject("data", 0);
  		} catch (Exception e) { 
			//e.printStackTrace();
			txManager.rollback(txStatus); 
			//에러날경우 CATCH로 빠져서 ROLLBACK; 
			//model.addAttribute("data", -1);
			mav.addObject("data", 1);
  		}
	 
	  return mav;
    }
	
	@RequestMapping("/usr/InsertaddressU.do")
	public ModelAndView InsertReceiptrefusal (AddressBookVO adbkVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	Date today = new Date();
        DateFormat format = new SimpleDateFormat("yy/MM/dd");
    	
        adbkVO.setUser_id(user.getId());
        adbkVO.setAddress_date(format.format(today));
    	
		System.out.println("-------insertNumber : " + adbkVO.getAddress_num() );
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			adbkService.insertAddressBook(adbkVO);
			txManager.commit(txStatus);
			//정상일경우 COMMIT; 
			//model.addAttribute("", 0); 
			mav.addObject("data", 0);
  		} catch (Exception e) { 
			//e.printStackTrace();
			txManager.rollback(txStatus); 
			//에러날경우 CATCH로 빠져서 ROLLBACK; 
			//model.addAttribute("data", -1);
			mav.addObject("data", 1);
  		}
	 
	  return mav;
	}

	//(value="/testpost", method=RequestMethod.POST)
    /*
     * 
     * data[45][address_capy]=N&
     * data[45][address_type]=&
     * data[45][address_name]=test2&
     * data[45][address_num]=01012345678&
     * data[45][address_ect]=3333&
     * action=edit
     * 
     */
	@RequestMapping("/updateaddressbook.do") 
	public String updateAddressBook (HttpServletRequest  req, AddressBookVO adbkVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	Date today = new Date();
        DateFormat format = new SimpleDateFormat("yy/MM/dd");
    	
        adbkVO.setUser_id(user.getId());
        adbkVO.setAddress_date(format.format(today)); 
        
 
        String[] pArrName = new String[6];
        
     	@SuppressWarnings("rawtypes")
		Enumeration eParam = req.getParameterNames(); 
  
     	int i =0;
    	while ( eParam.hasMoreElements()) {
    	  String pName = (String)eParam.nextElement();
    	  String pValue = req.getParameter(pName);
    	  
    	  
  			System.out.println(pName + " : " + pValue);
  			//pArrName[i][0] = pName;
  			pArrName[i] = pValue;
  	     	i++;
    	} 
    	adbkVO.setAddress_capy(pArrName[0]);
 		adbkVO.setAddress_id(pArrName[1]);
 		adbkVO.setAddress_name(pArrName[2]);
 		adbkVO.setAddress_num(pArrName[3]);
 		adbkVO.setAddress_ect(pArrName[4]); 
    	
    	
		System.out.println(
				"-------UPDATE : " + adbkVO.getAddress_capy() + 
				":id =" + adbkVO.getAddress_id() +
				":name = " + adbkVO.getAddress_name() +
				":num =" + adbkVO.getAddress_num() +
				":ect =" + adbkVO.getAddress_ect()
		);
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			adbkService.updateAddressBook(adbkVO);
			txManager.commit(txStatus);
			//정상일경우 COMMIT; 
			//model.addAttribute("", 0); 
			mav.addObject("data", 0);
			
  		} catch (Exception e) { 
			//e.printStackTrace();
			txManager.rollback(txStatus); 
			//에러날경우 CATCH로 빠져서 ROLLBACK; 
			//model.addAttribute("data", -1);
			mav.addObject("data", 1);
  		} 
	 
	  return "jsonView";
	}	
	
	
	
	
    /**
     * 주소록의 구성원을 삭제한다.
     *
     * @param userVO
     * @param adbkVO
     * @param checkCnd
     * @param checkWord
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/usr/add/deleteUser.do")
    public ModelAndView deleteUser(AddressBook addressBook, HttpServletRequest request) throws Exception {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			adbkService.deleteAddressBook(addressBook);
			txManager.commit(txStatus); 
			mav.addObject("data", 0);
  		} catch (Exception e) { 
			txManager.rollback(txStatus); 
			mav.addObject("data", 1);
  		}
	 
	  return mav;
    }
    
    /**
     * 주소록의 구성원을 삭제한다. 전체
     *
     * @param userVO
     * @param adbkVO
     * @param checkCnd
     * @param checkWord
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/usr/add/deleteUserAll.do")
    public ModelAndView deleteUserAll(@RequestBody AddressBook addressBook, HttpServletRequest request) throws Exception {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
    	TransactionStatus txStatus = txManager.getTransaction(def); 
    	try{ 	
    		adbkService.deleteAddressBookAll(addressBook);
    		txManager.commit(txStatus);
    		mav.addObject("data", 0);
    	} catch (Exception e) { 
    		//e.printStackTrace();
    		txManager.rollback(txStatus); 
    		mav.addObject("data", 1);
    	}
    	return mav;
    }
    /**
     * 주소록의 구성원을 삭제한다. 전체
     *
     * @param userVO
     * @param adbkVO
     * @param checkCnd
     * @param checkWord
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/usr/add/deleteUserDetail.do")
    public ModelAndView deleteUserDetail(@RequestBody AddressBook addressBook, HttpServletRequest request) throws Exception {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
    	TransactionStatus txStatus = txManager.getTransaction(def); 
    	try{ 	
    		adbkService.deleteUserDetail(addressBook);
    		txManager.commit(txStatus);
    		mav.addObject("data", 0);
    	} catch (Exception e) { 
    		//e.printStackTrace();
    		txManager.rollback(txStatus); 
    		mav.addObject("data", 1);
    	}
    	return mav;
    }
    
    /**
     * 카피할 address_id 리스트
     * @param adbkVO
     * @return
     * @throws Exception
     */
    @PostMapping("/usr/copy/createUser.do")
    public ModelAndView copyUser(@RequestBody AddressBookVO adbkVO) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			List<AddressBookVO> addressBookVoList = adbkService.selectAddressBooks(adbkVO);
  			for(int i = 0 ; i < addressBookVoList.size() ; i++) {
  				addressBookVoList.get(i).setUser_id(adbkVO.getUser_id());
  				addressBookVoList.get(i).setAddress_grp_name(adbkVO.getAddress_grp_name());
  				addressBookVoList.get(i).setAddress_category(adbkVO.getAddress_category());
  				addressBookVoList.get(i).setPart_id(adbkVO.getPart_id());
  				addressBookVoList.get(i).setAddress_type(adbkVO.getAddress_type());
  			}
  			adbkVO.setAddressBookVoList(addressBookVoList);
  			adbkService.insertAddressCopyList(adbkVO);
  			
			txManager.commit(txStatus);
			mav.addObject("data", 0);
  		} catch (Exception e) { 
			txManager.rollback(txStatus); 
			mav.addObject("data", 1);
  		}
	  return mav;
    }
    
    @RequestMapping("/serchEmpAddr.do")
    public ModelAndView serchEmpAddr(AddressBookVO adbkVO) throws Exception{
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	AddressBookVO empaddr = adbkService.serchEmpAddr(adbkVO);
    	
    	mav.addObject("empaddr", empaddr);
    	
    	return mav;
    }

}
