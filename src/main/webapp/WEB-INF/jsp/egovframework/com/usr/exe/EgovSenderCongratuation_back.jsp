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
#counter {
  background:rgba(255,0,0,0.5);
  border-radius: 0.5em;
  padding: .5em .5em .5em .5em;
  text-align: center;
  text-color: #fff;
  font-weight: bold;
}
</style>
<script type="text/javaScript" language="javascript" defer="defer">

$(document).ready(function(){ 
	


	/* 알림톡 주소록버튼클릭시 주소록리스트 */
	$('#uSPopGrpLst').on('click', function(){	
		
		console.log('----ajax 알림톡을 위한 전체 group 가져오기--');
		//주소록가져오기 
		
		$.ajax({
        	type: "POST",
        	url: "/grp/AddrGroupListByType.do",
            data:  { 
            	"type" : "3"  /* 직원  */
            },
            dataType: "json",          // ajax 통신으로 받는 타입
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
            },
        	success: function(jsondata){

        		var idx = 1;
        		var object = jsondata.data;
				arrUCGLst = jsondata.data;
				console.log(arrUCGLst);
				
        		/* 최초그룹리스트 Render */ 
        		
        		$.each(object, function(idx, row){  
    			 
    					var html = "<li><div class=\"checkbox-small_2\">" +
    					"<input type=\"checkbox\" id=\"uccheck-" + idx + "g\" name=\"uc_group_check" + idx + "\" onclick=\"msg_check_uc(this," + object[idx].code + ",'.uc_pop_detail_list'," + idx + ");\" />" +
    					"<label for=\"uccheck-" + idx + "g\"></label>" + 
    					"</div><span>" + object[idx].title + "<span>" + object[idx].code + "</span></span></li>";
						$('.uc_pop_employ_group_list').append(html); 
        		}); 

                $('.wrap-loading').addClass('display-none'); 
        	},
        	error: function(request,status,error){
        		  
        		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
                $('.wrap-loading').addClass('display-none');
        	}
   		}); /* ajax */
		$(".pop_bg").css('display','block');
		$('#share_pop_group').css('display','block'); 
	}); /* ftalkAddressBtn click */
	 
	
	/* 그룹주소 이동버튼 */
	$("a.ucGrpPrvBtn").click(function(){		
		
		/* 체크된 그룹탭 값 확인 */
		/* 체크된 그룹탭 값 확인 */
		//var radioVal = $('input[name="tabmenu_small_thanks"]:checked').val(); 
		//console.log(radioVal);
		/* arrUCGLst arrUCPLst 중복제거 */  
 			console.log(arrUCGLst);
		
		/* arrUCGLst checked : 1 */
 		$.each(arrUCGLst, function(idx, row){ 
 			//var typeVal = arrUCGLst[idx].type;
 			console.log("----push-----");
 			if( arrUCGLst[idx].rowNo == 1 ){  

 				arrUCPLst.push({
 	 				isGroup : "Y", /* 그룹여부 */
 	 				title : arrUCGLst[idx].title,  /* 타이틀 */
 	 				code : arrUCGLst[idx].code,     /* 그룹code Unique */
 	 				phone : null
 	 				
 	 			});
 	 			
 				var html = "<li><div class=\"checkbox-small_2\">" +
 				"<input type=\"checkbox\" id=\"uccheck-" + idx + "pg\" name=\"uc_group_check_" + idx + "\"  />" +
 				"<label for=\"uccheck-" + idx + "pg\"></label>" + 
 				"</div><span>" + arrUCGLst[idx].title + "<span>" + arrUCGLst[idx].code + "</span></span></li>";
 				$('ul.uc_pop_receiver').append(html);
 			}  
 			
		});
		
		console.log(arrUCGLst);
		console.log(arrUCPLst);
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
 	 				phone : arrUCGDLst[idx].address_num 	 				
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

		console.log("-----arrMCPLst []-----");
		console.log(arrUCPLst);
		 
		
		/* arrMCPLst [] rendering */
		$.each(arrUCPLst, function(idx, row){ 
			
			/* 최종에 push */
			arrUCLst.push(arrUCPLst[idx]);
			/* console.log(arrMCPLst[idx].title); */
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
			             	"<a href=\"#\" class=\"icon_delete\"onclick=\"arrayPop(" + idx + ");deleteLine(this);\" >삭제</a>" + 
			             "</td>" + 
			             "</tr>";
			$('#tblsendthanks tbody').append(trData);
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
		console.log(arrUCPLst);
	});
	
	/************************************************* 팝업 주소록 보기 스크립트 ***************************************/
	
	var bnr_cong = "<spring:message code='bnr_cong' javaScriptEscape='true' ></spring:message>"
	var address = unescape(location.href);
	var param = "";
	
	if(address.indexOf("tab",0)!=-1){
		param = address.substring(address.indexOf("tab",0)+4)
		console.log("param :: "+param);
	}
	
	console.log("------bnr_cong---- :"  + bnr_cong);
		//var b = $('#tabmenu-4').prop('checked',true);
		//console.log(b);
		if(bnr_cong == "Y" && param ==4){
			$('#tabmenu-4').prop('checked',true);
			//$('input:radio[name="tabmenu-4"][value="4"]').prop('checked', true);
	}
		
		
		
		
		
		

	/*
	제목글자수체크
	*/
	$('#ucTitle').keyup(function (e){
	    var title = $(this).val();
	    
	    //$('#counter').html("("+content.length+" / 최대 200자)");    //글자수 실시간 카운팅

	    if ( Number(byteCheck($(this))) > 30){ 
	    	//$(this).val(title.substring(0, title.length - 1));
	    	
	    	//e.preventDefault();
	    	$('#ucContent').focus();
	    	toastr.error("최대 30BYTE까지만 입력 가능합니다.");
	    	f_chk_byte($(this),30);
	    	return onlyBackspace(e);
	        //return false;
	        
	        //$('#counter').html("(200 / 최대 200자)");
	    }
	});
	
	/*
	내용글자수체크
	*/
	$('#ucContent').keyup(function (e){
	    var content = $(this).val();

	    if ( Number(byteCheck($(this))) == 90 ){  
	    	
	    	e.preventDefault();
	    	//$(this).attr("readonly",true); 
	    	//$('#phonelist').focus();
	    	toastr.error("단문은 최대 90BYTE까지만 입력 가능합니다.");
	    	//f_chk_byte($(this),90);
	        //$(this).val(content);
	        //return false; 
	        //$('#counter').html("(200 / 최대 200자)");
	    }
	    
	    if ( Number(byteCheck($(this))) > 1800 ){ 

	    	e.preventDefault();
	    	$('#phonelist').focus();
	    	toastr.error("최대 1800BYTE까지만 입력 가능합니다.");
	    	f_chk_byte($(this),1800);
	    }
	    
 		if( Number(byteCheck($(this))) > 90 ){
 			totalCnt = "1800";
 		}else{
 			totalCnt = "90";
 		}
 		
       /*  $(this).height(((content.split('\n').length + 1) * 1.5) + 'em'); */
        $('#counter').html(content.length + '/' + totalCnt );
	});
 

	//보내는번호입력
	$('input:radio[name=send_num]').change(function() {
		
		var sendnumType = $('input:radio[name=send_num]:checked').val();
		
		if(sendnumType == "3") {
			$('#ucSendNum').val("");
		}else if(sendnumType == "2"){
			$('#ucSendNum').val("01056351595");
		}else{
			$('#ucSendNum').val("01056351595");
		}
		
	});
	 
	


	
	
	//제목내용 클리어
	$('#contClearBtn').on('click', function(){	 
		$('#ucTitle').val(""); 
		$('#ucContent').val(""); 
	});	 
	
	
	//테스트입력
	$('input:radio[name=sendtime]').change(function() {
		 
		  if ($('input:radio[name=sendtime]:checked').val() == "2") {
		     $('#testinput').removeClass("none");
		  }else{
			 $('#testinput').addClass("none");
		  } 
	});
	
	//오늘날짜세팅 
	$('#datePicker').val(getCurrentDate());
	
	//lodingbar hide
	$('.loading_bar').hide();
	
	
	/* 전송하기 */
	$('#sendThanksBtn').on('click', function(){	 
		
		/* 직전 동일내용 전송체크 메세지 */ 
		if( g_dupMessageUseFlag == "Y" ){
			
			if( getCookie("ucContent") ==  $('#ucContent').val() ){
				var r = confirm("이전 내용과  동일한 메세지내용입니다. 전송하시겠습니까?");
				if (r == true) {
				} else {
					toastr.error("전송이 취소되었습니다");
					return false;
				}
			}
		}
		
		
		
		var title = $('#ucTitle').val(); 
		var content = $('#ucContent').val(); 
		

		console.log(title + ": " + content);
		var titleLen = getTextLength(title);
		var contentLen = getTextLength(content);
	
		//toastr.success(titleLen + ":" + contentLen);
		// alert( maxLengthCheck("ucContent","내용",90) );
		
		if( titleLen < 10 ) { 
     		toastr.error('제목을 입력하세요'); 
     		$('#ucTitle').focus();
     		return false;
		}
		
		if( contentLen < 20 ) { 
     		toastr.error('내용을 입력하세요'); 
     		$('#ucContent').focus();
     		return false;
		}

		if( !maxLengthCheck("ucTitle","제목",30) ){
			$('#ucTitle').focus();
			return false;
		} 


		if( !maxLengthCheck("ucContent","내용",1800) ){
			$('#ucContent').focus();
			return false;
		}
		      
		var checkMsgType = "0";  //SMS
		var isImage = false;
		
		if(contentLen > 90 ) checkMsgType = "1";  //LMS
		if(contentLen > 90 && isImage ) checkMsgType = "2"; //MMS
		
	 	
	 	//check snd_number  부서원소속 사무실, 사용자핸드폰, 직접입력
	 	//var sendPhoneType = $('input:radio[name=send_num]:checked').val(); 
		
		
	 	//var sendPhone = $('input:text[name=msg_rcv_number]').val(); 
	 	var sendPhone = $('select[name=ucSendNum]').val();
	 	//alert("sendPhoneType: " + sendPhoneType + ": phone " + sendPhone + ": phone x " + sendP );

		/* var sendPhoneLen = getTextLength(sendPhone);
		if( sendPhoneLen < 8 ) { 
     		toastr.error('발신번호를 입력하세요'); 
     		$('input[name=ucSendNum]').focus();
     		return false;
		}
	 	 */
		
		
		//수동입력체크
		var manualInput = $('#phonelist').val();  
		
		if(manualInput.length > 0) {
     		toastr.error('수동입력창에 자료가 남아 있습니다'); 
     		$('#phonelist').focus();
			return false;
		}
		
		var jobOptThanks = $('select[name=jobOptThanks]').val();
		//alert(jobOpt);
		if( jobOptThanks == "0"  ){
			toastr.error("업무분류를 선택하세요");
			return false;
		}
		
	 	var startDate = getTimeStamp();
	 	
	 	//즉시 에약 테스트
	 	var sendTimeValue = $('input:radio[name=sendtime]:checked').val(); 
	 	//alert(sendTimeValue);  //on
	 	//즉시 현재시각  , 예약 예약시각 ,  테스트 즉시
	 	if( sendTimeValue == "2"){
	 		//alert("예약");
	 		var iDate = $('#datePicker').val();
	 		var iTime = $('#hour option:selected').val();
	 		var iMinute = $('#minute option:selected').val();
	 		startDate = iDate + iTime + iMinute;
	 	}
	 	
	 	
	 	
	 	$('.wrap-loading').removeClass('display-none');   
	 	

		var optId = "<c:out value="${familyEventMasterId}" />";
		var param = tableToJsonThanks(document.getElementById("tblsendthanks"), checkMsgType, startDate, optId); // table id를 던지고 함수를 실행한다.

		if( !param.length ){
			toastr.error("수신목록이 없습니다");
			return false;
		} 
        var obj = JSON.stringify(param);  
        
        //$('#result').text(obj);  
		$('#sendThanksBtn').attr('disabled', true);	 
		
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
        		$('#sendThanksBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#sendThanksBtn').attr('disabled', false);
            },
        	success: function(jsondata){
        		var res = JSON.stringify(jsondata);
        		//alert(res); //로딩
        		
        		//clear
        		if(jsondata['result_msg'] == "ok"){
        			$("#tblsendthanks tbody").remove(); 
            		$('#ucTitle').val(""); 
            		$('#ucContent').val(""); 
        		}
        		$('#result').text("전송시간:" + res); 
                toastr.success('성공적으로 전정되었습니다'); 
                   /* $(".pop_templet").css('display','none'); */

                $('.wrap-loading').addClass('display-none');
        		$('#sendThanksBtn').attr('disabled', false);
        		//close popup
        	},
        	error: function(request,status,error){
        		  
        		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            	//$('#result').text(error);
            	//alert("serialize err");
        		$('#sendThanksBtn').attr('disabled', false);
                $('.wrap-loading').addClass('display-none');
        	}
   		});
	});
	
	$('#templetSaveC').on('click', function(){
		
		var title = $("#ucTitle").val();
		var subject = $("#ucContent").val();
		var status = "C";
		
		var obj = {
			"title" : title,
			"subject" : subject,
			"status" : status
		}
		
		console.log("obj :: "+JSON.stringify(obj));
		
		$.ajax({
	       	url: "<c:url value='/usr/insertMySave' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){  
	     	   
	       		console.log(jsondata["data"]);
	            
	            if(jsondata["data"]==0){
	                //로딩
	                alert("저장되었습니다.");
	            }else{
	            	alert("양식을 다시 확인해주시기 바랍니다.");
	            }
	       	},
	       	error: function(request,status,error){
	       		  
	       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	           	$('#result').text(jsondata);
	           	//console.log("serialize err");
	       		$('#addrBtn').attr('disabled', false);
	       	}
	   	});
	});
});



