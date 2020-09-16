<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- FILEMAXSIZE
g_excle_max_num
g_excle_encoding
EXCEL_SHEET_DATA_COUNT
fakeNumberPreventPopUpUseFlag
g_CallbackInputType
 -->
 
 <!-- 경조사 기능여부  사용:Y 미사용:N 경조사휴일관리 -->
<spring:message code="familyEventUseFlag" var="familyEventUseFlag" /> 

 <!-- 경조사 상시 발송 -->
<spring:message code="familyEventUseFlagAlways" var="familyEventUseFlagAlways" /> 

 <!-- 경조사 발송계정 -->
<spring:message code="familyEventMasterId" var="familyEventMasterId" /> 

<!-- 발신번호 직접입력 -->
<spring:message code="form_num_input" var="form_num_input" /> 

<!-- 미리보기 버튼 -->
<spring:message code="previewActive" var="previewActive" /> 

<%-- <spring:message code="areaCodeActive" var="areaCodeActive" /> 
<spring:message code="areaCode" var="areaCode" />  --%>

<!-- 지정휴대폰 자동표시 -->
<spring:message code="form_num_auto" var="form_num_auto" />

<!-- 광고자제메세지 보여줄지 말지  -->
<spring:message code="messageLayerFlag" var="messageLayerFlag" />

<!-- 광고자제메세지 로그인당 1회 매번표시  -->
<spring:message code="g_messageLayerCycle" var="g_messageLayerCycle" />


<spring:message code="g_dispCashTextUseFlag" var="g_dispCashTextUseFlag" /> 

<!--  -->
<spring:message code="sending_refusal_check" var="sending_refusal_check" /> 
<!-- 최대전송갯수 -->
<spring:message code="max_receive_cnt" var="max_receive_cnt" /> 

<spring:message code="g_empAddressTabDisplayFlag" var="g_empAddressTabDisplayFlag" /> 

<!-- 주소록 부서탭명  -->
<spring:message code="send_address_part_name" var="send_address_part_name" /> 
<!-- 주소록 공유탭명  -->
<spring:message code="send_address_share_name" var="send_address_share_name" /> 

 
<spring:message code="g_dupMessageUseFlag" var="g_dupMessageUseFlag" /> 
<spring:message code="g_MaxByte_smsurl" var="g_MaxByte_smsurl" /> 
<spring:message code="g_MaxByte_lmsmms" var="g_MaxByte_lmsmms" /> 
<spring:message code="mms_only_image" var="mms_only_image" /> 
<spring:message code="image_auto_resize" var="image_auto_resize" /> 
<spring:message code="mms_max_pixel" var="mms_max_pixel" /> 
<spring:message code="mms_max_size" var="mms_max_size" /> 
<spring:message code="mms_auto_resize_pixel" var="mms_auto_resize_pixel" /> 
<spring:message code="image_auto_resize_pixel" var="image_auto_resize_pixel" /> 

<!-- 친구톡 이미지 사용여부 -->
<spring:message code="g_FriendTalkImageUseFlag" var="g_FriendTalkImageUseFlag" /> 
<!--  경조사 페이지 모드 0 단문장문 1 단문장문멀티 2 친구톡 3멀티톡 -->
<spring:message code="familyEventTypeFlag" var="familyEventTypeFlag" /> 
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>iGOV SMS SYSTEM</title> 
<style>
.cursor_point {cursor: pointer;}
.umMybox { border:2px solid; border-color:red; }
.background-eaeaea{ background-color:eaeaea;}

.disable {
   color: #ccc;
   pointer-events: none;
   cursor: default;
}

#umPopRecentLayer, #ufPopRecentLayer, #uaPopRecentLayer{
	position: absolute;
	display: none;
	background-color: #ffffff;
	border: solid 2px #d0d0d0;
	width: 350px;
	height: 150px;
	padding: 10px;
}
#umPopRecentLayer, #ufPopRecentLayer, #uaPopRecentLayer div {
	position: absolute;
	top: 5px;
	right: 5px
}
.btnSelect {
	cursor: pointer;
}

.display_none {
	display:none;
}

/* 대체문자 내용 div */
.word-break-break-all{
	word-break:break-all;
}
</style>
<script type="text/javaScript" language="javascript" defer="defer">
/* 천체 사용자권한가져오기  */ 
/* console.log("-------userInfo---------" +
		"${loginVO.sms_role}"  +
		"${loginVO.lms_role}"  +
		"${loginVO.mms_role}"  +
		"${loginVO.noti_role}"  +
		"${loginVO.notilms_role}"  +
		"${loginVO.fri_role}"  +
		"${loginVO.frilms_role}"  +
		"${loginVO.frimms_role}"
); */
var roleSMS = "${loginVO.sms_role}"; /* 무조건 1 */
var roleLMS = "${loginVO.lms_role}";
var roleMMS = "${loginVO.mms_role}";
var roleFRI = "${loginVO.fri_role}"; 
var roleFRILMS = "${loginVO.frilms_role}";
var roleFRIMMS = "${loginVO.frimms_role}"; 
var roleNOT = "${loginVO.noti_role}"; 
var roleNOTLMS = "${loginVO.notilms_role}";

/* user 월한도 캐시 */
var uCashSMS = "${loginVO.sms}";
var uCashLMS = "${loginVO.lms}";
var uCashMMS = "${loginVO.mms}";
var uCashNMS = "${loginVO.nms}";
var uCashFMS = "${loginVO.fms}"; 
 
var USERCASH = {};

var globalId = "${loginVO.id}";



/* 개별문자처리용 변수 */
var arrUMVariables = [];
var arrUFVariables = [];
var arrUCVariables = [];

var arrUMLstFlag = 0; /* 문자보내기용 0 전송목록없음   1 주소록목록   2.엑셀목록 */
var arrUFLstFlag = 0; /* 친구톡용 0 전송목록없음   1 주소록목록   2.엑셀목록 */

/* 최근 전송번호 5개 */
var arrUMRecentLst = [];
var arrUFRecentLst = [];
var arrUARecentLst = []; 
var arrUCRecentLst = []; 


/* 사용자 저장함 배열 */
var arrSaveS = [];
var arrSaveL = [];
var arrSaveM = [];
var arrSaveF = [];
var arrSaveE = []; /* ? 화면설계서에는 경조사탭 있음 */
		
/* 문자보내기 친구톡 내 저장함 탭 */
var umSaveTableS;
var umSaveTableL;
var umSaveTableM;
var umSaveTableF;
var umSaveTableC; 

/* 친구톡 내 저장함 탭   오류남 */
var ufSaveTableS;
var ufSaveTableL;
var ufSaveTableM;
var ufSaveTableF;
var ufSaveTableC; 

/* 내저장함 선택변수 */
var umCurMySave = [];
var ufCurMySave = []; 
/* 템플릿 저장변수 */ 
var uaCurTemplate = [];
var oTableTemplet;
var oTableTempletUC;

/* 친구톡 버튼배열 */
var p_seq = 0;
var p_ua_seq = 0;  //알림톡용
var arrButtonF = []; 
var arrButtonN = []; 
var arrButtonC = []; 

