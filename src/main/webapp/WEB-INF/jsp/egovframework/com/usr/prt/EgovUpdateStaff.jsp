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

$(document).ready(function(){ 
	
	console.log(${pwSet.pwdPattern});
	$('#user_pw').attr('data-parsley-pattern', pwset[${pwSet.pwdPattern}]);
	console.log(pwset[${pwSet.pwdPattern}]);

    $('.bs-callout-info').toggleClass('hidden', true);
    $('.bs-callout-warning').toggleClass('hidden', true);
	
	
	$('#demo-form').parsley().on('field:validated', function() {
	    var ok = $('.parsley-error').length === 0;
	   	/* alert(ok); */
	    $('.bs-callout-info').toggleClass('hidden', !ok);
	    $('.bs-callout-warning').toggleClass('hidden', ok);
	  })
	  .on('form:submit', function() {
	    return false; // Don't submit form for this demo
	  });
});	
function validateForm() {
	$('#demo-form').parsley().validate();
    if (!$('#demo-form').parsley().isValid()) {
    	return;
    }
	
	var user_id = $("#user_id").val(); //
	var user_name = $("#user_name").val(); //text
	var position_id = $("#position_id").val(); //text
	var cellphone = $("#cellphone1 option:selected").val()+$("#cellphone2").val()+$("#cellphone3").val(); //text
	var phone = $("#phone1 option:selected").val()+$("#phone2").val()+$("#phone3").val();
	var memo = $("#memo").val(); //text
	var status = $("#status option:selected").val(); //select
	var sms = $("#sms").val(); //text
	var lms = $("#lms").val(); //text
	var mms = $("#mms").val(); //text
	var alt = $("#alt").val(); //text
	var frt = $("#frt").val(); //text
	var sms_add = $("#sms_add").val(); //text
	var lms_add = $("#lms_add").val(); //text
	var mms_add = $("#mms_add").val(); //text
	var nms_add = $("#nms_add").val(); //text
	var fms_add = $("#fms_add").val(); //text
	var useStatus = $("input[name=use]:checked").val();
	
	//alert(reg_user_name);
	var obj = {
			"emplyrId": user_id,
           	"emplyrNm": user_name,
           	"ofcpsNm": position_id,
           	"moblphonNo": cellphone,
           	"offmTelno": phone,
           	"memo": memo,
           	"emplyrSttusCode": status,
           	"sms": sms,
           	"lms": lms,
           	"mms": mms,
           	"nms": alt,
           	"fms": frt,
           	"smsAdd": sms_add,
           	"lmsAdd": lms_add,
           	"mmsAdd": mms_add,
           	"nmsAdd": nms_add,
           	"fmsAdd": fms_add,
           	"useStatus": useStatus
	};
	console.log(obj);
	/* alert(JSON.stringify(obj)); */
   	$.ajax({
       	url: "<c:url value='/usr/UpdatePartUser.do' />",
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
     	   
            alert(jsondata["data"]);
            
            if(jsondata["data"]==0){
                //로딩
                toastr.success("성공적으로 부서원이 수정 되었습니다.");
                $('#newstaffbtn').attr('disabled', false);
           		//close popup
           		location.href  ="/usr/staff"
          	  
            }else{
          	  alert("양식을 다시 확인하길 바랍니다.");
            }
       	},
       	error: function(request,status,error){
       		  
       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
           	$('#result').text(jsondata);
           	//alert("serialize err");
       		$('#newstaffbtn').attr('disabled', false);
       	}
   	});
}

function id_check() {
	 
 	alert($("#user_id").val());
	
	var checkId = $("#user_id").val(); //text
	
	//alert(reg_user_name);
	var obj = {
        	"checkId": checkId
	};
	
	//alert(JSON.stringify(obj));
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
    	   
       alert(jsondata["data"]);
       
       if(jsondata["data"]==0){
               //로딩
               toastr.success('사용 가능한 아이디입니다.'); 
               idCheck = 1;
               /* $(".pop_templet").css('display','none'); */

        		$('#idCheckBtn').attr('disabled', false);
        		//close popup
       }else{
     	  //alert("중복되는 아이디가 있습니다.");
     	  toastr.error("중복되는 아이디가 있습니다.");
       }
    	},
    	error: function(request,status,error){
    		  
    		alert("일치하는 정보가 없습니다.");
    	}
	});
}

