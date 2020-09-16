<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="dispMemberJoin" var="dispMemberJoin" /> 
<spring:message code="g_pw_search" var="g_pw_search" /> 
<spring:message code="iUsableFailCnt" var="iUsableFailCnt" /> 
<spring:message code="g_mng_login_fail_time" var="g_mng_login_fail_time" /> 
<spring:message code="g_mng_login_fail" var="g_mng_login_fail" /> 
<spring:message code="Notice_YN" var="Notice_YN" /> 
<%
	/**
	 * @Class Name : EgovLoginUsr.jsp
	 * @Description : Login 인증 화면
	 * @Modification Information
	 * @
	 * @  수정일         수정자                   수정내용
	 * @ -------    --------    ---------------------------
	 * @ 2020.02.26  김수로          최초 생성
	 *
	 *  @author softkids 수로
	 *  @since 2020.02.26
	 *  @version 1.0
	 *  @see
	 *
	 *  Copyright (C) 2020 by LEANAUTO  All right reserved.
	 */
%>
<!doctype html>
<html lang="en">
<head>
<title><spring:message code="titleName" /></title>
<!-- 로그인 -->
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<link rel="stylesheet"
	href="<c:url value='/css/egovframework/com/bootstrap.min.css' />" />
<link rel="stylesheet"
	href="<c:url value='/css/egovframework/com/bootstrap-datepicker.css' />">
<link rel="stylesheet"
	href="<c:url value='/css/egovframework/com/font.css' />" />
<link rel="stylesheet"
	href="<c:url value='/css/egovframework/com/reset.css' />" />
<link rel="stylesheet"
	href="<c:url value='/css/egovframework/com/custom.css' />" />
<script src="<c:url value='/js/egovframework/com/jquery.min.js' />"></script>
<script src="<c:url value='/js/egovframework/com/bootstrap.min.js' />"></script>
<script src="<c:url value='/js/egovframework/com/jquery-3.2.1.js' />"></script>
<script
	src="<c:url value='/js/egovframework/com/bootstrap-datepicker.js' />"></script>
<script src="<c:url value='/js/egovframework/com/custom.js' />"></script>

<!-- message toast -->
<script src="<c:url value='/js/egovframework/com/cmm/jquery.js' />"></script>
<script src="<c:url value='/js/egovframework/com/toastr.min.js' />"></script>
<link type="text/css" rel="stylesheet"
	href="<c:url value='/css/egovframework/com/toastr.css' />">

<link rel="stylesheet" type="text/css"
	href="<c:url value='/js/egovframework/com/datatable/DataTables-1.10.20/css/jquery.dataTables.min.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/css/buttons.dataTables.min.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/js/egovframework/com/datatable/Select-1.3.1/css/select.dataTables.min.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/js/egovframework/com/datatable/Editor-1.9.2/css/editor.dataTables.min.css' />" />

<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/jquery-3.2.1.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/DataTables-1.10.20/js/jquery.dataTables.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/dataTables.buttons.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/Select-1.3.1/js/dataTables.select.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/Editor-1.9.2/js/dataTables.editor.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/buttons.flash.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/buttons.print.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/buttons.html5.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/pdfmake-0.1.36/vfs_fonts.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/pdfmake-0.1.36/pdfmake.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/JSZip-2.5.0/jszip.min.js' />"></script>


<link rel="stylesheet" type="text/css"
	href="<c:url value='/js/egovframework/com/datatable/dataTables.min.css' />" />
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/datatable/datatables.min.js' />"></script>

<link rel="stylesheet"
	href="<c:url value='/js/egovframework/com/plugin/parsley/parsley.css' />" />
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/plugin/parsley/parsley.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/plugin/parsley/ko.js' />"></script>