/* 0봇키워드 1메세지버튼  2웹링크 3앱링크 4배송조회 */
var arrTypeHtml = [
	"<span id='t_btn_name_BK'><input type='text' placeholder='버튼명' id='link_name_bk' name='link_name_bk' size='14' maxlength='28' value=''></span>",
	"<span id='t_btn_name_MD'><input type='text' placeholder='버튼명' id='link_name_md' name='link_name_md' size='14' maxlength='28' value=''></span>",
	"<span id='t_btn_input_WL'><input type='text' placeholder='버튼명' id='link_name_wl' name='link_name_wl' size='14' maxlength='28' value=''><br> Mobile<br><input type='text' id='link_mo' name='link_mo' style='width:200px;' maxlength='500' value=''><br>PC(옵션)<input type='text' id='link_pc' name='link_pc' style='width:200px;' maxlength='500' value=''></span>",
	"<span id='t_btn_input_AL'><input type='text' placeholder='버튼명' id='link_name_al' name='link_name_al' size='14' maxlength='28' value=''><br> URL(Android)<input type='text' id='link_andr' name='link_andr' style='width:200px;' maxlength='500' value=''><br>URL(iOS)<input type='text'id='link_ios'  name='link_ios' style='width:200px;' maxlength='500' value=''></span>",
	"<span id='t_btn_input_DS'>※ '배송 조회하기' 고정 문구</span>"
];
var arrTypeHtmlUC = [
	"<span id='t_btn_name_BK'><input type='text' placeholder='버튼명' id='uc_link_name_bk' name='link_name_bk' size='14' maxlength='28' value=''></span>",
	"<span id='t_btn_name_MD'><input type='text' placeholder='버튼명' id='uc_link_name_md' name='link_name_md' size='14' maxlength='28' value=''></span>",
	"<span id='t_btn_input_WL'><input type='text' placeholder='버튼명' id='uc_link_name_wl' name='link_name_wl' size='14' maxlength='28' value=''><br> Mobile<br><input type='text' id='link_mo' name='link_mo' style='width:200px;' maxlength='500' value=''><br>PC(옵션)<input type='text' id='link_pc' name='link_pc' style='width:200px;' maxlength='500' value=''></span>",
	"<span id='t_btn_input_AL'><input type='text' placeholder='버튼명' id='uc_link_name_al' name='link_name_al' size='14' maxlength='28' value=''><br> URL(Android)<input type='text' id='link_andr' name='link_andr' style='width:200px;' maxlength='500' value=''><br>URL(iOS)<input type='text'id='link_ios'  name='link_ios' style='width:200px;' maxlength='500' value=''></span>",
	"<span id='t_btn_input_DS'>※ '배송 조회하기' 고정 문구</span>"
];


var arrTypeHtmlUM = [
	"<span id='t_btn_name_um'><input type='text' placeholder='버튼명' id='link_name' name='link_name' size='14' maxlength='28' value=''></span>",
	"<span id='t_btn_name_1_um'><input type='text' placeholder='버튼명' id='link_name_1' name='link_name_1' size='14' maxlength='28' value=''></span>",
	"<span id='t_btn_input_WL_um'>Mobile<br><input type='text' id='link_mo' name='link_mo' style='width:200px;' maxlength='500' value=''><br>PC(옵션)<input type='text' id='link_pc' name='link_pc' style='width:200px;' maxlength='500' value=''></span>",
	"<span id='t_btn_input_AL_um'>URL(Android)<input type='text' id='link_andr' name='link_andr' style='width:200px;' maxlength='500' value=''><br>URL(iOS)<input type='text'id='link_ios'  name='link_ios' style='width:200px;' maxlength='500' value=''></span>",
	"<span id='t_btn_input_DS_um'>※ '배송 조회하기' 고정 문구</span>"
];
			
/* 대체문자용 배열 */
var arrUFReContent = [];
var arrUAReContent = []; 	
var arrUCReContent = []; 		

/* 사용자 문자 최종리스트 배열   
 * 
 * User 
 * Message 단문/장문/멀티
 * Friend 친구톡
 * Alarm 알림톡
 * Lst List 목록
 */
var arrUMLst = [];
var arrUFLst = [];
var arrUALst = [];
var arrUCLst = [];

/* 
  사용자 문자 그룹리스트
 User Message group list 
 indivisual 개인 I   part 부서 P    employ 직원 E    share 공유 S 
 Detail 상세리스트
 Push 등록전 리스트
*/
var arrUMPLst = []; 
var arrUFPLst = [];
var arrUAPLst = [];
var arrUCPLst = [];

/* 단문/장문/멀티 */ /* ajax json data 그룹리스트 불러오기 */
var arrUMGLst = {};
/* var arrUMIGLst = {}; 
var arrUMPGLst = {};
var arrUMEGLst = {};
var arrUMSGLst = {}; */

/* 친구톡 */
var arrUFGLst = {};
/* var arrUFIGLst = {}; 
var arrUFPGLst = {};
var arrUFEGLst = {};
var arrUFSGLst = {}; */

/* 알림톡 */
var arrUAGLst = {}; 
/* var arrUAIGLst = {}; 
var arrUAPGLst = {};
var arrUAEGLst = {};
var arrUASGLst = {}; */

/* 경조사  */
var arrUCGLst = {}; 


/* ajax json data 그룹지정 주소록 리스트 불러오기 */
var arrUMGDLst = {};
var arrUFGDLst = {}; 
var arrUAGDLst = {};
var arrUCGDLst = {};


/* 전송리스트 배열에서 특정 행 빼기 */
function arrayPop_UM(idx){ 
	arrUMLst.splice(idx,1);
	//console.log(arrUMLst);
}
function arrayPop_UF(idx){ 
	arrUFLst.splice(idx,1);
	//console.log(arrUFLst);
}
function arrayPop_UA(idx){ 
	arrUALst.splice(idx,1);
	//console.log(arrUALst);
}
function arrayPop_UC(idx){ 
	arrUCLst.splice(idx,1);
	//console.log(arrUCLst);
}

/*
 * 그룹상세주소록 리스트 체크 해제
 */
function indivi_check_UM(idx, address_id){
	arrUMGDLst[idx].rowNo == 1 ? arrUMGDLst[idx].rowNo = 0 : arrUMGDLst[idx].rowNo = 1;
}

function indivi_check_UF(idx, address_id){
	arrUFGDLst[idx].rowNo == 1 ? arrUFGDLst[idx].rowNo = 0 : arrUFGDLst[idx].rowNo = 1;
}

function indivi_check_UA(idx, address_id){
	arrUAGDLst[idx].rowNo == 1 ? arrUAGDLst[idx].rowNo = 0 : arrUAGDLst[idx].rowNo = 1;
}

function indivi_check_UC(idx, address_id){
	arrUCGDLst[idx].rowNo == 1 ? arrUCGDLst[idx].rowNo = 0 : arrUCGDLst[idx].rowNo = 1;
}


/*
* 그룹체크 체크 해제  | 그룹에 속한 핸펀리스트 render
*/

/* 그룹리스트 가져오기 */
function AjaxGroupList(tab,classname,tabprefix) {
	$("." + classname ).empty();
	$.ajax({
    	type: "POST",
    	url: "/grp/AddrGroupListByType.do?type=" + tab,
        dataType: "json",          // ajax 통신으로 받는 타입
        contentType: "application/json",  // ajax 통신으로 보내는 타입
        beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
        },
		complete:function(){
            $('.wrap-loading').addClass('display-none');
        },
    	success: function(jsondata){

    		var idx = 1;
    		var object = jsondata.data;
    		
    		if(tabprefix == "m") 	arrUMGLst = jsondata.data;
    		if(tabprefix == "f") 	arrUFGLst = jsondata.data;
    		if(tabprefix == "a") 	arrUAGLst = jsondata.data;
    		if(tabprefix == "c") 	arrUCGLst = jsondata.data;
			//console.log("======주소록리스트=======");
			//console.log(JSON.stringify(object));
			
    		/* 최초그룹리스트 Render */
    		var iidx=0; var eidx=0; var pidx=0; var sidx=0;
			arrURI = ["getaddressbookmy.do","getaddressbookpart.do","getaddressbookshare.do","getaddressbookemploy.do"]; 
    		
    		$.each(object, function(idx, row){ 
					var tabtype = object[idx].type;
    				var html = "<li><div class=\"checkbox-small_2\">" +
    				"<input type=\"checkbox\" "
    						+ "id=\"u"+tabprefix+"check_"+ tabtype + "_" + idx + "\" "
    						+ "name=\"u"+tabprefix+"_group_check_" + tabtype  + "\" "
    				 		+ "onclick=\"msg_check_u"+tabprefix+"(this," 
    				 				+ object[idx].code + ","
    				 				+ "'.u"+tabprefix+"_pop_detail_list'," 
    				 				+ idx + ","
    				 				+ "'"+ arrURI[tabtype] + "'," 
    				 				+ tabtype
    				 		+ ");\" />" +
    				"<label for=\"u"+tabprefix+"check_" + tabtype + "_" + idx + "\"></label>" + 
    				"</div><span>" + object[idx].title + "<span>(" + object[idx].groupcnt + ")</span></span></li>";
    				$("." + classname ).append(html);
    		}); 

            $('.wrap-loading').addClass('display-none'); 
    	},
    	error: function(request,status,error){
    		  
    		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
            $('.wrap-loading').addClass('display-none');
    	}
	}); /* ajax */
}