function tableToJsonThanks(table, type, startDate, optId) {
	
	    var data = []; 
	    
	    for (var r = 1, n = table.rows.length; r < n; r++) {
	    	
	       	var tableRow = table.rows[r];
	        var rowData = {}; 
	            rowData["optId"] = optId,  /* 지정발송계정 */
        		rowData["rcv_title"] = $('#ucTitle').val(),
        		rowData["rcv_content"] = $('#ucContent').val(),                
	        	rowData["column1"] = tableRow.cells[0].querySelector('a').innerHTML; //이름
	        	rowData["rcv_number"] = tableRow.cells[1].innerHTML; //수신번호
	        	rowData["snd_number"] = $('#ucSendNum').val();
	        	rowData["rcv_etc"] = tableRow.cells[2].innerHTML; //비고란
	        	rowData["rcv_type"] = type;
	        	rowData["snd_date"] = startDate;
	        	rowData["rcv_rsvt_chk"] = "1";
 
	         data.push(rowData); 
	        
	    } 

	    return data;
}
</script>
</head>
<body>

							<input type="radio"  name="sendM_tabmenu" id="tabmenu-4" >
							<label for="tabmenu-4">경조사</label>
							<div class="tabCon none">
								<ul class="width-100 margin-bottom-100">
									
			
									
									
									<li class="float-left  width-350px margin-right-30 none">
										<div class="width-350px height-650px border-radius-5 background-f7fafc padding-20 border-box">
											<textarea type="text"  name="ucTitle" id="ucTitle"  placeholder="제목 (최대 30Byte)" class="width-100 height-50 border-e8e8e8 background-transparent font-16px padding-left-20 padding-right-20 border-box row-1 margin-bottom-5"></textarea>
											<div class="relative width-100 height-410px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden">
												<textarea type="text" name="ucContent" id="ucContent" placeholder="내용 (텍스트 최대 1000자 or 이미지+텍스트 400자)" class="width-100 height-100 background-transparent font-16px line-height-default" style="overflow-y: auto;"></textarea>
								 
											 <div id="phonelistthanks" name="phonelistthanks"  contentEditable="true"  onkeydown='return onlyNumberEnter(event)' onkeyup='removeCharEnter(event)' placeholder="전화번호를 직접 입력하거나 메모장, 엑셀을 붙여넣기 한 후에 우측의 입력버튼을 눌러주세요. 두 개 이상의 전화번호는 꼭 엔터키로 구분해주세요."  class="width-100 height-70px background-transparent font-14px line-height-default"  style="overflow:scroll;overflow-x:hidden;overflow-y:hidden;" ></div>														
										 
											</div>
											<ul class="margin-bottom-20">
												<li class="float-left width-50 padding-right-5 border-box"><a class="width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">경조사 저장함</a></li>
												<li class="float-left width-50 padding-left-5 border-box"><a id="templetSaveC" class="width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">저장하기</a></li>
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
													<input type="radio" id="ucOfficeNum" name="send_num" value="1" />
													<label for="ucOfficeNum"><span></span></label>
												</div> 사무실
											</div>
											<div class="radio-box_s font-14px font-053c72 margin-right-10">
												<div class="radio_s">
													<input type="radio" id="ucPhoneNum" name="send_num" value="2" />
													<label for="ucPhoneNum"><span></span></label>
												</div> 핸드폰
											</div>						
											<div class="radio-box_s font-14px font-053c72 ">
												<div class="radio_s">
													<input type="radio" id="r_3" name="send_num" value="3" />
													<label for="r_3"><span></span></label>
												</div> 직접입력
											</div>				
											<input type="text" maxlength="12" value="01056351595" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'  name="ucSendNum" id="ucSendNum" class="width-230px background-transparent font-14px height-40px line-height-40px border-e8e8e8 border-radius-5 padding-left-10 margin-top-10"  />
										</li>
										<!--//***옵션:직접선택일 경우-->
										
										<!--***옵션:등록번호콤보표시일 경우-->
										<li id="ucSendNumCombo" class="float-right width-230px height-70px padding-top-5">	 
											<!--***옵션:등록번호표시일 경우-->
											<select id="ucSendNum" class="select_blank_lightblue width-230px float-right" style="margin-top:10px;">
												<option>010-0000-0000</option>
												<option>010-1234-5678</option>
											</select> 
										</li>
										<!--//***옵션:등록번호콤보표시일 경우-->
										
									</ul>
								</li>  	
											
											 
											</ul>
										</div>
									<li>
									<li class="float-right width-970px">
										<div class="width-100 height-650px padding-20 border-box border-radius-bottom-5 background-f7fafc">
											<ul class="width-100">
												<li class="width-100">
													<h3 class="inline-block float-left width-100 font-18px font-174962 margin-bottom-10">경조사 수신번호 불러오기</h3>
													<ul class="float-left width-100 height-50px">
														<li class="width-200px margin-bottom-5"><a id="uSPopGrpLst" class="open_pop_excel_thanks width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-16px font-053c72">주소록 불러오기</a></li>
													</ul>
													<div class="clear margin-bottom-20"></div>


													<h3 class="font-18px font-174962 margin-bottom-10">수신자 목록 <span class="font-bold">[0건]</span></h3>
													<div class="height-260px border-box scroll-y">
														<table  id="tblsendthanks" class="con_tb width-100" cellpadding="0" cellspacing="0" border="0">
															<thead>
																<tr>
																	<th class="width-20">이름</th>
																	<th class="width-20">전화번호</th>
																	<th class="width-20">비고</th>
																	<th class="width-20">관리</th>
																</tr>
															</thead>
															<tbody>
															<!-- 	<tr>
																	<td class="relative">
																		<div class="absolute position-left-10px position-top-5px checkbox-small_2">
																		<input type="checkbox" id="check_3" name="체크" class="thankscheck" />
																		<label for="check_3"></label>
																		</div><a class="rev_name">김단문1</a>
																	</td>
																	<td class="rcv_number">01042319120</td>
																	<td class="rcv_etc">비고가 들어갑1.</td>
																	<td class="tb_btn">
																		<a class="open_pop icon_modify">수정</a>
																		<a href="#" class="icon_delete">삭제</a>
																	</td>
																</tr> -->
															</tbody>
															<!--검색결과 없을 시>
															<tfoot>
																<tr>
																	<td  colspan="4">검색 결과가 없습니다.</td>
															</tfoot-->
														</table>
													</div>

													<div class="width-100 margin-top-10 padding-left-10 border-box">
													<c:if test="${workSeqRequiredFlag != 'ND'}" >
														<span class="inline-block margin-right-5 font-12px font-aaa">업무분류</span>
														<select id="jobOptThanks" name="jobOptThanks"  class="select_white_small width-120px">
															<c:if test="${workSeqRequiredFlag != 'Y'}" >	
																<option value="">선택해주세요</option>
															</c:if>
															<c:if test="${g_workSeqZeroCodeUseYN eq 'Y'}" >	
																<option value="0">미분류</option>
															</c:if>
																<option value="1">알림톡</option>
																<option value="2">알림</option>
																<option value="3">민원</option>
																<option value="4">공지</option>
																<option value="5">비상</option>
																<option value="6">기타</option>
														</select>
														</c:if>
														<span class="float-right inline-block margin-top-5 margin-right-10 font-14px font-aaa font-bold font-053c72"><span class="inline-block margin-right-10 font-12px font-aaa font-normal">예상비용</span>친구톡 대체 0원</span>
													</div>
													<div class="clear margin-bottom-20"></div>
													<div class="float-left width-650px padding-left-10 border-box margin-bottom-15 background-f9fbfd">
														<div class="checkbox-small">
																<input type="checkbox" id="check_4" name="chkfrifail" />
																<label for="check_4"></label>
																<span class="font-16px font-053c72 margin-left-5">친구톡 실패시 대체문자 발송</span>
														</div><a class="open_pop_message width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-10">대체문자</a>
													</div>

														<div class="relative float-left width-650px height-110px border-box border-radius-5 margin-bottom-10 hidden box-shadow-smallest background-f9fbfd">
															<div class="absolute position-left position-vertical-center">
																<div class="relative width-100 height-30px margin-bottom-5 padding-left-10">
																	<div class="absolute position-left position-vertical-center check-box_c font-16px font-053c72 ">
																		<div class="checkbox-c" >
																			<input type="checkbox" id="checkbox_7" name="sendtime" value="0" checked/>
																			<label for="checkbox_7"><span></span></label>
																		</div> 즉시발송
																	</div>
																</div>
															</div>
														</div>
											
													<ul class="float-right width-230px height-120px">
														<li id="ucPreviewBtn"  class="width-100 margin-bottom-10"><a class="open_pop_preview width-100 height-50px line-height-50px text-center border-radius-5 background-efefef font-20px font-bold font-053c72">미리보기</a></li>
														<li id="sendThanksBtn"  class="width-100"><a class="width-100 height-50px line-height-50px text-center  border-radius-5 background-8bc5ff font-20px font-bold  font-053c72">전송하기</a></li>
													</ul>
													<div class="clear"></div>
												</li>
											</ul>
										</div>
									</li>
								</ul>
							</div>
							


 		<!-- popup 엑셀&주소록 -->
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
												<input type="radio" checked name="tabmenu_small_thanks" id="tabmenu_small_thanks_1">
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
</body>
</html>
