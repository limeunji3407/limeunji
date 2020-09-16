package egovframework.com.msg.mys.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.msg.mys.service.EgovMySaveService;
import egovframework.com.msg.mys.service.MySaveVO;

@Controller
public class EgovMySaveController {

	@Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;
	
	@Resource(name = "egovMySaveService")
	private EgovMySaveService egovMySaveService;
	
	// 내 저장함 insert
	@RequestMapping(value="/usr/insertMySave")
	public ModelAndView insertMySave(MySaveVO mySaveVO) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");

        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(); 
        mySaveVO.setUserId(user.getId());
		
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
      	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
      	TransactionStatus txStatus = txManager.getTransaction(def); 
      	try{ 		
      		egovMySaveService.insertMySave(mySaveVO);     		   		
      		txManager.commit(txStatus); 
      		mav.addObject("data", 0);
      	} catch (Exception e) { 
      		e.printStackTrace();
      		txManager.rollback(txStatus); 
      		mav.addObject("data", 1);
      	} 
		
		return mav;
	}
	
	// 단문저장함
	@RequestMapping(value ="/getMySaveS.do")
	public ModelAndView getMySaveS(MySaveVO mySaveVO) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		mySaveVO.setStatus("S");
		List<MySaveVO> list = egovMySaveService.MySaveList(mySaveVO);
		mav.addObject("data", list);
		return mav;
	}
	
	// 장문저장함
	@RequestMapping(value ="/getMySaveL.do")
	public ModelAndView getMySaveL(MySaveVO mySaveVO) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		mySaveVO.setStatus("L");
		List<MySaveVO> list = egovMySaveService.MySaveList(mySaveVO);
		mav.addObject("data", list);
		return mav;
	}
	
	// 멀티저장함
	@RequestMapping(value ="/getMySaveM.do")
	public ModelAndView getMySaveM(MySaveVO mySaveVO) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		mySaveVO.setStatus("M");
		List<MySaveVO> list = egovMySaveService.MySaveList(mySaveVO);
		mav.addObject("data", list);
		return mav;
	}
	
	// 친구톡저장함
	@RequestMapping(value ="/getMySaveF.do")
	public ModelAndView getMySaveF(MySaveVO mySaveVO) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		mySaveVO.setStatus("F");
		List<MySaveVO> list = egovMySaveService.MySaveList(mySaveVO);
		mav.addObject("data", list);
		return mav;
	}
	
	// 경조사저장함
	@RequestMapping(value ="/getMySaveC.do")
	public ModelAndView getMySaveC(MySaveVO mySaveVO) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		mySaveVO.setStatus("C");
		List<MySaveVO> list = egovMySaveService.MySaveList(mySaveVO);
		mav.addObject("data", list);
		return mav;
	}
	
	@RequestMapping(value="/deleteMySave.do")  
	public ModelAndView deleteMySave(MySaveVO mySaveVO) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
      	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
      	TransactionStatus txStatus = txManager.getTransaction(def); 
      	try{ 		

      		egovMySaveService.deleteMySave(mySaveVO);     				
      		txManager.commit(txStatus); 
      		mav.addObject("data", 0);
      	} catch (Exception e) { 
      		e.printStackTrace();
      		txManager.rollback(txStatus); 
      		mav.addObject("data", 1);
      	} 
		
		return mav;
	}
}