/* 문자보내기 그룹코드별 상세주소록리스트 */
function msg_check_um(dom, code, rstdom, arrNum, url, tabtype){ 

	/* checkbox radio */ 
	
    if($(dom).is(":checked")){ 
    	$('input[type="checkbox"][name="um_group_check_' + tabtype  + '"]').prop('checked',false);
    	$(dom).prop('checked',true);
    	for(var i in arrUMGLst){
    		arrUMGLst[i].rowNo = 0;
    	}
    	arrUMGLst[arrNum].rowNo = 1;
    }else{
    	$('input[type="checkbox"][name="um_group_check_' + tabtype  + '"]').prop('checked',false);
    	$(dom).prop('checked',false);
    	arrUMGLst[arrNum].rowNo = 0;
    } 
	
	
	/* 제거하면 이중선택을 할 수 있다  */	
	$(rstdom).empty(); 

	 
	/* 체크인지 아닌지 조건 */
	//arrUMGLst[arrNum].rowNo == 1 ? arrUMGLst[arrNum].rowNo = 0 : arrUMGLst[arrNum].rowNo = 1;
	
	//console.log("---- code -----" + code + ": -----arrNum:" + arrNum + ":-------check rowNo:" + arrUMGLst[arrNum].rowNo);
    
	var object = [];
	//var data  = [{ address_category : code }];
    //data: JSON.stringify(data)
	//address_grp_name = tempAddr
    //address_category = globalGroupId;
	$.ajax({
    	type: "POST",
    	url: "<c:url value='/" + url + "?address_category=" + code + "' />",
        dataType: "json",          // ajax 통신으로 받는 타입/
        /* contentType: "application/json",  // ajax 통신으로 보내는 타입 */
        beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
    		/* $('#sendMsgBtn').attr('disabled', false); */
        },
		complete:function(){
            $('.wrap-loading').addClass('display-none');
    		/* $('#sendMsgBtn').attr('disabled', false); */
        },
    	success: function(jsondata){
    		
    		var idx = 1;
    		object = jsondata.data;
    		////console.log(object);

    		arrUMGDLst = jsondata.data;
    		//console.log(arrUMGDLst);
    		
    		
    	    if($(dom).is(":checked")){
    	        //console.log("체크박스 체크했음!");
    			//getUserByGroup(code); 
    			$.each(object, function(idx, row){
    				var html = "<li id='" + code + "_" + idx + "'><div class=\"checkbox-small_2\">" +
    				"<input type=\"checkbox\" id=\"umcheck-"+ tabtype + "_" + idx + "gd\" name=\"msg_group_user_um" + idx + "\" onclick=\"indivi_check_UM(" + idx + "," + object[idx].address_id + ")\"  />" +
    				"<label for=\"umcheck-"+ tabtype + "_" +  idx + "gd\"></label>" + 
    				"</div><span>" + object[idx].address_name + "<span>" + object[idx].address_num + "</span></span></li>";
    				$(rstdom).append(html);  
    			});
    	        //
    	        
				
    	        //getUserByGroup(code);
    	    }else{
    	    	//console.log("체크박스 체크 해제!");
    			$.each(object, function(idx, row){
    				$('#' + code + "_" + idx).remove();
    				//$(dom).prop('checked',false);
    			});
    	    	
    	        //getUserByGroup(code);
    	    } 	 
    		 
    		
    		/* var res = JSON.stringify(object); */ 
    		 
    		//close popup
    	},
    	error: function(request,status,error){
    		  
    		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        	//$('#result').text(error);
        	//alert("serialize err");
    		/* $('#sendMsgBtn').attr('disabled', false); */
            $('.wrap-loading').addClass('display-none');
    	}
	}); /* ajax */
	
	

	
} 





function msg_check_uf(dom, code, rstdom, arrNum, url, tabtype){ 
	 
	
    if($(dom).is(":checked")){ 
    	$('input[type="checkbox"][name="uf_group_check_' + tabtype  + '"]').prop('checked',false);
    	$(dom).prop('checked',true);
    	for(var i in arrUFGLst){
    		arrUFGLst[i].rowNo = 0;
    	}
    	arrUFGLst[arrNum].rowNo = 1;
    }else{
    	$('input[type="checkbox"][name="uf_group_check_' + tabtype  + '"]').prop('checked',false);
    	$(dom).prop('checked',false);
    	arrUFGLst[arrNum].rowNo = 0;
    } 

	$(rstdom).empty();
	var object = [];
 	
 	$.ajax({
     	type: "POST",
    	url: "<c:url value='/" + url +"?address_category=" + code +"' />",
         dataType: "json",          // ajax 통신으로 받는 타입
         /* contentType: "application/json",  // ajax 통신으로 보내는 타입 */
         beforeSend:function(){
             $('.wrap-loading').removeClass('display-none');
     		/* $('#sendMsgBtn').attr('disabled', false); */
         },
 		complete:function(){
             $('.wrap-loading').addClass('display-none');
     		/* $('#sendMsgBtn').attr('disabled', false); */
         },
     	success: function(jsondata){
     		
     		var idx = 1;
     		object = jsondata.data;
     		////console.log(object);

     		arrUFGDLst = jsondata.data;
     		//console.log(arrUFGDLst);
     		
     		
     	    if($(dom).is(":checked")){
     	        //console.log("체크박스 체크했음!");
     			//getUserByGroup(code); 
     			$.each(object, function(idx, row){
     				var html = "<li id='" + code + "_" + idx + "'><div class=\"checkbox-small_2\">" +
     				"<input type=\"checkbox\" id=\"ufcheck-" + idx + "gd\" name=\"msg_group_user_uf" + idx + "\" onclick=\"indivi_check_UF(" + idx + "," + object[idx].address_id + ")\"  />" +
     				"<label for=\"ufcheck-" + idx + "gd\"></label>" + 
     				"</div><span>" + object[idx].address_name + "<span>" + object[idx].address_num + "</span></span></li>";
     				$(rstdom).append(html);  
     			});
     	        //
     	        //getUserByGroup(code);
     	    }else{
     	    	//console.log("체크박스 체크 해제!");
     			$.each(object, function(idx, row){
     				$('#' + code + "_" + idx).remove();
     			});
     	    	
     	        //getUserByGroup(code);
     	    } 	 
     		 
     		
     		/* var res = JSON.stringify(object); */ 
     		 
     		//close popup
     	},
     	error: function(request,status,error){
     		  
     		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
         	//$('#result').text(error);
         	//alert("serialize err");
     		/* $('#sendMsgBtn').attr('disabled', false); */
             $('.wrap-loading').addClass('display-none');
     	}
 	}); /* ajax */
 } 
 

 function msg_check_ua(dom, code, rstdom, arrNum, url, tabtype){  
		
	    if($(dom).is(":checked")){ 
	    	$('input[type="checkbox"][name="ua_group_check_' + tabtype  + '"]').prop('checked',false);
	    	$(dom).prop('checked',true);
	    	for(var i in arrUAGLst){
	    		arrUAGLst[i].rowNo = 0;
	    	}
	    	arrUAGLst[arrNum].rowNo = 1;
	    }else{
	    	$('input[type="checkbox"][name="ua_group_check_' + tabtype  + '"]').prop('checked',false);
	    	$(dom).prop('checked',false);
	    	arrUAGLst[arrNum].rowNo = 0;
	    } 
 	
	$(rstdom).empty();
	var object = [];
 	
 	$.ajax({
     	type: "POST",
    	url: "<c:url value='/" + url + "?address_category=" + code + "' />",
         dataType: "json",          // ajax 통신으로 받는 타입
         /* contentType: "application/json",  // ajax 통신으로 보내는 타입 */
         beforeSend:function(){
             $('.wrap-loading').removeClass('display-none');
     		/* $('#sendMsgBtn').attr('disabled', false); */
         },
 		complete:function(){
             $('.wrap-loading').addClass('display-none');
     		/* $('#sendMsgBtn').attr('disabled', false); */
         },
     	success: function(jsondata){
     		
     		var idx = 1;
     		object = jsondata.data;
     		////console.log(object);

     		arrUAGDLst = jsondata.data;
     		//console.log(arrUAGDLst);
     		
     		
     	    if($(dom).is(":checked")){
     	        //console.log("체크박스 체크했음!");
     			//getUserByGroup(code); 
     			$.each(object, function(idx, row){
     				var html = "<li id='" + code + "_" + idx + "'><div class=\"checkbox-small_2\">" +
     				"<input type=\"checkbox\" id=\"uacheck-" + idx + "gd\" name=\"msg_group_user_gd" + idx + "\" onclick=\"indivi_check_UA(" + idx + "," + object[idx].address_id + ")\"  />" +
     				"<label for=\"uacheck-" + idx + "gd\"></label>" + 
     				"</div><span>" + object[idx].address_name + "<span>" + object[idx].address_num + "</span></span></li>";
     				$(rstdom).append(html);  
     			});
     	        //
     	        //getUserByGroup(code);
     	    }else{
     	    	//console.log("체크박스 체크 해제!");
     			$.each(object, function(idx, row){
     				$('#' + code + "_" + idx).remove();
     			});
     	    	
     	        //getUserByGroup(code);
     	    } 	 
     		 
     		
     		/* var res = JSON.stringify(object); */ 
     		 
     		//close popup
     	},
     	error: function(request,status,error){
     		  
     		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
         	//$('#result').text(error);
         	//alert("serialize err");
     		/* $('#sendMsgBtn').attr('disabled', false); */
             $('.wrap-loading').addClass('display-none');
     	}
 	}); /* ajax */
 } 
 
 
 
 

