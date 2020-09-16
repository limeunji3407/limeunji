package egovframework.com.msg.mol.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.msg.mol.service.EgovMessagingMoListService;
import egovframework.com.msg.mop.service.MessagingMoListVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class EgovMessagingMoListController {
	
	@Resource(name = "egovMessagingMoListService")
    private EgovMessagingMoListService messagingMoListService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;  
 
    
    /*
     * 민원 문자투표 리스트업자료
     */
	@RequestMapping("/getmolistall.do")
	public ModelAndView moListAllAjax(MessagingMoListVO molist) throws Exception {

		ModelAndView mav = new ModelAndView("jsonView");
		
		List<MessagingMoListVO> mlist = messagingMoListService.msgMoListAll(molist);
		
        System.out.println("------MO_LIST:" + mlist.get(0).getMo_recipient() ); 
        
        mav.addObject("data", mlist); 
        return mav;
	}    
    
}