</script>
</head>
<body>

	<div class="wrap">

		<!--contents-->
		<div class="con-inner">
			<!--타이틀-->
			<h1 class="con-title">
				<ul>
					<li>부서원 관리</li>
					<li class="icon_home"></li>
					<li><span class="dot"></span>부서장기능</li>
					<li><span class="dot"></span>부서원관리</li>
				</ul>
			</h1>


			<!-- 입력폼-->
			<div
				class="margin-auto margin-top-30 margin-bottom-100 width-730px  padding-rl-65 padding-tb-40 background-f7fafc border-box box-shadow">
				<h3 class="form_tit">기본정보</h3>
				<form id="demo-form" data-parsley-validate="">
					<table class="width-100 margin-bottom-40">
						<tr>
							<th class="width-125px">아이디</th>
							<td><input type="text" id="user_id" name="user_id"
								required="" readonly="readonly" placeholder="아이디를 입력해주세요."
								value="${userInfo.emplyrId}"
								class="width-260px padding-left-20 border-box margin-right-10"
								data-parsley-required="true" data-parsley-trigger="change" /></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" id="user_name" name="user_name"
								required="" placeholder="이름을 입력해주세요."
								value="${userInfo.emplyrNm}"
								class="width-260px padding-left-20 border-box"
								data-parsley-required="true" data-parsley-trigger="change" /></td>
						</tr>
						<tr>
							<th>직위(급)</th>
							<td><input type="text" id="position_id" name="position_id"
								required="" placeholder="직급을 입력해주세요."
								value="${userInfo.ofcpsNm}"
								class="width-260px padding-left-20 border-box"
								data-parsley-required="true" data-parsley-trigger="change" /></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td><select title="" id="cellphone1"
								class="select_white width-90px inline-block ">
									<!-- <option selected value="${phonNo1}">${phonNo1}</option> -->
									<option <c:if test="${phonNo1 eq '010'}">selected</c:if>>010</option>
									<option <c:if test="${phonNo1 eq '011'}">selected</c:if>>011</option>
									<option <c:if test="${phonNo1 eq '016'}">selected</c:if>>016</option>
							</select> <input type="text" id="cellphone2" name="cellphone2" required=""
								placeholder="" value="${phonNo2 }"
								class="inline-block width-90px padding-left-20 border-box margin-left-10 margin-right-10" />
								<input type="text" id="cellphone3" name="cellphone3" required=""
								placeholder="" value="${phonNo3 }"
								class="inline-block width-90px padding-left-20 border-box" /></td>
						</tr>
						<tr>
							<th>일반전화</th>
							<td><select title="" id="phone1" name="phone1"
								class="select_white width-90px inline-block "
								data-parsley-trigger="change">
									<option value="">번호를 선택해주세요</option>
									<option <c:if test="${phone1 eq '02'}">selected</c:if>>02</option>
									<option <c:if test="${phone1 eq '031'}">selected</c:if>>031</option>
									<option <c:if test="${phone1 eq '051'}">selected</c:if>>051</option>
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
						<tr>
							<th>메모</th>
							<td><input type="text" id="memo" name="memo" placeholder=""
								value="${userInfo.memo}"
								class="width-300px padding-left-20 border-box" /></td>
						</tr>
						<tr>
							<th>상태</th>
							<td><select title="status" id="status" name="status"
								required="" class="select_white width-260px">
									<!-- <option selected value="${userInfo.emplyrSttusCode}">${status}</option> -->
									<option value="AAA"
										<c:if test="${userInfo.emplyrSttusCode eq 'AAA'}">selected</c:if>>근무</option>
									<option value="AAB"
										<c:if test="${userInfo.emplyrSttusCode eq 'AAB'}">selected</c:if>>근무(파견)</option>
									<option value="ABA"
										<c:if test="${userInfo.emplyrSttusCode eq 'ABA'}">selected</c:if>>휴직</option>
									<option value="DAB"
										<c:if test="${userInfo.emplyrSttusCode eq 'DAB'}">selected</c:if>>전출</option>
									<option value="DAA"
										<c:if test="${userInfo.emplyrSttusCode eq 'DAA'}">selected</c:if>>퇴직</option>
							</select></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td>
								<div class="relative width-100 height-60px">
									<div class="absolute position-vertical-center position-left">
										<div class="radio-box font-16px font-053c72 margin-right-20">
											<div class="radio">
												<input type="radio" id="a1" name="use" value="Y"
													<c:if test="${userInfo.useStatus eq 'Y'}">checked</c:if> />
												<label for="a1"><span></span></label>
											</div>
											사용
										</div>
										<div class="radio-box font-16px font-053c72 ">
											<div class="radio">
												<input type="radio" id="a2" name="use" value="N"
													<c:if test="${userInfo.useStatus eq 'N'}">checked</c:if> />
												<label for="a2"><span></span></label>
											</div>
											사용안함
										</div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>등록일시</th>
							<td><input type="text" name="" placeholder="" value="${userInfo.sbscrbDe }" readonly="readonly"
								class="width-260px padding-left-20 border-box" /></td>
						</tr>
					</table>

					<h3 class="form_tit">설정하기</h3>
					<table class="width-100 margin-bottom-10">
						<tr>
							<th class="width-125px">월 건수 한도</th>
							<td>
								<ul>
									<li class="float-left width-20 text-center padding-right-10">단문<br>
										<input type="text" id="sms" name="" placeholder=""
										value="${userInfo.sms}"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">장문<br>
										<input type="text" id="lms" name="" placeholder=""
										value="${userInfo.lms}"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">멀티<br>
										<input type="text" id="mms" name="" placeholder=""
										value="${userInfo.mms}"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">알람톡<br>
										<input type="text" id="alt" name="" placeholder=""
										value="${userInfo.nms}"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">친구톡<br>
										<input type="text" id="frt" name="" placeholder=""
										value="${userInfo.fms}"
										class="border-box text-center margin-top-5" /></li>
									<li
										class="float-left width-100 text-center  padding-right-10 margin-top-5">
										<div
											class="width-100 padding-tb-25 line-height-default font-normal border-radius-5 background-fff border-box text-center margin-top-5" />
										입력한 월 캐쉬 한도는 매월 1일 0시에
										REFRESH됩니다.
										</div>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th class="width-125px">임시 추가 한도</th>
							<td>
								<ul>
									<li class="float-left width-20 text-center padding-right-10">단문<br>
										<input type="text" id="sms_add" name="" placeholder=""
										value="${userInfo.smsAdd}"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">장문<br>
										<input type="text" id="lms_add" name="" placeholder=""
										value="${userInfo.lmsAdd}"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">멀티<br>
										<input type="text" id="mms_add" name="" placeholder=""
										value="${userInfo.mmsAdd}"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">알람톡<br>
										<input type="text" id="nms_add" name="" placeholder=""
										value="${userInfo.nmsAdd}"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center">친구톡<br> <input
										type="text" id="fms_add" name="" placeholder=""
										value="${userInfo.fmsAdd}"
										class="border-box text-center margin-top-5" /></li>
								</ul>
							</td>
						</tr>
						<tr>
							<th class="padding-bottom-30">비고</th>
							<td class="padding-bottom-40">
								<div
									class="width-100 padding-top-15 padding-bottom-15 line-height-default font-normal border-radius-5 background-fff border-box text-center margin-top-5" />
								비고가 들어갑니다.
								</div>
							</td>
						</tr>

						<tr>
							<th class="width-125px">사용한 캐시</th>
							<td>
								<ul>
									<li class="float-left width-20 text-center padding-right-10">단문<br>
										<input type="text" name="" placeholder="" value="0"
										readonly="readonly"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">장문<br>
										<input type="text" name="" placeholder="" value="0"
										readonly="readonly"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">멀티<br>
										<input type="text" name="" placeholder="" value="0"
										readonly="readonly"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">알람톡<br>
										<input type="text" name="" placeholder="" value="0"
										readonly="readonly"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center">친구톡<br> <input
										type="text" name="" placeholder="" value="0"
										readonly="readonly"
										class="border-box text-center margin-top-5" /></li>
								</ul>
							</td>
						</tr>
						<tr>
							<th class="padding-bottom-30">비고</th>
							<td class="padding-bottom-40">
								<div
									class="width-100 padding-top-15 padding-bottom-15 line-height-default font-normal border-radius-5 background-fff border-box text-center margin-top-5" />
								비고가 들어갑니다.
								</div>
							</td>
						</tr>

						<tr>
							<th class="width-125px">남은 캐시</th>
							<td>
								<ul>
									<li class="float-left width-20 text-center padding-right-10">단문<br>
										<input type="text" name="" placeholder="" value="0"
										readonly="readonly"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">장문<br>
										<input type="text" name="" placeholder="" value="0"
										readonly="readonly"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">멀티<br>
										<input type="text" name="" placeholder="" value="0"
										readonly="readonly"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">알람톡<br>
										<input type="text" name="" placeholder="" value="0"
										readonly="readonly"
										class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center">친구톡<br> <input
										type="text" name="" placeholder="" value="0"
										readonly="readonly"
										class="border-box text-center margin-top-5" /></li>
								</ul>
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>
								<div
									class="width-100 padding-top-15 padding-bottom-15 line-height-default font-normal border-radius-5 background-fff border-box text-center margin-top-5" />
								비고가 들어갑니다.
								</div>
							</td>
						</tr>
					</table>
				</form>
				<div class="btn-center">
					<!-- <input type="submit" class="background-053c72 font-fff" value="등록"> -->
					<!-- <a href="#" onClick="javascript:document.myForm.submit();" class="background-053c72 font-fff" id="newstaffbtn">등록</a> -->
					<input id="newstaffbtn" type="submit" onClick="validateForm();"
						class="background-053c72 font-fff" value="등록"> <a
						href="/usr/staff" class="background-8bc5ff font-fff">이전 페이지</a>
				</div>
			</div>
		</div>
	</div>
	<!-- <script type="text/javascript">
$(function () {
  $('#demo-form').parsley().on('field:validated', function() {
    var ok = $('.parsley-error').length === 0;
    $('.bs-callout-info').toggleClass('hidden', !ok);
    $('.bs-callout-warning').toggleClass('hidden', ok);
  })
  .on('form:submit', function() {
    return false; // Don't submit form for this demo
  });
});
</script>	 -->
</body>
</html>