function msg_check_uc(dom, code, rstdom, arrNum, url){ 
	 
	$(rstdom).empty();
	 
 	/* 체크인지 아닌지 조건 */
 	arrUCGLst[arrNum].rowNo == 1 ? arrUCGLst[arrNum].rowNo = 0 : arrUCGLst[arrNum].rowNo = 1;
 	
 	//console.log("---- code -----" + code + ": -----arrNum:" + arrNum + ":-------check rowNo:" + arrUCGLst[arrNum].rowNo);
     
 	var object = [];
	var data  = [{ address_category : code }];
	
 	$.ajax({
     	type: "POST",
    	url: "<c:url value='/" + url + "?address_category=" + code +"' />",
         dataType: "json",          // ajax 통신으로 받는 타입
         data: JSON.stringify(data),
         /* contentType: "application/json",  // ajax 통신으로 보내는 타입 */
         beforeSend:function(){
             $('.wrap-loading').removeClass('display-none');
     		/* $('#sendMsgBtn').attr('disabled', false); */
         },
 		complete:function(){
             $('.wrap-loading').addClass('display-none');
     		/* $('#sendMsgBtn').attr('disabled', false); */
         },
     	success: function(jsondata){
     		
     		var idx = 1;
     		object = jsondata.data;
     		////console.log(object);

     		arrUCGDLst = jsondata.data;
     		//console.log(arrUCGDLst);
     		
     		
     	    if($(dom).is(":checked")){
     	        //console.log("체크박스 체크했음!");
     			//getUserByGroup(code); 
     			$.each(object, function(idx, row){
     				var html = "<li id='" + code + "_" + idx + "'><div class=\"checkbox-small_2\">" +
     				"<input type=\"checkbox\" id=\"uccheck-" + idx + "gd\" name=\"msg_group_user_uc" + idx + "\" onclick=\"indivi_check_UC(" + idx + "," + object[idx].address_id + ")\"  />" +
     				"<label for=\"uccheck-" + idx + "gd\"></label>" + 
     				"</div><span>" + object[idx].address_name + "<span>" + object[idx].address_num + "</span></span></li>";
     				$(rstdom).append(html);  
     			});
     	        //
     	        //getUserByGroup(code);
     	    }else{
     	    	//console.log("체크박스 체크 해제!");
     			$.each(object, function(idx, row){
     				$('#' + code + "_" + idx).remove();
     			});
     	    	
     	        //getUserByGroup(code);
     	    } 	 
     		 
     		
     		/* var res = JSON.stringify(object); */ 
     		 
     		//close popup
     	},
     	error: function(request,status,error){
     		  
     		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
         	//$('#result').text(error);
         	//alert("serialize err");
     		/* $('#sendMsgBtn').attr('disabled', false); */
             $('.wrap-loading').addClass('display-none');
     	}
 	}); /* ajax */
 } 
 
 
 
 
 /*
  * 그룹상세주소록 리스트 체크 해제
  */
