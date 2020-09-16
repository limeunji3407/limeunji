/**
 * 개요
 * - 메인화면이미지에 대한 controller 클래스를 정의한다.
 *
 * 상세내용
 * - 메인화면이미지에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * - 메인화면이미지의 조회기능은 목록조회, 상세조회로 구분된다.
 * @author 이문준
 * @version 1.0
 * @created 03-8-2009 오후 2:08:57
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2010.8.3	이문준          최초 생성
 *  2011.8.26	정진오			IncludedInfo annotation 추가
 *
 *  </pre>
 */

package egovframework.com.uss.ion.msi.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
/*import egovframework.com.uss.ion.bnr.service.Banner;*/
import egovframework.com.uss.ion.msi.service.EgovMainImageService;
import egovframework.com.uss.ion.msi.service.MainImage;
import egovframework.com.uss.ion.msi.service.MainImageVO;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class EgovMainImageController {

	@Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name="EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name="EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    /** Message ID Generation */
    @Resource(name="egovMainImageIdGnrService")
    private EgovIdGnrService egovMainImageIdGnrService;

    @Resource(name = "egovMainImageService")
    private EgovMainImageService egovMainImageService;
    
    @Resource(name = "txManager") 
	protected DataSourceTransactionManager txManager;

    @Autowired
	private DefaultBeanValidator beanValidator;

    /**
	 * 메인화면이미지 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/uss/ion/msi/selectMainImageListView.do")
    public String selectMainImageListView() throws Exception {

        return "egovframework/com/uss/ion/msi/EgovMainImageList";
    }

	/**
	 * 메인화면이미지정보를 관리하기 위해 등록된 메인화면이미지 목록을 조회한다.
	 * @param mainImageVO - 메인이미지 VO
	 * @return String - 리턴 Url
	 */
    @IncludedInfo(name="메인이미지관리", order = 770 ,gid = 50)
    //@RequestMapping("/uss/ion/msi/selectMainImageList.do")
    @RequestMapping("/mng/logolist.do")
	public String selectMainImageList(@ModelAttribute("mainImageVO") MainImageVO mainImageVO,
                                       ModelMap model) throws Exception {

    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(mainImageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(mainImageVO.getPageUnit());
		paginationInfo.setPageSize(mainImageVO.getPageSize());

		mainImageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mainImageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mainImageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		mainImageVO.setMainImageList(egovMainImageService.selectMainImageList(mainImageVO));

		model.addAttribute("mainImageList", mainImageVO.getMainImageList());

        int totCnt = egovMainImageService.selectLoginScrinImageListTotCnt(mainImageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

        //return "egovframework/com/uss/ion/msi/EgovMainImageList";
        return "egovframework/com/mng/sts/EgovLogoList";
	}

    @RequestMapping("/getLogoList.do")
	public String selectMainImageListAjax(@ModelAttribute("mainImageVO") MainImageVO mainImageVO,
                                       ModelMap model) throws Exception {
    	
    	mainImageVO.setRecordCountPerPage(999999);
    	
    	if(mainImageVO.getLocation() != null && !"".equals(mainImageVO.getLocation())) {
    		List<MainImageVO> list = new ArrayList<MainImageVO>();
    		String[] strs = mainImageVO.getLocation().split(",");
        	for(int  i = 0 ; i < strs.length ; i++ ) {
        		MainImageVO temp = new MainImageVO();
        		temp.setLocation(strs[i]);
        		list.add(temp);
        	}
        	mainImageVO.setMainImageList(list);
    	}
    	
    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(mainImageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(mainImageVO.getPageUnit());
		paginationInfo.setPageSize(mainImageVO.getPageSize());

		mainImageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mainImageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mainImageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		mainImageVO.setMainImageList(egovMainImageService.selectMainImageList(mainImageVO));

		model.addAttribute("data", mainImageVO.getMainImageList());

        int totCnt = egovMainImageService.selectLoginScrinImageListTotCnt(mainImageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
        return "jsonView";
	}
    
    
	/**
	 * 등록된 메인화면이미지의 상세정보를 조회한다.
	 * @param mainImageVO - 메인이미지 VO
	 * @return String - 리턴 Url
	 */
    @RequestMapping(value="/uss/ion/msi/getMainImage.do")
	public String selectMainImage(@RequestParam("imageId") int imageId,
                                  @ModelAttribute("mainImageVO") MainImageVO mainImageVO,
                                   ModelMap model) throws Exception {

    	mainImageVO.setImageId(imageId);
    	model.addAttribute("mainImage", egovMainImageService.selectMainImage(mainImageVO));
    	model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

    	return "egovframework/com/uss/ion/msi/EgovMainImageUpdt";
	}

	/**
	 * 메인인화면이미지 등록 화면으로 이동한다.
	 * @return String - 리턴 Url
	 */
    @RequestMapping(value="/uss/ion/msi/addViewMainImage.do")
	public String insertViewMainImage(@ModelAttribute("mainImageVO") MainImageVO mainImageVO) throws Exception {
    	return "egovframework/com/uss/ion/msi/EgovMainImageRegist";
	}

	/**
	 * 메인화면이미지정보를 신규로 등록한다.
	 * @param mainImage - 메인이미지 model
	 * @return String - 리턴 Url
	 */
    @SuppressWarnings("unused")
	@RequestMapping(value="/uss/ion/msi/addMainImage.do")
	public String insertMainImage(final MultipartHttpServletRequest multiRequest,
			                      @ModelAttribute("mainImage") MainImage mainImage,
			                      @ModelAttribute("mainImageVO") MainImageVO mainImageVO,
			                       BindingResult bindingResult,
			                       ModelMap model) throws Exception {

    	beanValidator.validate(mainImage, bindingResult); //validation 수행

    	if (bindingResult.hasErrors()) {
    		model.addAttribute("mainImageVO", mainImageVO);
			return "egovframework/com/uss/ion/msi/EgovMainImageRegist";
		} else {

	    	List<FileVO> result = null;

	    	String uploadFolder = "";
	    	String image = "";
	    	String imageFile = "";
	    	String atchFileId = "";

	    	final Map<String, MultipartFile> files = multiRequest.getFileMap();

	    	if(!files.isEmpty()){
	    	    result = fileUtil.parseFileInf(files, "MSI_", 0, "", uploadFolder);
	    	    atchFileId = fileMngService.insertFileInfs(result);

	        	FileVO vo = result.get(0);
	        	Iterator<FileVO> iter = result.iterator();

	        	while (iter.hasNext()) {
	        	    vo = iter.next();
	        	    image = vo.getOrignlFileNm();
	        	    imageFile = vo.getStreFileNm();
	        	}
	    	}

	    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	    	mainImage.setImageId(Integer.parseInt(egovMainImageIdGnrService.getNextStringId()));
	    	mainImage.setImage(image);
	    	mainImage.setImageFile(atchFileId);
	    	mainImage.setImageId(mainImage.getImageId());
	    	mainImage.setUserId(user.getId());

	    	model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
	    	model.addAttribute("mainImage", egovMainImageService.insertMainImage(mainImage, mainImageVO));

//			return "egovframework/com/uss/ion/msi/EgovMainImageUpdt";
			return "forward:/uss/ion/msi/selectMainImageList.do";

		}
	}
    
    @RequestMapping(value = "/addLogo.do")
    public ModelAndView insertBanner(
    		MainImage mainImage
	) throws Exception {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
		
    	mainImage.setImage(mainImage.getImageFile());
    	mainImage.setReflctAt("Y");
    	
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
  		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
  		TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			egovMainImageService.insertMainImage2(mainImage);
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
    @RequestMapping(value = "/updateLogo.do")
    public ModelAndView updateBanner(
    		MainImage mainImage
    		) throws Exception {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
    	TransactionStatus txStatus = txManager.getTransaction(def); 
    	try{ 	
    		egovMainImageService.updateLogo(mainImage);
    		txManager.commit(txStatus);
    		mav.addObject("data", 0);
    	} catch (Exception e) { 
    		txManager.rollback(txStatus); 
    		mav.addObject("data", 1);
    	}
    	return mav;
    }
    @RequestMapping(value = "/updateLogoLocation.do")
    public ModelAndView updateLogoLocation(
    		MainImage mainImage
    		) throws Exception {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
    	TransactionStatus txStatus = txManager.getTransaction(def); 
    	try{ 	
    		egovMainImageService.updateLogoLocation(mainImage);
    		txManager.commit(txStatus);
    		mav.addObject("data", 0);
    	} catch (Exception e) { 
    		txManager.rollback(txStatus); 
    		mav.addObject("data", 1);
    	}
    	return mav;
    }
    @RequestMapping(value = "/updateLogoImg.do")
    public ModelAndView updateLogoImg(
    		MainImage mainImage
    		) throws Exception {

    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
    	TransactionStatus txStatus = txManager.getTransaction(def); 
    	try{ 	
    		egovMainImageService.updateLogoImg(mainImage);
    		txManager.commit(txStatus);
    		mav.addObject("data", 0);
    	} catch (Exception e) { 
    		txManager.rollback(txStatus); 
    		mav.addObject("data", 1);
    	}
    	return mav;
    }
    @RequestMapping(value = "/delLogo.do")
    public ModelAndView deleteBanner(@RequestParam int imageId) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
    	TransactionStatus txStatus = txManager.getTransaction(def); 
  		try{ 	
  			egovMainImageService.deleteMainImage2(imageId);
  			txManager.commit(txStatus);
			mav.addObject("data", 0);
  		} catch (Exception e) { 
  			txManager.rollback(txStatus); 
			mav.addObject("data", 1);
  		}
    	return mav;
    }
    

	/**
	 * 기 등록된 메인화면이미지정보를 수정한다.
	 * @param mainImage - 메인이미지 model
	 * @return String - 리턴 Url
	 */
    @SuppressWarnings("unused")
	@RequestMapping(value="/uss/ion/msi/updtMainImage.do")
	public String updateMainImage(final MultipartHttpServletRequest multiRequest,
                                  @ModelAttribute("mainImage") MainImage mainImage,
                                   BindingResult bindingResult,
                                   ModelMap model) throws Exception {

    	beanValidator.validate(mainImage, bindingResult); //validation 수행

    	if (bindingResult.hasErrors()) {
    		model.addAttribute("mainImageVO", mainImage);
			return "egovframework/com/uss/ion/msi/EgovMainImageUpdt";
		} else {

	    	List<FileVO> result = null;

	    	String uploadFolder = "";
	    	String image = "";
	    	String imageFile = "";
	    	String atchFileId = "";

	    	final Map<String, MultipartFile> files = multiRequest.getFileMap();

	    	if(!files.isEmpty()){
	    	    result = fileUtil.parseFileInf(files, "MSI_", 0, "", uploadFolder);
	    	    atchFileId = fileMngService.insertFileInfs(result);

	        	FileVO vo = null;
	        	Iterator<FileVO> iter = result.iterator();

	        	while (iter.hasNext()) {
	        	    vo = iter.next();
	        	    image = vo.getOrignlFileNm();
	        	    imageFile = vo.getStreFileNm();
	        	}

	        	if (vo == null) {
	        		mainImage.setAtchFile(false);
	        	} else {
	        		mainImage.setImage(image);
	        		mainImage.setImageFile(atchFileId);
	        		mainImage.setAtchFile(true);
	        	}
	    	} else {
	    		mainImage.setAtchFile(false);
	    	}

	    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	    	mainImage.setUserId(user.getId());

	    	egovMainImageService.updateMainImage(mainImage);
//	    	return "forward:/uss/ion/msi/getMainImage.do";
	    	return "forward:/uss/ion/msi/selectMainImageList.do";
		}
    }

	/**
	 * 기 등록된 메인화면이미지정보를 삭제한다.
	 * @param mainImage - 메인이미지 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping(value="/uss/ion/msi/removeMainImage.do")
	public String deleteMainImage(@RequestParam("imageId") int imageId,
                                  @ModelAttribute("mainImage") MainImage mainImage,
  			                       ModelMap model) throws Exception {

		mainImage.setImageId(imageId);
		egovMainImageService.deleteMainImage(mainImage);
    	model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/uss/ion/msi/selectMainImageList.do";
	}

	/**
	 * 기 등록된 메인화면이미지정보를 삭제한다.
	 * @param mainImage - 메인이미지 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping(value="/uss/ion/msi/removeMainImageList.do")  
	public String deleteMainImageList(@RequestParam("imageIds") String imageIds,
                                      @ModelAttribute("mainImage") MainImage mainImage,
                                       ModelMap model) throws Exception {

    	String [] strImageIds = imageIds.split(";");

    	for(int i=0; i<strImageIds.length;i++) {
    		mainImage.setImageId(Integer.parseInt(strImageIds[i]));
    		egovMainImageService.deleteMainImage(mainImage);
    	}

    	model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
    	return "forward:/uss/ion/msi/selectMainImageList.do";
	}

	/**
	 * 기 등록된 메인화면이미지정보의 이미지파일을 삭제한다.
	 * @param mainImage - 메인이미지 model
	 * @return String - 리턴 Url
	 */
	public String deleteMainImageFile(MainImage mainImage) throws Exception {
		return "";
	}

	/**
	 * 메인화면이미지가 특정화면에 반영된 결과를 조회한다.
	 * @param mainImageVO - 메인이미지 VO
	 * @return String - 리턴 Url
	 */
	@IncludedInfo(name="메인이미지 반영결과보기", order = 771 ,gid = 50)
	@RequestMapping(value="/uss/ion/msi/getMainImageResult.do")
	public String selectMainImageResult(@ModelAttribute("mainImageVO") MainImageVO mainImageVO,
		                                 ModelMap model) throws Exception {

		List<MainImageVO> fileList = egovMainImageService.selectMainImageResult(mainImageVO);
		model.addAttribute("fileList", fileList);

		return "egovframework/com/uss/ion/msi/EgovMainImageView";
	}
}