<!--
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/uat/uia/login.css' />">
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery.js'/>" ></script>
-->
<script type="text/javascript">
			function checkLogin(userSe) {
			    // 일반회원
			    if (userSe == "GNR") {
			        document.loginForm.rdoSlctUsr[0].checked = true;
			        document.loginForm.rdoSlctUsr[1].checked = false;
			        document.loginForm.rdoSlctUsr[2].checked = false;
			        document.loginForm.userSe.value = "GNR";
			    // 기업회원
			    } else if (userSe == "ENT") {
			        document.loginForm.rdoSlctUsr[0].checked = false;
			        document.loginForm.rdoSlctUsr[1].checked = true;
			        document.loginForm.rdoSlctUsr[2].checked = false;
			        document.loginForm.userSe.value = "ENT";
			    // 업무사용자
			    } else if (userSe == "USR") {
			        document.loginForm.rdoSlctUsr[0].checked = false;
			        document.loginForm.rdoSlctUsr[1].checked = false;
			        document.loginForm.rdoSlctUsr[2].checked = true;
			        document.loginForm.userSe.value = "USR";
			    }
			}
			function actionLogin() {
				var g_mng_login_fail = '${g_mng_login_fail}';
				var g_mng_login_fail_time = '${g_mng_login_fail_time}';
				var iUsableFailCnt = '${iUsableFailCnt}';
				
				$('#loginForm').parsley().validate();
			    if (!$('#loginForm').parsley().isValid()) {
			    	return;
			    }
		        
		        var id = $("#id").val(); //text
				var password = $("#password").val();
		        var userSe = $("#userSe").val();
				
				var obj = {
		            	"id": id,
		            	"password": password,
		            	"userSe": userSe
				};
				
		     	$.ajax({
		        	url: "<c:url value='/uat/uia/actionLogin.do' />",
		        	type: "POST",
		            data: obj,
		            dataType: "json",
		            beforeSend:function(){
		                $('.wrap-loading').removeClass('display-none');
		        		$('#loginBtn').attr('disabled', false);
		            },
					complete:function(){
		                $('.wrap-loading').addClass('display-none');
		        		$('#loginBtn').attr('disabled', false);
		            },
		        	success: function(jsondata){  
	                  if(jsondata["data"]==1){
			        		sessionStorage.setItem ( "uSTel", jsondata["uSTel"]);
			        		sessionStorage.setItem ( "uSMobile", jsondata["uSMobile"]);
			        		
			        		if(jsondata["datas"] == 'Y'){
			        			location.href="<spring:message code='g_usr_uri' javaScriptEscape='true' ></spring:message>";
			        		}else{
			        			location.href="/mypage";
			        		}
			        		
		        		}else if(jsondata["data"]==2){
							if(jsondata["datas"] == 'Y'){
			        			location.href="<spring:message code='g_mng_uri' javaScriptEscape='true' ></spring:message>";
			        		}else{
			        			location.href="/mng/mypage";
			        		}
		        		}else if(jsondata["data"]==3){
		        			var today = new Date();   
		        			var year = today.getFullYear(); // 년도
		        			var month = today.getMonth() + 1;  // 월
		        			var date = today.getDate();  // 날짜
		        			var hours = today.getHours(); // 시
		        			var minutes = today.getMinutes();  // 분
		        			var seconds = today.getSeconds();  // 초
		        			
		        			failtime = year + '/' + month + '/' + date + '/ '+ hours +':' +minutes;
		        			
		        			if(g_mng_login_fail=="Y"){
		        				var msg = "비밀번호를 "+jsondata["pwFailCount"]+" 회 틀렸습니다";
		        			}else{
		        				var msg = "아이디, 비밀번호를 확인해주세요.";
		        			}
		        			
		        			if(g_mng_login_fail_time=="Y"){
		        				var msg1 = "로그인 실패 시간 : "+failtime;
		        			}
		        			
		        			$("#loginfail").css('display','block');
		        			$("#loginfailtime").css('display','block');
		        			$('#loginfail').html(msg);
		        			$('#loginfailtime').html(msg1);
		        		}else if(jsondata["data"]==4){
		        			alert("승인되지 않은 회원입니다. 관리자에게 문의하십시요.");
		        		}else if(jsondata["data"]==6){
		        			alert("비밀번호가 초기화 되었습니다. 비밀번호 변경을 위해 정보수정 페이지로 이동합니다.");
		        			location.href="/mypage";
		        		}else if(jsondata["data"]==7){
		        			alert("비밀번호를 5회 틀리셨습니다.\n잠시후에 로그인 해주세요.");
		        		}else if(jsondata["data"]==8){
		        			alert("계정이 잠금상태입니다.\n잠시후에 로그인 해주세요.");
		        		}else if(jsondata["data"]==9){
		        		    alert("비밀번호가 초기화 되었습니다. 비밀번호 변경을 위해 정보수정 페이지로 이동합니다.");
		                    location.href="/mng/mypage";
		        		}else{
		        			if(iUsableFailCnt=="Y"){
		        				var msg = "비밀번호를 "+jsondata["pwFailCount"]+" 회 틀렸습니다";
		        			}else{
		        				var msg = "아이디, 비밀번호를 확인해주세요.";
		        			}
		        			$("#loginfail").css('display','block');
		        			$('#loginfail').html(msg);
		        		}
		        	},
		        	error: function(request,status,error){
		        		alert("아이디, 비밀번호를 확인해주세요.")
		        		$('#loginBtn').attr('disabled', false);
		        	}
		    	});
			}
			function actionCrtfctLogin() {
			    document.defaultForm.action="<c:url value='/uat/uia/actionCrtfctLogin.do'/>";
			    document.defaultForm.submit();
			}
			function goFindId() {
			    document.defaultForm.action="<c:url value='/uat/uia/egovIdPasswordSearch.do'/>";
			    document.defaultForm.submit();
			}
			function goRegiUsr() {
				
				var useMemberManage = '${useMemberManage}';
				if(useMemberManage != 'true'){
					<%-- 사용자 관리 컴포넌트가 설치되어 있지 않습니다. \n관리자에게 문의하세요. --%>
					alert("<spring:message code="comUatUia.validate.userManagmentCheck" />");
					return false;
				}
			    var userSe = document.loginForm.userSe.value;
			 
			    // 일반회원
			    if (userSe == "GNR") {
			        document.loginForm.action="<c:url value='/uss/umt/EgovStplatCnfirmMber.do'/>";
			        document.loginForm.submit();
			    // 기업회원
			    } else if (userSe == "ENT") {
			        document.loginForm.action="<c:url value='/uss/umt/EgovStplatCnfirmEntrprs.do'/>";
			        document.loginForm.submit();
			    // 업무사용자
			    } else if (userSe == "USR") {
			    	<%-- 업무사용자는 별도의 회원가입이 필요하지 않습니다. --%>
			        alert("<spring:message code="comUatUia.validate.membershipCheck" />");
			    }
			}
			function goGpkiIssu() {
			    document.defaultForm.action="<c:url value='/uat/uia/egovGpkiIssu.do'/>";
			    document.defaultForm.submit();
			}
			function setCookie (name, value, expires) {
			    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
			}
			function getCookie(Name) {
			    var search = Name + "=";
			    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
			        offset = document.cookie.indexOf(search);
			        if (offset != -1) { // 쿠키가 존재하면
			            offset += search.length;
			            // set index of beginning of value
			            end = document.cookie.indexOf(";", offset);
			            // 쿠키 값의 마지막 위치 인덱스 번호 설정
			            if (end == -1)
			                end = document.cookie.length;
			            return unescape(document.cookie.substring(offset, end));
			        }
			    }
			    return "";
			}
			function saveid(form) {
			    var expdate = new Date();
			    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
			    if (form.checkId.checked){
			        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
			    }else{
			        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
			    }
			    setCookie("saveid", form.id.value, expdate);
			}
			function getid(form) {
			    form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
			}
			function lodingGetId(){
				var cookieId = getCookie("saveid");
				if(cookieId){
				var form =document.loginForm;
					form.id.value=cookieId;
					form.checkId.checked = true;
				}
			}
			function fnInit() { 
			    document.loginForm.userSe.value = "USR"; 
			    document.loginForm.password.value="rhdxhd12"; 
			    getid(document.loginForm);
			    
			    fnLoginTypeSelect("typeUsr");
			    
			    <c:if test="${not empty fn:trim(message) &&  message ne ''}">
			    alert("${message}");    
			    </c:if>
			    
			}
			function fnLoginTypeSelect(objName){
					document.getElementById("typeGnr").className = "";
					document.getElementById("typeEnt").className = "";
					document.getElementById("typeUsr").className = "";
					
					document.getElementById(objName).className = "on";
					
					if(objName == "typeGnr"){ //일반회원
						document.loginForm.userSe.value = "GNR";
					}else if(objName == "typeEnt"){	//기업회원
						 document.loginForm.userSe.value = "ENT";
					}else if(objName == "typeUsr"){	//업무사용자
						 document.loginForm.userSe.value = "USR";
					}
				
			}
			function fnShowLogin(stat) {
				if (stat < 1) {	//일반로그인
					$(".login_input").eq(0).show();
					$(".login_input").eq(1).hide();
				} else {		//공인인증서 로그인
					$(".login_input").eq(0).hide();
					$(".login_type").hide();
					$(".login_input").eq(1).show();
				}
			}
			
			$(document).ready(function(){
				lodingGetId();
				$('.bs-callout-info').toggleClass('hidden', true);
			    $('.bs-callout-warning').toggleClass('hidden', true);
				
				
				$('#pw-form').parsley().on('field:validated', function() {
				    var ok = $('.parsley-error').length === 0;
				    $('.bs-callout-info').toggleClass('hidden', !ok);
				    $('.bs-callout-warning').toggleClass('hidden', ok);
				  })
				  .on('form:submit', function() {
				    return false; // Don't submit form for this demo
				  });
			})
			
			function validateForm() {
				
			    $('#pw-form').parsley().validate();
			    if (!$('#pw-form').parsley().isValid()) {
			    	return;
			    }
				
				var emplyrNm = $("#user_name").val(); //text
				var moblphonNo = $("#user_phone").val();
				var obj = {
		            	"emplyrNm": emplyrNm,
		            	"moblphonNo": moblphonNo
				};
				
		     	$.ajax({
		        	url: "<c:url value='/searchPw.do' />",
		        	type: "POST",
		            data: obj,
		            dataType: "json",
		            beforeSend:function(){
		                $('.wrap-loading').removeClass('display-none');
		        		$('#searchPwBtn').attr('disabled', false);
		            },
					complete:function(){
		                $('.wrap-loading').addClass('display-none');
		        		$('#searchPwBtn').attr('disabled', false);
		            },
		        	success: function(jsondata){  
	                  if(jsondata["data"]==1){
		                   toastr.success('인증번호가 전송되었습니다'); 
			        		$('#searchPwBtn').attr('disabled', false);
	 		        		$("#pop_pw").hide();
			        		$("#pop_cer").show();
	                	  
	                  }else{
	                	  alert("일치하는 정보가 없습니다.");
	                  }
		        	},
		        	error: function(request,status,error){
		        		alert("일치하는 정보가 없습니다.")
		            	$('#result').text(jsondata);
		        		$('#searchPwBtn').attr('disabled', false);
		        	}
		    	});
			}
			
			function chackCerForm() {
				
			    $('#cer-form').parsley().validate();
			    if (!$('#cer-form').parsley().isValid()) {
			    	return;
			    }
				
				var cer = $("#cer").val(); //text
				var emplyrNm = $("#user_name").val(); //text
				var moblphonNo = $("#user_phone").val();
				
				var obj = {
		            	"cer": cer,
		            	"emplyrNm": emplyrNm,
		            	"moblphonNo": moblphonNo
				};
				
		     	$.ajax({
		        	url: "<c:url value='/chackCer.do' />",
		        	type: "POST",
		            data: obj,
		            dataType: "json",
		            beforeSend:function(){
		                $('.wrap-loading').removeClass('display-none');
		        		$('#chackCerBtn').attr('disabled', false);
		            },
					complete:function(){
		                $('.wrap-loading').addClass('display-none');
		        		$('#chackCerBtn').attr('disabled', false);
		            },
		        	success: function(jsondata){
	                  	if(jsondata["data"]==1){
		                   //로딩
			        		$('#chackCerBtn').attr('disabled', false);
	 		        		$("#pop_cer").hide();
			        		$("#pop_changPw").show();
	                	  
		                }else{
		                	  alert("인증번호를 틀렸습니다.");
		                }
		        	},
		        	error: function(request,status,error){
		        		
		        		alert("인증번호를 틀렸습니다.")
		            	$('#result').text(jsondata);
		        		$('#chackCerBtn').attr('disabled', false);
		        	}
		    	});
			}
			function updatePwform() {
				
			    $('#changPw-form').parsley().validate("second");
			    if (!$('#changPw-form').parsley().isValid()) {
			    	return;
			    }
				
				var changPw = $("#changPw").val(); //text
				var emplyrNm = $("#user_name").val(); //text
				var moblphonNo = $("#user_phone").val();
				
				var obj = {
		            	"changPw": changPw,
		            	"emplyrNm": emplyrNm,
		            	"moblphonNo": moblphonNo
				};
				
		     	$.ajax({
		        	url: "<c:url value='/updatePw.do' />",
		        	type: "POST",
		            data: obj,
		            dataType: "json",
		            beforeSend:function(){
		                $('.wrap-loading').removeClass('display-none');
		        		$('#updatePwBtn').attr('disabled', false);
		            },
					complete:function(){
		                $('.wrap-loading').addClass('display-none');
		        		$('#updatePwBtn').attr('disabled', false);
		            },
		        	success: function(jsondata){
		                  if(jsondata["data"]==1){
		                	  toastr.success('성공적으로 수정되었습니다'); 
				        		$('#updatePwBtn').attr('disabled', false);
				        		location.href="";
		                	  
		                  }
		        	},
		        	error: function(request,status,error){
		            	$('#result').text(jsondata);
		        		$('#updatePwBtn').attr('disabled', false);
		        	}
		    	});
			}