function msg_check_receiver(cb, code){
	var obj = {"code" : code };
	$.ajax({
    	url: "/getRcvaddrListByGroup.do",  //msg/rcv/EgovRcvaddrList
    	type: "POST",
        dataType: "json",          // ajax 통신으로 받는 타입
        contentType: "application/json",  // ajax 통신으로 보내는 타입
        data: obj,
        beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
    		$('#sendMsgBtn').attr('disabled', false);
        },
		complete:function(){
            $('.wrap-loading').addClass('display-none');
    		$('#sendMsgBtn').attr('disabled', false);
        },
    	success: function(jsondata){ 
    		
    		var idx = 1;
    		var object = jsondata.data;    		

    		$.each(object, function(idx, row){
    			if(object[idx].type == "0"){
					var html = "<li><div class=\"checkbox-small_2\">" +
					"<input type=\"checkbox\" id=\"check-" + idx + "\" name=\"msg_group_check" + idx + "\" onclick=\"msg_check(this," + object[idx].code + ");\" />" +
					"<label for=\"check-" + idx + "\"></label>" + 
					"</div><span>" + object[idx].title + "<span>" + object[idx].code + "</span></span></li>";
					$('.msg_send_my').append(html); 
    			}
    			
    			if(object[idx].type == "1"){
					var html = "<li><div class=\"checkbox-small_2\">" +
					"<input type=\"checkbox\" id=\"check-" + idx + "\" name=\"msg_group_check" + idx + "\" />" +
					"<label for=\"check-" + idx + "\"></label>" + 
					"</div><span>" + object[idx].title + "<span>" + object[idx].code + "</span></span></li>";
					$('.msg_send_employ').append(html); 
    			}
    			
    			if(object[idx].type == "2"){
					var html = "<li><div class=\"checkbox-small_2\">" +
					"<input type=\"checkbox\" id=\"check-" + idx + "\" name=\"msg_group_check" + idx + "\" />" +
					"<label for=\"check-" + idx + "\"></label>" + 
					"</div><span>" + object[idx].title + "<span>" + object[idx].code + "</span></span></li>";
					$('.msg_send_part').append(html); 
    			}
    			
    			if(object[idx].type == "3"){
					var html = "<li><div class=\"checkbox-small_2\">" +
					"<input type=\"checkbox\" id=\"check-" + idx + "\" name=\"msg_group_check" + idx + "\" />" +
					"<label for=\"check-" + idx + "\"></label>" + 
					"</div><span>" + object[idx].title + "<span>" + object[idx].code + "</span></span></li>";
					$('.msg_send_share').append(html);
    			}        			
    		});
    		
    	 
    		if(jsondata['data'] == "index.do"){
    			location.href = "index.do";
    		}
    		
    		var res = JSON.stringify(object);
    		//alert(res); //로딩
    		
    		//clear
    		if(jsondata['result_msg'] == "ok"){
    			$("#tblsendmsg tbody").remove(); 
        		$('#title_msg').val(""); 
        		$('#content_msg').val(""); 
    		}
    		//$('#result').text("전송시간:" + res); 
            toastr.success('성공적으로 전정되었습니다'); 
            /* $(".pop_templet").css('display','none'); */

            $('.wrap-loading').addClass('display-none');
    		$('#sendMsgBtn').attr('disabled', false);
    		//close popup
    	},
    	error: function(request,status,error){
    		  
    		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        	//$('#result').text(error);
        	//alert("serialize err");
    		$('#sendMsgBtn').attr('disabled', false);
            $('.wrap-loading').addClass('display-none');
    	}
	});
	
	
	
	if(cb.checked==true){
		//.msg_send_group에 넣기
		var html ="<li><div class=\"checkbox-small_2\"><input type=\"checkbox\" id=\"check-g-1\" name=\"check-g-1\" />" + 
		          "<label for=\"check-g-1\"></label></div><span>테스트1<span>01042139120</span></span></li>";		          
		$('.msg_send_group').append(cb);
	}else{
		//.msg_send_group에서 빼기
		var html ="<li><div class=\"checkbox-small_2\"><input type=\"checkbox\" id=\"check-g-1\" name=\"check-g-1\" />" + 
		          "<label for=\"check-g-1\"></label></div><span>테스트1<span>01042139120</span></span></li>";	
		$('.msg_send_group').remove(cb);
	}
}


/* 전송 데이터 byte 를 계산해주는 function */
function getByteLength(subject){
	if (subject == null || subject.length == 0) {
		return 0;
	}
	var size = 0;

	for ( var i = 0; i < subject.length; i++) {
		size += this.charByteSize(subject.charAt(i));
	}
	return size;
}

function charByteSize(ch){
	if (ch == null || ch.length == 0) {
		return 0;
	}
	var charCode = ch.charCodeAt(0);

	if (charCode <= 0x00007F) {
		return 1;
	} else if (charCode <= 0x0007FF) {
		return 2;
	} else if (charCode <= 0x00FFFF) {
		return 3;
	} else {
		return 4;
	}
}
/* 전송 데이터 byte 를 계산해주는 function */


	/********************* cookie *************************/	 
	function setCookie(name, value, days) {
	    if (days) {
	            var date = new Date();
	            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
	            var expires = "; expires=" + date.toGMTString();
	    } else {
	           var expires = "";
	    }
	    
	    document.cookie = name + "=" + value + expires + "; path=/";
	}



	function getCookie(name) {
	    var i, x, y, ARRcookies = document.cookie.split(";");
	    
	    for (i = 0; i < ARRcookies.length; i++) {     
	            x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
	            y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
	            
	            x = x.replace(/^\s+|\s+$/g, "");

	            if (x == name) {
	                    return unescape(y);
	            }
	    }
	} 

	function deleteCookie(cookieName){
	    var temp=getCookie(cookieName);
	    if(temp){
	        setCookie(cookieName,temp,(new Date(1)));
	    }
	}
	/********************* cookie *************************/


	/* 세션값 */
	if (window.sessionStorage) {

		//console.log(sessionStorage);
		//sessionStorage.setItem('저장할 이름 - 문자열', '저장할 객체');
        //var position = sessionStorage.getItem('저장된 이름');
    }

 
	
	
	
//엑셀다운로드 최대용량 65536  error: Exception
var excel_max_size = "<spring:message code='g_refuse_use' javaScriptEscape='true' ></spring:message>";
var bnr_warning = "<spring:message code='bnr_warning' javaScriptEscape='true' ></spring:message>";



var messageLayerFlag = "<spring:message code='messageLayerFlag' javaScriptEscape='true' ></spring:message>";
var g_messageLayerCycle = "<spring:message code='g_messageLayerCycle' javaScriptEscape='true' ></spring:message>";
var familyEventUseFlagAlways = "<spring:message code='familyEventUseFlagAlways' javaScriptEscape='true' ></spring:message>"; 

var partTabName = "<spring:message code='send_address_part_name' javaScriptEscape='true' ></spring:message>"; 
var shareTabName = "<spring:message code='send_address_share_name' javaScriptEscape='true' ></spring:message>"; 

/* 직원탭  */
var g_empAddressTabDisplayFlag = "<spring:message code='g_empAddressTabDisplayFlag' javaScriptEscape='true' ></spring:message>"; 

/* 예상비용표시 */
var g_dispCashTextUseFlag = "<spring:message code='g_dispCashTextUseFlag' javaScriptEscape='true' ></spring:message>"; 


/* 전송시 수신거부록체크 */
var sending_refusal_check = "<spring:message code='sending_refusal_check' javaScriptEscape='true' ></spring:message>"; 

/* 최대 수신자 등록가능 건수 제한 */
var max_receive_cnt = "<spring:message code='max_receive_cnt' javaScriptEscape='true' ></spring:message>"; 


/* 단문 제한갯수 */
var g_MaxByte_smsurl = "<spring:message code='g_MaxByte_smsurl' javaScriptEscape='true' ></spring:message>"; 
/* 장문 멀티 제한갯수 */
var g_MaxByte_lmsmms = "<spring:message code='g_MaxByte_lmsmms' javaScriptEscape='true' ></spring:message>"; 

/* 문자보내기탭  content없이 이미지만 보내기 가능   */ 
var mms_only_image = "<spring:message code='mms_only_image' javaScriptEscape='true' ></spring:message>";  



/* MMS 자동 리사이징여부 */
var image_auto_resize = "<spring:message code='image_auto_resize' javaScriptEscape='true' ></spring:message>"; 
/* 이미지 자동리사이즈 크기 */
var image_auto_resize_pixel = "<spring:message code='image_auto_resize_pixel' javaScriptEscape='true' ></spring:message>"; 
/* MMS 이미지 최대 크기 pixel */
var mms_max_pixel = "<spring:message code='mms_max_pixel' javaScriptEscape='true' ></spring:message>"; 
/* MMS 이미지 최대 용량 */
var mms_max_size = "<spring:message code='mms_max_size' javaScriptEscape='true' ></spring:message>"; 
/* MMS 이미지 자동리사이즈 크기 */
var mms_auto_resize_pixel = "<spring:message code='mms_auto_resize_pixel' javaScriptEscape='true' ></spring:message>"; 

/* 직접입력 */
var form_num_input = "<spring:message code='form_num_input' javaScriptEscape='true' ></spring:message>"; 

/* 기본 핸드폰체크 */
var form_num_auto = "<spring:message code='form_num_auto' javaScriptEscape='true' ></spring:message>";   



/* 부서탭   */ 
var departActive = "<spring:message code='departActive' javaScriptEscape='true' ></spring:message>";  

/* 미리보기 버튼  */
var previewActive = "<spring:message code='previewActive' javaScriptEscape='true' ></spring:message>"; 

