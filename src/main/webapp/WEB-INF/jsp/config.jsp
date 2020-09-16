<%@page contentType="text/html; charset=euc-kr"%>
<% 

//매뉴얼다운로드(기본 true) 버튼 유무 true = 버튼보이기 / false = 버튼숨기기
//2010년 06월 03일 박동욱
//boolean manualconf = true;

//관리자 시작페이지를 통계페이지로 변경 
//2010년 06월 03일 박동욱
//로그인시 시작페이지 설정 true = 통계페이지 / false = 정보수정페이지
//청송군청(true) , 증평군청(false)
boolean startPage = true;

//상단 홈페이지로가기 버튼 설정 true = 통계페이지 / false = 정보수정페이지
//청송군청(true) , 증평군청(false)
boolean startHomePage = true;

//좌측매뉴 권한에 따라서 보여주기설정 true = 권한에따라 매뉴가보임 / false = 좌측매뉴모두보임
//2010년 06월 07일 박동욱
//청송군청(true) , 증평군청(false)
boolean leftMenuActive = true; 

//모든 페이지의 핸드폰 셀렉트박스의 013번호를 표시 true = 표시 / false = 비표시
//2010년 06월 07일 박동욱
//청송군청(false) , 증평군청(true)
//boolean hpno013View = false;

//메세지발송화면 > 주소록보기 > 부서탭 사용안함 true = 표시 / false = 비표시
//2010년 06월 07일 박동욱
//청송군청(true) , 증평군청(false)
boolean departActive = true;

//메세지발송화면 미리보기버튼 비활성화 true = 표시 / false = 비표시
//2010년 06월 07일 박동욱
//청송군청(true) , 증평군청(false) 
boolean previewActive = true;

//모바일타운 활성화 true = 표시 / false = 비표시
//슈퍼관리자 > 사용자관리 > 추가기능설정:모바일설문 true = 표시 / false = 비표시
//2010년 06월 14일 박동욱
//청송군청(true) , 증평군청(false)
boolean mobileActive = false;

//모바일타운 주소 설정
//2010년 06월 14일 박동욱
String mobileAddress = "http://123.123.123.123:9090/member/Login?id=";

//청송군청:: 타이틀 제목 
//2010년 06월 10일 양정규
//String titleName = "++모바일메시징서비스 I-GOV++"; // 디폴트
//청송군청 = "청송군 통합민원알리미시스템";
//증평군청 = "증평군 통합민원알리미시스템";
//String titleName = "SMS/MMS 통합민원알리미시스템";


//메세지삭제 버튼 활성화 true = 표시 / false = 비표시
//2010년 06월 24일 박동욱
//청송군청(false) , 증평군청(true) 
boolean msgDelete = false;

//예약삭제 버튼 활성화 (이미 발송된 예약그룹만) true = 표시 / false = 비표시
//2016년 12월 26일 강경우
boolean msgReservDelete = true;

//상단 매뉴바에 경로보기 활성화 true = 표시 / false = 비표시
//2010년 06월 24일 박동욱
//청송군청(false)
boolean nowURLView = false;

//사용자>주소록관리> 상단 이미지 문구설정
//true = 부서공유를 사용할경우(부서탭 사용함)
//false = 부서공유를 사용하지 않을경우(부서탭 사용안함)
//2010년 07월 02일 박동욱
//청송군청(true) , 증평군청(false) 
boolean addressText = true;

//사용자 > 발송화면 > 주소록보기 탭 문구변경
//true = 부서 -> 부서공유 공유 -> 전체공유 로 변경
//false = 부서, 공유 
//2010년 07월 02일 박동욱
//청송군청(true) , 증평군청(false) 
boolean addrTab = false;

//사용자 > 전송내역조회 > 검색날짜 설정변경 ( 현재달의 1일 ~ 현재일 )
//true = 현재달의 1일 ~ 현재일
//false = 7일전 ~ 현재일
//2010년 07월 05일 박동욱
//청송군청(true) , 증평군청(false)
boolean searchDate  = true;

//주소록에 그룹이 한개도 없을경우 자동생성  true = 생성 / false = 비생성
//2010년 7월 6일 박동욱
//청송군청(true) , 증평군청(false)
//boolean defaultGroup = true;

//청송군청 텍스트박스 및 전체 글자 검은색 혹은 찐하게 변경 요청  true = 청송 찐하게 / false = 원래것
//2010년 7월 7일 박동욱
//청송군청(true) , 다른곳 모두(false)
boolean cssCJ = true;

//지역번호가 없을경우 자동으로 입력해 줍니다.  true = 입력 / false = 비입력
//2010년 7월 8일 박동욱
//청송군청(true)
//boolean areaCodeActive = true;

//보내는사람 전화번호에 지역번호가 없을경우 이곳에 설정한 번호로 자동으로 넣어줍니다.  
//2010년 7월 8일 박동욱
//청송군청 054
//String areaCode = "02";

//보내는사람 전화번호를 핸드폰,사무실 번호로 선택할수 있는 라디오박스를 생성해 줍니다. true = 생성 / false = 비생성
//2010년 7월 8일 박동욱
//청송군청(true) , 증평군청(false)
//boolean fromNumCheck = true;

//관리자>예약전송>예약취소버튼을 보이기 안보이기  true = 보임 / false = 안보임
//2010년 7월 14일 박동욱
//디폴트 셋팅 false (신지수 대리님이 관리자는 삭제 안되게 하자고 하심)
boolean reserCansleActive = false;

