<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <spring:message code="g_sPasswordPattern" var="g_sPasswordPattern" /> --%>
<spring:message code="g_hangulidFlag" var="g_hangulidFlag"/>
<spring:message code="defaultGroup" var="defaultGroup"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title><spring:message code="titleName"/></title><meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<link rel="stylesheet" href="<c:url value='/css/egovframework/com/bootstrap.min.css' />" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/bootstrap-datepicker.css' />">
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/font.css' />" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/reset.css' />" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/custom.css' />" />
<script src="<c:url value='/js/egovframework/com/jquery.min.js' />"></script>
<script src="<c:url value='/js/egovframework/com/bootstrap.min.js' />"></script>
<script src="<c:url value='/js/egovframework/com/jquery-3.2.1.js' />"></script>
<script src="<c:url value='/js/egovframework/com/bootstrap-datepicker.js' />"></script>
<script src="<c:url value='/js/egovframework/com/custom.js' />"></script>

<!-- message toast -->
<script src="<c:url value='/js/egovframework/com/cmm/jquery.js' />"></script> 
<script src="<c:url value='/js/egovframework/com/toastr.min.js' />"></script> 
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/toastr.css' />">

<link rel="stylesheet" type="text/css" href="<c:url value='/js/egovframework/com/datatable/DataTables-1.10.20/css/jquery.dataTables.min.css' />"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/css/buttons.dataTables.min.css' />"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/egovframework/com/datatable/Select-1.3.1/css/select.dataTables.min.css' />"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/egovframework/com/datatable/Editor-1.9.2/css/editor.dataTables.min.css' />"/>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/jquery-3.2.1.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/DataTables-1.10.20/js/jquery.dataTables.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/dataTables.buttons.min.js' />"></script> 
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Select-1.3.1/js/dataTables.select.min.js' />"></script> 
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Editor-1.9.2/js/dataTables.editor.min.js' />"></script> 
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/buttons.flash.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/buttons.print.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/buttons.html5.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/pdfmake-0.1.36/vfs_fonts.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/pdfmake-0.1.36/pdfmake.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/JSZip-2.5.0/jszip.min.js' />"></script>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/xlsx.full.min.js' />"></script> 
<script type="text/javascript" src="<c:url value='/js/egovframework/com/filesaver.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/excelupdown.js' />"></script>

<script src="https://cdn.jsdelivr.net/alasql/0.3/alasql.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.7.12/xlsx.core.min.js"></script>
<script src="/js/egovframework/com/common.js"></script>
<link href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=PT+Serif:400,700&amp;display=swap" rel="stylesheet" type="text/css">

<script src="/js/egovframework/com/commonAjax.js"></script>
<script src="/js/egovframework/com/bootstrap/bootstrap.bundle.js"></script>
<script src="/js/egovframework/com/bootstrap/bootstrap.min.js"></script> 
<script src="https://www.jsviews.com/download/jsrender.js"></script>

<link rel="stylesheet" href="<c:url value='/js/egovframework/com/jstree/dist/themes/default/style.min.css' />" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/jstree/dist/jstree.min.js' />"></script>

<link rel="stylesheet" href="<c:url value='/js/egovframework/com/plugin/parsley/parsley.css' />" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/parsley/parsley.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/parsley/ko.js' />"></script>


<script type="text/javaScript" language="javascript" defer="defer">
var idCheck = 0;