/* 메세지 삭제버튼  */ 
var msgDelete = "<spring:message code='msgDelete' javaScriptEscape='true' ></spring:message>";  


/* 수신번호  080 옵션일때 본문끝에 붙이는 TXT */
var refusal_txt = "\n거부/무료 080-1111-2222";	/*문자보내기에서 수신거부목록을 체크해 온다 */
 
/* 친구톡 이미지업로드 버튼 표시여부 */
var g_FriendTalkImageUseFlag = "<spring:message code='g_FriendTalkImageUseFlag' javaScriptEscape='true' ></spring:message>";

/* 이전 전송 메세지와 현재 전송메세지가 같은가? 체크 */
var g_dupMessageUseFlag = "<spring:message code='g_dupMessageUseFlag' javaScriptEscape='true' ></spring:message>";

/* 경조사옵션 마스터 계정으로 발송 */
var familyEventMasterId = "<spring:message code='familyEventMasterId' javaScriptEscape='true' ></spring:message>";


var g_workSeqZeroCodeUseYN = "<spring:message code='g_workSeqZeroCodeUseYN' javaScriptEscape='true' ></spring:message>";
var workSeqRequiredFlag = "<spring:message code='workSeqRequiredFlag' javaScriptEscape='true' ></spring:message>";


/* 경조사용 페이지 모드 */
var pageMode = "<spring:message code='familyEventTypeFlag' javaScriptEscape='true' ></spring:message>"; 


/*  SESSION 변수    */
var uSMobile; 
var uSTel; 

/* RF_050_04 
 * 앞자리 0 추가및 유효성 체크
 */
/* 엑셀입력시 수신번호 체크 */
function chkPhoneNumber(num,k){
	var count = []; 
		
		////console.log("====start===num:" + num + "====length:" + num.length + "=====phone:" + num.substr(0,3));
		/* 0 빠진 엑셀 */
		if(num.length === 10 && num.substr(0,2) === "10" ){
			////console.log("====10개번호===num:" + num + "====length:" + num.length + "=====phone:" + num.substr(0,3));
			num = "0" + num;
		}
		
		if(num.length !== 11 || num.substr(0,3) !== "010"){
			//console.log("====Not Number===num:" + num + "====length:" + num.length + "=====phone:" + num.substr(0,3));
			toastr.error( k + "번째 " + num + "은 부정확한 번호입니다");
			return "0";
		}   
		
	
	return num;
}


/* 경조사 발송불가시 화면처리 */
function tab1_click() {
	////console.log("------tabl click--------");
	/* $("#tab-1").trigger("click"); */
	document.getElementById("tab-1")[0].click();
}

function isEmpty(value){ 
	////console.log(typeof value);
	////console.log(value);
	////console.log(Object.keys(value).length);
	if( value=="null" || value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){ 
		return true;
	}else{ 
		return false; 
	} 
}

/* 업무분류 */
var jobOptLst;


/* 가격 */
var unitPrice;

/* 전송유형 */
var unitType = "SMS";

/* MMS */
var umImgFile = {};
var ufImgFile = {};
var uaImgFile = {};
var ucImgFile = {};


var umExcelFileName;
var chkError = false;

/* 버튼 */
var arrButtonJSON = "";
var ucBtnListJSON = "";

/*****************전송타입유형을 정하고 예상비용을 산정한다*******건수대비 전송가격**********/
/* 전송타입설정  */
function checkType(tabname){
	var contentsTxt = $("#"+ tabname +"Content" ).text();
	var contentsHtml = $("#"+ tabname +"Content" ).html();
	var unitType;
	var contLen = getByteLength(contentsTxt);
	
	if(tabname === "um"){
		if(umImgFile.length){ 
			unitType = "MMS";
		}else{
			if(contentsTxt.length < 90){
				unitType = "SMS";
			}else{
				unitType = "LMS";
			}
		}
		////console.log("-----문자보내기:이미지-" + umImgFile.length +":type-" + unitType + ":length" + contentsTxt.length);
	}
	
		
	if(tabname === "uf"){
		if(ufImgFile.length){
			unitType = "FRI";
		}else{
			unitType = "FRT";
		}
	}
	
	if(tabname === "ua"){
		unitType ="SMS_G";
	}
	
	if(tabname === "uc"){
		
		//단문 장문
		if(pageMode=="2"){ 
			if(contentsTxt.length < 90){
				unitType = "SMS";
			}else{
				unitType = "LMS";
			}
		} 
		
		//단문 장문 멀티 
		if(pageMode=="3"){

			if(ucImgFile.length){ 
				unitType = "MMS";
			}else{
				if(contentsTxt.length < 90){
					unitType = "SMS";
				}else{
					unitType = "LMS";
				}
			}
		}
		
		//친구톡
		if(pageMode=="0"){ 
			if(ucImgFile.length){
				unitType = "FRI";
			}else{
				unitType = "FRT";
			}
		}
		
		//알림톡
		if(pageMode=="1"){
			unitType ="NOT";
		}
	}
	
	
	return unitType;
}





/* 코드에 따르는 가격 */
function getPriceByCode(paycode){
	return unitPrice[paycode];
}

/* 유저캐쉬체크 */
function usrCashCheck(pay_code, cost){
	
	var usercash = USRCASH[pay_code] - cost; //월간한도 - 사용한도
	return usercash - cost; 
	/*
	$.ajax({
	    url: "/usrCashCheck.do?pay_code="+pay_code + "&pay_fee="+ pay_fee,
	    type: "POST",
	    dataType: "json",
	    success: function(jsondata){  
	       	return jsondata.data; 
	    },
	    error: function(request,status,error){
			toastr.error(" 전송중에 오류가 발생했습니다 에러코드 : " + error);
	    	return false;
	    }
	});
	*/
}

/* 전송타입명설정  */ 
/* 단문 장문 멀티  친구톡 텍스트   친구톡 이미지  알림톡 */
function checkName(type){
	var unitnameArr = {"SMS":"단문","LMS":"장문","MMS":"멀티", "NOT":"알림톡",
			"FRT":"친구톡","FRI":"친구톡",
			"SMS_G":"알림톡 대체단문","LMS_G":"알림톡 대체장문","MMS_G":"알림톡 대체멀티"
	};
	var unitname = unitnameArr[type];
	return unitname;	
}

/* 가격설정  */
function SetPrice(tabname, totalcnt){
	
	
	 var unittype = checkType(tabname);
	 var unitname = checkName(unittype);
    /* 단문 */
       
    	var smsP = unitPrice[unittype];
    	var realPrice = smsP *totalcnt; 
    	
    	//올림처리
    	realPrice = Math.ceil(realPrice); 
    	$("#"+ tabname + "Price" ).text(unitname + "  " + realPrice + " 원");
}

/* 최근 전송 5건 */
function PopupRecentLst(btnID,listID,popupID,arrName){

	$(btnID).mouseover(function(e){ //조회 버튼 마우스 오버시
		
		var sWidth = window.innerWidth;
		var sHeight = window.innerHeight;

		var oWidth = $(popupID).width();
		var oHeight = $(popupID).height();

		// 레이어가 나타날 위치를 셋팅한다.
		var divLeft = e.clientX - oWidth*1.5;
		var divTop = e.clientY - oHeight;

		// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
		//if( divLeft + oWidth > sWidth ) divLeft -= oWidth*2;
		//if( divTop + oHeight > sHeight ) divTop -= oHeight;

		// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
		//if( divLeft < 0 ) divLeft = 0;
		//if( divTop < 0 ) divTop = 0;
		
		////console.log(sWidth + ":" + sHeight + ":::" + oWidth + ":" + oHeight + "--divLeft:" + divLeft); 
		if(arrName.length == 0){ $(listID).append("최근 전송한 내역이 없습니다"); }
		arrName.forEach(function(element){
    		//console.log(element); 
    		var name = element.title;
    		var phone = element.phone;
    		var html = "<li><span>" + name + "</span><span>" + phone + "</span></li>";
    		$(listID).append(html);
		}); 
		
		$(popupID).css({
			"top": divTop,
			"left": divLeft,
			"position": "absolute"
		}).show();
 	});
	
	$(btnID).mouseout(function(e){ //조회 버튼 마우스 오버시
		$(listID).empty();
		$(popupID).hide();
 	});
}