//사용자>멀티발송>이미지수정창 하단 취소버튼 클릭시  true = 팝업창 닫힘 / false = 팝업창 재로딩됨
//2010년 8월 10일 박동욱
//디폴트 셋팅 false 
//청송군청 true
boolean closeEditor = true;

//사용자 주소록의 핸드폰 입력란 3칸 -> 한칸으로 바꾸기 true = 한칸 / false = 3칸
//2010년 8월 11일 박동욱
//디폴트 셋팅 false 
//청송군청 true
//boolean hpnoForm = true;

//주소록보기 각 탭 클릭시 하단 선택그룹 상세보기 에 각탭의 전체보여주기 true = 클릭시 상세그룹  각탭의 전체보여주기  / false = 상세보기 고정하기
//2010년 8월 19일 박동욱
//디폴트 셋팅 false 
//청송군청 true , 증평군청(false)
//boolean addressTabAll = true;

//슈퍼관리자 통계관리 월별통계 날짜 설정 ( 12개월 전부터  ~ 현재일 )
//true = 12개월 전부터  ~ 현재일
//2010년 10월 06일 박동욱  -> 사용안함 2012.04.30  LEE
//청송군청(true) , 증평군청(false)
boolean searchDateMon12 = true;

//연별통계를 설치년도로 시작 검색 설정
//2010년 10월 06일 박동욱
//청송군청(true) , 증평군청(false)
boolean statYearActive = true;
//설치년도설정
String statYearRdate = "2018";


//슈퍼유저 전체내역조회->메시지단위 리스트:엑셀다운로드에 이름,부서항목표시여부  true = 휴대폰에관련한 이름 표시, false = 이름항목 제외.
//2011년 03월 07일 이목희
boolean statAddName = false;

//슈퍼유저 엑셀다운로드에서 셀타입을 숫자로 셋팅할 항목의 엑셀Header명 리스트
//2011년 03월 10일 이목희
// 내용 추가 - 예: "건수" 부터 뒤쪽 (2018.11.07 KKW)
String[] arrNumTitle = {"총발송","성공","실패","번호오류","예약","성공률","대기","남은캐쉬","건수","월사용건수","월사용캐쉬","임시추가건수","임시추가캐쉬"};

//문자전송 송신제한 건수(단문, 장문, URL, MMS, 음성 모두 공통 적용)
//2011년04월04일 이목희
//옵션 미사용(properties EXCELMEMBERLOADMAXCNT 옵션으로 통합)으로 주석처리 20130708 KKW 
//int sendLimit = 1000;

//유저의 캐쉬충전요청 팝업창  true: 표시, false: 비표시 (cashCharge라는 사용자를 반드시 만들어 줘야 문자가 나감 비밀번호는 상관 없음)
//2011년05월11일 이목희
boolean cashChargeActive = false;
//2011년05월18일 이목희 새올유저에게만 표시 true: 새올유저만 표시 , false: 모든유저 표시 
// 조건 : (cashChargeActive:true) 일때만 해당됨
boolean cashChargeActiveForSaeallUser = false;

//2012년01월05일 이목희 일반업체(기업)용 화면일 경우  true: 일반업체용 화면임(직원탭 제거) , false: 시군구용.  
//사용자관리: [인감관리자설정],[주민등록관리자설정] 2개메뉴삭제
//시스템관리: [발송라인관리],[디자인관리] 2개메뉴 삭제
//관리자> 사용자 등록시에 [직원주소록등록] 항목 제거  
boolean useForCompany = false;

//2012년02월08일 이목희 부서장화면 메뉴 리스트에서 [부서원등록] 리스트 표시여부  true: 표시함. false: 표시안함. 
boolean regWorkerOfDept = true;

//2012년02월14일 이목희 메인화면 메뉴 리스트에서 [음성전송] 표시여부  true: 표시함. false: 표시안함. 
boolean dispVMS = false;

//2012년02월21일 이목희 통계화면에서 총가격 표시여부  true: 표시함. false: 표시안함.  광주시청: true 
boolean dispTotPrice = true; 

//2012년02월21일 이목희 로그인화면에 회원가입 버튼 표시여부  true: 표시함. false: 표시안함.  광주시청: true
boolean dispMemberJoin = true;

//2012년02월23일 이목희 관리자 화면의 왼쪽 매뉴얼 다운로드 밑에 발송금액계산 버튼 표시 여부 true: 표시함. false: 표시안함.  광주시청: true
boolean dispSendCalculator = false; 

//2012년02월23일 이목희 일반사용자에서 로그인정보 표시란에 문자 전송 타입별  문자전송가능건수 표시여부  true: 표시함. false: 표시안함.  광주시청: true
//  (개별 발송가능 건수)
boolean dispPossibleSendCnt = true; 

//2012년02월23일 이목희 일반사용자에서 footer에서 개인정보처리방침 버튼  표시여부  true: 표시함. false: 표시안함.  광주시청: true
boolean dispPersonalInfoMang = false; 

//슈퍼관리자 통계관리 월별통계 날짜 설정 ( 현재년도1월  ~ 현재일 )
// 1: 12개월 전부터  ~ 현재일  2: 현재 월만  3:현재년도 1월 ~ 현재일  
// 2012년 4월 30일 이목희
//청송군청(1) , 증평군청(2)
int iDateMon12 = 3;

//2012년05월25일 이목희  동영상 전송화면  true: 표시,  false:비표시   광주시청: true 
boolean dispVideo = false; // 기능 없음 - 업로드 화면 미구현 (2018.10.22)

