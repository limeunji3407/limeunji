<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_workSeqZeroCodeUseYN" var="g_workSeqZeroCodeUseYN" /> 
<spring:message code="workSeqRequiredFlag" var="workSeqRequiredFlag" /> 

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
#ucCounter {
  background:rgba(255,0,0,0.5);
  border-radius: 0.5em;
  padding: .5em .5em .5em .5em;
  text-align: center;
  text-color: #fff;
  font-weight: bold;
}
</style>
<script type="text/javaScript" language="javascript" defer="defer">
 
/*
 *  RF_036_04 스팸문자를 발송할 수 없도록 지정된 내용과 폼으로 메시지를 전송
 *
 *
 *  0  UF
 *  1  UA
 *  2  USL  단문/장문
 *  3  USLM 단문/장문/멀티톡
 *
 *
 *
 */


/************* GLOBAL ****************/
/* 페이지모드 setprice를 위해 egovSender에 선언 */
//var pageMode = "<spring:message code='familyEventTypeFlag' javaScriptEscape='true' ></spring:message>"; 



/* 전송paycode */
var ucPayCode = "SMS";  /* LMS MMS FRI NOT */
/* 전송구분코드 */
var ucSendType = "0";  /* 0-SMS  1-LMS  2-MMS  3-FRI  4-NOT */

/* 친구톡 버튼리스트  EgovSender에 선언 */
//var ucBtnListJSON = "";

/* 지정계정발송 */
var senderId = "<c:out value="${familyEventMasterId}" />";  //지정계정대리발송 RF_034_04

/* 최근전송내역 */
var arrUCRecentLst = [];

/* 대체문자 지정된 내용  type:SMS content:내용 */
var arrUCReContent = [];

/* 알림톡 변수값 */
var ucTmpVars = "";

/* 경조사 템플릿 받아오기 */
var ucCurTemplate= [];

/* 재전송 내용 */
var reContent = "";

/* 재전송 코드  */
//var reType = "SMS"; //4다문 6장문멀티

/* 알림톡 이미지파일  EgovSender선언*/
//var ucImgFileName = "";
//var ucImgFile = {};

//EgovSender Define
//var arrUCLst=[]; //최종전송리스트
/************* GLOBAL ****************/


/*
 * 주요 로컬 변수 
 * tempData  전송데이터 : 컨텐츠 + 주소록리스트
 * 
 *
 *
 *
 */



/* 공통 초기 세팅   */
function pageInit(){
	$('.loading_bar').show();
	
	//TEST 
	/* var d = new Date(); 
	var month = d.getMonth() + 1 ;
	var currentDate = d.getFullYear() + "년 " + month  + "월 " + d.getDate() + "일"; 
	var currentTime = d.getHours() + "시 " + d.getMinutes() + "분 " + d.getSeconds() + "초";
	$('#ucTitle').val(currentDate);
	$('#ucContent').html("현재시각 " + currentDate + "=======" + currentTime + "======" + ucPayCode  + "====" + pageMode ); */
	//TEST 	
	
/* 	if(pageMode === 1){
		
		$("#ucMyBox").addClass("none");
		$("#ucContentClearBtn").addClass("none");
		$("#ucPopBtnAddBtn").addClass("none");
		$("#pageUF").addClass("none");
		$("#ucCounter").addClass("none");
		$("#ucPopImgUploadBtn").addClass("none");
		$("#ucContentTmp").addClass("none");
		$("#pageSLM").addClass("none");
		$("#ucTemplateBox").addClass("none");
		$("#pageUA").addClass("none");

	}
*/
	
	pageMode = "0";
	
	/* 친구톡 */
	if(pageMode === "0"){ 
		$("#ucCounter").addClass("none");
		$("#ucTemplateBox").addClass("none");
		//$("#ucContentTmp").addClass("none"); 
		$("#pageUA").addClass("none"); 

		$("#ucVars1").addClass("none");  
		$("#ucVars2").addClass("none"); 
		

		$("#ucContentsChange").removeClass("none");
	}

	/* 알림톡 */
	if(pageMode === "1"){
		$("#ucMyBox").addClass("none");
		$("#ucContentClearBtn").addClass("none");
		$("#ucPopBtnAddBtn").addClass("none");
		$("#ucCounter").addClass("none");
		$("#ucPopImgUploadBtn").addClass("none");
		$("#ucContentTmp").addClass("none");  
		$("#ucContentsChange").addClass("none"); 
		
		$("#pageUF").addClass("none"); 
		
		$("#ucVars1").removeClass("none");   
		$("#ucVars2").removeClass("none");  
		$("#pageUA").removeClass("none"); 
		$("#ucTemplateBox").removeClass("none");
	}
	

	if(pageMode === "2" || pageMode === "3" ){
		$("#ucPopBtnAddBtn").addClass("none");
		$("#ucTemplateBox").addClass("none");
		$("#pageUF").addClass("none"); 
		$("#pageUA").addClass("none"); 
		$("#ucVars1").addClass("none");  
		$("#ucVars2").addClass("none"); 
		
		if(pageMode === "2"){
			$('#ucPopImgUploadBtn').hide();
		}
		
		$("#ucContentsChange").removeClass("none");
	}
	 
	
	
	
	$('.loading_bar').hide();
}

/* 전송후 클리어 */
function pageClear(){
	
}

/* 클래스 */
function eventPage(){
	
} 


/* 서버로 전송하기 */
function send(){
	
}


/* 리스트 제거 */
function arrUCLstPop(idx){ 
	var idx = arrUCLst.indexOf(idx); 
	arrUCLst.splice(idx,1);
	if(!arrUCLst.length){
		//console.log("------disable -> enable -----:" + idx);
		arrUCLstFlag = 0; 
	} 
	$("#ucTotalCnt").text("총 " + arrUCLst.length + "건");
	SetPrice("uc",arrUCLst.length);
}

