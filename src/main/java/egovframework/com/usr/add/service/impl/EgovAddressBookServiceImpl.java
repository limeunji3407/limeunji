package egovframework.com.usr.add.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.usr.add.service.AddressBook;
import egovframework.com.usr.add.service.AddressBookVO;
import egovframework.com.usr.add.service.EgovAddressBookService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 주소록정보를 관리하기 위한 서비스 구현  클래스
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
 *
 * </pre>
 */
@Service("egovAddressBookService")
public class EgovAddressBookServiceImpl extends EgovAbstractServiceImpl implements EgovAddressBookService{

    
    @Resource(name = "AddressBookDAO")
    private AddressBookDAO adbkDAO;
    
    @Resource(name = "egovAdbkIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "egovAdbkUserIdGnrService")
    private EgovIdGnrService idgenService2;
    /**
     * 주소록 목록을 조회한다.
     * @param AddressBookVO
     * @return  Map<String, Object>
     * @exception Exception
     */
    public   List<AddressBookVO>   selectAddressBookListAll(AddressBookVO adbkVO) throws Exception {
      
    	 List<AddressBookVO>  result1 = adbkDAO.selectAddressBookListAll(adbkVO); 
/*
        int cnt = adbkDAO.selectAddressBookListCnt(adbkVO);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultCnt", Integer.toString(cnt));
        map.put("result", result1);*/
        return result1;    
    }  
    
    /**
     * 주소록 목록을 조회한다.
     * @param AddressBookVO
     * @return  Map<String, Object>
     * @exception Exception
     */
    public List<AddressBookVO> selectAddressBookList(AddressBookVO adbkVO) throws Exception {
     
    	List<AddressBookVO> result = adbkDAO.selectAddressBookList(adbkVO);

        //int cnt = adbkDAO.selectAddressBookListCnt(adbkVO);

        //map.put("resultCnt", Integer.toString(cnt));

        return result;    
    }    
    
    /**
     * 주소록 정보를 삭제한다.
     * @param AddressBook
     * @return 
     * @exception Exception
     */
    public void deleteAddressBook(AddressBook addressBook) throws Exception {        
        adbkDAO.deleteAddressBook(addressBook);        
    }
    
    /**
     * 주소록 정보를 삭제한다. 전체
     * @param AddressBook
     * @return 
     * @exception Exception
     */
    public void deleteAddressBookAll(AddressBook addressBook) throws Exception {        
    	adbkDAO.deleteAddressBookAll(addressBook);        
    }
    public void deleteUserDetail(AddressBook addressBook) throws Exception {        
    	adbkDAO.deleteUserDetail(addressBook);        
    }

    /**
     * 주소록 정보를 등록한다.
     * @param AddressBookVO
     * @return M
     * @exception Exception
     */
    public void insertAddressBook(AddressBookVO adbkVO) throws Exception {
           
        adbkDAO.insertAddressBook(adbkVO);       
        
        for(int i = 0; i < adbkVO.getAdbkMan().size(); i++){            
            adbkVO.getAdbkMan().get(i).setUser_id(idgenService2.getNextStringId());
            adbkVO.getAdbkMan().get(i).setAddress_id(adbkVO.getAddress_id());
            adbkDAO.insertAddressBook(adbkVO.getAdbkMan().get(i));
        }        
    }


    /**
     * 주소록 정보를 수정한다.
     * @param AddressBookVO
     * @return M
     * @exception Exception
     */
    public void updateAddressBook(AddressBookVO adbkVO) throws Exception {
           
        adbkDAO.updateAddressBook(adbkVO);       
        
        for(int i = 0; i < adbkVO.getAdbkMan().size(); i++){            
            adbkVO.getAdbkMan().get(i).setUser_id(idgenService2.getNextStringId());
            adbkVO.getAdbkMan().get(i).setAddress_id(adbkVO.getAddress_id());
            adbkDAO.insertAddressBook(adbkVO.getAdbkMan().get(i));
        }        
    }

	@Override
	public List<AddressBookVO> selectAddressBooks(AddressBookVO adbkVO) throws Exception {
		return adbkDAO.selectAddressBooks(adbkVO);        
	}
	@Override
	public void insertAddressCopyList(AddressBookVO adbkVO) throws Exception {
		adbkDAO.insertAddressCopyList(adbkVO);        
	}

	@Override
	public AddressBookVO serchEmpAddr(AddressBookVO addrVO) throws Exception {
		return adbkDAO.serchEmpAddr(addrVO);
	}
	 
}