//2012년6월22일 이목희  광주시청 복호화 작업위해서 true: 광주시청임   false: 광주시청이 아님. 
boolean isGwangju = false;

//2012년6월22일 이목희  광주시청 복호화 작업 복호화 dsd 키정보  
String sDsdCode = "sdjkfljaslkfsjadklf";

//2012년6월22일 이목희  광주시청 복호화 작업 복호화 FSD 홈디렉토리 
String sFsdinitDir = "/usr/local/fsdinit";//주의: 끝에 /는 안붙임

//2012년8월13일  이목희 패스워드 금지어 지정.  
//String[] pwdForbiddenWord = {"love","happy","qwer","zxcv"};

//2012년8월14일 이목희 변경주기 패스워드 변경 주기 (단위: 월)  
int iPwChangeCycle_Mnt = 3;

//2012년8월20일 이목희 패스워드 금지어 체크 유무  (true: 금지어 체크 , false: 금지어 체크 안함.)  
//boolean usePwForbWord = true;

//2012년8월20일 이목희 허용가능 실패카운트수 
// 값이 0이면 실패 횟수 제한 없슴 (20131113 KKW)
// 주의사항 : igov.properties 에도 실패카운트수 같이 적용해야함 (20140214 KKW)
//int iUsableFailCnt = 5;

//2012년8월20일 이목희 과거 패스워드를 몇개까지 지정하여 동일패스워드 유무 체크 할지
// 값이 0이면 과거 패스워드를 제한없이 사용 (20131113 KKW)
//int iUsablePastPwCnt = 3;

//2012년9월14일 이목희 액세스 로그의 경로 지정. (주의: 끝에 구분자 (예 C:\\) 넣을 것.) 
//String sAccesslogPath = "C:\\";
// kkk
//String sAccesslogPath = "/usr/local/tomcat7/acc_log/";
String sAccesslogPath = "D:\\imsi\\";

//2012년10월16 이목희 사용자 [인감증명][주민등록]메뉴의 [신청자관리]메뉴 표시유무 true: 표시 false:비표시 
boolean applyMangFlg = false;


//2012년10월26 이목희 관리자 의 사용자 정보변경시에 패스워드 초기화에 필요한 패스워드정보  
String sDefaultPW = "default123!";

//2012년12월06 이목희  레프트메뉴의 로그인 사용자 정보에서 정보수정버튼의 표시유무 
Boolean modifyIconFlg = true; 

//2013년1월11 이목희  SSL사용유무(true: SSL 사용,  false: SSL 사용안함)   
//Boolean sslFlg = false;

//사이트 환경설정 DB  true: 사용, false: 미사용  (2013.04.01 KKW)
//true 이면 TBCONFIG DB설정이 사용되고 관리자 패스워드설정관리 메뉴가 표시 / false 설정 시 config.jsp 의 설정이 적용됩니다.
//*** 적용대상 : 패스워드패턴, 패스워드변경주기 *** 
boolean g_bConfigDbSetting = true;

//패스워드 패턴 (sPasswordPattern 값은 bPasswordDbSetting 이 false 일때만 적용됨)
// 08A:영문,숫자,특수문자  8자리 / 10A:영문,숫자 10자리 / 10B:영문,특수문자 10자리
// 09A:영문,숫자,특수문자 9자리
//String g_sPasswordPattern = "09A";

//접속기록조회 (시스템관리-접속기록조회) 표시여부   true: 표시, false: 미표시  (2013.03.28 KKW)
boolean g_bAccessHistory = true;

//로그인 실패 시 패스워드 실패 횟수 표시여부  true:표시, false:미표시 (2013.04.05 KKW)
//boolean g_PasswordFailCountDisplay = true;

// 메인화면 메뉴 리스트에서 [콜백전송] 표시여부  true: 표시함. false: 표시안함. (20130626 KKW)
boolean g_dispURL = false;

// 로그인 실패 시 DB실패내역 초기화 여부 설정  true:초기화, false:초기화안함 (false 시 로그인 성공해도 초기화 되지 않고 계속 카운트됨)  (20130703 KKW)
// 주의사항 : igov.properties 에도 실패카운트수 같이 적용해야함 (20140217 KKW)
//boolean g_bLoginFailinit = true;

// 재난관리부서코드 : 문자전송 주소록탭중 "부서공유" 명칭을 "재난공유" 로 표시하기 위함
// 코드값이 있으면 해당 직원 로그인 시 "재난공유" 표시, 공백이면 모든직원에 대해 "부서공유"로 표시함 (20130805 KKW)
String g_sendAddrDeptTabDisp = "0000001";

// 영동군청 도움말 이미지 출력 여부   true:표시, false:미표시 (20130902 KKW)
boolean g_yeongdongImgDisplay = true;

// 인감관리자, 주민관리자 메뉴 표시 옵션 - useForCompany옵션과 달리 단 두개 메뉴 표시만 제어
// true:표시, false:미표시 (20131113 KKW)
boolean g_bDisplayInkamJuminMenu = false;

// 패스워드 입력 시 문자형태(ID유사성,연속문자 등) 체크 통과 옵션    true:문자형태체크안함, false:체크함 (20131113 KKW)
//boolean g_bPwFormCheckSkip = false;

// 사용자 캐쉬 변경 시 부서 캐쉬의 잔여 한도 이내에서만 가능하게 할 것인지 결정하는 옵션
// A:부서잔여한도체크함(부서한도-사용자한도의 합보다 클수없다), B:부서한도만체크함(부서한도보다 클수없다), C:한도체크안함 (20131218 KKW)
//String g_UserCashLimitCheckFlag = "A";