/************************ 대체문자 ****************************/
function ReContentEditMode(id,btnId){
	$("#"+id).attr("contenteditable",true);
	
	/*대체문자로 지정이 되어있을경우 무조건 활성화*/
	$("#"+ btnId).removeClass('background-efefef');
	$("#"+ btnId).addClass('background-8bc5ff');
	$("#"+ btnId).css({ 'pointer-events': 'auto' });
	toastr.success("편집모드로 변경되었습니다. 수정후 대체문자로 지정하세요");
}

function ReContentRegister(conId, btnId, type, mode){

	var content = $('#'+conId).text(); /* 이미지나 버튼들은  배열에 저장 */
	
	if(mode == "UA"){
		arrUAReContent.push({
			type : type,
			content : content
		});
	}else if(mode == "UC"){
		arrUCReContent.push({
			type : type,
			content : content
		});
	}else{
		arrUFReContent.push({
			type : type,
			content : content
		});
	}


	$('#'+conId).attr("contenteditable",false);
	toastr.success("대체문자가 지정되었습니다");
	
	$('#'+ btnId).removeClass('background-8bc5ff');
	$('#'+ btnId).addClass('background-efefef');
	$('#'+ btnId).css({ 'pointer-events': 'none' });
}


function removeHtml(text){
	text = text.replace(/<br\/>/ig, "\n");
	text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
}
/************************** 대체문자 ***************************/	
	

$(document).ready(function (){ 
	
	
	
	
	/*
	* RF_046_01
	* 20200906 ERROR: tab 설정시에  CSS width 자동LEFT정렬 및 tab지정오류
	*
	*/ 
	
  	if(roleSMS ==="0" && roleLMS ==="0" && roleMMS ==="0"){ $("#tab-1").addClass('display_none'); }
  	
	if( roleFRI ==="0" ){ 
		$("#tab-2").addClass('display_none'); 
	}
	
	if( roleNOT ==="0" ){ $("#tab-3").addClass('display_none'); }  
	
	
	/* 업무분류가져오기   */
	$.ajax({
        	type: "POST",
        	url: "/usr/work.do",
            dataType: "json",          // ajax 통신으로 받는 타입
            contentType: "application/json",  // ajax 통신으로 보내는 타입
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
            },
        	success: function(jsondata){
 
        		var object = jsondata.data; 
        		var price = jsondata.price; 
        		var cash = jsondata.cash; 
        		
        		/* 테스트 설정  */
        		//unitPrice = price;
        		unitPrice = { "SMS" : price.sms, "LMS" : price.lms, "MMS" : price.mms, "NOT" : price.notice,
        				"FRT" : price.friend_txt, "FRI" : price.friend_img,
        				"SMS_G" : price.sms_g, "LMS_G" : price.lms_g, "MMS_G" : price.mms_g };
        		
        		USRCASH = { 
						"SMS" : uCashSMS - cash.SMS, 
						"LMS" : uCashLMS - cash.LMS, 
						"MMS" : uCashMMS - cash.MMS, 
						"NOT" : uCashNMS - cash.NOT, 
						"FRT" : uCashFMS - cash.FRT, 
						"FRI" : uCashFMS - cash.FRI,
						"FIT" : uCashFMS - cash.FIT
				}; 
        		
        		var opt;
        		$.each(object, function(idx, row){ 
        			//console.log("-----key--:"+idx+"------row:" + row.codenM);
        			opt += "<option value='" + row.code  + "' > " + row.codeNm + "</option>";	
        		});  
        		
				if(g_workSeqZeroCodeUseYN == "Y") opt += "<option value=\"0\" selected>미분류</option>";
				if(workSeqRequiredFlag == "Y") opt += "<option value=\"\" selected>선택해주세요</option>";
				
    			jobOptLst = opt;
        		$('#umJobOpt').append(jobOptLst); 
        		$('#ufJobOpt').append(jobOptLst); 
        		$('#uaJobOpt').append(jobOptLst);  
        		$('#ucWorkLstOpt').append(jobOptLst); 
                $('.wrap-loading').addClass('display-none'); 
        	},
        	error: function(request,status,error){
        		  
        		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
                $('.wrap-loading').addClass('display-none');
        	}
   	}); /* ajax */
   	
   	

   	
	
	/* 발신번호 input값에 null이 표기되어서 */
	if(isEmpty(sessionStorage.getItem("uSMobile"))){
		uSMobile = "";
	}else{
		uSMobile =  sessionStorage.getItem("uSMobile");
	}
	
	if(isEmpty(sessionStorage.getItem("uSTel"))){
		uSTel = "";
	}else{
		uSTel =  sessionStorage.getItem("uSTel");
	}
	
	
	/* 전송에 필요한  세션변수 보기 테스트*/
	//console.log("----sessionStorage-----" + sessionStorage.getItem("iSender"));
	
	var iSender = sessionStorage.getItem("iSender");
	//for (item in iSender) {
	//    console.log("item:" + item + "::::" + iSender[item]);
	//}
	
	/*
    OPTION RF-058-04 친구톡 이미지 표시여부  
	*/ 
	if(g_FriendTalkImageUseFlag == "N"){
		$('#ufImgUpBtn').hide();	
	}

	

	/* RF_046_03  발신번호 입력
	*  
	*/
	/* 발신번호 직접입력모드로 */
	if(form_num_input == "Y"){
		
		$("#umSendNumDirect").show();
		$("#umSendNumCombo").hide();
		$("#ufSendNumDirect").show();
		$("#ufSendNumCombo").hide();
		$("#uaSendNumDirect").show();
		$("#uaSendNumCombo").hide();
		$("#ucSendNumDirect").show();
		$("#ucSendNumCombo").hide();
		
		if( form_num_auto == "Y"){ /* 핸드폰 체크 */
			$("input:radio[id='umPhoneNum']:radio[value='2']").prop('checked', true);  /* 기본 핸드폰 */
			$("input:radio[id='ufPhoneNum']:radio[value='2']").prop('checked', true);  /* 기본 핸드폰 */
			$("input:radio[id='uaPhoneNum']:radio[value='2']").prop('checked', true);  /* 기본 핸드폰 */
			$("input:radio[id='ucPhoneNum']:radio[value='2']").prop('checked', true);  /* 기본 핸드폰 */
		}else{
			$("input:radio[name='umOfficeNum']:radio[value='1']").prop('checked', true);  /* 옵션선택 사무실 */
			$("input:radio[name='ufOfficeNum']:radio[value='1']").prop('checked', true);  /* 옵션선택 사무실 */
			$("input:radio[name='uaOfficeNum']:radio[value='1']").prop('checked', true);  /* 옵션선택 사무실 */
			$("input:radio[name='ucOfficeNum']:radio[value='1']").prop('checked', true);  /* 옵션선택 사무실 */
		}
		
	}else{		
		$("#umSendNumCombo").show();
		$("#umSendNumDirect").hide();
		$("#ufSendNumCombo").show();
		$("#ufSendNumDirect").hide();
		$("#uaSendNumCombo").show();
		$("#uaSendNumDirect").hide();
		$("#ucSendNumCombo").show();
		$("#ucSendNumDirect").hide();		
	}
	
	

	/* 
	* RF_046_08 예상비용 표시
	*/
	/* 예상비용표시 */ 
	if(g_dispCashTextUseFlag == "N"){  
		$('#umCost').hide(); 
		$('#ufCost').hide(); 
		$('#uaCost').hide(); 
	} 
	
	/* 부서탭명  공유탭명 적용 */	
	$('#umPartTab').text(partTabName);
	$('#ufPartTab').text(partTabName);
	$('#uaPartTab').text(partTabName);
	
	$('#umShareTab').text(shareTabName);
	$('#ufShareTab').text(shareTabName);
	$('#uaShareTab').text(shareTabName);
	/* 부서탭명  공유탭명 적용 */
	
	
	
	if(g_empAddressTabDisplayFlag == "Y"  &&  departActive == "Y"){  
		
		$('.umEmployTab').hide(); 
		$('.umPartTab').hide(); 
		$('ul.tabmenu_small > li:nth-child(4) > label').css('left','75px');  
		$('.ufEmployTab').hide(); 
		$('.ufPartTab').hide(); 
		$('ul.tabmenu_small_ftalk > li:nth-child(4) > label').css('left','75px');  
		$('.uaEmployTab').hide(); 
		$('.uaPartTab').hide(); 
		$('ul.tabmenu_small_alarm > li:nth-child(4) > label').css('left','75px'); 
		
	}else{

		/* 직원탭 보여기기 */
		if(g_empAddressTabDisplayFlag == "Y"){ 
			console.log("---- 직원탭 숨기기 ---");
			$('.umEmployTab').hide(); $('ul.tabmenu_small > li:nth-child(4) > label').css('left','150px');  
			$('.ufEmployTab').hide(); $('ul.tabmenu_small_ftalk > li:nth-child(4) > label').css('left','150px');  
			$('.uaEmployTab').hide(); $('ul.tabmenu_small_alarm > li:nth-child(4) > label').css('left','150px');  
		}
		
		/* 부서탭 보여기기  RFP없음 보류 */
		if(departActive == "Y"){ 
			console.log("---- 부서탭 숨기기 ---");		 
			$('.umPartTab').hide(); 
			$('ul.tabmenu_small > li:nth-child(3) > label').css('left','75px');
			$('ul.tabmenu_small > li:nth-child(4) > label').css('left','150px');  
			$('.ufPartTab').hide();
			$('ul.tabmenu_small_ftalk > li:nth-child(3) > label').css('left','75px');
			$('ul.tabmenu_small_ftalk > li:nth-child(4) > label').css('left','150px');   
			$('.uaPartTab').hide(); 
			$('ul.tabmenu_small_alarm > li:nth-child(3) > label').css('left','75px');
			$('ul.tabmenu_small_alarm > li:nth-child(4) > label').css('left','150px');  
		}
	}
	
	
	
	/* 미리보기 버튼 */ 
	if(previewActive == "N"){ 
		//console.log("---- 미리보기 버튼 ---"); 
		$('#umPreviewBtn').hide(); 
		$('#ufPreviewBtn').hide(); 
		$('#uaPreviewBtn').hide(); 
		$('#ucPreviewBtn').hide(); 
	}  

	/* 메세지삭제 버튼 */
	if(msgDelete == "N"){ 
		//console.log("---- 메세지삭제 버튼 ---"); 
		$('#umContentClearBtn').hide(); 
		$('#ufContentClearBtn').hide(); 
		$('#uaContentClearBtn').hide(); 
		$('#ucContentClearBtn').hide(); 
	}

	/* 친구톡 이미지업 버튼 표시여부 */

	
	var isCheckbnr = true;
	
	/*
	로그인 캐쉬가 살아있을때  로그인1회시만 
	*/
    var logCheck = getCookie("loginCheckPop");
	//console.log("messageLayerFlag:" + messageLayerFlag);
	//console.log("g_messageLayerCycle:" + g_messageLayerCycle);
	//console.log("loginCheckPop:" + logCheck);

	/* RF_046_06 메세지표시  RF_046_07 메세지표시옵션
	*
	*
	*/
	if(messageLayerFlag == "Y"){

		if( g_messageLayerCycle == "Y" && logCheck ){  //로그인시 1번만 로그인 쿠키가 살아있다면 
			$(".pop_bg").show();
			$("#pop_warning").show();
    	    setCookie("loginCheckPop", "false", 1);
		}else{  
			$(".pop_bg").show();
			$("#pop_warning").show();
		}
	}
	
	
	
	$('#tab-4').on("click", function(){		

		//console.log("tab-4 click");
		
		/* 발송금지 */
		//console.log("trim처리 전:" + familyEventUseFlagAlways);
		familyEventUseFlagAlways.trim();		
		//console.log("trim처리 후:" + familyEventUseFlagAlways);
		
		familyEventUseFlagAlways = "Y"; //테스트
		
		if( familyEventUseFlagAlways == "N" ){			 
			/*
			금요일 19시 이후 , 토, 일 발송가능
			경조사 휴일리스트에만 발송가능
			발송불가시 경조사화면 표시되기 전에 발송불가알림
			*/
			var d = new Date();
			var week = d.getDay();
			//console.log("주 차:0일요일 " + week + ":시간" + d.getHours() );
			
			/* ajax 경조사 휴일가져와서 현재 날짜와 비교하여 지정된 휴일에만 보내기  */
			
			
			if( ( week < 5 ) || ( week == 5 && ( d.getHours() < 19 ) ) ){
				//console.log("--------------------발송시간이 아닙니다 -------------");
				$(".pop_bg").show();
				$("#pop_warning2").show();
				/* $("#tab-1").trigger("click"); */
				return false; /* 경조사 발송불가시 화면처리 */
			}
			
		}
	});
	
	
});



