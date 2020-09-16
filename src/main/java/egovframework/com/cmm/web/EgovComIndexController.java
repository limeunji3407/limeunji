package egovframework.com.cmm.web;

/**
 * 컴포넌트 설치 후 설치된 컴포넌트들을 IncludedInfo annotation을 통해 찾아낸 후
 * 화면에 표시할 정보를 처리하는 Controller 클래스
 * <Notice>
 * 		개발시 메뉴 구조가 잡히기 전에 배포파일들에 포함된 공통 컴포넌트들의 목록성 화면에
 * 		URL을 제공하여 개발자가 편하게 활용하도록 하기 위해 작성된 것으로,
 * 		실제 운영되는 시스템에서는 적용해서는 안 됨
 *      실 운영 시에는 삭제해서 배포해도 좋음
 * <Disclaimer>
 * 		운영시에 본 컨트롤을 사용하여 메뉴를 구성하는 경우 성능 문제를 일으키거나
 * 		사용자별 메뉴 구성에 오류를 발생할 수 있음
 * @author 공통컴포넌트 정진오
 * @since 2011.08.26
 * @version 2.0.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 *  2011.08.26	정진오 		최초 생성
 *  2011.09.16  서준식		컨텐츠 페이지 생성
 *  2011.09.26  이기하		header, footer 페이지 생성
 * </pre>
 */

import java.lang.reflect.Method;
import java.util.Map;
import java.util.TreeMap;

