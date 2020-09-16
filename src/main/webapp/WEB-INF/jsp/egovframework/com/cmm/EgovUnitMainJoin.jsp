<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="pageTitle"><spring:message code="comUssUmt.deptUserManage.title"/></c:set>
<!DOCTYPE html>
<html lang="ko">
<head>
<title><spring:message code="titleName" /></title><!-- 로그인 -->
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/bootstrap.min.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/bootstrap-datepicker.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/font.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/reset.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/custom.css' />">

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery-1.12.4.min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/bootstrap.min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/bootstrap-datepicker.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/custom.js'/>" ></script>


<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/ccm/zip/EgovZipPopup.js' />" ></script>
<script src="<c:url value='/js/egovframework/com/cmm/jquery.js' />"></script>
<script type="text/javaScript" language="javascript" defer="defer">
/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init(){

	//모달 셋팅
	fn_modal_setting();

}
/*********************************************************
 * 모달셋팅
 ******************************************************** */
function fn_modal_setting(){
	//버튼에 모달 연결
	$("#btnEmplyrId").egovModal( "egovModal" );
	
	//타이틀 설졍
	$("#egovModal").setEgovModalTitle("<spring:message code="comUssUmt.userManageRegistModal.title" />"); //아이디 중복 확인
	var content = "";
	content = content + "<div class='modal-alignL' style='margin:5px 0 0 0'>"+"<spring:message code="comUssUmt.userManageRegistModal.userIsId" /> :"+"</div>"; //사용할아이디
	content = content + "<div class='modal-alignL'>"+"<input type='text' id='checkIdModal' name='checkIdModal' value='' size='20' maxlength='20' />"+"</div>";	
	content += "<div style='clear:both;'></div>";
	content += "<div id='divModalResult' style='margin:10px 0 0 0'><spring:message code="comUssUmt.userManageRegistModal.initStatus" /></div>"; //결과 : 중복확인을 실행하십시오.
	//모달 body 설정
	$("#egovModal").setEgovModalBody(content);

	var footer = "";
	//footer += "<div class='modal-btn'><button class='btn_s2' id='btnModalOk' onclick='fn_id_checkOk()'>확인</button></div>";
	//footer += "<div class='modal-btn'><button class='btn_s2' id='btnModalSelect' onclick='fn_id_check()'>조회</button></div>";
	footer += "<span class='btn_style1 blue' id='btnModalOk' onclick='fn_id_checkOk()'><a href='#'>확인</a></span>&nbsp;";
	footer += "<span class='btn_style1 blue' id='btnModalSelect' onclick='fn_id_check()'><a href='#'>조회</a></span>&nbsp;";
	//모달 footer 설정
	$("#egovModal").setEgovModalfooter(footer);
	
	//엔터이벤트처리
	$("input[name=checkIdModal]").keydown(function (key) {
		if(key.keyCode == 13){
			fn_id_check();	
		}
	});
	
	footer = null;
	content = null;
}
/*********************************************************
 * 아이디 체크 AJAX
 ******************************************************** */
function fn_id_check(){	
	$.ajax({
		type:"POST",
		url:"<c:url value='/uss/umt/EgovIdDplctCnfirmAjax.do' />",
		data:{
			"checkId": $("#checkIdModal").val()			
		},
		dataType:'json',
		timeout:(1000*30),
		success:function(returnData, status){
			if(status == "success") {
				if(returnData.usedCnt > 0 ){
					//사용할수 없는 아이디입니다.
					$("#divModalResult").html("<font color='red'><spring:message code="comUssUmt.userManageRegistModal.result" /> : ["+returnData.checkId+"]<spring:message code="comUssUmt.userManageRegistModal.useMsg" /></font>");
				}else{
					//사용가능한 아이디입니다.
					$("#divModalResult").html("<font color='blue'><spring:message code="comUssUmt.userManageRegistModal.result" /> : ["+returnData.checkId+"]<spring:message code="comUssUmt.userManageRegistModal.notUseMsg" /></font>");
				}
			}else{ alert("ERROR!");return;} 
		}
		});
}

/*********************************************************
 * 아이디 체크 확인
 ******************************************************** */
function fn_id_checkOk(){
	$.ajax({
		type:"POST",
		url:"<c:url value='/uss/umt/EgovIdDplctCnfirmAjax.do' />",
		data:{
			"checkId": $("#checkIdModal").val()			
		},
		dataType:'json',
		timeout:(1000*30),
		success:function(returnData, status){
			if(status == "success") {
				if(returnData.usedCnt > 0 ){
					alert("<spring:message code="comUssUmt.userManageRegistModal.noIdMsg" />"); //사용이 불가능한 아이디 입니다.
					return;
				}else{
					
					$("input[name=emplyrId]").val(returnData.checkId);
					$("#egovModal").setEgovModalClose();
				}
			}else{ alert("ERROR!");return;} 
		}
		});
}

function fnIdCheck1(){
    var retVal;
    var url = "<c:url value='/uss/umt/EgovIdDplctCnfirmView.do'/>";
    var varParam = new Object();
    varParam.checkId = document.userManageVO.emplyrId.value;
    var openParam = "dialogWidth:303px;dialogHeight:250px;scroll:no;status:no;center:yes;resizable:yes;";
    retVal = window.showModalDialog(url, varParam, openParam);
    if(retVal) {
        document.userManageVO.emplyrId.value = retVal;
    }
}

function showModalDialogCallback(retVal) {
	if(retVal) {
	    document.userManageVO.emplyrId.value = retVal;
	}
}

function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/EgovUserManage.do'/>";
    document.userManageVO.submit();
}

function fnInsert(form){
	if(confirm("<spring:message code="common.regist.msg" />")){
	    if(validateUserManageVO(form)){
	    	if(form.password.value != form.password2.value){
	            alert("<spring:message code="fail.user.passwordUpdate2" />");
	            return false;
	        }
	    	form.submit();
	        return true;
	    }
	}
}

function fn_egov_inqire_cert() {
	var url = "<c:url value='/uat/uia/EgovGpkiRegist.do' />";
	var popupwidth = '500';
	var popupheight = '400';
	var title = '인증서';

	Top = (window.screen.height - popupheight) / 3;
	Left = (window.screen.width - popupwidth) / 2;
	if (Top < 0) Top = 0;
	if (Left < 0) Left = 0;
	Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no,	scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
	PopUpWindow = window.open(url, title, Future)
	PopUpWindow.focus();
}

function fn_egov_dn_info_setting(dn) {
	var frm = document.userManageVO;

	frm.subDn.value = dn;
}

/*
if (typeof(opener.fn_egov_dn_info_setting) == 'undefined') {
	alert('메인 화면이 변경되거나 없습니다');
	this.close();
} else {
	opener.fn_egov_dn_info_setting(dn);
	this.close();
}
*/

</script>
<style>
.modal-content {width: 400px;}
</style>

</head>
<body onload="fn_egov_init()">

<c:import url="/uss/umt/EgovUserInsert.do" />


</body>
</html>