// 사용자 캐쉬 변경 시 부서 캐쉬의 잔여 한도를 체크할 때 관리자가 입력한 임시추가캐쉬도 체크하도록 할 것인지를 결정하는 옵션. (20140807 조정민)
// g_UserCashLimitCheckFlag 와 함께 사용된다.
// g_UserCashLimitCheckFlag : A, g_addcashLimitCheckFlag : true => 부서의 잔여 한도(해당 사용자의 월캐쉬한도 + 임시추가캐쉬 미포함)와 사용자의 변경하려는 월 캐쉬한도 + 임시추가캐쉬 비교
// g_UserCashLimitCheckFlag : A, g_addcashLimitCheckFlag : false => 부서의 잔여 한도(해당 사용자의 월캐쉬한도 + 임시추가캐쉬 미포함)와 사용자의 변경하려는 월 캐쉬한도  비교
// g_UserCashLimitCheckFlag : B, g_addcashLimitCheckFlag : true => 부서의 잔여 한도(해당 사용자의 월캐쉬한도 + 임시추가캐쉬 포함)와 사용자의 변경하려는 월 캐쉬한도 + 임시추가캐쉬 비교
// g_UserCashLimitCheckFlag : B, g_addcashLimitCheckFlag : false => 부서의 잔여 한도(해당 사용자의 월캐쉬한도 + 임시추가캐쉬 포함)와 사용자의 변경하려는 월 캐쉬한도 비교
//boolean g_addcashLimitCheckFlag = true;

// 일반사용자 주소록관리의 부서공유 기능을 on/off 할 수 있는 옵션 추가  (true:부서공유 기능 사용, false:부서공유 기능 미사용) (20131231 KKW)
// 부서장은 부서주소록을 관리할 수 있으며 일반사용자는 전송화면에서 부서공유탭도 보임.
// 이 값이 false 이면 일반사용자의 주소록관리 화면에서 부서공유 버튼이 나타나지 않으며 부서장의 부서주소록 화면에서 관리담당자 임명 기능을 감춤
// 이 값이 false 이면 부서공유가 없어지므로 addressText 설정 값도 같이 false 로 바꿀것
// 참고 : 기존 departActive 설정값은 일반 사용자와 부서장 모두 부서주소록을 관리하거나 조회하지 못하며 전송화면에서 부서공유탭도 없어짐.
//boolean g_bDeptShare = true;

// 부서 정렬 선택 여부  (20140107 KKW)
// (true 일때에는 DEPT_RANK 컬럼을 사용하여 정렬하며 관리자는 순서 조절을 할 수 없슴)
// (false 일때에는 ORDERBYLEV 컬럼을 사용하며 관리자는 순서 조절이 가능함)
//boolean g_bDeptRank = false;

//금천구청 요구사항
//슈퍼관리자용 전체 주소록 갯수 조회 : 사용중인 사용자 중에서 중복 제거(2014.12.22 조정민)
//admin 계정으로 로그인 => 시스템관리 => 공유주소록관리
boolean g_addressTotalCountFlag = false;

//직원 주소록 엑셀 다운로드 버튼 활성화 여부 (2014.12.30 조정민)
//admin 계정으로 로그인 => 시스템관리 => 공유주소록관리
boolean g_empAddressExcelDownFlag = false;

//기존에 사용하고 있던 SMS 서비스를 팝업으로 띄워주는 버튼 표시여부(2015.02.27 조정민)
boolean dispOtherSmsService = false;

//이전 SMS 페이지를 admin 계정에만 표시할지 전체 사용자에게 표시할지 여부(2015.07.14 조정민)
//dispOtherSmsService = true 일 경우 dispOtherSmsServiceAdmin = true 이면 admin 계정만 보이기.
//dispOtherSmsServiceAdmin = false 이면 전체 사용자에게 보이기.
boolean dispOtherSmsServiceAdmin = false;

//기존에 사용하고 있던 SMS 서비스 URL(2015.02.27 조정민)
//dispOtherSmsService =  true 일 경우 사용 됨
String otherSmsServiceUrl = "http://www.naver.com";

//전송관리 => 내역조회 화면으로 이동 시 최초로 보여주는 화면 선택(2015.04.16 조정민)
// 발송단위 : J, 메시지 단위 : M
String sendListScreenFlag = "J";

//전송관리 => 내역조회 화면으로 이동 시 최초로 보여주는 화면 JSP 파일명(2015.04.16 조정민)
String sendListScreen = "sendJobList.jsp";
if( "M".equals( sendListScreenFlag ) ) sendListScreen = "sendMessageList.jsp";

//메시지 전송의 "업무의 성격" 항목 필수 입력 여부(2015.04.17 조정민)
// Y : 필수입력, N : 필수아님 (Select Box의 Option값 "선택" 생성)
// NA : 필수아님. "-선택해주세요-"가 기본. 그러나 "-선택해주세요-" 상태로 전송시 경고창 뜨고 전송안됨  (2016.11.14 강경우)
// ND : 필수아님. 화면에 업무성격이 표시도 안됨. (2017.05.11 KKW)
String workSeqRequiredFlag = "NA";

//각 메세지 전송 화면에서 메세지 내용에 경고 문구를 보여줄지 여부(2015.04.20 조정민)
//boolean messageLayerFlag = true;

//push 기능 사용여부 2015.07.06 조정민(igov.properties 에서 설정)
String pushUseFlag = PropertiesManager.getProperties("pushUseFlag");

