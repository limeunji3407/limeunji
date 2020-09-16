<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>iGOV SMS SYSTEM</title>
<script type="text/javaScript" language="javascript" defer="defer"> 
$(document).ready(function() {
	
	$('#demo-form').parsley().on('field:validated', function() {
	    var ok = $('.parsley-error').length === 0;
	    $('.bs-callout-info').toggleClass('hidden', !ok);
	    $('.bs-callout-warning').toggleClass('hidden', ok);
	  })
	  .on('form:submit', function() {
	    return false; // Don't submit form for this demo
	  });
	
	pwd_Pattern = $("#pwdPattern option:selected").val();
	$('#pwdFirst').attr('data-parsley-pattern', pwset[pwd_Pattern]);
	
	$('#pwdPattern').on('change', function(){ 
		pwd_Pattern = $("#pwdPattern option:selected").val();
		$('#pwdFirst').attr('data-parsley-pattern', pwset[pwd_Pattern]);
	});
	
	/* JSON.stringify(form), */
	$('#pwdConfBtn').on('click', function(){ 
		
		$('#demo-form').parsley().validate();
	    if (!$('#demo-form').parsley().isValid()) {
	    	return;
	    }
		
		$('#pwdConfBtn').attr('disabled', true);
		var pwdCycle = $("#pwdCycle").val();
		var pwdPattern = $("#pwdPattern option:selected").val();
		var pwdFirst = $("#pwdFirst").val();
		var denycheck; 
		
		if($("input:checkbox[name=denycheck]").is(":checked") == true) {
			denycheck = "Y";
		}else{
			denycheck = "N";
		}
	 	
		var obj = {
				"pwdCycle" : pwdCycle,
				"pwdPattern" : pwdPattern,
				"pwdFirst" : pwdFirst,
				"dentcheck" : denycheck
		};
     	$.ajax({
           	url: "<c:url value='/mng/updatePwSet.do' />",
           	type: "POST",
            data: obj,
            dataType: "json",
           	success: function(jsondata){  
                if(jsondata["data"]==0){
                    toastr.success("성공적으로 변경 되었습니다.");
                }else{
              	  alert("양식을 다시 확인하길 바랍니다.");
                }
           	},
           	error: function(request,status,error){
           		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
           	}
       	});
	});
});
</script>
</head>
<body>


	<input type="radio" name="standard_tabmenu2" id="tabmenu-3">
	<label for="tabmenu-3">패스워드설정</label>
	<div class="tabCon">
		<div class="width-100 padding-top-60 margin-bottom-100">
			<div
				class="width-100  padding-rl-20 padding-tb-40 background-f7fafc border-radius-bottom-5 border-box box-shadow">
				<div class="padding-rl-100 border-box">
					<form id="demo-form" data-parsley-validate="">
						<table class="width-100 margin-top-20" border="0">
							<colgroup>
								<col style="width: 200px" />
								<col style="" />
							</colgroup>
							<tr>
								<th class="text-left">패스워드 변경주기</th>
								<td class="text-left"><input type="text" name="pwdCycle" id="pwdCycle"
									placeholder="" value="${pwSet.pwdCycle}"
									class="width-50px height-50px line-height-50px border-radius-5 background-fff border-box text-center margin-right-10" />개월</td>
							</tr>
							<tr>
								<th class="text-left">패스워드 패턴</th>
								<td class="text-left"><select title=""
									class="select_white width-330px" name="pwdPattern"
									id="pwdPattern">
										<option <c:if test="${pwSet.pwdPattern eq '0'}">selected</c:if> value="0">최소 8자리(영문자, 숫자, 특수문자 구성)</option>
										<option <c:if test="${pwSet.pwdPattern eq '1'}">selected</c:if> value="1">최소 9자리(영문자, 숫자, 특수문자 구성)</option>
										<option <c:if test="${pwSet.pwdPattern eq '2'}">selected</c:if> value="2">최소 10자리(영문자, 숫자 구성)</option>
										<option <c:if test="${pwSet.pwdPattern eq '3'}">selected</c:if> value="3">최소 10자리(영문자, 특수문자 구성)</option>
										<option <c:if test="${pwSet.pwdPattern eq '4'}">selected</c:if> value="4">최소 10자리(영문자, 숫자, 특수문자 구성)</option>
								</select></td>
							</tr>
							<tr>
								<th class="text-left">초기화 패스워드</th>
								<td class="text-left"><input type="text" name="pwdFirst" id="pwdFirst"
									placeholder="" value="${pwSet.pwdFirst}" required=""
									class="width-330px height-50px line-height-50px border-radius-5 background-fff border-box text-left margin-right-10 padding-left-20"
									data-parsley-pattern="" data-parsley-required="true"
									data-parsley-trigger="change" />패스워드 초기화시 설정되는 값 (8~16자)</td>
							</tr>
							<tr>
								<th class="text-left">패스워드 금지어</th>
								<td class="text-left height-60px line-height-60px">
									<div class="checkbox_big_blue" style="margin-right: 10px">
										<input type="checkbox" id="check_pw" name="denycheck"
											<c:if test="${pwSet.dentcheck eq 'Y'}">checked</c:if> />
										<label for="check_pw"></label>
									</div> 새 패스워드 금지어 체크
								</td>
							</tr>
						</table>
					</form>
					<!--버튼-->
					<div class="btn-center">
						<a class="background-053c72 font-fff" id="pwdConfBtn">변경</a> <a
							class="background-af0000 font-fff" id="pwdConfDelBtn">삭제</a>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
