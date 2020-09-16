<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<spring:message code="dispMemberJoin" var="dispMemberJoin" /> 
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
		        document.loginForm.action="<c:url value='/uat/uia/actionLogin.do'/>";
		        document.loginForm.submit();
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
			    if (form.checkId.checked)
			        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
			    else
			        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
			    setCookie("saveid", form.id.value, expdate);
			}

			function getid(form) {
			    form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
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
				
			    $('#pw-form').parsley().validate("second");
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
				
			    $('#cer-form').parsley().validate("second");
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
		                	  
		                  }
		        	},
		        	error: function(request,status,error){
		            	$('#result').text(jsondata);
		        		$('#updatePwBtn').attr('disabled', false);
		        	}
		    	});
			}
</script>
</head>
<body>
<div id="result"></div>
	<!-- javascript warning tag  -->
	<noscript class="noScriptTitle">
		<spring:message code="common.noScriptTitle.msg" />
	</noscript>
	<div class="wrap bg_login">
		<ul
			class="login-wrap relative absolute position-center height-460px box-shadow">

			<!-- 로그인 입력폼-->
			<li
				class="float-left width-540px height-460px background-f7fafc border-box"
				style="padding: 82px 65px 0;">
				<form name="loginForm" id="loginForm"
					action="<c:url value='/uat/uia/actionLogin.do'/>" method="post">
					<input type="hidden" id="message" name="message"
						value="<c:out value='${message}'/>"> <input type="text"
						name="id" id="id" maxlength="10"
						placeholder="아이디를 입력해주세요.${title} ${inputTxt}"
						title="${title} ${inputTxt}"
						class="icon_id block padding-left-60 margin-bottom-30 border-box input-box-shadow"
						value="TEST1" /> <input type="text" name="password" id="password"
						placeholder="비밀번호를 입력해주세요."
						class="icon_pw block padding-left-60 margin-bottom-30 border-box input-box-shadow" />
					<ul class="margin-bottom-30">
						<li class="float-left">
							<div class="checkbox">
								<input type="checkbox" name="checkId" class="check2"
									onclick="javascript:saveid(document.loginForm);" id="checkId" />
								<label for="check_1"></label> <span
									class="font-13px margin-left-10">자동로그인</span>
							</div>
						</li>
						<li class="float-right"><a
							class="open_pop_pw height-30px line-height-30px inline-block font-13px hover-underline">비밀번호를
								잃어버리셨나요?</a></li>
					</ul>
					<div class="padding-top-20 text-center">
						<a
							class="width-120px height-50px line-height-50px font-18px background-8bc5ff font-fff text-center"
							onclick="actionLogin()">로그인U</a>
					</div>
					<c:if test="${dispMemberJoin eq 'Y'}" >	
					<div class="padding-top-30 text-center font-14px font-000">
						처음 이용해보시나요? <a href="/join.do"
							class="font-14px font-bold font-000 hover-underline">가입하기</a>
					</div>
					</c:if>
					<input name="userSe" type="hidden" value="USR" /> <input
						name="j_username" type="hidden" />
				</form>
			</li>

			<!-- 공지사항 -->
			<li
				class="notice-box float-left width-540px height-460px background-fff border-box"
				style="padding: 50px 65px 0;;display:none">
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
			</li>
			<a href="#" class="icon_notice" style="display: none;"></a>
			<a href="#" class="icon_close"></a>
		</ul>
	</div>
	<div id="pop_pw" class="pop_wrap pop_pw width-430px">
			<div class="pop_tit">비밀번호 찾기</div>
			<form id="pw-form" data-parsley-validate="">
			<div class="width-100 padding-bottom-10 border-bottom-e9eced">
				<table class="width-100" cellpadding="0" cellspacing="0" border="0">
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
				<input type="submit" id="chackCerBtn"
					class="background-8bc5ff border-8bc5ff font-fff margin-right-20"
					onclick="chackCerForm()" value="확인"> <a
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