//경조사 기능 사용여부 2015.07.06 조정민(igov.properties 에서 설정)
//String familyEventUseFlag = PropertiesManager.getProperties("familyEventUseFlag");

//문자 발송 시 발신번호 변작 방지 관련 세칙 적용 여부(true: 세칙 적용, false: 세칙 미적용)
boolean fakeNumberPreventUseFlag = true;

//로그인 시 발신번호 변작 방지 관련 안내 팝업창을 띄우는 기능 사용 여부(true: 팝업창 띄우기, false: 팝업창 안띄우기)
boolean fakeNumberPreventPopUpUseFlag = false;

//캐쉬마스터는 tbuser 테이블의 nlevel=2


// 부서주소록 기능 동작에 대한 설정 (igov.properties 에서 설정) (2016.05.04 KKW)
// - 주소록 기존 정책
// 	g_DeptShareGubun <--------- ""
// 		부서주소록 : 다른 사용자가 부서공유한 주소록의 소유자가 표시안되며 주소록 이름만 보임.
// 		부서주소록 : 다른 사용자가 등록한 전화번호를 수정은 가능하나 삭제는 못함.
// 		주소록 : 주소록 소유자는 다른 사용자에게 위임된 주소록관리(주소록 공유해지,그룹명수정,그룹삭제)를 못함.
// 		주소록 : 관리담당자(위임받은자)는 주소록 공유해지, 그룹명수정, 그룹삭제 가능함.
// 		주소록 : 관리담당자(위임받은자)는 다른 사용자가 등록한 전화번호 수정은 가능하나 삭제는 못함.
// - 주소록 V2정책 (2016.05.04)
// 	g_DeptShareGubun <---------- "V2"
// 		부서주소록 : 다른 사용자가 부서공유한 주소록의 소유자가 주소록 이름옆에 추가 표시됨.
// 		부서주소록 : 다른 사용자가 등록한 전화번호를 수정, 삭제 가능함. (단, 부서장이 주소록의 소유자가 아니라면 그룹명변경,그룹삭제 못함)
// 		주소록 : 관리담당자(위임받은자)는 주소록 이름옆에 부서공유한 원래 소유자가 추가 표시됨.
// 		주소록 : 주소록 소유자는 다른 사용자에게 위임된 주소록관리(주소록의 공유해지,그룹명수정,그룹삭제)와 전화번호 관리가 가능함.
// 		주소록 : 주소록 소유자는 다른 사용자가 등록한 전화번호를 수정, 삭제 가능함.
// 		주소록 : 관리담당자(위임받은자)는 전화번호추가,수정,삭제에 대한 권한만 가짐. (주소록의 공유해지, 그룹명수정, 그룹삭제가 불가능함)
// 		주소록 : 관리담당자(위임받은자)는 다른 사용자가 등록한 전화번호를 수정, 삭제 가능함.
//String g_DeptShareGubun = PropertiesManager.getProperties("g_DeptShareGubun");

// 부서장 부서주소록관리 메뉴 표시 여부 옵션 (true:표시, false:미표시) (20160526 KKW)
//  g_bDeptAddressMenuDisplay=true, departActive=true : 메뉴 표시.
//  g_bDeptAddressMenuDisplay=false, departActive=true : 메뉴 미표시.
//  g_bDeptAddressMenuDisplay=true, departActive=false : 메뉴 미표시.
boolean g_bDeptAddressMenuDisplay = true;

// 이모티콘 버튼 표시 여부 옵션 (true:표시, false:미표시) (2016.11.14 KKW)
boolean g_emoticonDisplay = false;

// 로그인 회원가입 활성화 시 개인정보취급방침 표시 옵션 (true:개인정보취급방침표시, false:개인정보취급동의없이가입화면) (2017.02.23 KKW)
//  dispMemberJoin = true 일때만 효력이 있음. dispMemberJoin 이 false 이면 이 옵션은 무시됨.
boolean g_dispMemberJoin_privacy = false;

// 로그인 회원가입승인 메뉴 활성화 옵션
//  dispMemberJoin = true 일때만 활성화 옵션이 동작됨. dispMemberJoin 이 false 이면 이 옵션은 무시됨.
boolean g_dispMemberApprovalMenu = true;

//--------------- 캐쉬 문구 대체 --------------- 시작 (2017.04.05 KKW)
//  ##### 주의1 : igov.properties 파일의 g_dispCashImage 설정을 변경하면 됨.
//  ##### 주의2 : 이 파일의 아래 내용을 그대로 사용해야 하며 전체 내용이나 값을 변경하지 말것.
//String g_dispCashImage = PropertiesManager.getProperties("g_dispCashImage");
//String g_dispCashText = "캐쉬";
//String g_dispCashText2 = "금액";
//String g_dispCashText2_2 = g_dispCashText2 + "은";
//String g_dispCashText3 = "비용";
//String g_dispCashText3_2 = g_dispCashText3 + "은";
//String g_dispCashText4 = "원";
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText = "건수";
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText2 = g_dispCashText;
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText2_2 = g_dispCashText2 + "는";
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText3 = g_dispCashText;
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText3_2 = g_dispCashText3 + "는";
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText4 = "건";
//--------------- 캐쉬 문구 대체 --------------- 끝 (2017.04.05 KKW)