$(document).ready(function(){ 
	
	
	/* 경고팝업 */
	/*
	var bnr_cong = "<spring:message code='bnr_cong' javaScriptEscape='true' ></spring:message>"
	var address = unescape(location.href);
	var param = "";
	
	if(address.indexOf("tab",0)!=-1){
		param = address.substring(address.indexOf("tab",0)+4)
		console.log("param :: "+param);
	}
	
	if(bnr_cong == "Y" && param ==4){
		$('#tabmenu-4').prop('checked',true); 
	}
	*/
	
	
	/* 초기화   */
	pageInit();
	pageClear();
	
	
	

	/*
	제목글자수체크
	*/
	$('#ucTitle').keydown(function (e){
	    var title = $(this).val();
	    
	    //$('#counter').html("("+content.length+" / 최대 200자)");    //글자수 실시간 카운팅

	    if ( Number(byteCheck($(this))) > 30){ 
	    	//$(this).val(title.substring(0, title.length - 1));
	    	
	    	//e.preventDefault();
	    	$('#ucContent').focus();
	    	toastr.error("최대 30BYTE까지만 입력 가능합니다.");
	    	f_chk_byte($(this),30);
	    	return onlyBackspace(e); 
	    }
	});
	
	/*
	내용글자수체크
	*/
	$('#ucContent').keydown(function (e){
		
	    var content = $(this).text();
	    //text

	    if ( Number(byteCheck($(this))) == 90 ){   
	    	e.preventDefault(); 
	    	toastr.error("단문은 최대 90BYTE까지만 입력 가능합니다."); 
	    }
	    
	    if ( Number(byteCheck($(this))) > 1800 ){  
	    	e.preventDefault();
	    	//$('#phonelist').focus();
	    	toastr.error("최대 1800BYTE까지만 입력 가능합니다.");
	    	f_chk_byte($(this),1800);
	    }
	    
 		if( Number(byteCheck($(this))) > 90 ){
 			totalCnt = "1800";
 		}else{
 			totalCnt = "90";
 		}
 		
       /*  $(this).height(((content.split('\n').length + 1) * 1.5) + 'em'); */
        $('#ucCounter').html(content.length + '/' + totalCnt );
       
        if(arrUCLst.length){
        	SetPrice("uc", arrUCLst.length);
        }
        
	});
 

	//제목내용 클리어
	$('#ucContentClearBtn').on('click', function(){	 
		$('#ucTitle').val(""); 
		$('#ucContent').empty(); 
	});	
	
	
	//보내는번호입력
	$('input:radio[name=ucSendNumRadio]').change(function() {
		
		var sendnumType = $('input:radio[name=ucSendNumRadio]:checked').val(); 
		
		if(sendnumType === "3") {
			$('#ucSendNum').val(""); 
		}else if(sendnumType === "1"){ //사무실 
			if( isEmpty(uSTel) ){
				uSTel = "";
				toastr.error("발송용 사무실번호가 없습니다.입력해주세요");
			}
			$('#ucSendNum').val(uSTel);
		}else{ //사무실 핸드폰 
			if( isEmpty(uSMobile) ){
				uSMobile = "";
				toastr.error("발송용 핸드폰번호가 업습니다.입력해주세요");
			}
			$('#ucSendNum').val(uSMobile);
		}
		
	}); 
	
	
	/*********************************************** 내저장함 ************************************/
	/* 내저장함 가져오기*/
	/* 내저장함 */
	$('#ucMyBoxBtn').on('click', function(){	
		////console.log("----------------내저장함---------------");

		var dom = $(this).parents(".tabmenu_search");
		var searchKey = dom.find("select[name='searchKey']").val();
		var searchValue = dom.find("input[name='searchValue']").val();
		var tab = $("input[name='pop_tabmenu_uc_mybox']:checked").val();
		
		var param = {
				"userId":globalId,
				"searchCnd":searchKey,
				"searchWrd":searchValue
		}
		
		if(tab == 'S'){
			ucSaveTableS.ajax.url( "/getMySaveS.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'L'){
			ucSaveTableL.ajax.url( "/getMySaveL.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'M'){
			ucSaveTableM.ajax.url( "/getMySaveM.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'F'){
			ucSaveTableF.ajax.url( "/getMySaveF.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'C'){
			ucSaveTableC.ajax.url( "/getMySaveC.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}
		


		ucSaveTableS = ucSaveTableInit("ucTemplateS", "/getMySaveS.do", "cntS");
		ucSaveTableL = ucSaveTableInit("ucTemplateL", "/getMySaveL.do", "cntL");
		ucSaveTableM = ucSaveTableInit("ucTemplateM", "/getMySaveM.do", "cntM");
		ucSaveTableF = ucSaveTableInit("ucTemplateF", "/getMySaveF.do", "cntF");
		ucSaveTableC = ucSaveTableInit("ucTemplateC", "/getMySaveC.do", "cntC");

		$(".pop_bg").css('display','block');
		$('#ucMyBoxPopUp').css('display','block');		
	});
	
	/* 내저장함 팝업시 초기화오류로 인해 */
	$('#ucMyBoxCloseBtn').on('click', function(){
		 destroyTableUC();
	});
	
	

	/* 내저장함에 저장하기 */
	$('#ucMyBoxSave').on('click', function(){
		
		var title = $("#ucTitle").val();
		//var subject = $("#ucContent").val();
		var mmsInfo =  ucImgFile;                        //$("#ucContent").html(); /* 이미지 MMS */ 
		var subject = $("#ucContent").html(); 
		var subjectLength = getByteLength(subject); 
		var status = 'C';
		
		if(subjectLength<=90){
			status = 'S';
			////console.log("단문입니다. byte : "+subjectLength+", status : "+status);
		}else{
			status = 'L';
			////console.log("장문입니다. byte : "+subjectLength+", status : "+status);
		}
		
		var obj = {
			"title" : title,
			"subject" : subject,
			"status" : status,
			"imgFile" : ucImgFile
		}
		
		////console.log("obj :: "+JSON.stringify(obj));		
		$.ajax({
	       	url: "<c:url value='/usr/insertMySave' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){   
	       		////console.log(jsondata["data"]); 
	            if(jsondata["data"]==0){
	                //로딩
	                toastr.success("저장되었습니다.");
	            }else{
	            	toastr.error("입력 중에 오류가 발생했습니다. 입력값들 다시한번 확인해주시기 바랍니다.");
	            }
	       	},
	       	error: function(request,status,error){ 
	       		////console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	           	$('#result').text(jsondata);
	           	//////console.log("serialize err");
	       		$('#addrBtn').attr('disabled', false);
	       	}
	   	});
	});

	/*********************************************** 내저장함 ************************************/
	
	
	
	

	
	
	
	/************************************* 템플릿 선택 및 템플릿 팝업***************************************/
	$('#ucPopTempletBtn').on('click', function(){
		 
		//console.log("-------mysaveSMS Insert Start ------");
		oTableTempletUC = $('#ucTemplate').DataTable({
				dom : "frtip",
				ajax : { "url" : "<c:url value='/getTemplate' />" },
				columns : [ {
					data : "template_content",
					data : "template_code",
					data : "sender_key",
					data : "template_buttons",
					data : "template_variables"
				}],
				searching : false,
				paging : true,
				info : true,
				language : {
					"url" : "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"
				},
				pageLength : 4,
				drawCallback : function(settings) {
					var api = this.api();
					var rowData = api.rows({
						page : 'current'
					}).data();
					var rowCount = api.rows({
						page : 'current'
					}).count();
					var this_row = api.rows().count();
					//console.log(rowCount);

					var td_body = "";
					if (this_row > 0) { 
						
							for (var i = 0; i < rowCount; i++) {
								 
								td_body = td_body
								+ "<div id='ucTemplate"+ rowData[i]['template_data_seq'] + "' class='column width-25 border-box padding-rl-10 margin-left-33 margin-right-33 cursor_point' "
								+ " onclick=\"selectRowUC('" + rowData[i]['template_data_seq'] + "','" + rowData[i]['sender_key'] + "','" + rowData[i]['template_code'] + "','" + rowData[i]['template_name'] + "','" + rowData[i]['template_content'] + "','" + rowData[i]['template_variables'] + "','" + escape(rowData[i]['template_buttons']) + "');\">" 
								+ "<div class='width-250'>"
								+ "<h5 class='font-14px font-normal font-174962 text-left'>"
								+ rowData[i]['template_name']
								+ "</h5>"
								+ "<div class='width-100 height-340px font-4d4f5c font-14px text-left border-e8e8e8 border-radius-5 background-transparent padding-5 line-height-default margin-bottom-10' style='overflow:auto;' >"
								+ rowData[i]['template_content'] 
								+ "</div>"
								+ "</div>"
								+ "</div>";
						
							}
							
							$("#ucTemplate tbody").addClass('row');
							$("#ucTemplate tbody").html(td_body);
							
					}
				}
			});
		
		$(".pop_bg").css('display','block');
		$('#ucTempletPopUp').css('display','block'); 		
	});	 
	 
	/************************************* 템플릿 선택 ***************************************/
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*************************************************** 대체문자 지정  ***************************************************/
	/*
	* RF_061_01 대체문자
	*/
	$('#ucReContentCheck').on('change', function () {
		////console.log(this.checked);
	    if (!this.checked) { 
			$('#ucContentsRePopUpBtn').addClass('background-efefef');
			$('#ucContentsRePopUpBtn').removeClass('background-053c72');
			$("#ucContentsRePopUpBtn").prop("disabled", true);
	    }else{
			$('#ucContentsRePopUpBtn').addClass('background-053c72');
			$('#ucContentsRePopUpBtn').removeClass('background-efefef');
			$("#ucContentsRePopUpBtn").prop("disabled", false);

			/* 지정된 대체문자가 있다면 */
			if( arrUCReContent.length > 0 ){

				/* 지정버튼 활성화 */
				$('#ucReContentSMSRegBtn').addClass('background-8bc5ff');
				$('#ucReContentSMSRegBtn').removeClass('background-efefef');
				$('#ucReContentSMSRegBtn').css({ 'pointer-events': 'auto' });
				$('#ucReContentLMSRegBtn').addClass('background-8bc5ff');
				$('#ucReContentLMSRegBtn').removeClass('background-efefef');
				$('#ucReContentLMSRegBtn').css({ 'pointer-events': 'auto' });
				$('#ucReContentMMSRegBtn').addClass('background-8bc5ff');
				$('#ucReContentMMSRegBtn').removeClass('background-efefef');
				$('#ucReContentMMSRegBtn').css({ 'pointer-events': 'auto' });
				
				/* 대체문자지정 배열 삭제 */
				arrUCReContent = [];
				toastr.success("대체문자지정이 취소되었습니다"); 
			}
	    }
	});

	/* 친구톡 */
	$('#ucFReContentCheck').on('change', function () {
		////console.log(this.checked);
	    if (!this.checked) { 
			$('#ucFContentsRePopUpBtn').addClass('background-efefef');
			$('#ucFContentsRePopUpBtn').removeClass('background-053c72');
			$("#ucFContentsRePopUpBtn").prop("disabled", true);
	    }else{
			$('#ucFContentsRePopUpBtn').addClass('background-053c72');
			$('#ucFContentsRePopUpBtn').removeClass('background-efefef');
			$("#ucFContentsRePopUpBtn").prop("disabled", false);

			/* 지정된 대체문자가 있다면 */
			if( arrUCReContent.length > 0 ){

				/* 지정버튼 활성화 */
				$('#ucReContentSMSRegBtn').addClass('background-8bc5ff');
				$('#ucReContentSMSRegBtn').removeClass('background-efefef');
				$('#ucReContentSMSRegBtn').css({ 'pointer-events': 'auto' });
				$('#ucReContentLMSRegBtn').addClass('background-8bc5ff');
				$('#ucReContentLMSRegBtn').removeClass('background-efefef');
				$('#ucReContentLMSRegBtn').css({ 'pointer-events': 'auto' });
				$('#ucReContentMMSRegBtn').addClass('background-8bc5ff');
				$('#ucReContentMMSRegBtn').removeClass('background-efefef');
				$('#ucReContentMMSRegBtn').css({ 'pointer-events': 'auto' });
				
				/* 대체문자지정 배열 삭제 */
				arrUCReContent = [];
				toastr.success("대체문자지정이 취소되었습니다"); 
			}
	    }
	});
	 
		/*알림톡용 대체문자 팝업창 열기 */ 
	$('#ucContentsRePopUpBtn').on('click', function(){	

		$("ul.pop_tabmenu_uc_contens_re > li:nth-child(4)").addClass("none");
		
		/* 템플릿 팝업이 없으면 */
		if( ucCurTemplate["idx"] === undefined ){
			toastr.success("선택된 템플릿이 없습니다. 템플릿을 선택해주세요");
			return;
		}
		
		var reType, reContent;
		
		/* ////console.log("==========length=============" + arrUFReContent.length); */
		if( arrUCReContent.length > 0 ){
			
			arrUCReContent.forEach(function(element){ 
	    		reType = element.type;
	    		reContent = element.content; 
			}); 
		}
		/*////console.log("----------------대체문자 팝업창 열기---------------" +JSON.stringify(arrUFReContent) + reType  + reContent); */
		
		/* 
		RF_061_01 대체문자 발송 
		RF_062_01 대체문자 작성 
		RF_062_02 대체문자 수정  
		RF_062_03 대체문자 용량    자동변경
		*
		*/
		
		/* 최종선택한 형태로 대체문자발송 */ 
		/* 단문 /장문 /멀티 중 선택 */		
		/* 팝업창 열때마다 컨텐츠 가져오기  지정이 없다면  */
	
		var subject = ucCurTemplate["title"];
		var content = ucCurTemplate["content"];
		
		subject = $('#ucTitle').val();
		content = $('#ucContent').text(); 
		
		

		var contentTxt = "";
		var div = document.createElement("div");
		div.innerHTML = content;
	    contentTxt = div.textContent || div.innerText || "";


		var isImage = Object.keys(ucImgFile).length; 
		
		//if(isImage > 0 ){
		//	reType = "MMS";
		//}else{
			if(getTextLength(contentTxt) < 90 ){

				reType = "SMS";
			}else{

				reType = "LMS";
			}
		//}
		
		var recontentS = content,recontentL = content, recontentM = content;
		
		/* 지정된 대체문자가 있을경우  */
		if( arrUFReContent.length > 0 ){
			if(reType === "SMS" ){ recontentS = reContent;}	
			if(reType === "LMS" ){ recontentL = reContent;}	
			//if(reType === "MMS" ){ recontentM = reContent;}	

			$('#ucReContentSMSTitle').html(subject);
			$('#ucReContentSMSContent').text(recontentS);			
			$('#ucReContentLMSTitle').html(subject);
			$('#ucReContentLMSContent').text(recontentL);			
			//$('#ucReContentMMSTitle').html(subject);
			//$('#ucReContentMMSContent').html(recontentM);
		}else{
			$('#ucReContentSMSTitle').html(subject);
			$('#ucReContentSMSContent').text(contentTxt);			
			$('#ucReContentLMSTitle').html(subject);
			$('#ucReContentLMSContent').text(contentTxt);			
			//$('#ucReContentMMSTitle').html(subject);
			//$('#ucReContentMMSContent').html(content);
		}
		
		$(".pop_bg").css('display','block');
		$('#ucContentsRePopUp').css('display','block');
	});
	
	
	/*친구톡용 대체문자 팝업창 열기 */ 
	$('#ucFContentsRePopUpBtn').on('click', function(){	

 
		
		var reType, reContent;
		
		/* ////console.log("==========length=============" + arrUFReContent.length); */
		if( arrUCReContent.length > 0 ){
			
			arrUCReContent.forEach(function(element){ 
	    		reType = element.type;
	    		reContent = element.content; 
			}); 
		}
		/*////console.log("----------------대체문자 팝업창 열기---------------" +JSON.stringify(arrUFReContent) + reType  + reContent); */
		
		/* 
		RF_061_01 대체문자 발송 
		RF_062_01 대체문자 작성 
		RF_062_02 대체문자 수정  
		RF_062_03 대체문자 용량    자동변경
		*
		*/
		
		/* 최종선택한 형태로 대체문자발송 */ 
		/* 단문 /장문 /멀티 중 선택 */		
		/* 팝업창 열때마다 컨텐츠 가져오기  지정이 없다면  */
	
		var subject = ucCurTemplate["title"];
		var content = ucCurTemplate["content"];
		
		subject = $('#ucTitle').val();
		content = $('#ucContent').text(); 
		
		

		var contentTxt = "";
		var div = document.createElement("div");
		div.innerHTML = content;
	    contentTxt = div.textContent || div.innerText || "";


		var isImage = Object.keys(ucImgFile).length;  
		
		if(isImage > 0 ){
			reType = "MMS";
		}else{
			if(getTextLength(contentTxt) < 90 ){

				reType = "SMS";
			}else{

				reType = "LMS";
			}
		}
		
		var recontentS = content,recontentL = content, recontentM = content;
		
		/* 지정된 대체문자가 있을경우  */
		if( arrUFReContent.length > 0 ){
			if(reType === "SMS" ){ recontentS = reContent;}	
			if(reType === "LMS" ){ recontentL = reContent;}	
			//if(reType === "MMS" ){ recontentM = reContent;}	

			$('#ucReContentSMSTitle').html(subject);
			$('#ucReContentSMSContent').text(recontentS);			
			$('#ucReContentLMSTitle').html(subject);
			$('#ucReContentLMSContent').text(recontentL);			
			$('#ucReContentMMSTitle').html(subject);
			$('#ucReContentMMSContent').html(recontentM);
		}else{
			$('#ucReContentSMSTitle').html(subject);
			$('#ucReContentSMSContent').text(contentTxt);			
			$('#ucReContentLMSTitle').html(subject);
			$('#ucReContentLMSContent').text(contentTxt);			
			$('#ucReContentMMSTitle').html(subject);
			$('#ucReContentMMSContent').html(content);
		}
		
		$(".pop_bg").css('display','block');
		$('#ucContentsRePopUp').css('display','block');
	});
	
	$('#ucReContentSMSContent').keydown(function (e){
	    var content = $(this).text(); 
	    if ( Number(byteCheck($(this))) > 90 ){  
	    	e.preventDefault(); 
	    	toastr.error("단문은 최대 90BYTE까지만 입력 가능합니다."); 
	    }
	});
	$('#ucReContentLMSContent').keydown(function (e){
	    var content = $(this).text(); 
	    if ( Number(byteCheck($(this))) > 1800 ){  
	    	e.preventDefault(); 
	    	toastr.error("장문은 최대 1800BYTE까지만 입력 가능합니다."); 
	    }
	});
	
	 
	$('#ucReContentMMSContent').keydown(function (e){
	    var content = $(this).text(); 
	    if ( Number(byteCheck($(this))) > 1800 ){  
	    	e.preventDefault(); 
	    	toastr.error("멀티는 최대 1800BYTE까지만 입력 가능합니다."); 
	    }
	}); 
 
	
	
	/* 닫기 */
	$('#ucReContentSMSCloseBtn').on('click', function(){
		$('#ucReContentSMSContent').attr("contenteditable",false);
		$(".pop_bg").css('display','none');
		$('#ucContentsRePopUp').css('display','none');
	});

	$('#ucReContentLMSCloseBtn').on('click', function(){
		$('#ucReContentLMSContent').attr("contenteditable",false);
		$(".pop_bg").css('display','none');
		$('#ucContentsRePopUp').css('display','none');
	});
	$('#ucReContentMMSCloseBtn').on('click', function(){
		$('#ucReContentMMSContent').attr("contenteditable",false);
		$(".pop_bg").css('display','none');
		$('#ucContentsRePopUp').css('display','none');
	});
	/*************************************************** 대체문자 지정  ***************************************************/
 
	
	/*************************************************** 메세지  버튼넣기추가하기  *****************************************************/ 
	
	/* 초기화 팝업시 */ 
	$('#ucPopBtnAddBtn').on('click', function(){
		$(".pop_bg").css('display','block');
		$('#ucMsgBtnPopUp').css('display','block');	
		
		$('#ucButtonTitle').text("친구톡버튼 (" + arrButtonC.length + " / 5 )");
		$('#ucPopBtnAddBtn').text("버튼 (" + arrButtonC.length + " / 5 )");
	});	

	/* 버튼 추가시 */
	$('#ucButtonAdd').on('click', function(){	

		var addButtonHtml = "";
		////console.log(p_seq);
		if(p_seq==5){
			toastr.error("버튼은 5개까지만 추가 가능합니다.");
			return false;
		}
		addButtonHtml = "<tr id='tr"+p_seq+"'><td>"+ optLinkTypeListUC(p_seq) +"</td><td id='c" + p_seq +"'></td><td></td><td><a onclick='javascript:removeButtonUC(this," + p_seq +");' class='icon_delete'>삭제</a></td></tr>"
		$("#ucButtonTbody").append(addButtonHtml);
		arrButtonC.push(p_seq); 
		
		p_seq = p_seq+1; 

		/* 배열요소의 p_seq값만 저장해서 테이블정보를 불러옴 */

		
		$('#ucButtonTitle').text("친구톡버튼 (" + arrButtonC.length + " / 5 )");
		$('#ucPopBtnAddBtn').text("버튼 (" + arrButtonC.length + " / 5 )");
	}); 

	/*************************************************** 메세지  버튼넣기추가하기  *****************************************************/ 
	
	
	
	
	
	
	
	
	/* 개별문자 입력 ucContentsChangeOpt */	
	$('#ucContentsChangeBtn').on('click', function(){ 
		////console.log("----arrUMLst-----" + arrUMLst);
		if(!arrUCLst.length){
			 toastr.error("수신자 전송목록이 비어있습니다");
			 return;			
		}
		////console.log('----------------개별문자입력---------------' + $('#ucContentsChangeOpt option:selected').val());
		 var variable = "#[" + $('#ucContentsChangeOpt option:selected').val() + "]";
		 $('#ucContent').append(variable);

		 arrUCVariables.push(variable); /*동일한 컬럼변수가 있으면 푸시안함*/
		 toastr.success("개별문자가 입력되었습니다");
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
/************************************************ 미리보기용 *****************************************************/

	/* 미리보기용  배열 
	ucArrSendNum 초기에 선택된 번호 
	ucArrRcvNum 리스트 된 번호
	*/
	var ucPreviewSendNum = "01056355959";
	var ucPreviewRcvNumArr = ["01012345678","01012345678","01012345678"];
	
	$('#ucPreviewBtn').on('click', function(){			
		$(".pop_bg").css('display','block');
		$('#ucPreviewPopUp').css('display','block');
		
		var ucT = $('#ucTitle').val();
		////console.log("----------umTitle-------" + umT);
		var ucC = $('#ucContent').html();		
		////console.log(":--------------umContent---------" + umC);
		
		 
		
		$('#ucPreviewTitle1').html(ucT);
		$('#ucPreviewTitle2').html(ucT);
		$('#ucPreviewTitle3').html(ucT);

		var ucC1, ucC2, ucC3;
        if(ucC.indexOf("#[이름]") != -1 ){
        	ucC1 = ucC.replaceAll("#[이름]", arrUCLst[0].name);  //이름
        }
        if(ucC.indexOf("#[비고]") != -1 ){
        	ucC1 = ucC.replaceAll("#[비고]", arrUCLst[0].title);  //비고
        } 
		$('#ucPreviewContents1').html(ucC1);
		

        if(ucC.indexOf("#[이름]") != -1 ){
        	ucC2 = ucC.replaceAll("#[이름]", arrUCLst[1].name);  //이름
        }
        if(ucC.indexOf("#[비고]") != -1 ){
        	ucC2 = ucC.replaceAll("#[비고]", arrUCLst[1].title);  //비고
        } 		
		$('#ucPreviewContents2').html(ucC2);
		
		

        if(ucC.indexOf("#[이름]") != -1 ){
        	ucC3 = ucC.replaceAll("#[이름]", arrUCLst[2].name);  //이름
        }
        if(ucC.indexOf("#[비고]") != -1 ){
        	ucC3 = ucC.replaceAll("#[비고]", arrUCLst[2].title);  //비고
        } 	
		$('#ucPreviewContents3').html(ucC3);
		
		
		
		$('#ucPreviewSendNum1').text(ucPreviewSendNum);
		$('#ucPreviewSendNum2').text(ucPreviewSendNum);
		$('#ucPreviewSendNum3').text(ucPreviewSendNum);
		////console.log(":--------------umPreviewSendNum---------" + umPreviewSendNum);
		
		$('#ucPreviewRcvNum1').text(ucPreviewRcvNumArr[0]);
		$('#ucPreviewRcvNum2').text(ucPreviewRcvNumArr[1]);
		$('#ucPreviewRcvNum3').text(ucPreviewRcvNumArr[2]);
		////console.log(":--------------umPreviewRcvNumArr---------" + umPreviewRcvNumArr[0]);
	});
	/************************************************ 미리보기용 *****************************************************/
	
	
	
	
	/*********************************************** MMSINFO 이미지 업로드 ************************************/
		
	/* 이미지등록 팝업 */
	$('#ucPopImgUploadBtn').on('click', function(){	 
		$(".pop_bg").css('display','block');
		$(".ucPopImgUpload").css('display','block');
	});
	
	/* 이미지파일 onChange */
	$('#uc_img_file').change( function(){
		 
	    var timeUID = Math.floor(new Date().getTime() / 1000);
	   //console.log($("#um_img_file")[0].files[0].type); // 파일 타임
	   //console.log($("#um_img_file")[0].files[0].size); // 파일 크기
	       
	       
		var previewTag = "<img id='thumbnailImg" + timeUID + "' src='' width='100' height='100' align='center' />";
		$('#ucContent').append(previewTag);
		
		let fileInfo = document.getElementById("uc_img_file").files[0];
		let reader = new FileReader();
		
		reader.onload = function() {
			document.getElementById("thumbnailImg" + timeUID ).src = reader.result;
			if($('input[name=uc_img_file]')[0].files[0].name !== undefined){
				document.getElementById("uc_img_name").value = $('input[name=uc_img_file]')[0].files[0].name;
			} 
		}
		
		if( fileInfo ){
			reader.readAsDataURL( fileInfo );
		}
		//console.log(fileInfo);
	});
	
	
	
	/* 이미지 등록하기 */
	$('#ucImgRegBtn').on('click', function(){
		
		var formData = new FormData(document.getElementById("ucForm")); 
		//var formData = new FormData(document.getElementById("uploadForm")); 
		
		//console.log(formData);
		$.ajax({ 
			type: "POST", 
			url: '/msg/imgFileupload.do', 
			data: formData, // 필수
			processData: false, // 필수 
			contentType: false, // 필수 
			cache: false, 
			success: function (result) { 
				
				/* MMS 정보에 입력  삭제할 수도 있으니 ucContent내의 img태그를 취합해서 입력하도록 해야 */
				//arrUmMMS.push(result);
				
				//console.log(result);
				
				ucImgFile = result;
				//document.getElementById("thumbnailImg" + timeUID ).src = result;
				$(".pop_bg").css('display','none');
				$(".ucPopImgUpload").css('display','none');
			}, 
			error: function (e) { 
				toastr.error(e);
				$(".pop_bg").css('display','none');
				$(".ucPopImgUpload").css('display','none');
				
			} 
		});
 
	});
	
	/*********************************************** MMSINFO 이미지 업로드 ************************************/
	
	
	
/*********************************************************************** 주소록 팝업 이벤트  ***********************************************************/	
	
	/*  주소록버튼클릭시 주소록리스트 */
	$('#ucPopGrpLst').on('click', function(){	 
		/* 그룹탭 */
		var tab = $('input:radio[name="tabmenu_small_thanks"]:checked').val(); // "3" 직원탭만 가능
		AjaxGroupList(tab, "uc_pop_employ_group_list","c");
		
		$(".pop_bg").css('display','block');
		$('#share_pop_group').css('display','block'); 
		 
	});

	
	/* 그룹주소 이동버튼 */
	$("a.ucGrpPrvBtn").click(function(){		
		
		/* arrUCGLst checked : 1 */
 		$.each(arrUCGLst, function(idx, row){ 
 			//var typeVal = arrUCGLst[idx].type;
 			console.log("----push-----");
 			if( arrUCGLst[idx].rowNo == 1 ){  

 				arrUCPLst.push({
 	 				isGroup : "Y", /* 그룹여부 */
 	 				title : arrUCGLst[idx].title,  /* 타이틀 */
 	 				code : arrUCGLst[idx].code,     /* 그룹code Unique */
 	 				phone : arrUCGLst[idx].groupcnt,
 	 				type : arrUCGLst[idx].type
 	 				
 	 			});
 	 			
 				var html = "<li><div class=\"checkbox-small_2\">" +
 				"<input type=\"checkbox\" id=\"uccheck-" + idx + "pg\" name=\"uc_group_check_" + idx + "\"  />" +
 				"<label for=\"uccheck-" + idx + "pg\"></label>" + 
 				"</div><span>" + arrUCGLst[idx].title + "<span>" + arrUCGLst[idx].code + "</span></span></li>";
 				$('ul.uc_pop_receiver').append(html);
 			}  
 			
		});
		
		//console.log(arrUCGLst);
		//console.log(arrUCPLst);
	});
	
	
	
	/* 개별주소 이동버튼 */
	$("a.ucIndivPrvBtn").click(function(){
		/* 중복제거 */
		
 		$.each(arrUCGDLst, function(idx, row){ 
 			//체크인지 확인하고 PUSH
 			if(arrUCGDLst[idx].rowNo){
 				arrUCPLst.push({
 	 				isGroup : "N", /* 그룹여부 */
 	 				title : arrUCGDLst[idx].address_name,  /* 타이틀 */
 	 				code : arrUCGDLst[idx].address_id,     /* 그룹code Unique */
 	 				phone : arrUCGDLst[idx].address_num,
 	 				type : ""
 	 			});
 				var html = "<li><div class=\"checkbox-small_2\">" +
 				"<input type=\"checkbox\" id=\"uccheck-" + idx + "p\" name=\"uc_indivi_check_" + idx + "\"  />" +
 				"<label for=\"uccheck-" + idx + "p\"></label>" + 
 				"</div><span>" + arrUCGDLst[idx].address_name + "<span>" + arrUCGDLst[idx].address_num + "</span></span></li>";
 				$('ul.uc_pop_receiver').append(html);
 			} 			
		});
 		
 		console.log(arrUCPLst);
	});  
	
	
	/*
	* 선택제거
	*/
	$("#ucPopDelSelect").click(function(){

		var gb = $('ul.uc_pop_receiver li').get();
		//var gbInput = $('ul.mng_pop_receiver li').get();
		console.log(gb);

		for ( var i = 0; i < gb.length; i++) {
			var gbInput = gb[i].childNodes;
			gbInput = gbInput[0].childNodes;
		  	var checked = gbInput[0].checked;
			console.log(checked);
			if(checked){			
				$(gb[i]).remove();	
				//gb[i].innerHTML = ''; //li까지 제거해야
				arrUCPLst.splice(i-1, 1);		
			}
        } 
		
	});	

	/*
	* 전체제거
	*/
	$("#ucPopDelAll").click(function(){
		//$('ul.mng_pop_receiver li').remove();  
		$('.uc_pop_receiver').empty();	 
		arrUCPLst = [];
	});	
	
	
	/* 팝업 취소 버튼 */
	$('#ucPopCancelBtn').click(function(){
		
		$('.uc_pop_my_group_list').empty();
		$('.uc_pop_employ_group_list').empty();
		$('.uc_pop_part_group_list').empty();
		$('.uc_pop_share_group_list').empty();
		$('.uc_pop_detail_list').empty();
		$('.uc_pop_receiver').empty();		 
		arrUCPLst = [];
		arrUCGLst = {};
		arrUCGDLst = {};
		
	});
	
	

	
	/* 
	* 최종리스트 #tblSendList로 리스트이동
	* 등록하기 버튼
	*/
	$('#ucPopRegisterBtn').click(function(){ 
		 
		
		/* arrMCPLst [] rendering */
		$.each(arrUCPLst, function(idx, row){ 
			 
		 	var trData = "<tr>" + 
						 "<td class=\"relative\">" + 
						 	"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
						 		"<input type=\"checkbox\" id=\"check_" + idx + "s\" name=\"체크\" class=\"mngcheck\" />" + 
						 		"<label for=\"check_" + idx + "s\"></label>" + 
						 	"</div> <a class=\"rev_name\">" + arrUCPLst[idx].title + "</a>" + 
						 "</td>" + 
						 "<td>" + arrUCPLst[idx].phone + "</td><td>직접입력</td>" + 
						 "<td class=\"tb_btn\">" + 
						 	"<a class=\"open_pop icon_modify\">수정</a>" + 
			             	"<a href=\"#\" class=\"icon_delete\"onclick=\"arrUCLstPop(" + arrUFLst.length + ");deleteLine(this);\" >삭제</a>" + 
			             "</td>" + 
			             "</tr>";
			$('#tblsendthanks tbody').append(trData);

			/* 최종에 push */
			arrUCLst.push({ 
				isGroup : row.isGroup, /* 그룹여부 */
 	 			title : "주소록",  /* 타이틀 */
 	 			code : row.code,     /* 그룹code Unique */
 	 			phone : row.phone,  /* 구룹시 count */
 	 			name : row.title,
 	 			type : row.type
 	 		});
			
		}); 

		/* popup close */
		$(".pop_bg").css('display','none'); 
		/* 모든 것 clear */
		$('.uc_pop_my_group_list').empty();
		$('.uc_pop_employ_group_list').empty();
		$('.uc_pop_part_group_list').empty();
		$('.uc_pop_share_group_list').empty();
		$('.uc_pop_detail_list').empty();
		$('.uc_pop_receiver').empty();	 
		arrUCPLst = [];
		arrUCGLst = {};
		arrUCGDLst = {};

		$('#share_pop_group').css('display','none');
		$("#ucTotalCnt").text("총 " + arrUCLst.length + "건");
		SetPrice("uc", arrUCLst.length);
		
	});

/*********************************************************************** 주소록 팝업관련 ***********************************************************/	
	

	
/***************************************** 전송하기 *************************************/
	$('#ucSenderBtn').on('click', function(){
		sendMessage();
	});
/***************************************** 전송하기 *************************************/
	
	 
});






function sendMessage(){

	var ucTitle = $('#ucTitle').val();
	var ucContent = $('#ucContent').text();
	var ucContentHtml = $('#ucContent').html();
	
	var ucContentCookie = getCookie("ucBeforeContent"); 
	
	/* 직전 동일내용 전송체크 메세지 */ 

	if( g_dupMessageUseFlag == "Y" ){
		
		if( ucContent ==  ucContentCookie ){
			var r = confirm("이전 내용과  동일한 메세지내용입니다. 전송하시겠습니까?");
			if (r == true) {
			} else {
				toastr.error("전송이 취소되었습니다");
				return false;
			}
		}
	}


	/* 옵션  --  080 수신거부 메세지 첨가 */
	if(sending_refusal_check == "N"){
		ucContent += refusal_txt;
	} 
	
	 
	var ucTitleLen = getTextLength(ucTitle);
	var ucContentLen = getTextLength(ucContent); 
	
	if( ucTitleLen < 10 ) { 
 		toastr.error('제목을 입력하세요'); 
 		$('#ucTitle').focus();
 		return false;
	}
	
	if( ucContentLen < 20  && pageMode !=="0" ) {  /*친구톡일때 이미지만전송가능*/ 
 		//toastr.error('내용은 최소 20자 이상입력해야 합니다'); 
 		//return false;
	}

	if( !maxLengthCheck("ucTitle","제목",30) ){
 		toastr.error('제목은 30자까지 가능합니다'); 
		$('#ucTitle').focus();
		return false;
	} 


	if( !maxLengthCheck("ucContent","내용",1800) ){
 		toastr.error('내용은 1000자까지 가능합니다');  
		return false;
	}
	      
	/* 재전송 reType check */ 
	/* image check */  
	var isImage = false;	
	if(Object.keys(ucImgFile).length > 0){
		isImage = true;
	} 
	
	//if(ucContentLen < 90 ){ reType = 4; } //LMS
	//if(ucContentLen >= 90 || isImage ) { reType = 6; }
	
 	
 	var sendPhone = $('select[name=ucSendNum]').val();
	 
 	
 	
 	var sendPhoneType = $('input:radio[name=ucSendNumDirect]:checked').val();  
 	var sendPhone = $('input[name=ucSendNum]').val();
	var sendPhoneLen = getTextLength(sendPhone);
	if( sendPhoneLen < 8 ) { 
 		toastr.error('발신번호를 입력하세요'); 
 		$('input[name=ucSendNum]').focus();
 		return false;
	}
 	
	/* RF_046_02  발신번호 유효성 체크
	*  
	*/
	if( isNaN(sendPhone) || sendPhoneLen < 8 || sendPhone.substring(1) === "0"  ) {
		toastr.error("유효한 발신번호가 아닙니다");
	}

	/* 발신번호 input값에 null이 표기되어서 */
 	 
 
	
	//수동입력체크없음
	//예약발송 없음
 	var startDate = getTimeStamp(); //즉시발송만 있음 
 	

 	//업무분류  EgovSender에서 입력
	var ucWorkLstOpt = $('select[name=ucWorkLstOpt]').val(); 
	if( ucWorkLstOpt == "0" ){
		toastr.error("업무분류를 선택하세요");
		return false;
	}	
	
	/*
    OPTION RF-058-04 친구톡 이미지 표시여부  EgovSender에도 있음
	*/ 
	if(g_FriendTalkImageUseFlag == "N"){
		$('#ucImgUpBtn').hide();	
	}

	/* 광고 옵션 */
	if(pageMode === "0"){

		if( $("input:checkbox[name='ucCheckAD']").is(":checked")  ){
			ucContent = "[광고]" + ucContent;
		}
	}	
 	

	var param = tableToJsonEvent(document.getElementById("tblsendthanks"), startDate, ucTitle, ucContent, sendPhone, ucWorkLstOpt); // table id를 던지고 함수를 실행한다.
	
	if( arrUCGLst.length ){
		toastr.error("수신자목록을 입력하세요");
		return false;
	}  
	
    var obj = JSON.stringify(param); 
    
    //$('#result').text(obj);  
	$('#ucSenderBtn').attr('disabled', true);	 
	
	//loading
	$('.loading_bar').show(0).delay(3000).hide(0);
	
	//toastr.success("------ajax--start-------");
	$.ajax({
    	url: "/sendSMS.do",
    	type: "POST",
        dataType: "json",          // ajax 통신으로 받는 타입
        contentType: "application/json",  // ajax 통신으로 보내는 타입
        data: obj,
        beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
    		$('#ucSenderBtn').attr('disabled', false);
        },
		complete:function(){
            $('.wrap-loading').addClass('display-none');
    		$('#ucSenderBtn').attr('disabled', false);
        },
    	success: function(jsondata){
   	     /*
  	      * 
  	      * RF_047_01 입력 번호 유효성 체크
  	      * 
  	      */
   			if(jsondata['error']){
   				toastr.error(jsondata['errorcode'] + JSON.stringify(jsondata['data']));
   				return;
   			}
   		
   			var res = JSON.stringify(jsondata);
   			//alert(res); //로딩
   		
   			//clear
   			if(jsondata['result_msg'] == "ok"){
   				$("#tblsendthanks tbody").empty();  
       			$('#ucTitle').val(""); 
       			$('#ucContent').empty();  
       		
       			ucImgFile = {};
       		
       			/* 배열 데이타 처리  */
       			arrUCLst = []; 
       			arrUCGLst = []; 
       			arrUCVariables = [];
       			$("#ucTotalCnt").empty();
       			$("#ucPrice").empty();
       			

				/* 버튼 Clear */
				arrButtonC = [];
				arrButtonUCJSON = "";
        		$("#ucButtonTbody").empty();
        		$('#ucPopBtnAddBtn').text("버튼 ( 0 / 5 )");
        		$('#ucButtonTitle').text("친구톡버튼 ( 0 / 5 )");
        		
        		
   			} 
           	toastr.success('성공적으로 전정되었습니다');  
           	
   			/* 		바로 직전 콘텐츠 저장    		*/ 
           	setCookie("ucBeforeContent",ucContent);
   			
           	$('.wrap-loading').addClass('display-none');
   			$('#ucSenderBtn').attr('disabled', false);
    	},
    	error: function(request,status,error){
    		  
    		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    		$('#ucSenderBtn').attr('disabled', false);
            $('.wrap-loading').addClass('display-none');
    	}
		});

	/* 최근 전송 5건 */	
	PopupRecentLst("#ucRecentLstBtn","#ucRecentLst","#ucPopRecentLayer",arrUCRecentLst);
	
	// clear
	ucImgFile = {};

}

function tableToJsonEvent(table, startDate, title, content, senderNum, workLstOpt) {
	/* 
	* RF_049_01 수신자  건수 제한
	*
	*/
	if( arrUCLst.length > max_receive_cnt ){
		toastr.error("수신목록 가능한 최대갯수는 " + max_receive_cnt + "입니다");
		return;
	}
	
	
    var tempData = {};

	var rcv_type="0"; //0 SMS 1 LMS 2 MMS 3 FRI 4 NOT 
	var contentTxt = "";
	var div = document.createElement("div");
	div.innerHTML = content;
    contentTxt = div.textContent || div.innerText || ""; 
    var isImage = false;
	isImage = Object.keys(ucImgFile).length; 
	
	if(pageMode=="3"){ 
		if(isImage > 0 ){
			ucPayCode = "MMS"; 
			rcv_type = "2";
		}else{
			if(getTextLength(contentTxt) < 90 ){
				ucPayCode = "SMS"; 
			}else{
				ucPayCode = "LMS"; 
				rcv_type = "1";
			}
		}
	}

	/* 친구톡일때 */
	if(pageMode=="0"){ 
		rcv_type = "3";
		ucPayCode = "FRT";  
		var ucContent = $('#ucContent').text();   //ucContent.replace("/<img(.*?)>/gi", "");  
		if( !isImage && Object.keys(ucContent).length ){ payCode = "FRT"; }//텍스트만
		if( isImage && !Object.keys(ucContent).length ){ payCode = "FRI"; }//이미지만
		if( isImage && Object.keys(ucContent).length ){ payCode = "FIT"; }//이미지만 
	}

	/* 친구톡일때 */
	if(pageMode=="1"){ 
		rcv_type = "4";
		ucPayCode = "NOT";  
	}
	
	//MMS_CONTENTS_INFO 에 필요한 데이타
	tempData["mms_info"] = "";
	tempData["title"] = title;
	tempData["content"] = content;
	tempData["snd_number"] = senderNum;
	tempData["rcv_type"] = rcv_type; /* 0 SMS 1 LMS 2 MMS 3 친구톡  4 알람톡  */
	tempData["snd_date"] = ""; // 즉시발송만 ""startDate  있을때 예약오륫생김;
	tempData["rcv_rsvt_chk"] = "1";
	tempData["rcv_mmsinfo"] = "";
	tempData["rcv_work_seq"] = workLstOpt;  /* 업무분류 */
	 
	
	
	
	
	
	/* MMS 친구톡 */   
	var img = ucImgFile.string;
	if(img !== undefined){  		
		var ext = img.slice(img.lastIndexOf(".") + 1).toLowerCase();
		if(ext =="jpg" || ext == "png" || ext == "gif") ext = "IMG";		
		tempData["imgFileName"] = img; 
		tempData["fileType"] = ext;
	}else{
		tempData["imgFileName"] = ""; 
		tempData["fileType"] = "";
	}

	

	var reContent = "";
	var reType = ""; //4다문 6장문멀티
	


	var reTypeInt = 4;
		
	/* 친구톡  알림톡  재전송 */
	
	if( pageMode === "1" ){ //알림톡에서

		if( ucCurTemplate["idx"] === undefined  ){
			tempData["reContents"] = "";  
			tempData["reType"] = reTypeInt; 
			tempData["btnList"] = "";
			tempData["tmpVars"] = ""; 
			tempData["senderKey"] = ""; 
			tempData["templateKey"] = "";
			tempData["senderkey"] = "";
		}else{  

			if(reType==="SMS"){
				reTypeInt = 4;
			}else{
				reTypeInt = 6;
			}
			
			tempData["reContents"] = reContent;
			tempData["reType"] = reTypeInt;
			tempData["btnList"] = ucCurTemplate["buttons"];
			tempData["tmpVars"] = ucCurTemplate["variables"];
			tempData["senderKey"] = ucCurTemplate["senderKey"]; 
			tempData["templateKey"] = ucCurTemplate["templateKey"]; 
			tempData["senderkey"] = ucCurTemplate["senderkey"];
		}
	}
	
	

	/* 친구톡  */ 		
	if( pageMode === "0"){ 
	 	if( arrUCReContent.length > 0 ){
	 		arrUCReContent.forEach(function(element){ 
		    	reContent = element.content; 
		    	reType = element.type;
			});  
	 	}  

		tempData["reContents"] = reContent;
		tempData["reType"] = reTypeInt;
		
		tempData["btnList"] = "";
		tempData["tmpVars"] = ""; 
		tempData["senderKey"] = ""; 
		tempData["templateKey"] = "";
		tempData["senderkey"] = "";
	}
	 
 
	/* 친구톡 */
	if( pageMode === "0"){
		tempData["btnList"] = ucBtnListJSON;
	}

	//if( pageMode === "0"){
	//	tempData["tmpVars"] = ucTmpVars;
	//} 

	/* 친구톡 FRI FRT FIT */

	
	tempData["payCode"] = ucPayCode;
	
	tempData["price"] = getPriceByCode(ucPayCode);
	
	/* PHONE LIST */
	var row = [];
	var rowG = [];
	
for ( var r = 0; r < arrUCLst.length; r++ ){ 
		
		
        var rowData = {};   
		var isGroup = "N";
		isGroup = arrUCLst[r].isGroup;
        rowData["isgroup"] = arrUCLst[r].isGroup; //비고란 
        
        if(isGroup == "Y"){ 
        	
            rowData["column1"] = arrUCLst[r].name; //이름
            rowData["rcv_number"] = arrUCLst[r].phone; //수신번호
            rowData["rcv_etc"] = ""; //비고란

            rowData["grp_category"] = arrUCLst[r].code; //비고란 
            rowData["grp_name"] = arrUCLst[r].name; //비고란
            rowData["grp_type"] = arrUCLst[r].type; //비고란 
            rowData["grp_cnt"] = Number(arrUCLst[r].phone); //비고란
        	rowG.push(rowData); 
            
        }else{

            rowData["column1"] = arrUCLst[r].name; //이름
            rowData["rcv_number"] = arrUCLst[r].phone; //수신번호
            rowData["rcv_etc"] = ""; //비고란
            rowData["grp_name"] = ""; //비고란
            rowData["grp_category"] = ""; //비고란 
            rowData["grp_type"] = ""; //비고란 
            rowData["grp_cnt"] = 0; //비고란
	    	row.push(rowData); 
            
        }
         
         
        arrUCRecentLst.push({
			isGroup : "N", 
			title : rowData["column1"],  
			code : null,     
			phone : rowData["rcv_number"],
			name : rowData["column1"]
		});
    	
    	if(arrUCRecentLst.length > 5){
    		arrUCRecentLst[arrUCRecentLst.length - 1]
    		arrUCRecentLst.pop();
    	}
	}  
     
    
    tempData["content"] = content;
    
    
    
	tempData["group"] = rowG.slice();  /* 전체내용넣기 */
	tempData["data"] =  row.slice();  /* 전체내용넣기 */ 
    
    var totalPrice = Number(tempData["data"].length) * Number(tempData["price"]); 
    var uCashChk = usrCashCheck(tempData["payCode"], totalPrice);
    
    if(uCashChk < 0){
		toastr.error("캐쉬 잔액이 부족합니다");
    	return false;
    }	    	
    
	return tempData;
}



/************************** 메세지 버튼처리 **********************************/ 
function registerButtonUC() {
	
	/* 리셋  */
	$("#ucContent").find("a").remove(); 
	
	for(var i in arrButtonC){ 
		var p_seq = arrButtonC[i]; 
		var bType = $("#link_type_uc" + p_seq + " option:selected ").val();
		var tName = "";
		var url_mo = "";
		var url_pc = ""; 
		var buttons = {};
		/*
		4 배송조회
		3 웹링크
		2 앱링크
		1 메세지전달
		0 봇키워드
		*/ 
		
		//content에 button추가하기
		/* MMS_CONTENTS_INFO sql에 넣을 데이타 */
		if(bType === "4"){ 
			tName ="배송 조회하기";buttons = {"name": "배송 조회하기", "type" : "DS"  };
		} /* 배송조회 */ 
		if(bType === "3"){ 
			tName = $("#uc_link_name_al").val(); 
			link_andr = $("#uc_link_andr").val();
			link_ios = $("#uc_link_ios").val();
			buttons = {"name": tName, "type" : "AL", "link_andr": link_andr, "link_ios": link_ios }; /* 앱링크 */ 
		} 
		if(bType === "2"){ 
			tName = $("#uc_link_name_wl").val(); 
			url_mo = $("#uc_link_mo").val();
			url_pc = $("#uc_link_pc").val();
			buttons = {"name": tName, "type" : "WL", "url_mobile": url_mo, "url_pc": url_pc }; /* 웹링크 */ 
		}   
		if(bType === "1"){ 
			tName = $("#uc_link_name_md").val(); buttons = {"name": tName, "type" : "MD" };} /* 메세지버튼 */ 
		if(bType === "0"){ 
			tName = $("#uc_link_name_bk").val(); buttons = {"name": tName, "type" : "BK" };} /* 봇키워드 */

		if(i === "0"){
			ucBtnListJSON += JSON.stringify(buttons);
		}else{
			ucBtnListJSON += "," + JSON.stringify(buttons);
		} 
		$("#ucContent").append("<a id='b_uc" + p_seq +"' class=\"width-100 height-50px line-height-50px text-center margin-top-5 border-radius-5 background-efefef font-14px font-053c72\">" + tName + "</a>");
	}

	$('.pop_bg').css("display","none");
	$('#ucMsgBtnPopUp').css("display","none"); 
}

function removeButtonUC(el,seq) {
		/* data 제거 */
		const idx = arrButtonC.indexOf(seq);
		arrButtonC.splice(idx,1);
	
		$(el).parents("tr").remove();
		p_seq = p_seq-1;
		//console.log(p_seq);
		$('#ucButtonTitle').text("친구톡버튼 (" + arrButtonC.length + " / 5 )");
		$('#ucPopBtnAddBtn').text("버튼 (" + arrButtonC.length + " / 5 )");
}
function chgBtntypeUC(p_seq) {
	var btn_name = "";
	var buttonsHtml = "";
	var s_index = $("select[name=link_type_uc"+p_seq).val();
	
	$("td[id=c"+p_seq+"]").html(arrTypeHtmlUC[s_index]); 
}

function optLinkTypeListUC(p_seq) {
	var optLinkTypeList = "<select class='select_white_small width-130px' style='background-color:#f9fbfd;' id='link_type_uc"+p_seq+"' name='link_type_uc"+p_seq+"' onchange='javascript:chgBtntypeUC("+p_seq+");'><option value=''>=선택=</option><option value='4'>배송조회</option><option value='2'>웹링크</option><option value='3'>앱링크</option><option value='0'>봇키워드</option><option value='1'>메시지전달</option></select>";
	var repOptLinkTypeList = optLinkTypeList.replace(/\*\*TEMPSEQ\*\*/g, p_seq);
	repOptLinkTypeList = repOptLinkTypeList.replace(/\*\*BTNSEQ\*\*/g, p_seq);
	return repOptLinkTypeList;
}
/************************** 메세지 버튼처리 **********************************/ 




/************************** 템플릿 등록 **********************************/ 
function inputTemplateUC(){

	oTableTempletUC.destroy();
	
	/* 초기화  */	
	$('#ucVariablesTitle').empty();
	$('#ucVariables').empty();
	 
	
	var idx = ucCurTemplate["idx"];
	var tab = $("input[name='sendM_tabmenu']:checked").val(); //C
	
	if( idx != "undefined" && idx != null ){
		//console.log("-----선택사항입력있음----");
		var title = ucCurTemplate["title"];
		var content = ucCurTemplate["content"]; 
		var buttons = ucCurTemplate["buttons"]; 
		var variables = ucCurTemplate["variables"]; 

		
		$('#ucTitle').val(title);
		$('#ucContent').html(content);
  
		//buttons = "{\"name\":\"1\"},{\"name\":\"1\"}";
		var arrButtons = JSON.parse(buttons); 
		
		//button.length 체크
		var buttonCount = arrButtons.length;
		//console.log("------buttonCount------:" + buttons.length);
			
		//button JSON
		if(buttonCount > 0){
			//$('#uaPopButtonBtn').addClass("umMyBox");
			$('#ucPopButtonBtn').text("버튼(" + buttonCount + "/5)");
		}
		
		//var variables = "고객명||이름";
		
		//variables JSON
		if(!isEmpty(variables)){  
			var arrVar = variables.split("||");
			var el;
			for(var i in arrVar){
				el = "<span class=\"width-50  inline-block \"><span class=\"width-50px text-center  border-box font-14px\">"+ 
				arrVar[i]+"</span><span class=\" width-100px font-14px text-left paddin-left-30 \"><div class='checkbox-small'><input type='checkbox' id='uaCheck' readonly checked /><label for='ucCheck'></label><span class='font-16px font-053c72 margin-left-5'>자동매칭</span></div></span></span>";
			}
			var len = arrVar.length;
			$('#ucVariablesTitle').append("변수입력 <span class=\"font-bold\">[" + len + "/5]</span");
			$('#ucVariables').append(el);
		}else{
			$('#ucVariablesTitle').append("변수명 입력 없음");
		}
		
		
		
	}else{ 
		console.log("-----선택사항입력없음----");
	}
	
}



/******************************************************************************** 내저장함 INIT *********************************************************/
function ucSaveTableInit(talbeId, url, cntTextId){
		var tempTable = $('#'+talbeId).DataTable({
			dom : "frtip",
			ajax : {
				"url" : url+"?userId="+globalId,
				"type" : "GET",
			},
			columns : [ {
				data : "subject"
			} ],
			searching : false,
			paging : true,
			info : true,
			language : {
				"url" : "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"
			},

			pageLength : 4,
			drawCallback : function(settings) {
				var api = this.api();
				var rowData = api.rows({page : 'current'}).data();
				var rowCount = api.rows({page : 'current'}).count();
				var this_row = api.rows().count();

				var td_body = "";

				if (this_row > 0) {

					for (var i = 0; i < rowCount; i++) {

						//console.log(rowData[i]);

						td_body = td_body
								+ "<div id='ucSave"+ rowData[i]['status'] + rowData[i]['mysaveSeq'] + "' class='column width-20 border-box padding-rl-10 margin-left-33 margin-right-33 cursor_point' onclick=\"selectRowUM('umSave"+ rowData[i]['status']+ rowData[i]['mysaveSeq'] + "','"+rowData[i]['title']+ "','" + rowData[i]['subject'] + "');\">"
								+ "<div class='width-250'>"
								+ "<h5 class='font-14px font-normal font-174962 text-left'>"
								+ rowData[i]['title']
								+ "</h5>"
								+ "<div class='width-100 height-340px font-4d4f5c font-14px text-left border-e8e8e8 border-radius-5 background-transparent padding-5 line-height-default margin-bottom-10' style='overflow:auto;' >"
								+ rowData[i]['subject'] 
								+ "</div>"	
								+ "<a href=\"#\" class=\"icon_delete margin-left-5\" onclick=\"delRowUC("+rowData[i]['mysaveSeq']+ ");\" >삭제</a>"
								//+ "<a href=\"#\" class=\"icon_save margin-left-5\" onclick=\"selectRowUM('umSave"+ rowData[i]['mysaveSeq'] + "','"+rowData[i]['title']+ "','" + rowData[i]['subject'] + "');\" >선택</a>"
								+ "</div>"
								+ "</div>   ";
					}
					$("#"+talbeId+" tbody").addClass('row');
					$("#"+talbeId+" tbody").html(td_body);
				}
				$("#"+cntTextId).text(rowCount);

			}
		});
		
		
		return tempTable;
}
function reloadTableUC(){
	ucSaveTableS.ajax.reload();
	ucSaveTableL.ajax.reload();
	ucSaveTableM.ajax.reload();
	ucSaveTableF.ajax.reload();
	ucSaveTableC.ajax.reload();
}
function destroyTableUC(){

	var idx = umCurMySave["idx"];
	var tab = $("input[name='sendM_tabmenu']:checked").val();
	
	if( idx != "undefined" && idx != null ){
		//console.log("-----선택사항입력있음----");
		var title = umCurMySave["title"];
		var content = umCurMySave["content"]; 
		//console.log("---------선택--idx-----" + idx  );
		//console.log("---------선택--title-----" + title  );
		//console.log("---------선택--content-----" + content  );
		
		//if( tab == "M" ){  /*현재 탭체크*/
			$('#ucTitle').val(title);
			$('#ucContent').html(content);
		//}else{
		//	$('#ufTitle').val(title);
		//	$('#ufContent').html(content);
		//}
		
	}else{ 
		//console.log("-----선택사항입력없음----");
	}
	
	ucSaveTableS.destroy();
	ucSaveTableL.destroy();
	ucSaveTableM.destroy();
	ucSaveTableF.destroy();
	ucSaveTableC.destroy();
}

function delRowUC(mysave_seq){
	if (confirm("정말 삭제하시겠습니까?") == true){    //확인
	    $.ajax({
	    	url: "/deleteMySave.do?mysaveSeq="+mysave_seq,
	       	type: "GET",
	    	dataType: "json",
	       	success: function(jsondata){  
	            if(jsondata["data"]==0){
	                alert("성공적으로 삭제 되었습니다.");
	                reloadTableUC();
	            }else{
	            	alert("삭제할수 없습니다.");
	            }
	       	},
	       	error: function(request,status,error){
	       		//console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	       	}
	   	});

	 }
}
/******************************************************* 내저장함 ******************************************************/



/* 선택하기 */
function selectRowUC(a,senderkey,tmpkey,title, contents,variables,buttons){  
	 
  	var idx = "ucTemplate" + a;
  	
	if( $("#"+idx).hasClass("umMybox") === true ) { 
		
		$("#"+idx).removeClass("umMybox");  
		uaCurTemplate = []; //초기화
		toastr.error("선택이 해제되었습니다");
		return;
	}

	/* 현재 el 클래스 추가 */
	$('#'+idx).addClass("umMybox"); 
	
	if( ( ucCurTemplate["idx"] != null ) && ( ucCurTemplate["idx"] != "undefined" ) ){

			$('#ucTemplate'+ ucCurTemplate["idx"]).removeClass("umMybox");
	}  


	ucCurTemplate["idx"] = a;
	ucCurTemplate["senderkey"] =  senderkey;
	ucCurTemplate["templateKey"] =  tmpkey;
	ucCurTemplate["title"] = title;
	ucCurTemplate["content"] = contents; 
	ucCurTemplate["variables"] = variables;
	ucCurTemplate["buttons"] =  unescape(buttons);
 
	
}
  
</script>
 <style>

#ucContent {
    width:280px;
    height:410px;
    overflow-y: auto;
}

[contenteditable]:focus {
    outline: 0px solid transparent;
}


</style>
</head>
<body>
<input type="radio"  name="sendM_tabmenu" id="tabmenu-4" value="E">
<label for="tabmenu-4">경조사</label>

<div class="tabCon ">
	<ul class="width-100 margin-bottom-100">
	
		<!--  LEFT INPUT FORM -->
		<li class="float-left  width-350px margin-right-30">
		<div class="width-350px height-650px border-radius-5 background-f7fafc padding-20 border-box">
				<!--  제목 -->
				<textarea type="text"  name="ucTitle" id="ucTitle"  placeholder="제목 (최대 30Byte)" class="width-100 height-50 border-e8e8e8 background-transparent font-16px padding-left-20 padding-right-20 border-box row-1 margin-bottom-5"></textarea>
				<!--  제목 -->
				
				<div class="relative width-100 height-410px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden">
					<!-- content -->		
					<div id="ucContent"  contentEditable="true" class="border-box border-radius-5"></div>
 
					<input type='hidden' name='ucContentTmp' id='ucContentTmp' /> 
					<a id="ucPopImgUploadBtn" class="icon_photo width-30px height-30px background-8bc5ff border-radius-40 absolute position-bottom-10px position-left-10px"></a>
	  				<a id="ucCounter" class="width-100px height-30px absolute  position-bottom-10px" style="left: 35%;">0/90</a>
					
					<!-- 0 -->
					<a id="ucPopBtnAddBtn" class="open_pop_button width-160px height-30px line-height-30px text-center border-radius-5 border-8bc5ff font-174962 font-14px border-box absolute position-bottom-10px position-text-center">버튼추가(0/5)</a>
												
					<!-- 0 2 3  -->
					<a id="ucContentClearBtn" class="icon_trash width-30px height-30px background-8bc5ff border-radius-40 absolute position-bottom-10px position-right-10px"></a>
					
					
					<!-- Sender Number  -->
					<div id="ucSenderNum" name="ucSenderNum"  contentEditable="true"  onkeydown='return onlyNumberEnter(event)' onkeyup='removeCharEnter(event)' placeholder="전화번호를 직접 입력하거나 메모장, 엑셀을 붙여넣기 한 후에 우측의 입력버튼을 눌러주세요. 두 개 이상의 전화번호는 꼭 엔터키로 구분해주세요."  class="width-100 height-70px background-transparent font-14px line-height-default"  style="overflow:scroll;overflow-x:hidden;overflow-y:hidden;" ></div>														
					
					</div> 
						
						<!-- 0 2 3  -->
						<ul id="ucMyBox" class="margin-bottom-20"> 
							<li class="float-left width-50 padding-right-5 border-box"><a id="ucMyBoxBtn" class="width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">경조사 저장함</a></li>
 							<li class="float-left width-50 padding-left-5 border-box"><a id="ucMyBoxSaveBtn" class="width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">저장하기</a></li>
						</ul>
						
						<!-- 1 알림톡만 -->
						<ul id="ucTemplateBox" class="margin-bottom-20">
							<li class="float-left width-50 padding-right-5 border-box"><a id="ucPopTempletBtn" class="width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">템플릿 선택</a></li>
							<li class="float-left width-50 padding-left-5 border-box"><a id="ucPopButtonBtn" class=" width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">버튼(0/5)</a></li>
						</ul>
						
						<ul>
							<li class="width-100"> 
							<ul class="width-100 height-70px">
								<li class="float-left width-80px height-70px">
									<span class="inline-block width-80px height-40px margin-top-40 text-left font-16px font-4d4f5c">발신번호</span>
								</li>
										
								<!--***옵션:직접선택일 경우-->
								<li id="ucSendNumDirect" class="float-right width-230px height-70px padding-top-5"> 
									<div class="radio-box_s font-14px font-053c72 margin-right-10">
										<div class="radio_s">
											<input type="radio" id="ucOfficeNum" name="ucSendNumRadio" value="1" />
											<label for="ucOfficeNum"><span></span></label>
												</div> 사무실
										</div>
										<div class="radio-box_s font-14px font-053c72 margin-right-10">
											<div class="radio_s">
												<input type="radio" id="ucPhoneNum" name="ucSendNumRadio" value="2" />
												<label for="ucPhoneNum"><span></span></label>
											</div> 핸드폰
										</div>						
										<div class="radio-box_s font-14px font-053c72 ">
											<div class="radio_s">
												<input type="radio" id="ucDirectSendNum" name="ucSendNumRadio" value="3" />
												<label for="ucDirectSendNum"><span></span></label>
											</div> 직접입력
									</div>				
									<input type="text" id="ucSendNum" name="ucSendNum" maxlength="12" value="01056351595" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'  name="ucSendNum" id="ucSendNum" class="width-230px background-transparent font-14px height-40px line-height-40px border-e8e8e8 border-radius-5 padding-left-10 margin-top-10"  />
								</li>
								<!--//***옵션:직접선택일 경우-->
										
								<!--***옵션:등록번호콤보표시일 경우-->
								<li id="ucSendNumCombo" class="float-right width-230px height-70px padding-top-5 none">	 
									<!--***옵션:등록번호표시일 경우-->
									<select id="ucSendNum" class="select_blank_lightblue width-230px float-right" style="margin-top:10px;">
										<option value="" selected>010-0000-0000</option>
										<option value="">010-1234-5678</option>
									</select> 
								</li>
								<!--//***옵션:등록번호콤보표시일 경우-->
										
							</ul>
							</li>  	
						</ul>
		</div>
		<li>
			
		<!--  RIGHT SELECT FORM -->									
		<li class="float-right width-970px">
		<div class="width-100 height-650px padding-20 border-box border-radius-bottom-5 background-f7fafc">
			<ul class="width-100">
				<li class="width-100">
					<h3 class="inline-block float-left width-100 font-18px font-174962 margin-bottom-10">경조사 수신번호 불러오기</h3>
					<ul class="float-left width-100 height-50px">
						<li class="width-200px margin-bottom-5"><a id="ucPopGrpLst" class="open_pop_excel_thanks width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-16px font-053c72">주소록 불러오기</a></li>
					</ul>
					<div class="clear margin-bottom-20"></div>
						<h3 class="font-18px font-174962 margin-bottom-10">수신자 목록 <span class="font-bold" id="ucTotalCnt"></span></h3>
						<div class="height-240px border-box scroll-y">
						<table  id="tblsendthanks" class="con_tb width-100" cellpadding="0" cellspacing="0" border="0">
							<thead>
							<tr>
								<th class="width-20">이름</th>
								<th class="width-20">전화번호</th>
								<th class="width-20">비고</th>
								<th class="width-20">관리</th>
							</tr>
							</thead>
							<tbody id="ucPhoneList"></tbody>
						</table>
					</div>
					
					
					<div id="ucVars1" class="margin-bottom-10">
						<h3 id="ucVariablesTitle" class="font-18px font-174962 float-left"></h3>
					</div>
					<div id="ucVars2" class="margin-bottom-10">
						<div id="ucVariables"></div>
					</div>			
					
					
					<!-- 업무분류 -->
					<div class="width-100 padding-left-10 border-box">
						<span id="ucContentsChange">
						<span id="ucContentsChangeTitle" class="inline-block margin-left-5 margin-right-5 font-12px font-aaa">주소록 개별문자 </span>
						<select id="ucContentsChangeOpt" class="select_white_small width-120px">
							<option value="이름" selected>이름</option>
							<option value="비고">비고</option>
						</select>
						<a id="ucContentsChangeBtn" class="width-55px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">입력</a>
						</span>				
						<c:if test="${workSeqRequiredFlag != 'ND'}" >
						<span class="inline-block margin-right-5 font-12px font-aaa">업무분류</span>
						<select id="ucWorkLstOpt" name="ucWorkLstOpt"  class="select_white_small width-120px"></select>
						</c:if>
						<span id="ucCost" class="float-right inline-block margin-top-5 margin-right-10 font-14px font-aaa font-bold font-053c72">
							<span class="inline-block margin-right-10 font-12px font-aaa font-normal">예상비용</span>
							<span id="ucPrice"></span>
						</span>
					</div>

<!--  UA  -->  
<div id="pageUA" class="float-left width-430px margin-top-10 padding-left-10 border-box background-f9fbfd">
	<div class="checkbox-small">
		<input type="checkbox" checked id="ucReContentCheck" name="ucReContents" />
		<label for="ucReContentCheck"></label>
		<span class="font-16px font-053c72 margin-left-5">알림톡 실패 시 대체문자 발송</span>
	</div><a id="ucContentsRePopUpBtn" class=" width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-10">대체문자</a>
</div>
<!--  UA  -->					
					
					
<!--  UF  -->
<div class="clear margin-bottom-15"></div>
<div id="pageUF" class="float-left width-430px padding-left-10 border-box margin-bottom-15 background-f9fbfd">
	<span class="inline-block margin-left-10 margin-right-5 font-12px font-aaa checkbox-small "> 
		<div class="checkbox-small">
		<input type="checkbox" id="ucFReContentCheck" name="ucFReContents" />
		<label for="ucFReContentCheck"></label>
		<span class="font-16px font-053c72 margin-left-5">친구톡 실패시</span>
		</div><a id="ucFContentsRePopUpBtn" class="width-80px height-24px line-height-24px text-center border-radius-5 background-efefef font-12px font-fff box-shadow-smallest margin-left-10">대체문자</a>
														 
	</span>
	<span class="inline-block margin-left-20 margin-right-5 font-12px font-aaa checkbox-small ">
		<div  class="checkbox-small" style="display:block; margin-bottom:10px;">
			<input type="checkbox" id="uc_check_ad" name="ucCheckAD" />
			<label for="uc_check_ad"></label>
			<span class="font-16px font-053c72 margin-left-5">광고포함</span>
		</div>
	</span>
</div>											
<!--  UF  -->

 



					<div class="relative float-left width-650px height-110px border-box border-radius-5 margin-bottom-10 hidden box-shadow-smallest background-f9fbfd">
						
						<div class="absolute position-left position-vertical-center">
							<div class="relative width-100 height-30px margin-bottom-5 padding-left-10">
								<div class="absolute position-left position-vertical-center check-box_c font-16px font-053c72 ">
									<div class="checkbox-c" >
										<input type="checkbox" id="checkbox_7" name="ucTimeDirect" value="0" checked/>
										<label for="checkbox_7"><span></span></label>
									</div> 즉시발송
								</div>
							</div>
						</div>
						
					</div>
								
					<ul class="float-right width-230px height-120px">
						<li id="ucPreviewBtn"  class="width-100 margin-bottom-10"><a class="open_pop_preview width-100 height-50px line-height-50px text-center border-radius-5 background-efefef font-20px font-bold font-053c72">미리보기</a></li>
						<li id="ucSenderBtn"  class="width-100"><a class="width-100 height-50px line-height-50px text-center  border-radius-5 background-8bc5ff font-20px font-bold  font-053c72">전송하기</a></li>
					</ul>
					<div class="clear"></div>
					

				</li>
			</ul>
		</div>
		</li>					
	</ul>
</div>
							


 						
						
						
						






<!-- popup 주소록 -->
        <div id="share_pop_group" class="pop_wrap pop_excel_thanks width-730px" style="background:transparent;">
			<div class="width-100">
				<ul class="pop_tabmenu_excel_thanks">
					<li id="pop_tab_1" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_excel_thanks" id="pop_tabmenu_excel_thanks_1">
						<label for="pop_tabmenu_excel_thanks_1">주소록 불러오기</label>
						<div class="pop_tabCon">
							<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000 padding-20">
							<table cellpadding="0" cellspacing="0" border="0" class="width-100 height-210px margin-auto">
								<tr>
									<td class="width-330px height-240px vertical-top">
										<h5 class="font-18px font-normal font-174962 text-left">주소록보기</h2>
										<ul class="tabmenu_small_thanks">
											<li id="small_tab_1" class="btnCon">
												<input type="radio" checked name="tabmenu_small_thanks" id="tabmenu_small_thanks_1" value="3">
												<label for="tabmenu_small_thanks_1">직원</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="uc_pop_employ_group_list thanks_send_employ width-100 li-h30">
														</ul>
													</div>
												</div>
											</li> 
										</ul>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="ucGrpPrvBtn icon_group">그룹</a>
									</td>
									<td rowspan="2" class="vertical-top width-230px">
										<h5 class="font-18px font-normal font-174962 text-left">연락 받을 사람<a class="width-55px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest float-right">최근</a></h2>
										<div class="width-230px height-480px hidden scroll-y font-12px border-radius-5 border-e8e8e8" style="height:485px;">
											<ul class="uc_pop_receiver width-100 li-h30">
											
											</ul>
										</div>
									</td>
								</tr>
								<tr>
									<td class="width-330px height-240px vertical-top ">
										<h5 class="font-18px font-normal font-174962 text-left">선택그룹 상세보기</h2>
										<div class="width-330px height-210px hidden scroll-y font-12px border-radius-5 border-e8e8e8">
											<ul class="uc_pop_detail_list thanks_send_group width-100 li-h30">
											</ul>
										</div>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="ucIndivPrvBtn icon_each">개별</a>
									</td>
								</tr>
							</table>
							<div class="margin-top-5 text-right">
								<a id="ucPopDelSelect" class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest ">선택삭제</a>
								<a id="ucPopDelAll" class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">전체삭제</a>
							</div>
							</div>
							<!--버튼-->
							<div class="pop_btn-big margin-auto text-center margin-bottom-10">
								<a id="ucPopRegisterBtn" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
								<a id="ucPopCancelBtn" class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>	
        
        
        
        
         <!-- popup 이미지 업로드 -->
         <div class="pop_wrap ucPopImgUpload width-600px padding-20 border-radius-5 background-f7fafc">
            <div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">이미지 업로드</div>
            
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
 
		 	<form id="ucForm" enctype="multipart/form-data" method="POST" action="/msg/imgFileupload.do"> 
				<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-50">
					이미지선택
					<input id="uc_img_name" class="upload-name" value="" disabled="disabled" placeholder="제목 (최대 30Byte)" />
					<label for="uc_img_file">찾아보기</label> 
					<input type="file" id="uc_img_file" name="uc_img_file" required="required"  />		
				</div> 
        	</form>
			
				<!-- <div id="thumbnailUrl"></div> -->
				<ul class="pop_notice">
					<li>확장자는 jpg만 가능합니다.</li>
					<li>오리지널 사진 업로드를 체크해제하면 700 * 700  기준으로 사이즈가 자동조절됩니다.</li>
					<li>파일크기 100Kbyte 이상의 사진은 등록할 수 없습니다.</li>
					<li>
						오지리널 사진 업로드
						<span>
							<div class="checkbox">
									<input type="checkbox" id="uc_img_resize_check" name="체크" />
									<label for="uc_img_resize_check"></label>
							</div> 체크하면 오리지널 이미지 파일이 올라갑니다.</span>
					</li>
				</ul>
			</div>
			
			<!--버튼-->
			<div class="pop_btn-big">
				<a id="ucImgRegBtn" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>
        
                <!-- popup 미리보기 -->
         <div id="ucPreviewPopUp" class="pop_wrap width-800px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">미리보기</div>
				<!--내용-->
				<div class="flex-between margin-top-20">
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="umPreviewTitle1"></h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="ucPreviewContents1"  contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="umPreviewRcvNum1">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="umPreviewRcvNum1">01087654387</span>
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="umPreviewTitle2">내용 (최대 30Byte)</h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="ucPreviewContents2"  contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="umPreviewRcvNum2">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="umPreviewSendNum2">01087654387</span>
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="umPreviewTitle3">테스트</h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="ucPreviewContents3"  contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="umPreviewRcvNum3">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="umPreviewSendNum3">01087654387</span>
							</div>
						</div>
					</div>		
				</div>
				<!--버튼-->
				<div class="margin-auto text-center margin-top-30 margin-bottom-10">
					<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
				</div>
        </div>
        
  
<style>

    /* 문자보내기  내저장함 탭  prefix= um */
	ul.pop_tabmenu_uc_mybox{position:relative; width:100%; padding:60px 0 0; margin:0;}
	ul.pop_tabmenu_uc_mybox > li{display:inline-block; width:100%; float:left; text-align:center;  background :transparent; padding:0; margin:0;;}
	ul.pop_tabmenu_uc_mybox > li > label{position:absolute; left:0; top:0; display:block; width:182.5px;  height:60px; line-height:60px; background-image: linear-gradient(to left, #c1d4ed, #b4cae8); color:#688ba6; border-radius:5px 5px 0 0; text-align:center; font-weight:bold; font-size:20px;}
	ul.pop_tabmenu_uc_mybox > li:nth-child(2) > label{position:absolute; left:182.5px; top:0; }
	ul.pop_tabmenu_uc_mybox > li:nth-child(3) > label{position:absolute; left:365px; top:0; }
	ul.pop_tabmenu_uc_mybox > li:nth-child(4) > label{position:absolute; left:546.5px; top:0; width:183.5px;}
	ul.pop_tabmenu_uc_mybox > li > input{display:none;}
	ul.pop_tabmenu_uc_mybox > li > div.pop_tabCon{display:none;  text-align:left;  width:730px; padding:20px; background:#f7fafc; box-sizing:border-box; border-radius:0 0 5px 5px;}
	ul.pop_tabmenu_uc_mybox input:checked ~ label{ background:#f7fafc; color:#174962;}
	ul.pop_tabmenu_uc_mybox input:checked ~ .pop_tabCon{ display:block;}


</style>  
  
        
         <!-- popup 내저장함 -->
         <div id="ucMyBoxPopUp" class="pop_wrap width-1190px" style="background:transparent;">

			<div class="width-100">
				<ul class="pop_tabmenu_uc_mybox">
					<li id="pop_tab1" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_uc_mybox" id="pop_tabmenu_ucbox1" checked>
						<label for="pop_tabmenu_ucbox1">단문</label>
						<div class="pop_tabCon">
							
							
							<!-- 검색하기 --> 
			<div class="margin-bottom-20">

				<!--제목  셀렉박스-->
				<select class="select_blank_lightblue width-120px"
					style="margin-right: 10px">
					<option selected>제목</option>
					<option>내용</option>
					<option>기간</option>
				</select>

				<!--검색-->
				<div class="inline-block width-250px">
					<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
				</div>
				<a class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
				</div>
			<!-- //검색설정 -->
							<!--내용-->
							<div class="flex-between">
								
					<table id="ucTemplateS" style="padding-bottom: 10px; width: 100%">
						<thead height="0" style="display: none;">
							<tr height="0">
								<th height="0">검수상태</th>
								<th height="0">내용</th>
							</tr>
						</thead>
					</table>
							 
																
							</div>
							<!--내용--> 
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a OnClick="destroyTableUC()" class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
					<li id="pop_tab2" class="btnCon">
						<input type="radio" name="pop_tabmenu_uc_mybox" id="pop_tabmenu_ucbox2">
						<label for="pop_tabmenu_ucbox2">장문</label>
						<div class="pop_tabCon">
							<!--검색-->
							<div class="margin-bottom-20">
								<select class="select_blank_lightblue width-140px" style="margin-right:10px">
									<option selected>제목</option>
									<option >내용</option>
									<option >기간</option>
								</select>
								<div class="inline-block width-350px">
									<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
								</div>
								<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
							</div>

							<!--내용-->
							<div class="flex-between">

					<table id="ucTemplateL" style="padding-bottom: 10px; width: 100%">
						<thead height="0" style="display: none;">
							<tr height="0">
								<th height="0">검수상태</th>
								<th height="0">내용</th>
							</tr>
						</thead>
					</table>		
										
							</div>
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a OnClick="destroyTableUC()" class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
					<li id="pop_tab3" class="btnCon">
						<input type="radio" name="pop_tabmenu_uc_mybox" id="pop_tabmenu_ucbox3">
						<label for="pop_tabmenu_ucbox3">멀티</label>
						<div class="pop_tabCon">
							<!--검색-->
							<div class="margin-bottom-20">
								<select class="select_blank_lightblue width-140px" style="margin-right:10px">
									<option selected>제목</option>
									<option >내용</option>
									<option >기간</option>
								</select>
								<div class="inline-block width-350px">
									<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
								</div>
								<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
							</div>

							<!--내용-->
							<div class="flex-between">
								
					<table id="ucTemplateM" style="padding-bottom: 10px; width: 100%">
						<thead height="0" style="display: none;">
							<tr height="0">
								<th height="0">검수상태</th>
								<th height="0">내용</th>
							</tr>
						</thead>
					</table>							
							</div>
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a OnClick="destroyTableUC()" class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
					<li id="pop_tab4" class="btnCon">
						<input type="radio" name="pop_tabmenu_uc_mybox" id="pop_tabmenu_ucbox4">
						<label for="pop_tabmenu_ucbox4">친구톡</label>
						<div class="pop_tabCon">
							<!--검색-->
							<div class="margin-bottom-20">
								<select class="select_blank_lightblue width-140px" style="margin-right:10px">
									<option selected>제목</option>
									<option >내용</option>
									<option >기간</option>
								</select>
								<div class="inline-block width-350px">
									<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
								</div>
								<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
							</div>

							<!--내용-->
							<div class="flex-between">
								
					<table id="ucTemplateF" style="padding-bottom: 10px; width: 100%">
						<thead height="0" style="display: none;">
							<tr height="0">
								<th height="0">검수상태</th>
								<th height="0">내용</th>
							</tr>
						</thead>
					</table>
												
							</div>
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a OnClick="destroyTableUC()" class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>
        
        
            
        <!-- popup 템플릿 -->
        <div id="ucTempletPopUp" class="pop_wrap width-1190px min-width-1110px background-f7fafc border-radius-5" >
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">알림톡 템플릿</div>

		<div class="margin-top-5 margin-bottom-10"> 

				<!--업무분류 셀렉박스-->
				<select class="select_blank_lightblue width-120px"
					style="margin-right: 10px">
					<option value="">선택해주세요</option>
					<c:if test="${g_workSeqZeroCodeUseYN eq 'Y'}">
						<option value="0">미분류</option>
					</c:if>
					<option value="1">알림톡</option>
					<option value="2">알림</option>
					<option value="3">민원</option>
					<option value="4">공지</option>
					<option value="5">비상</option>
					<option value="6">기타</option>
				</select>

				<!--제목  셀렉박스-->
				<select class="select_blank_lightblue width-120px"
					style="margin-right: 10px">
					<option selected>제목</option>
					<option>템플릿이름</option>
					<option>내용</option>
				</select>

				<!--검색-->
				<div class="inline-block width-250px">
					<input type="text" name="" placeholder=""
						class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
				</div>
				<a	class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
			</div>
			<!-- //검색설정 -->				
				<!--내용-->
				<div class="flex-between margin-top-20">
					
					<table id="ucTemplate" style="padding-bottom: 10px; width: 100%">
						<thead height="0" style="display: none;">
							<tr height="0">
								<th height="0">검수상태</th>
								<th height="0">내용</th>
							</tr>
						</thead>
					</table>
					 
				</div> 
				<div class="margin-auto text-center margin-top-30 margin-bottom-10">
					<a id="uaRegTemplateBtn" OnClick="inputTemplateUC();" class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
				</div>
        </div>
        
     


		 <!-- popup 버튼추가 -->
         <div id="ucMsgBtnPopUp" class="pop_wrap width-730px padding-20 border-radius-5 background-fff">
     	    <div class="width-100 margin-bottom-10 padding-bottom-10 border-bottom-e9eced">
          	  <div id="ucButtonTitle" class="font-20px font-000 font-bold text-left  float-left">버튼입력 (2/5)</div>
          	  <button id="ucButtonAdd" class="plus_btn float-left" style="margin-top: -3px;"><span>+</span></button>
            </div>
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-12px font-000">
			 
			
				<table class="con_tb width-100" cellpadding="0" cellspacing="0" border="0"  id="t_btn_uc">
					<thead>
						<tr>
							<th class="width-30">버튼타입</th>
							<th class="width-20">버튼명</th>
							<th class="width-35">링크</th>
							<th class="width-15">관리</th>
						</tr>
					</thead>
					<tbody id="ucButtonTbody">
					</tbody>
				</table>
			</div>
			<!--버튼-->
			<div class="pop_btn-big">
				<a  OnClick="registerButtonUC()" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>   
        
        
 
<style>
ul.pop_tabmenu_uc_contens_re { position:relative; width:100%; padding:60px 0 0; margin:0; }
ul.pop_tabmenu_uc_contens_re > li{ display:inline-block; width:100%; float:left; text-align:center;  background :transparent; padding:0; margin:0;;}
ul.pop_tabmenu_uc_contens_re > li > label{position:absolute; left:0; top:0; display:block; width:180px;  height:60px; line-height:60px; background-image: linear-gradient(to left, #c1d4ed, #b4cae8); color:#688ba6; border-radius:5px 5px 0 0; text-align:center; font-weight:bold; font-size:20px;}
ul.pop_tabmenu_uc_contens_re > li:nth-child(2) > label{position:absolute; left:180px; top:0; }
ul.pop_tabmenu_uc_contens_re > li:nth-child(3) > label{position:absolute; left:340px; top:0; }
ul.pop_tabmenu_uc_contens_re > li:nth-child(4) > label{position:absolute; left:546.5px; top:0; width:183.5px;}
ul.pop_tabmenu_uc_contens_re > li > input{display:none;}
ul.pop_tabmenu_uc_contens_re > li > div.pop_tabCon{ display:none;  text-align:left;  width:540px; padding:20px; background:#f7fafc; box-sizing:border-box; border-radius:0 0 5px 5px;}
ul.pop_tabmenu_uc_contens_re input:checked ~ label{ background:#f7fafc; color:#174962;}
ul.pop_tabmenu_uc_contens_re input:checked ~ .pop_tabCon{ display:block;}
</style>
        
         <!-- popup 대체문자 -->
         <div id="ucContentsRePopUp" class="pop_wrap width-540px" style="background:transparent;">
			<div class="width-100">
				<ul class="pop_tabmenu_uc_contens_re">
					<li id="pop_tab01" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_uc_contens_re" id="pop_tabmenu_uc01" value="SMS">
						<label for="pop_tabmenu_uc01">단문</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 id="ucReContentSMSTitle" class="font-18px font-bold font-174962 text-center background-8bc5ff padding-10 "></h2>
									<div id="ucReContentSMSContent" class="word-break-break-all width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"></div>
								</div>
							</div>							
							<!--버튼-->
							<div class="pop_btn-big">
							    <a OnClick="ReContentEditMode('ucReContentSMSContent','ucReContentSMSRegBtn')"  class="margin-right-30 font-053c72 font-bold width-100px background-8bc5ff box-shadow">편집하기</a>
								<a id="ucReContentSMSRegBtn" OnClick="ReContentRegister('ucReContentSMSContent','ucReContentSMSRegBtn','SMS','UC');" class="margin-right-30 font-053c72 font-bold width-200px background-8bc5ff box-shadow">대체문자로 지정</a>
								<a id="ucReContentSMSCloseBtn" class="background-efefef width-70px font-053c72 font-normal">닫기</a>
							</div>
						</div>
					</li>
					<li id="pop_tab02" class="btnCon">
						<input type="radio" name="pop_tabmenu_uc_contens_re" id="pop_tabmenu_uc02" value="LMS">
						<label for="pop_tabmenu_uc02">장문</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 id="ucReContentLMSTitle" class="font-18px font-bold font-174962 text-center background-8bc5ff padding-10"></h2>
									<div id="ucReContentLMSContent" class="word-break-break-all width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"></div>
								</div>
							</div>							
							<!--버튼-->
							<div class="pop_btn-big">
								<a OnClick="ReContentEditMode('ucReContentLMSContent','ucReContentLMSRegBtn');" class="margin-right-30 font-053c72 font-bold width-100px background-8bc5ff box-shadow">편집하기</a>
								<a id="ucReContentLMSRegBtn"  OnClick="ReContentRegister('ucReContentLMSContent','ucReContentLMSRegBtn','LMS','UC')" class="margin-right-30 font-053c72 font-bold width-200px background-8bc5ff box-shadow">대체문자로 지정</a>
								<a id="ucReContentLMSCloseBtn" c class="pop_close background-efefef width-70px font-053c72 font-normal">닫기</a>
							</div>
						</div>
					</li>
					<li id="pop_tab03" class="btnCon">
						<input type="radio" name="pop_tabmenu_uc_contens_re" id="pop_tabmenu_uc03" value="MMS">
						<label for="pop_tabmenu_uc03">멀티</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 id="ucReContentMMSTitle" class="font-18px font-bold font-174962 text-center background-8bc5ff  padding-10"></h2>									
									<div id="ucReContentMMSContent" class="word-break-break-all width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"></div>
								</div>
							</div>	 
							<div class="pop_btn-big">
								<a OnClick="ReContentEditMode('ucReContentMMSContent','ucReContentMMSRegBtn');" class="margin-right-30 font-053c72 font-bold width-100px background-8bc5ff box-shadow">편집하기</a>
								<a id="ucReContentMMSRegBtn"  OnClick="ReContentRegister('ucReContentMMSContent','ucReContentMMSRegBtn','MMS','UC')"  class="margin-right-30 font-053c72 font-bold width-200px background-8bc5ff box-shadow">대체문자로 지정</a>
								<a id="ucReContentMMSCloseBtn" class="pop_close background-efefef width-70px font-053c72 font-normal">닫기</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>

        
        
</body>
</html>
