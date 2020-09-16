package egovframework.com.grp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.grp.service.AddrGroupVO;
import egovframework.com.grp.service.EgovAddrGroupService;
import egovframework.com.usr.add.service.EgovAddressBookService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EgovAddrGroupController {

	@Resource(name = "egovAddrGroupService")
    private EgovAddrGroupService egovAddrGroupService;
	
	@Resource(name = "egovAddressBookService")
    private EgovAddressBookService egovAddressBookService;
	
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
     
	/*
	 * 
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	*/
	
	@Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;
	
	/* 주소록 그룹에 대한 목록을 조회한다. */
	@IncludedInfo(name="주소록 그룹관리", order=380, gid=40)
	@RequestMapping("/grp/AddrGroupList.do")
	public ModelAndView addrGroupList(AddrGroupVO addrGroupVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<AddrGroupVO> addrGroupList = egovAddrGroupService.addrGroupList(addrGroupVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(addrGroupVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(addrGroupVO.getPageUnit());
        paginationInfo.setPageSize(addrGroupVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("addrGroupList", addrGroupList);
        
        return mav;
	}
	
	/* 주소록을 구분해서 가져와서 Tree구조로 만든다  0:개인  1:부서  2:공유  3:직원   */
	@RequestMapping("/grp/AddrGroupListByType.do")
	public ModelAndView addrGroupListByType(AddrGroupVO addrGroupVO) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		ModelAndView mav = new ModelAndView("jsonView");
		
		addrGroupVO.setUserid(user.getId());
		
		List<AddrGroupVO> addrGroupList = egovAddrGroupService.addrGroupList(addrGroupVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(addrGroupVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(addrGroupVO.getPageUnit());
        paginationInfo.setPageSize(addrGroupVO.getPageSize());
        
        mav.addObject("paginationInfo", paginationInfo);
        mav.addObject("data", addrGroupList); 
        System.out.println("----grouplist: --- " + addrGroupList );
        return mav;
	}
	
	
	
	/* 주소록 그룹에 대한 항목을 insert한다.*/
	@RequestMapping("/grp/AddrGroupInsert.do")
    public String addrGroupInsert(AddrGroupVO addrGroupVO) throws Exception {


		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		addrGroupVO.setUserid(user.getId());
		
		
		
		System.out.println("---addressGroup---:" + addrGroupVO);
		
		//Transaction
  		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 		

  			egovAddrGroupService.addrGroupInsert(addrGroupVO);
			
			txManager.commit(txStatus); 
			//정상일경우 COMMIT; 
			//model.put("result", 0); 
  		} catch (Exception e) { 
			e.printStackTrace();
			txManager.rollback(txStatus); 
			//에러날경우 CATCH로 빠져서 ROLLBACK; 
			//model.put("result", -1); 
  		}


        return "jsonView";
    }
	/* 주소록 그룹에 대한 항목을 insert한다.*/
	@RequestMapping("/grp/AddrGroupInserts.do")
	public @ResponseBody String addrGroupInserts(AddrGroupVO addrGroupVO) throws Exception {
		return egovAddrGroupService.addrGroupInsert(addrGroupVO);
	}

	
	/* 1Depth List */

	@RequestMapping("/grp/getNodeTop.do")
	public String getNodeListOneDepth(Model mo) throws Exception {
		
		AddrGroupVO addrG = new AddrGroupVO(); 
		addrG.setUserid("TEST1");
		addrG.setDepth(1);
	    //소속그룹리스트를 추출하여 가져온다.
	    List < AddrGroupVO > GroupList =  egovAddrGroupService.addrGroupList(addrG);
	    
	    // 루트노드를 하나 만들어준다.
	    List < Object > treeList = new ArrayList < Object > ();
	    //Map < String, Object > root = new HashMap < String, Object > ();
	    //Map < String, Boolean > rootState = new HashMap < String, Boolean > (); 
	    
	    // 각 메뉴를 리스트에 넣어준다.
	    for (AddrGroupVO ag: GroupList) {
	        Map < String, Object > tree = new HashMap < String, Object > ();
	        Map < String, Boolean > state = new HashMap < String, Boolean > ();
	        tree.put("id", String.valueOf(ag.getCode()));
	        tree.put("parent", String.valueOf(ag.getParent()));
	        tree.put("text", ag.getTitle());
	        state.put("opened", ag.getDepth() == 1 ? true : false);
	        tree.put("state", state);
	        treeList.add(tree);
	    } 
	    
	    ObjectMapper mapper = new ObjectMapper();
	    String jsonString = mapper.writeValueAsString(treeList);
	    System.out.println("-----jsonString:" + jsonString); 
	    mo.addAttribute(jsonString); 
	    //return jsonString;
	    return "jsonView"; 
	}
	
	/* 관리자 공유주소록 GROUP TREE */
	@RequestMapping("/grp/getNode.do")
	public String getNodeList(Model mo) throws Exception {

	    /*
		AddrGroupVO addrG = new AddrGroupVO();
		
		
		addrG.setUserid("TEST1");
	    //소속그룹리스트를 추출하여 가져온다.
	    //List < AddrGroupVO > GroupList =  egovAddrGroupService.addrGroupList(addrG);
	    
	    // 루트노드를 하나 만들어준다.
	    List < Object > treeList = new ArrayList < Object > ();
	    Map < String, Object > root = new HashMap < String, Object > ();
	    Map < String, Boolean > rootState = new HashMap < String, Boolean > ();
	    root.put("id", "0");
	    root.put("parent", "#");
	    root.put("text", "전체");
	    rootState.put("opened", true);
	    root.put("state"," rootState);
	    treeList.add(root);
	    
	    // 각 메뉴를 리스트에 넣어준다.
	    for (AddrGroupVO ag: GroupList) {
	        Map < String, Object > tree = new HashMap < String, Object > ();
	        Map < String, Boolean > state = new HashMap < String, Boolean > ();
	        tree.put("id", String.valueOf(ag.getCode()));
	        tree.put("parent", String.valueOf(ag.getParent()));
	        tree.put("text", ag.getTitle());
	        state.put("opened", ag.getDepth() == 1 ? true : false);
	        tree.put("state", state);
	        treeList.add(tree);
	    }
	    
	    [{"id":1,"text":"전체","children":true}]
	    
	    
	    ObjectMapper mapper = new ObjectMapper();
	    String jsonString = mapper.writeValueAsString(treeList);
	    System.out.println("-----jsonString:" + jsonString);


	    mo.addAttribute(jsonString);
	    
	    */
	    //return jsonString;
	    return "jsonView";
	}
	
	
	
	
	
	/* 그룹 TreeMenu */
	@RequestMapping("/grp/AddrGroupSelectOne.do")
    public ModelAndView addressGroupSelectOne(AddrGroupVO addrG) throws Exception {  
        /* 
         * param 관리자 USERID, 공유그룹 2
         * 
         */
	    List<Map<String, Object>> treeList = new ArrayList<Map<String, Object>>();
	       
 
        /*addrG.setSearchCnd("USERID");
	    addrG.setSearchWrd("TEST1");*/
	    addrG.setUserid("TEST1");
	       
	    List<AddrGroupVO> glist = new ArrayList<AddrGroupVO>();
	    glist = egovAddrGroupService.addrGroupList(addrG);
	     
	    for( AddrGroupVO grp : glist) { 
	    	
	    	Map<String, Object> child = new HashMap<String, Object>();
	    	child.put("id", grp.getCode());  
	    	child.put("text", grp.getTitle());  
	    	String childnode = "";
	    	if( grp.getDepth()== 1 ) {
	    		childnode = "false"; 
	    	}else {
	    		childnode = "true"; 
	    	}
	    	child.put("children", childnode);
	    	
	    	treeList.add(child);
	    }
	    
        System.out.println("--------------treeMenu : " + treeList );
	    ModelAndView mav = new ModelAndView("jsonView");
	    mav.addObject("data",treeList);
	    
        return mav;
    }

	
	
	  
	/* 주소록 그룹에 대한 항목을 update 한다.*/
	@RequestMapping("/grp/AddrGroupUpdate.do")
    public String addrGroupUpdate(AddrGroupVO addrGroupVO) throws Exception {
		egovAddrGroupService.addrGroupUpdate(addrGroupVO);
        return "jsonView";
    } 
	@RequestMapping("/grp/AddrGroupUpdateName.do")
	public String addrGroupUpdateName(AddrGroupVO addrGroupVO) throws Exception {
		egovAddrGroupService.addrGroupUpdateName(addrGroupVO);
		return "jsonView";
	}
	@RequestMapping("/grp/AddrGroupUpdateSequence.do")
	public String addrGroupUpdateSequence(AddrGroupVO addrGroupVO) throws Exception {
		egovAddrGroupService.addrGroupUpdateSequence(addrGroupVO);
		return "jsonView";
	}
	
	/* 주소록 그룹에 대한 항목을 delete 한다.*/
	@RequestMapping("/grp/AddrGroupDelete.do")
    public String addrGroupDelete(AddrGroupVO addrGroupVO) throws Exception {
		egovAddrGroupService.addrGroupDelete(addrGroupVO);
        return "jsonView";
    }
	
	/* 주소록 그룹에 대한 항목을 insert한다.*/
	@PostMapping("/grp/AddrGroupDeleteSell.do")
	public @ResponseBody String addrGroupDeletes(AddrGroupVO addrGroupVO) throws Exception {
		return egovAddrGroupService.addrGroupDeletes(addrGroupVO);
	}
}