// 등급관리 메뉴와 관련 기능 활성화 옵션 (true:활성화, false:비활성화) (2017.04.26 KKW)
//  ##### 주의 : 위쪽 옵션 중 g_UserCashLimitCheckFlag = "C" , g_addcashLimitCheckFlag = false 로 설정 필요.
//  활성화 시 사용자별 등급을 지정하여 캐쉬(건수)를 설정하게됨. 위쪽 옵션 지정 주의.
//  활성화 시 등급 TBLEVELCODE 테이블 생성 필수
//   CREATE TABLE TBLEVELCODE (LEVELCASH NUMBER(11,3) NOT NULL, LEVELNAME VARCHAR2(40) NOT NULL, DISPORDER NUMBER(3,0) DEFAULT 0, REGDATE DATE);
//   CREATE UNIQUE INDEX IDX_TBLEVELCODE_01 ON TBLEVELCODE(LEVELCASH);
//boolean g_levelCodeUseFlag = false;

// 문자발송 시 바로전에 보낸 메시지와 동일한 내용일 때 경고창 출력 발송확인 활성화 옵션 (true:활성화, false:비활성화) (2017.05.10 KKW)
//boolean g_dupMessageUseFlag = false;

// 공적업무외 문자전송금지 이미지 링크 연결 ("":링크없음 , "/manual/sample.hwp":해당경로해당파일링크)
//   * 위 옵션중 g_yeongdongImgDisplay 옵션이 true 일때에만 효과 발생됨.
//   * hwp 다운안될때 : tomcat cont/web.xml 파일에 아래 내용 추가 후 재시작. 사용자브라우져 캐시삭제.
//			<mime-mapping>
//				<extension>hwp</extension>
//				<mime-type>application/unknown</mime-type>
//			</mime-mapping>
String g_yeongdongImgDisplayFileLink = "/manual/siheung.hwp";

// 사용자 화면의 캐쉬(건수)와 예상발송캐쉬(건수) 표시 여부 옵션 (true:표시, false:미표시) (2017.07.10 KKW)
//   (시흥 dispPossibleSendCnt = false; , g_dispCashTextUseFlag = false;)
//   단, 부서장은 좌측에 부서캐쉬(건수) 건수가 표시됨
//   주의 : 좌측 개별발송가능 건수 표시 옵션은 dispPossibleSendCnt 옵션을 사용 바람
//boolean g_dispCashTextUseFlag = false;

// 개별발송가능 건수 표시 형식 변경 (음성:TYPE_OR , 그외:NORMAL) (2017.07.10 KKW)
//   g_dispPossibleSendCntFormat = "NORMAL";  단문 ->10건 
//   									장문 ->8건 
//   									멀티 ->6건 
//   g_dispPossibleSendCntFormat = "TYPE_OR";  단문 10건 또는 
//   									장문 8건 또는 
//   									멀티 6건 발송 가능
String g_dispPossibleSendCntFormat = "TYPE_OR";

// 공지사항 사용 여부 (true:사용 , false:사용안함) (2017.07.11 KKW)
boolean g_noticeUseFlag = false;

// 공지사항 첨부파일 저장 디렉토리 (igov.properties 에서 NOTICEFILEPATH 설정) (2017.07.11 KKW)
//   (여기서 값을 수정하지 말것)
String g_noticeFilePath = PropertiesManager.getProperties("NOTICEFILEPATH");

// 한글아이디 허용 여부 (true:허용 , false:허용안함) (2017.07.18 KKW)
//boolean g_hangulidFlag = false;

//슈퍼관리자 탑서브메뉴 메뉴간 구분선 높이 설정 (2017.07.25 KKW)
String g_admin_subMenuBarHeight = "255";

// 엑셀전송 개별문자 선택 시 기본 길이를 설정(2017.10.13 KKW)
//   기본설정값 지정 (김해제외) : g_replyDataLength = "10";
//   김해시청 : g_replyDataLength = "20";
String g_replyDataLength = "20";

// 전송화면 주소록 정렬순서 결정  (igov.properties 에서  g_AddressGroupOrderBy 설정) (2017.12.21 KKW)
//   (여기서 값을 수정하지 말것)
// 천안시청 (주소록명 오름차순) : g_AddressGroupOrderBy=TITLE
//							-- (그룹구분 grpflag 값과 g_DeptShareGubun 옵션 영향을 받지 않으며 주소록명 오름차순으로만 정렬)
// 그외 (다른 옵션에 따른 정렬) : g_AddressGroupOrderBy=
//							-- (그룹구분 grpflag 값과 g_DeptShareGubun 옵션 영향에 따른 정렬)
//String g_AddressGroupOrderBy = PropertiesManager.getProperties("g_AddressGroupOrderBy");

// 관리자 접속허용 IP 활성화 여부 (2017.12.28 KKW)
//   (여기서 값을 수정하지 말것)
// g_admin_checkIp=Y : 관리자 접속허용 IP 활성화 (가평군청)
// g_admin_checkIp=N : 관리자 접근허용 IP 비활성화 (가평군청 이외)
//String g_admin_checkIp = PropertiesManager.getProperties("g_admin_checkIp");

// 단문, 장문, 멀티 최대 byte 지정 (2018.02.05 KKW)
//   (여기서 값을 수정하지 말것)
// g_MaxByte_smsurl=80 (default: 80 , 천안시청: 90)
// g_MaxByte_lmsmms=1500 (default: 1500 , 천안시청: 1800)
//String g_MaxByte_smsurl = PropertiesManager.getProperties("g_MaxByte_smsurl");
//String g_MaxByte_lmsmms = PropertiesManager.getProperties("g_MaxByte_lmsmms");