</script>
</head>
<body>

<!-- session값 리스트 -->
<div id="sessionList"></div>

			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>전송</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>전송</li>
						<li><span class="dot"></span>문자보내기</li>
					</ul>
				</h1>  


				<div class="width-1350px height-710px margin-bottom-100">
					<ul class="sendM_tabmenu">
						<li id="tab-1" class="btnCon">
						<c:import url="/usr/sendermessage.do"></c:import>							
						</li>
						<li id="tab-2" class="btnCon">						
						<c:import url="/usr/senderfriend.do"></c:import>	
						</li>
						<li id="tab-3" class="btnCon">						
						<c:import url="/usr/sendernotice.do"></c:import>	
						</li>
						<li id="tab-4" class="btnCon">						
						<c:import url="/usr/sendercongratuation.do"></c:import>	
						</li> 
					<c:if test="${familyEventUseFlag eq 'N'}" >	 
					</c:if>
					</ul>
				</div>
			</div>
		</div>



		 <!-- popup _방침-->
         <div class="pop_wrap width-300px" id="pop_warning">
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-ff6464 line-height-20px" >
				1. 공적업무외 문자전송 자제<br><span class="font-14px font-aaa">(공무원 행동강령 제13조)</span><br><br>
				2. 개인정보(주민등록번호)<br><span class="font-14px font-aaa">전송 불가</span>
			</div>
			<!--버튼-->
			<div class="pop_btn">
				<a class="pop_close background-8bc5ff border-8bc5ff font-fff">확인</a>
			</div>
        </div>

<!-- popup 경조사 발송가능 시간  -->
         <div class="pop_wrap width-300px" id="pop_warning2">
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-ff6464 line-height-20px" >
				<span class="font-14px font-aaa">현재 시간에는 발송을 할 수 없습니다.</span>
				<span class="font-14px font-aaa">발송가능 시간 </span>
				<span class="font-14px font-aaa">금요일 19시 이후, 토요일 , 일요일
				경조사휴일
				기타 지정시간</span>
			</div>
			<!--버튼-->
			<div class="pop_btn">
				<a class="pop_close background-8bc5ff border-8bc5ff font-fff" >확인</a>
			</div>
        </div>




</body>
</html>