import egovframework.com.cmm.IncludedCompInfoVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.util.EgovUserDetailsHelper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EgovComIndexController implements ApplicationContextAware, InitializingBean {

	private ApplicationContext applicationContext;

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovComIndexController.class);

	private Map<Integer, IncludedCompInfoVO> map;

	public void afterPropertiesSet() throws Exception {}

	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.applicationContext = applicationContext;
		
		LOGGER.info("EgovComIndexController setApplicationContext method has called!");
	}

	@RequestMapping("/index.do")
	public String index(ModelMap model) {

		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("loginVO", loginVO);
		
		return "egovframework/com/uat/uia/EgovLoginUsr";
	}
	
	@RequestMapping("/")
	public String main(ModelMap model) {

		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("loginVO", loginVO);
		
		return "egovframework/com/uat/uia/EgovLoginUsr";
	}


	
	
	
	@RequestMapping("/usr/index.do")
	public String UserIndex(ModelMap model) {	
		/*
		UrlPathHelper urlPathHelper = new UrlPathHelper(); 
		String originalURL = urlPathHelper.getOriginatingRequestUri(request); 
		LOGGER.info("OriginalURL ==>" + originalURL);
		*/		
		String page = "/usr/sender.do";
		model.addAttribute("page", page);
		
		return "egovframework/com/usr/EgovUnitMain";
	}
	
	
	
	
	/*
	 * 
	 * 2020 02 29 
	 * 
	 * 관리자메뉴
	 * build : 김수로
	 * 
	 */

	@RequestMapping("/mng/index.do")
	public String ManagerIndex(ModelMap model) {
		String page = "/mng/congratuation.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	
	/************************************ 전송관리  **********************************/
	//경조사관리
	@RequestMapping("/mng/congratuation")
	public String M_EgoTranCgt(ModelMap model) {
		String page = "/mng/congratuation.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	
	//카카오 Senderkey 관리
	@RequestMapping("/mng/senderkey")
	public String EgoTranKko(ModelMap model) {
		String page = "/mng/senderkey.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	
	//템플릿 관리
	@RequestMapping("/mng/template")
	public String EgoTmplMng(ModelMap model) {
		String page = "/mng/template.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	
	@RequestMapping("/mng/templateDetail")
	public String EgoTmplMngDtail(ModelMap model) {
		String page = "/mng/templateDetail.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	
	@RequestMapping("/mng/templateUpdate")
	public String templateUpdate(ModelMap model) {
		String page = "/mng/templateUpdate.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	//예약 관리
	@RequestMapping("/mng/reservation")
	public String EgoRrvMng(ModelMap model) {
		String page = "/mng/reservation.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	//발송 단위별 전송
	@RequestMapping("/mng/lstbytype")
	public String EgoTranUnit(ModelMap model) {
		String page = "/mng/lstbytype.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	//전송 내역
	@RequestMapping("/mng/listall")
	public String EgoTransTotList(ModelMap model) {
		String page = "/mng/listall.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	
	//통계
	//기간별
	@RequestMapping("/mng/statistics")
	public String EgoStatPeriod(ModelMap model) {
		String page = "/mng/statistics.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	
	//유형별
	@RequestMapping("/mng/statisticsbytype")
	public String statisticsbytype(ModelMap model) {
		String page = "/mng/statisticsbytype.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}	
	
	//업무별
	@RequestMapping("/mng/statisticsbyjob")
	public String statisticsbyjob(ModelMap model) {
		String page = "/mng/statisticsbyjob.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	
	//알림톡템플릿별
	@RequestMapping("/mng/statisticsbyalt")
	public String statisticsbyalt(ModelMap model) {
		String page = "/mng/statisticsbyalt.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	
	//부서별
	@RequestMapping("/mng/statisticsbypart")
	public String statisticsbypart(ModelMap model) {
		String page = "/mng/statisticsbypart.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	/************************************ 전송관리  **********************************/					 
	
	
 
	/************************* 민워수신 / 문자투표 **************************/
	//민원괸리
	@RequestMapping("/mng/complain")
	public String EgoStatAs(ModelMap model) {
		String page = "/mng/complain.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	//문자투표
	@RequestMapping("/mng/poll")
	public String EgoSmsPoll(ModelMap model) {
		String page = "/mng/poll.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	
	
	//전체수신내역
	@RequestMapping("/mng/molist")
	public String EgoRcvTotList(ModelMap model) {
		String page = "/mng/molist.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	//#번호등록
	@RequestMapping("/mng/addnumber")
	public String EgoInsNumb(ModelMap model) {
		String page = "/mng/numberlist.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	/************************* 민워수신 / 문자투표 **************************/

	
	/************************* 시스템관리 **************************/
	//전송기준설정
	@RequestMapping("/mng/sendconfig")
	public String EgoSetPrice(ModelMap model) {
		String page = "/mng/sendconfig.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 		
	//기준정보관리 TAB 메인
	@RequestMapping("/mng/sendconfig.do")
	public String MessageLineConfig() {
		return "egovframework/com/mng/msd/EgovSendConfig";
	} 	
	//기준정보관리
	@RequestMapping("/mng/standardconfig")
	public String EgoMngBasic(ModelMap model) {
		String page = "/mng/standardconfig.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	//기준정보관리 TAB 메인
	@RequestMapping("/mng/standardconfig.do")
	public String StandardSetting() {
		return "egovframework/com/mng/sts/EgovStandardSetting";
	} 	
	
	//기록관리
	@RequestMapping("/mng/systemlog")
	public String EgoConnLogList(ModelMap model) {
		String page = "/mng/log.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	//기록관리 TAB 메인
	@RequestMapping("/mng/log.do")
	public String LogList() {
		return "egovframework/com/mng/log/EgovLogList";
	} 
	/************************* 시스템관리 **************************/

	
	/************************* 주소록 **************************/
	//공유주소록
	@RequestMapping("/mng/addressbook")
	public String EgovAddrBook(ModelMap model) {
		String page = "/mng/adr/EgovAddrBookShare.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	/************************* 주소록 **************************/



	/************** 사용자관리 ************/	
	//사용자정보	
	@RequestMapping("/mng/user")
	public String EgovMngUsr(ModelMap model) {
		String page = "/mng/mem/EgovUserManage.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	
	//사용자관리 -등록페이지
	@RequestMapping("/mng/addusr")
	public String EgovMngAddUsr(ModelMap model) {
		String page = "/mng/addusr.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	
	//사용자관리 -등록페이지
	@RequestMapping("/mng/updusr")
	public String EgovMngUpdUsr(ModelMap model) {
		String page = "/mng/updusr.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}
	
	//일괄부여
	@RequestMapping("/mng/batchrole")
	public String EgovSetBatch(ModelMap model) {
		String page = "/mng/batchrole.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 	
	
	//등급기준
	@RequestMapping("/mng/cashlevel")
	public String EgovSetLevel(ModelMap model) {
		String page = "/mng/cashlevel.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	}	
	/************ 사용자관리 *************/
	
	/************ 마이페이지 *************/
	@RequestMapping("/mng/mypage")
	public String MenuMngMypage(ModelMap model) {
		String page = "/mng/mypage.do";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 
	
	
	
	/*
	 * 
	 * 2020 02 29 
	 * 
	 * 사용자메뉴
	 * build : 김수로
	 * 
	 */
	
	/************************* 전송 **************************/
	//전송
	@RequestMapping("/usr/sender")
	public String MenuSenderU(ModelMap model) {
		String page = "/usr/sender.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 	
	
	//내 저장함
	@RequestMapping("/usr/templatebox")
	public String MenuTemplateBoxU(ModelMap model) {
		String page = "/usr/templatebox.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 	
	
	//템플릿 관리
	@RequestMapping("/usr/template")
	public String MenuTemplateU(ModelMap model) {
		String page = "/usr/template.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 	
	//템플릿 자세히
	@RequestMapping("/usr/templateDetail")
	public String MenuTemplateDetail(ModelMap model) {
		String page = "/usr/tempDetail.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 	
	
	@RequestMapping("/usr/templateUpdate")
	public String MenuTemplateUpdate(ModelMap model) {
		String page = "/usr/templateUpdate.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 	
	/************************* 전송 **************************/
	
	
	
	/************************* 전송관리 **************************/
	//예약관리
	@RequestMapping("/usr/reservation")
	public String MenuReservationU(ModelMap model) {
		String page = "/usr/reservation.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 	
	
	//발송단위별전송
	@RequestMapping("/usr/listbytype")
	public String MenuListByTypeU(ModelMap model) {
		String page = "/usr/listbytype.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 	
	
	//전체전송내역
	@RequestMapping("/usr/listall")
	public String MenuListAllU(ModelMap model) {
		String page = "/usr/listall.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 	
	
	//수신거부목록
	@RequestMapping("/usr/receiptrefusal")
	public String MenuReceiptrefusalU(ModelMap model) {
		String page = "/usr/receiptrefusalU.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 	
	
	//기간별통계
	@RequestMapping("/usr/statistics")
	public String MenuStatisticsU(ModelMap model) {
		String page = "/usr/statistics.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 	
	/************************* 전송관리 **************************/
 
	/************************* 민원수신/문자투표 **************************/
	//민원관리
	@RequestMapping("/usr/complain")
	public String MenuComplainU(ModelMap model) {
		String page = "/usr/complain.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 
	
	//문자투표
	@RequestMapping("/usr/poll")
	public String MenuPollU(ModelMap model) {
		String page = "/usr/poll.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 
	
	//전체수신내역
	@RequestMapping("/usr/molist")
	public String MenuMoListU(ModelMap model) {
		String page = "/usr/molist.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 
	
	/************************* 민원수신/문자투표 **************************/
	
	
 
	/************************* 부서장기능 **************************/
	//부서원관리
	@RequestMapping("/usr/staff")
	public String MenuStaffU(ModelMap model) {
		String page = "/usr/staff.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 
	//부서원관리 -등록페이지
	@RequestMapping("/usr/addstaff")
	public String MenuAddStaffU(ModelMap model) {
		String page = "/usr/addstaff.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 
	//부서원관리 - 부서원 수정
	@RequestMapping("/usr/prtstaff")
	public String MenuUpdateStaffU(ModelMap model) {
		String page = "/usr/prtstaff.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 
	
	
	//부서발송단위별전송
	@RequestMapping("/usr/translistbytype")
	public String MenuTransListByTypeU(ModelMap model) {
		String page = "/usr/translistbytype.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 
	
	//부서전송내역
	@RequestMapping("/usr/translist")
	public String MenuTransListU(ModelMap model) {
		String page = "/usr/translist.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 
	
	//부서업무별통계
	@RequestMapping("/usr/statisticsbyjob")
	public String MenuStatisticsByJobU(ModelMap model) {
		String page = "/usr/statisticsbyjob.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 
	
	//부서기간별통계
		@RequestMapping("/usr/partstatistics")
		public String MenuStatisticsByPart(ModelMap model) {
			String page = "/usr/partstatistics.do";
			model.addAttribute("page", page);
			return "egovframework/com/usr/EgovUnitMain";
		} 
	/************************* 부서장기능 **************************/
	
	
 
	/************************* 주소록 **************************/
	
	@RequestMapping("/usr/adkbU")
	public String MenuAddressBookU(ModelMap model) {
		String page = "/usr/adkbU.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 

	@RequestMapping("/usr/mon/PartStatJob")
	public String PartStatJob(ModelMap model) {
		String page = "./mon/PartStatJob.jsp";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 
	
	/*
	//부서주소록
	@RequestMapping("/usr/mon/PartStatJob")
	public String PartStatJob(ModelMap model) {
		String page = "./mon/PartStatJob.jsp";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 
	
	//공유주소록
	@RequestMapping("/usr/mon/PartStatJob")
	public String PartStatJob(ModelMap model) {
		String page = "./mon/PartStatJob.jsp";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 
	
	//직원주소록
	@RequestMapping("/usr/mon/PartStatJob")
	public String PartStatJob(ModelMap model) {
		String page = "./mon/PartStatJob.jsp";
		model.addAttribute("page", page);
		return "egovframework/com/mng/EgovUnitMain";
	} 
	*/
	
	/************************* 주소록 **************************/
	

	
	@RequestMapping("/mypage")
	public String MenuMypage(ModelMap model) {
		String page = "/mypage.do";
		model.addAttribute("page", page);
		return "egovframework/com/usr/EgovUnitMain";
	} 
	
	
	
	
	
	@RequestMapping("/EgovTop.do")
	public String top() {
		return "egovframework/com/cmm/EgovUnitTop";
	}

	@RequestMapping("/EgovBottom.do")
	public String bottom() {
		return "egovframework/com/cmm/EgovUnitBottom";
	}

	@RequestMapping("/EgovContent.do")
	public String setContent(ModelMap model) {

		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("loginVO", loginVO);

		return "egovframework/com/cmm/EgovUnitContent";
	}

	@RequestMapping("/EgovLeft.do")
	public String setLeftMenu(ModelMap model) {

		/* 최초 한 번만 실행하여 map에 저장해 놓는다. */
		if (map == null) {
			map = new TreeMap<Integer, IncludedCompInfoVO>();
			RequestMapping rmAnnotation;
			IncludedInfo annotation;
			IncludedCompInfoVO zooVO;

			/*
			 * EgovLoginController가 AOP Proxy되는 바람에 클래스를 reflection으로 가져올 수 없음
			 */
			try {
				Class<?> loginController = Class.forName("egovframework.com.uat.uia.web.EgovLoginController");
				Method[] methods = loginController.getMethods();
				for (int i = 0; i < methods.length; i++) {
					annotation = methods[i].getAnnotation(IncludedInfo.class);

					if (annotation != null) {
						LOGGER.debug("Found @IncludedInfo Method : {}", methods[i]);
						zooVO = new IncludedCompInfoVO();
						zooVO.setName(annotation.name());
						zooVO.setOrder(annotation.order());
						zooVO.setGid(annotation.gid());

						rmAnnotation = methods[i].getAnnotation(RequestMapping.class);
						if ("".equals(annotation.listUrl()) && rmAnnotation != null) {
							zooVO.setListUrl(rmAnnotation.value()[0]);
						} else {
							zooVO.setListUrl(annotation.listUrl());
						}
						map.put(zooVO.getOrder(), zooVO);
					}
				}
			} catch (ClassNotFoundException e) {
				LOGGER.error("No egovframework.com.uat.uia.web.EgovLoginController!!");
			}
			/* 여기까지 AOP Proxy로 인한 코드 */

			/*@Controller Annotation 처리된 클래스를 모두 찾는다.*/
			Map<String, Object> myZoos = applicationContext.getBeansWithAnnotation(Controller.class);
			LOGGER.debug("How many Controllers : ", myZoos.size());
			for (final Object myZoo : myZoos.values()) {
				Class<? extends Object> zooClass = myZoo.getClass();

				Method[] methods = zooClass.getMethods();
				LOGGER.debug("Controller Detected {}", zooClass);
				for (int i = 0; i < methods.length; i++) {
					annotation = methods[i].getAnnotation(IncludedInfo.class);

					if (annotation != null) {
						//LOG.debug("Found @IncludedInfo Method : " + methods[i] );
						zooVO = new IncludedCompInfoVO();
						zooVO.setName(annotation.name());
						zooVO.setOrder(annotation.order());
						zooVO.setGid(annotation.gid());
						/*
						 * 목록형 조회를 위한 url 매핑은 @IncludedInfo나 @RequestMapping에서 가져온다
						 */
						rmAnnotation = methods[i].getAnnotation(RequestMapping.class);
						if ("".equals(annotation.listUrl())) {
							zooVO.setListUrl(rmAnnotation.value()[0]);
						} else {
							zooVO.setListUrl(annotation.listUrl());
						}

						map.put(zooVO.getOrder(), zooVO);
					}
				}
			}
		}

		model.addAttribute("resultList", map.values());
		
		LOGGER.debug("EgovComIndexController index is called ");

		return "egovframework/com/cmm/EgovUnitLeft";
	}
}