$(document).ready(function(){

	$('#user_pw').attr('data-parsley-pattern', pwset[${pwSet.pwdPattern}]);
	$('.bs-callout-info').toggleClass('hidden', true);
    $('.bs-callout-warning').toggleClass('hidden', true);
    
    $('#demo-form').parsley().on('field:validated', function() {
	    var ok = $('.parsley-error').length === 0;
	    $('.bs-callout-info').toggleClass('hidden', !ok);
	    $('.bs-callout-warning').toggleClass('hidden', ok);
	  })
	  .on('form:submit', function() {
	    return false; // Don't submit form for this demo
	  });
    $(document).on("input", "#user_id",function(){
    	idCheck = 0;
    })
})
	 
	 function id_check() {
			var checkId = $("#user_id").val(); //text
			var obj = {
	            	"checkId": checkId
			};
	     	$.ajax({
	        	url: "<c:url value='/uss/umt/EgovIdDplctCnfirmAjax.do' />",
	        	type: "POST",
	            data: obj,
	            dataType: "json",
	            beforeSend:function(){
	                $('.wrap-loading').removeClass('display-none');
	        		$('#idCheckBtn').attr('disabled', false);
	            },
				complete:function(){
	                $('.wrap-loading').addClass('display-none');
	        		$('#idCheckBtn').attr('disabled', false);
	            },
	        	success: function(jsondata){  
	               if(jsondata["data"]==0){
		                   //로딩
		                   toastr.success('사용 가능한 아이디입니다.'); 
		                   idCheck = 1;
			        		$('#idCheckBtn').attr('disabled', false);
	               }else{
	             	  toastr.error("중복되는 아이디가 있습니다.");
	               }
	        	},
	        	error: function(request,status,error){
	        		alert("일치하는 정보가 없습니다.");
	        	}
	    	});
		}
	 
	 function validateForm() {
		    $('#demo-form').parsley().validate();
		    if (!$('#demo-form').parsley().isValid()) {
		    	return;
		    }
		    
		    if(idCheck<=0){
		    	alert("아이디 중복체크를 해주세요.");
		    	return;
		    }
		    
			var emplyrId = $("#user_id").val(); //text
			var password = $("#user_pw").val();
			var emplyrNm = $("#user_name").val();
			var ofcpsNm = $("#position_id").val();
			var orgnztId = $("#part_id").val();
			var moblphonNo = $("#cellphone1").val()+""+$("#cellphone2").val()+""+$("#cellphone3").val();
			var offmTelno = $("#phone1").val()+""+$("#phone2").val()+""+$("#phone3").val();
			var memo = $("#memo").val();
			
			
			var obj = {
	            	"emplyrId": emplyrId,
	            	"password": password,
	            	"emplyrNm": emplyrNm,
	            	"ofcpsNm": ofcpsNm,
	            	"orgnztId": orgnztId,
	            	"moblphonNo": moblphonNo,
	            	"offmTelno": offmTelno,
	            	"memo": memo
			};
			
	     	$.ajax({
	        	url: "<c:url value='/uss/umt/EgovUserInsert.do' />",
	        	type: "POST",
	            data: obj,
	            dataType: "json",
	            beforeSend:function(){
	                $('.wrap-loading').removeClass('display-none');
	        		$('#joinBtn').attr('disabled', false);
	            },
				complete:function(){
	                $('.wrap-loading').addClass('display-none');
	        		$('#joinBtn').attr('disabled', false);
	            },
	        	success: function(jsondata){  
	        	   
	               console.log(jsondata["data"]);
	               
	               if(jsondata["data"]==1){
	                   var defaultGroup = "${defaultGroup}";
	                   if(defaultGroup == 'Y'){
	                	   var param = {
	                			   "title":"기본그룹",
	                			   "parent":"0",
	                			   "sequence":"0",
	                			   "depth":"1",
	                			   "type":"0",
	                			   "userid":emplyrId
	                			   
	                	   }
	                	   $.ajax({
	                		    type : "POST",
		           	        	url: "<c:url value='/grp/AddrGroupInserts.do'/>",
		           	     		data : param,
		           	     		dataType: "json",
		           	        	success: function(jsondata){  
		           	        		console.log(jsondata)
		           	        		if(parseInt(jsondata)>0){
			           	        	    alert("회원가입이 정상적으로 처리되었습니다.");
			           	        		location.href  ="/"
		           	        		}else{
		           	        			alert("기본그룹 생성중 오류가 발생하였습니다.")
		           	        		}
		           	        	},error: function(request,status,error){
		        	        		console.log(status)
		        	        		console.log(error)
		        	        	}
		           	    	});
	                   }else{
	                	   alert("회원가입이 정상적으로 처리되었습니다.");
	                	   location.href  ="/"
	                   }
		        		$('#joinBtn').attr('disabled', false);
	               }else{
	             	  toastr.error("양식을 다시 확인하길 바랍니다.");
	               }
	        	},
	        	error: function(request,status,error){
	        		alert("에러가 발생하였습니다.")
	            	$('#result').text(jsondata);
	        		$('#joinBtn').attr('disabled', false);
	        	}
	    	});
		}
