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
</head>
<body>

	<script type="text/javascript" language="javascript" defer="defer"> 

/* 파슬리추가 */
$(document).ready(function(){ 

    $('.bs-callout-info').toggleClass('hidden', true);
    $('.bs-callout-warning').toggleClass('hidden', true);
	$('#newpassword').attr('data-parsley-pattern', pwset[${pwSet.pwdPattern}]);
   
});

function validateForm() {
	
	$('#myPageUpdate-form').parsley().validate();
    if (!$('#myPageUpdate-form').parsley().isValid()) {
    	return;
    }
	var user_id = $("#user_id").val(); //
	var user_pw = $("#password").val(); //text
	var newPw = $("#newpassword").val();
	var user_name = $("#user_name").val(); //text
	var position_id = $("#position_id").val(); //text
	var cellphone = $("#cellphone1 option:selected").val()+$("#cellphone2").val()+$("#cellphone3").val(); //text
	var phone = $("#phone1").val()+$("#phone2").val()+$("#phone3").val();
	
	var obj = {
			"emplyrId": user_id,
           	"password": user_pw,
           	"newPw": newPw,
           	"emplyrNm": user_name,
           	"ofcpsNm": position_id,
           	"moblphonNo": cellphone,
           	"offmTelno": phone
	};
	
   	$.ajax({
       	url: "<c:url value='/usr/updateUser.do' />",
       	type: "POST",
           data: obj,
           dataType: "json",
           beforeSend:function(){
               $('.wrap-loading').removeClass('display-none');
       		$('#newstaffbtn').attr('disabled', false);
           },
		complete:function(){
               $('.wrap-loading').addClass('display-none');
       		$('#newstaffbtn').attr('disabled', false);
        },
       	success: function(jsondata){  
            if(jsondata["data"]==0){
                toastr.success("성공적으로 수정 되었습니다.");
                $('#newstaffbtn').attr('disabled', false);
           		location.href  ="/mypage"
          	  
            }else if(jsondata["data"]==2){
          	  alert("현재 패스워드가 틀렸습니다.");
            }else{
          	  alert("양식을 다시 확인하길 바랍니다.");
            }
       	},
       	error: function(request,status,error){
       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
           	$('#result').text(jsondata);
       		$('#newstaffbtn').attr('disabled', false);
       	}
   	});
}
</script>
	<!--contents-->
	<div class="con-inner">
		<!--타이틀-->
		<h1 class="con-title">
			<ul>
				<li>마이페이지</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>마이페이지</li>
			</ul>
		</h1>
		<div id="result"></div>
		<!-- 입력폼-->
		<form id="myPageUpdate-form" data-parsley-validate="">
			<div
				class="margin-auto margin-top-30 margin-bottom-100 width-730px  padding-rl-65 padding-tb-25 background-f7fafc border-box box-shadow">
				<table class="width-100">
					<tr>
						<th class="width-125px">아이디</th>
						<td><input type="text" name="" id="user_id"
							placeholder="아이디를 입력해주세요." value="${ EmplurId }"
							class="width-260px padding-left-20 border-box margin-right-10"
							readonly /></td>
					</tr>
					<tr>
						<th>현재 패스워드</th>
						<td><input type="password" name="" id="password"
							placeholder="비밀번호를 입력해주세요."
							data-parsley-required="true" class="width-260px padding-left-20 border-box margin-right-10"
							/></td>
					</tr>
					<tr>
						<th>새 패스워드</th>
						<td><input type="password" name="" id="newpassword"
							placeholder="비밀번호를 입력해주세요."
							class="width-260px padding-left-20 border-box margin-right-10" /><span
							class="font-12px inline-block">(영문, 숫자, 특수문자 조합 8~16자)</span></td>
					</tr>
					<tr>
						<th>새 패스워드 확인</th>
						<td><input type="password" name="" id="newpassword2"
							placeholder="비밀번호를 다시 입력해주세요."
							class="width-260px padding-left-20 border-box" /></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" id="user_name" name="user_name"
							placeholder="이름을 입력해주세요." value="${ EmplyrNm }"
							class="width-260px padding-left-20 border-box" readonly /></td>
					</tr>
					<tr>
						<th>직위(급)</th>
						<td><input type="text" id="position_id"
							data-parsley-pattern="^[가-힣]+$" required=""
							data-parsley-required="true" data-parsley-trigger="change"
							name="ofcpsNm" placeholder="직위 혹은 직급을 입력해주세요."
							value="${ OfcpsNm }"
							class="width-260px padding-left-20 border-box" /></td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td><select title="" id="cellphone1" name="cellphone1"
							value="${ cellphone1 }"
							class="select_white width-90px inline-block " required=""
							data-parsley-required="true" data-parsley-trigger="change">
								<option value=""></option>
								<option value="010" <c:if test="${cellphone1 eq '010'}">selected</c:if>>010</option>
								<option value="011" <c:if test="${cellphone1 eq '011'}">selected</c:if>>011</option>
								<option value="016" <c:if test="${cellphone1 eq '016'}">selected</c:if>>016</option>
						</select> <input type="text" id="cellphone2" name="cellphone2"
							placeholder="" value="${ cellphone2 }"
							class="inline-block width-90px padding-left-20 border-box margin-left-10 margin-right-10"
							data-parsley-type="digits" data-parsley-maxlength="4" required=""
							data-parsley-required="true" data-parsley-trigger="change" /> <input
							type="text" id="cellphone3" name="cellphone3" placeholder=""
							value="${ cellphone3 }"
							class="inline-block width-90px padding-left-20 border-box"
							data-parsley-type="digits" data-parsley-maxlength="4" required=""
							data-parsley-required="true" data-parsley-trigger="change" /></td>
					</tr>
					<tr>
						<th>일반전화</th>
						<td><select title="" id="phone1" name="phone1"
							class="select_white width-90px inline-block "
							data-parsley-trigger="change">
								<option value=""></option>
								<option value="02" <c:if test="${phone1 eq '02'}">selected</c:if>>02</option>
								<option value="031"<c:if test="${phone1 eq '031'}">selected</c:if>>031</option>
								<option value="051"<c:if test="${phone1 eq '051'}">selected</c:if>>051</option>
						</select> <input type="text" id="phone2" name="phone2" value="${ phone2 }"
							placeholder=""
							class="inline-block width-90px padding-left-20 border-box margin-right-10"
							data-parsley-type="digits" data-parsley-maxlength="4"
							data-parsley-trigger="change" /> <input type="text" id="phone3"
							name="phone3" value="${ phone3 }" placeholder=""
							class="inline-block width-90px padding-left-20 border-box"
							data-parsley-type="digits" data-parsley-maxlength="4"
							data-parsley-trigger="change" /></td>
					</tr>
				</table>

				<!--버튼-->
				<div class="btn-center">
					<input class="background-8bc5ff font-fff" onclick="validateForm()"
						type="button" id="upBtn" value="저장"></input> <a
						class="background-efefef font-6f6f6f">취소</a>
				</div>
			</div>
		</form>
	</div>
	</div>

</body>
</html>