</script>
<script>
$(function(){
$(".notice_close").click(function(){
	$('.login-wrap').addClass('width-1080px');
	$('.notice_open').css('display','block');
	$(this).css('display','none');
	$(".notice-box").css('display','none');
	$('.login-wrap').removeClass('width-1080px');
});
$(".notice_open").click(function(){
	$('.notice_close').css('display','block');
	$(this).css('display','none');
	$(".notice-box").css('display','block');
	$('.login-wrap').addClass('width-1080px');
});
});

</script>
</head>
<body>
<div id="result"></div>
	<!-- javascript warning tag  -->
	<noscript class="noScriptTitle">
		<spring:message code="common.noScriptTitle.msg" />
	</noscript>
	<div class="wrap bg_login">
		<div
			class="login-wrap relative absolute position-center height-460px box-shadow <c:if test="${Notice_YN eq 'Y'}" > width-1080px	</c:if>">

			<!-- 로그인 입력폼-->
			<div
				class="float-left width-540px height-460px background-f7fafc border-box"
				style="padding: 82px 65px 0;">
				<form name="loginForm" id="loginForm"
					action="<c:url value='/uat/uia/actionLogin.do'/>" method="post">
					<input type="hidden" id="message" name="message"
						value="<c:out value='${message}'/>">
						<div style="position: relative">
							<img alt="아이디아이콘" src="/images/egovframework/com/usr/icon_id.png" class="icon_idd"/> 
							<input type="text"
							name="id" id="id" maxlength="16"
							placeholder="아이디를 입력해주세요.${title} ${inputTxt}"
							title="${title} ${inputTxt}"
							class="block padding-left-60 margin-bottom-30 border-box input-box-shadow"
							value="" /> 
						</div>
						<div style="position: relative">
							<img alt="비밀번호아이콘" src="/images/egovframework/com/usr/icon_pw.png" class="icon_pw"/> 	
							<input type="password" name="password" id="password"
							placeholder="비밀번호를 입력해주세요."
							class="block padding-left-60 margin-bottom-20 border-box input-box-shadow" />
						</div>	
						<p id="loginfail" style="color:red; display:none; margin-bottom: 5px;" ></p>
						<c:if test="${g_mng_login_fail_time eq 'Y'}" >
							<p id="loginfailtime" style="color:red; display:none; margin-bottom: 5px;" ></p>
						</c:if>
					<ul class="margin-top-10 margin-bottom-20">
						<li class="float-left">
							<div class="checkbox">
								<input type="checkbox" name="checkId" class="check2"
									onclick="javascript:saveid(document.loginForm);" id="checkId" />
								<label for="checkId"></label> <span
									class="font-13px margin-left-10">자동로그인</span>
							</div>
						</li>
						<c:if test="${g_pw_search eq 'Y'}" >	
						<li class="float-right"><a
							class="open_pop_pw height-30px line-height-30px inline-block font-13px hover-underline">비밀번호를
								잃어버리셨나요?</a></li>
								</c:if>
					</ul>
					<div class="padding-top-20 text-center">
						<a
							class="width-120px height-50px line-height-50px font-18px background-8bc5ff font-fff text-center"
							onclick="actionLogin();" id="loginBtn">로그인</a>
					</div>
					<c:if test="${dispMemberJoin eq 'Y'}" >	
					<div class="padding-top-30 text-center font-14px font-000">
						처음 이용해보시나요? <a href="/join.do"
							class="font-14px font-bold font-000 hover-underline">가입하기</a>
					</div>
					</c:if>
					<input id="userSe" name="userSe" type="hidden" value="USR" /> <input
						name="j_username" type="hidden" />
				</form>
			</div>

			<!-- 공지사항 -->
			<c:if test="${Notice_YN eq 'Y'}" >	
			<div
				class="notice-box float-left width-540px height-460px background-fff border-box"
				style="padding: 50px 65px 0;">
				<h2 class="font-20px margin-bottom-30">공지사항</h2>
				<div
					class="wdth-100 height-230px border-radius-5 border-eaeaea block; padding-30 border-box">
					<p class="font-14px">
						공지사항 제목이 들어갑니다.<span class="inline-block float-right font-8a95a6">2020.01.20</span>
					</p>
				</div>
				<div class="padding-top-30 text-right font-14px">
					<a class="font-14px hover-underline">더 보기</a>
				</div>
			</div>
			<a class="icon_notice notice_open"></a>
			<a class="icon_close notice_close"></a>
			</c:if>
		</div>
	</div>
	<div id="pop_pw" class="pop_wrap pop_pw width-430px">
			<div class="pop_tit">비밀번호 찾기</div>
			<form id="pw-form" data-parsley-validate="">
			<div class="width-100 padding-bottom-10 border-bottom-e9eced">
				<table class="width-100" cellpadding="0" cellspacing="0" border="0">
					<!-- <tr>
						<th class="width-100px font-000 font-16px text-left">사용자 ID</th>
						<td class="text-left"><input type="text" id="user_id" name="user_id"
							placeholder=""
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" required=""
							data-parsley-required="true" data-parsley-trigger="change" 
							data-parsley-length="[4, 16]" data-parsley-type="alphanum" /></td>
					</tr> -->
					<tr>
						<th class="width-100px font-000 font-16px text-left">이름</th>
						<td class="text-left"><input type="text" id="user_name"
							name="name" placeholder=""
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" required=""
							data-parsley-required="true" data-parsley-trigger="change"
							data-parsley-pattern="^[가-힣]+$" data-parsley-maxlength="5" /></td>
					</tr>
					<tr>
						<th class="font-000 font-16px text-left">전화번호</th>
						<td class="text-left"><input type="text" id="user_phone"
							name="phone" placeholder="- 제외 (예:01012345678)"
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" required=""
							data-parsley-required="true" data-parsley-trigger="change"
							data-parsley-type="digits" data-parsley-maxlength="11" /></td>
					</tr>
				</table>
			</div>
			</form>
			<!-- 버튼 -->
			<div class="pop_btn">
				<!-- <a class="open_pop_cer background-8bc5ff border-8bc5ff font-fff margin-right-20"
					id="addSenderKeyBtn">등록</a> -->
				<input type="submit" id="searchPwBtn"
					class="background-8bc5ff border-8bc5ff font-fff margin-right-20"
					onclick="validateForm()" value="등록"> <a
					class="pop_close background-fff border-6f6f6f font-6f6f6f">취소</a>
			</div>
	</div>

	<div id="pop_cer" class="pop_wrap pop_cer width-430px">
			<div class="pop_tit">인증번호 입력</div>
			<form id="cer-form" data-parsley-validate="">
			<div class="width-100 padding-bottom-10 border-bottom-e9eced">
				<table class="width-100" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th class="width-100px font-000 font-16px text-left">인증번호를
							입력해주세요.</th>
						<td class="text-left"><input type="text" name="cer" id="cer"
							placeholder="인증번호 6자리를 입력해주세요."
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" required=""
							data-parsley-required="true" data-parsley-trigger="change"
							data-parsley-type="digits" data-parsley-maxlength="6" /></td>
					</tr>
				</table>
			</div>
			</form>
			<!-- 버튼 -->
			<div class="pop_btn">
				<!-- <a class="background-8bc5ff border-8bc5ff font-fff margin-right-20"
				id="chackCerBtn">제출</a> -->
				<input type="submit" id="chackCerBtn"
					class="background-8bc5ff border-8bc5ff font-fff margin-right-20"
					onclick="chackCerForm()" value="등록"> <a
					class="pop_close background-fff border-6f6f6f font-6f6f6f">취소</a>
			</div>
	</div>
	
	<div id="pop_changPw" class="pop_wrap pop_changPw width-430px">
		<form id="changPw-form" data-parsley-validate="">
			<div class="pop_tit">비밀번호 변경</div>
			<div class="width-100 padding-bottom-10 border-bottom-e9eced">
				<table class="width-100" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th class="width-100px font-000 font-16px text-left">비밀번호 변경</th>
						<td class="text-left"><input type="password" name="changPw" id="changPw"
							placeholder="최소8자리, 영문자+숫자+특수문자 구성"
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" required=""
							data-parsley-required="true" data-parsley-trigger="change"
							data-parsley-pattern="^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{5,16}$" data-parsley-minlength="8" /></td>
					</tr>
					<tr>
						<th class="width-100px font-000 font-16px text-left">비밀번호 확인</th>
						<td class="text-left"><input type="password" name="changPw" id="changPw2"
							placeholder="비밀번호를 다시 입력해주세요."
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" required=""
							data-parsley-required="true" data-parsley-trigger="change"
							data-parsley-equalto="#changPw" /></td>
					</tr>
				</table>
			</div>
			<!-- 버튼 -->
			<div class="pop_btn">
				<!-- <a class="background-8bc5ff border-8bc5ff font-fff margin-right-20"
				id="updatePwBtn">제출</a> -->
				<input type="submit" id="updatePwBtn"
					class="background-8bc5ff border-8bc5ff font-fff margin-right-20"
					onclick="updatePwform()" value="변경"> <a
					class="pop_close background-fff border-6f6f6f font-6f6f6f">취소</a>
			</div>
		</form>
	</div>
	<div class="pop_bg"></div>
</body>
</html>