// 직원 주소록 탭 표시 여부 (하동군청 false, 나머지 true) (2018.08.06 KKW)
//* 참고사항 : 주소록 관리에서 직원주소록 기능과 엑셀 저장 허용 여부는 기존 옵션 중 아래 사항을 참고하여 설정할것
//  1) 사용자 - igov.properties 파일 : MEMADDRCOPYFLAG=N , MEMADDREXCELEXPORT=N
//  2) 관리자 - config.jsp 파일 : g_empAddressExcelDownFlag = false
// g_empAddressTabDisplayFlag = false (미표시)
// g_empAddressTabDisplayFlag = true (표시)
//boolean g_empAddressTabDisplayFlag = true;

// 관리자-사용자관리 리스트에 재직상태 검색 표시 여부 (2018.08.20 KKW)
//   (여기서 값을 수정하지 말것)
// g_UserList_WorkState=Y : 관리자 사용자관리 리스트에 재직상태 검색 표시 (화천군청)
// g_UserList_WorkState=N : 관리자 사용자관리 리스트에 재직상태 검색 표시안함
String g_UserList_WorkState = PropertiesManager.getProperties("g_UserList_WorkState");

// 관리자-회원가입승인 리스트에 삭제 기능 표시 여부 (2018.08.21 KKW)
//    + 회원리스트 상세화면에서 사용여부가 "사용", "미사용" 을 --> "승인대기" 로 변경 시 변경 불가능 (2018.11.15 KKW)
// 참고사항 : 우선 g_dispMemberApprovalMenu = true 이어야 함
// g_UserApproval_Delete = true (삭제버튼 표시) (화천군청)
// g_UserApproval_Delete = false (삭제버튼 미표시)
//boolean g_UserApproval_Delete = true;

//관리자-회원 목록에 "승인대기" 회원 제외 여부 (2018.11.15 KKW)
//(여기서 값을 수정하지 말것)
//** 주의 : 화천군청은 config.jsp 에서 g_UserApproval_Delete = true 설정하고, igov.properties 에서 g_UserList_Except_Approval=Y 로 설정할것.
//g_UserList_Except_Approval=Y : 관리자 사용자관리 리스트에 "승인대기" 회원 표시 제외 (화천군청)
//g_UserList_Except_Approval=N : 관리자 사용자관리 리스트에 "승인대기" 회원 표시 제외안함. 기존 쿼리 조건을 따름.
//String g_UserList_Except_Approval = PropertiesManager.getProperties("g_UserList_Except_Approval");

// 공적업무의 사적 문자전송 경고 형태 (2018.11.30 KKW)
//   다른 옵션 중 messageLayerFlag = true 일때에만 실제 적용이 됨
// g_messageLayerVersion = "V1";  (과거 문자 전송창에 경고 출력)
// g_messageLayerVersion = "V2";  (전체 화면을 덮는 경고 출력)
String g_messageLayerVersion = "V2";

// 공적업무의 사적 문자전송 경고 출력 html (2018.11.30 KKW)
//   다른 옵션 중 messageLayerFlag = true 일때에만 실제 적용이 됨
//   다른 옵션 중 g_messageLayerVersion = "V2" 일때에만 실제 적용이 됨 (V1은 common.js 에서 html 수정 필요)
// ------------------
//   기본 문구
//    String g_messageLayerHtml = "<font color='red'>1. 공적업무외 문자전송 자제</font>"
//		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;(공무원 행동강령 제13조)"
//		+ "<br/>"
//		+ "<br/><font color='red'>2. 개인정보(주민등록번호)</font>"
//		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;전송 불가"
//		+ "<br/><br/><br/>";
//   시흥시청 문구
//    String g_messageLayerHtml = "<font color='red'>공적업무 외 전송 금지</font>"
//		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(시흥시 공무원 행동강령 제14조)"
//		+ "<br/><br/>- 개인적인 용도로 사용할 시 불이익이 발생할 수 있음"
//		+ "<br/><br/>- 정보통신과에서 문자 전송 내역 모니터링 실시"
//		+ "<br/><br/><br/>";
String g_messageLayerHtml = "<font color='red'>1. 공적업무외 문자전송 자제</font>"
		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;(공무원 행동강령 제13조)"
		+ "<br/>"
		+ "<br/><font color='red'>2. 개인정보(주민등록번호)</font>"
		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;전송 불가"
		+ "<br/><br/><br/>";

// MO 기능 사용 여부(2019.03.05 cjm)
//   (여기서 값을 수정하지 말것)
// Y:사용, N:미사용
//String g_MO_USE = PropertiesManager.getProperties("g_MO_USE");

// 부서장 기능 사용 여부 옵션 (2019.03.29 KKW)
// g_DeptHeadFunctionYN = "N" : 부서장과 일반 사용자 구분이 없음
// g_DeptHeadFunctionYN = "Y" : 부서장로그인 시 메인 메뉴에 부서장 메뉴 표시. 사용자 설정에서 부서장 지정 가능 (예: 부천시청)
// ** 주의 : Y로 설정 시 기존 부서장 옵션 중 연관되어 동작되는 옵션이 있을 수 있음
//   (여기서 값을 수정하지 말것)
//String g_DeptHeadFunctionYN =  PropertiesManager.getProperties("g_DeptHeadFunctionYN");

// 통합 전송 기능 사용 여부 옵션 (2019.03.29 KKW)
// g_SendIntegrationFunctionYN = "N" : 전송화면이 서브메뉴로 각각 제공되는 기존 전송기능
// g_SendIntegrationFunctionYN = "Y" : 전송화면이 tab으로 구분된 renewal 전송 화면 (예: 부천시청)
String g_SendIntegrationFunctionYN = "Y";