</script>
<style>
.modal-content {
	width: 400px;
}
</style>
</head>
<body>

	<div class="wrap">

		<!--contents-->
		<div class="con-inner">
			<!--타이틀-->
			<div class="con-title_2">회원가입</div>


			<!-- 입력폼-->
			<div
				class="margin-auto margin-top-30 margin-bottom-100 width-730px  padding-rl-65 padding-tb-40 background-f7fafc border-box box-shadow">
				<form id="demo-form" data-parsley-validate="">
					<table class="width-100 margin-bottom-40">
						<tr>
							<th class="width-125px">아이디</th>
							<td class="relative"><input type="text" id="user_id" name="user_id"
								required="" placeholder="아이디를 입력해주세요."
								class="width-260px padding-left-20 border-box margin-right-10"
								<c:if test="${g_hangulidFlag eq 'N' }">
								data-parsley-type="alphanum"
								</c:if>
								data-parsley-length="[4, 16]"
								data-parsley-required="true" data-parsley-trigger="change" />
								<div style="position: absolute; top: 5px; left: 270px">
									<a onclick="id_check();"
									class="width-80px height-50px line-height-50px font-15px border-radius-5 background-8bc5ff font-fff text-center margin-right-10">중복확인</a>
									<span style="font-size: 12px">(4자 이상 16자 이하)</span>
								</div>
							</td>
						</tr>
						<tr>
							<th>패스워드</th>
							<td><input type="password" name="user_pw" id="user_pw"
								required="" placeholder="비밀번호를 입력해주세요."
								class="width-260px padding-left-20 border-box margin-right-10" data-parsley-pattern=""
								data-parsley-required="true" data-parsley-trigger="change" /></td>
						</tr>
						<tr>
							<th>패스워드 확인</th>
							<td><input type="password" name="user_pw_ch" id="user_pw_ch"
								required="" placeholder="비밀번호를 입력해주세요."
								class="width-260px padding-left-20 border-box margin-right-10" data-parsley-equalto="#user_pw"
								data-parsley-required="true" data-parsley-trigger="change" /></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" id="user_name" name="user_name"
								required="" placeholder="이름을 입력해주세요."
								class="width-260px padding-left-20 border-box" data-parsley-pattern="^[가-힣]+$" data-parsley-maxlength="5"
								data-parsley-required="true" data-parsley-trigger="change" /></td>
						</tr>
						<tr>
							<th>직위(급)</th>
							<td><input type="text" id="position_id" name="position_id"
								required="" placeholder="직급을 입력해주세요."
								class="width-260px padding-left-20 border-box" data-parsley-pattern="^[가-힣]+$"
								data-parsley-required="true" data-parsley-trigger="change" /></td>
						</tr>
						<tr>
							<th>부서명</th>
							<td><select title="part_id" id="part_id" name="part_id"
								required="" class="select_white width-260px">
								<option value="" disabled selected hidden>부서를 선택해주세요.</option>
									<c:forEach var="part_id" items="${partIdList}"
										varStatus="status">
										<option value="${part_id.orgnztId}"
											${part_id.orgnztId == provider ? 'selected="selected"' : '' }>${part_id.orgnztNm}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td><select title="" id="cellphone1"
								class="select_white width-90px inline-block ">
									<option>010</option>
							</select> <input type="text" id="cellphone2" name="cellphone2" required="" data-parsley-type="digits" data-parsley-maxlength="4"
								placeholder="1234" data-parsley-trigger="change"
								class="inline-block width-90px padding-left-20 border-box margin-left-10 margin-right-10" />
								<input type="text" id="cellphone3" name="cellphone3" required="" data-parsley-type="digits" data-parsley-maxlength="4"
								placeholder="1234" data-parsley-trigger="change"
								class="inline-block width-90px padding-left-20 border-box" /></td>
						</tr>
						<tr>
							<th>일반전화</th>
							<td><input type="text" id="phone1" name="phone1"
								placeholder="" data-parsley-type="digits" data-parsley-maxlength="4" data-parsley-trigger="change"
								class="inline-block width-90px padding-left-20 border-box margin-right-10" />
								<input type="text" id="phone2" name="phone2" placeholder="" data-parsley-type="digits" data-parsley-maxlength="4" data-parsley-trigger="change"
								class="inline-block width-90px padding-left-20 border-box margin-right-10" />
								<input type="text" id="phone3" name="phone3" placeholder="" data-parsley-type="digits" data-parsley-maxlength="4" data-parsley-trigger="change"
								class="inline-block width-90px padding-left-20 border-box" /></td>
						</tr>
						<tr>
							<th>메모</th>
							<td><input type="text" id="memo" name="memo" placeholder="" data-parsley-maxlength="200"
								value="" class="width-300px padding-left-20 border-box" /></td>
						</tr>
					</table>
					</form>
					<div class="btn-center">
						<input id="joinBtn" type="submit" onClick="validateForm();" class="background-053c72 font-fff" value="등록">
						<a href="/" class="background-8bc5ff font-fff">이전 페이지</a>
					</div>
			</div>
		</div>
	</div>
</body>
</html>