// 발신번호 기능 선택 (2019.05.09 KKW)
// g_CallbackInputType = "" : 값이 없으면 기존 5.0 직접입력 기능
// g_CallbackInputType = "CAUTH" : 값이 CAUTH 이면 부서별 발신번호로 이미 등록된 번호만 선택가능. 기능이 불편하여 향후 수정 필요함.
//String g_CallbackInputType = "";
//String g_CallbackInputType = "CAUTH";

//메시지 전송의 "업무의 성격" 또는 "업무구분" 항목에서 "미분류"(value = 0)인 선택지를 보이게 할지 안보이게 할지 (2019.05.15 cjm)
//통계화면에서는 DB에 등록된 값을 그대로 보여주기 때문에 해당 옵션에 영향을 받지 않는다.
// Y : 미분류 사용(Select Box에 미분류 선택값이 표시)
// N : 미분류 미사용(Select Box에 미분류 선택값이 표시되지 않음)
String g_workSeqZeroCodeUseYN = "Y";

//친구톡에서 이미지 사용여부 (2019.05.20 cjm)
// true : 이미지 사용
// false : 이미지 미사용
//boolean g_FriendTalkImageUseFlag = true;

// 공적업무외 문자전송금지 알림창을 얼마나 자주 표출할지 결정하는 옵션 (2019.06.17 KKW)
// 다른 옵션 중 messageLayerFlag = true 일때에만 효력이 있슴
// 예) String g_messageLayerCycle = "LOGIN"; // 탭별 로그인당 한번만 출력 (부천시청 사용중)
// 예) String g_messageLayerCycle = ""; // 항상 표시
//String g_messageLayerCycle = "LOGIN";

// 공적업무외 문자전송금지 출력 ***친구톡*** 화면 전용 추가 html (2019.06.17 KKW)
//   다른 옵션 중 messageLayerFlag = true 일때에만 실제 적용이 됨
//   다른 옵션 중 g_messageLayerVersion = "V2" 일때에만 실제 적용이 됨 (V1은 common.js 에서 html 수정 필요)
// ------------------
//   기본 문구
//    String g_messageLayerFrdAddHtml = "";
//   부천시청 문구
//    String g_messageLayerFrdAddHtml = "<font color='red'>* 친구톡 발송 제약시간 : 20시 ~ 익일 08시</font>"
//		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;제약시간에는 발송이 실패되므로, 시간을 확인"
//		+ "&nbsp;&nbsp;&nbsp;&nbsp;하시기 바랍니다."
//		+ "<br/><br/><br/>";
String g_messageLayerFrdAddHtml = "";

// MMS image 만 발송가능 옵션 - MMS 텍스트 내용없이 발송 가능한 옵션 (2019.06.19 KKW)
// g_mms_imageonly_send=N : MMS image만 발송 불가능
// g_mms_imageonly_send=Y : MMS image만 발송 가능 (예: 부천시청)
// ** 주의 : (여기서 값을 수정하지 말것)
//String g_mms_imageonly_send =  PropertiesManager.getProperties("g_mms_imageonly_send");

// 사용자 알림톡템플릿 관리 메뉴 표시 옵션 (2019.06.25 KKW)
// boolean g_user_alimtalk_template_manage_menu = true; : 메뉴 표시
// boolean g_user_alimtalk_template_manage_menu = false; : 메뉴 감추기 (부천시청 사용중)
//boolean g_user_alimtalk_template_manage_menu = true;

// 부서장 부서원등록 서브 메뉴 표시 옵션 (2019.06.25 KKW)
// 다른 옵션 중 g_DeptHeadFunctionYN = Y 일때에만 효력이 있슴
// boolean g_master_user_regist_menu = true; : 메뉴 표시
// boolean g_master_user_regist_menu = false; : 메뉴 감추기 (부천시청 사용중)
//boolean g_master_user_regist_menu = true;

// 통합전송 시 전송 메인메뉴를 클릭했을때 이동하는 URL (2019.06.26 KKW)
// String g_integration_send_menu_click_url = "/message/sendALTIntegration.jsp";
// String g_integration_send_menu_click_url = "/message/sendFRTIntegration.jsp";
// String g_integration_send_menu_click_url = "/message/sendSMSIntegration.jsp";
// String g_integration_send_menu_click_url = "/message/sendMMSIntegration.jsp";
String g_integration_send_menu_click_url = "/message/sendALTIntegration.jsp";

// 전송관리 > 내역조회 > 검색날짜 최대기간 월단위 설정(2019.10.21 cjm)
// 검색날짜를 현재 달 기준으로 잡고 몇 달전까지 조회 가능하게 할건지 설정.
// 0 = 기능 사용안함.(기존대로 제약 없음)
// n = n달전 ~ 현재달 (숫자만 입력. 현재월 - n)
int g_messageListSearchMonthLimit = 0;

// 전송관리 > 내역조회 > 검색날짜 최소기간 연단위 설정(2019.10.25 cjm)
// 검색날짜를 현재 년 기준으로 잡고 몇 년전까지 조회 가능하게 할건지 설정.
// 0 = 현재 연도만 조회 가능 (현재 연도로 나오지만 월이 나오지 않아 사용불가)
// n = n년전 ~ 현재 연도 (숫자만 입력. 현재년 - n)
int g_messageListSearchYearLimit = 5;
%>
