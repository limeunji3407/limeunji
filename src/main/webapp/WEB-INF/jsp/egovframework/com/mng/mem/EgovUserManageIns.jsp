<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_hangulidFlag" var="g_hangulidFlag"/>
<spring:message code="g_UserApproval_Delete" var="g_UserApproval_Delete"/>
<spring:message code="PART_MASTER_ONLY_ONE" var="PART_MASTER_ONLY_ONE"/>
<spring:message code="lms_change" var="lms_change"/>
<spring:message code="mms_change" var="mms_change"/>
<spring:message code="noti_change" var="noti_change"/>
<spring:message code="notilms_change" var="notilms_change"/>
<spring:message code="fri_change" var="fri_change"/>
<spring:message code="frilms_change" var="frilms_change"/>
<spring:message code="frimms_change" var="frimms_change"/>
<spring:message code="mo_change" var="mo_change"/>
<spring:message code="g_MO_USE" var="g_MO_USE"/>
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
var idCheck = 0;
$(document).ready(function() {
	$('#user_pw').attr('data-parsley-pattern', pwset[${pwSet.pwdPattern}]);
	
	$('.bs-callout-info').toggleClass('hidden', true);
    $('.bs-callout-warning').toggleClass('hidden', true);
    
    $("#basicPw").click(function(){
		if($("input:checkbox[name=basicPw]").is(":checked") == true) {
			var pwSet = "${pwSet.pwdFirst}";
			$("#user_pw").val(pwSet);
		}else{
			$("#user_pw").val("");
		}
	});
    $(document).on("input", "#user_id",function(){
    	idCheck = 0;
    })
    ajaxCallGetNoParse("/getCashlevelAll.do", function(res){
   		var str = '<option selected value="">등급을 선택해주세요</option>';
   		for(var i = 0 ; i < res.data.length ; i++){
   			str += '<option value="'+res.data[i].lvid+'">'+res.data[i].lvname+'</option>'
   		}
   		$("#level").html(str);
   	})
   	$(document).on("change","#level",function(){
   		var uids = $(this).val();
   		if(uids){
   			ajaxCallGetNoParse("/getCashlevelAll.do?uids="+uids, function(res){
   				if(res.data != null && res.data.length > 0){
   					$("#sms").val(res.data[0].sms); //text
   	   	   			$("#lms").val(res.data[0].lms); //text
   	   	   			$("#mms").val(res.data[0].mms); //text
   	   	   			$("#alt").val(res.data[0].notice); //text
   	   	   			$("#frt").val(res.data[0].friend); //text
   				}
   	   	   	})
   		}
   	})
});

function partMCheck(){
	$('#demo-form').parsley().validate();
    if (!$('#demo-form').parsley().isValid()) {
    	return;
    }
    if(idCheck<=0){
    	alert("아이디 중복체크를 해주세요.");
    	return;
    }
    var part_id = $("#part_id option:selected").val(); //select
    var partgRole = $("input[name=partgRole]:checked").val();
    
    if(partgRole == "N"){
    	//부서원일경우
    	validateForm();
    }else{
    	//부서장일경우
    	var obj = {
   			"orgnztId": part_id,
   			"partgRole": partgRole,
    	}
    	
    	console.log(JSON.stringify(obj));
    	console.log('${PART_MASTER_ONLY_ONE}');
    	
    	$.ajax({
	       	url: "<c:url value='/mng/partMCheck.do' />",
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
	            if(jsondata["data"]!=0){
	            	alert("발리데이션1")
	            	validateForm();
	            }else{
	            	
	            	alert("발리데이션2")
	            	
	            	if('${PART_MASTER_ONLY_ONE}' == "Y"){
	            		var check = confirm("부서장은 1명만 지정 가능합니다. 부서장을 변경하시겠습니까.");
	            		if(check == true){
	            			validateForm2();
	            		}else{
	            			return;
	            		}
	            	}else{
	            		validateForm2();
	            	}
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
}

function validateForm() {
	
	var user_id = $("#user_id").val(); //
	var user_pw = $("#user_pw").val(); //text
	var user_name = $("#user_name").val(); //text
	var position_id = $("#position_id").val(); //text
	var part_id = $("#part_id option:selected").val(); //select
	var cellphone = $("#cellphone1 option:selected").val()+$("#cellphone2").val()+$("#cellphone3").val(); //text
	var phone = $("#phone1 option:selected").val()+$("#phone2").val()+$("#phone3").val();//text
	var memo = $("#memo").val(); //text
	var status = $("#status option:selected").val(); //select
	var useStatus = $("input[name=use]:checked").val();
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
	var partgRole = $("input[name=partgRole]:checked").val();
	var moRole;
	var smsRole = $("input[name=smsRole]:checked").val();
	var lmsRole = $("input[name=lmsRole]:checked").val();
	var mmsRole = $("input[name=mmsRole]:checked").val();
	var notiRole = $("input[name=notiRole]:checked").val();
	var notilmsRole = $("input[name=notilmsRole]:checked").val();
	var friRole = $("input[name=friRole]:checked").val();
	var frilmsRole = $("input[name=frilmsRole]:checked").val();
	var frimmsRole = $("input[name=frimmsRole]:checked").val();
	var ip = $("#ip").val();
	var adrRole;
	var subiduse = $("input[name=subiduse]:checked").val();
	var subid = $("#subid").val();
	var staffAdr;
	
	if($("input:checkbox[name=moRole]").is(":checked") == true) {
		moRole = "Y";
	}else{
		moRole = "N";
	}
	
	if($("input:checkbox[name=adrRole]").is(":checked") == true) {
		adrRole = "Y";
	}else{
		adrRole = "N";
	}
	
	if($("input:checkbox[name=staffAdr]").is(":checked") == true) {
		staffAdr = "Y";
	}else{
		staffAdr = "N";
	}
	
	//alert(reg_user_name);
	var obj = {
			"emplyrId": user_id,
           	"password": user_pw,
           	"emplyrNm": user_name,
           	"ofcpsNm": position_id,
           	"orgnztId": part_id,
           	"moblphonNo": cellphone,
           	"offmTelno": phone,
           	"memo": memo, 
           	"emplyrSttusCode": status,
           	"useStatus": useStatus,
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
           	"partgRole": partgRole,
           	"moRole": moRole,
           	"smsRole": smsRole,
           	"lmsRole": lmsRole,
           	"mmsRole": mmsRole,
           	"notiRole": notiRole,
           	"notilmsRole": notilmsRole,
           	"friRole": friRole,
           	"frilmsRole": frilmsRole,
           	"frimmsRole": frimmsRole,
           	"ip": ip,
           	"adrRole": adrRole,
           	"subiduse": subiduse,
           	"subid": subid,
           	"staffAdr": staffAdr
	};
	
	console.log(JSON.stringify(obj));
    	$.ajax({
       	url: "<c:url value='/mng/InsertUser.do' />",
//        	url: "<c:url value='/mng/UpdateUser.do' />",
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
                toastr.success("성공적으로 등록 되었습니다.");
                $('#newstaffbtn').attr('disabled', false);
           		//close popup
           		location.href  ="/mng/user"
          	  
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

function validateForm2() {
	
	var user_id = $("#user_id").val(); //
	var user_pw = $("#user_pw").val(); //text
	var user_name = $("#user_name").val(); //text
	var position_id = $("#position_id").val(); //text
	var part_id = $("#part_id option:selected").val(); //select
	var cellphone = $("#cellphone1 option:selected").val()+$("#cellphone2").val()+$("#cellphone3").val(); //text
	var phone = $("#phone1 option:selected").val()+$("#phone2").val()+$("#phone3").val();//text
	var memo = $("#memo").val(); //text
	var status = $("#status option:selected").val(); //select
	var useStatus = $("input[name=use]:checked").val();
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
	var partgRole = $("input[name=partgRole]:checked").val();
	var moRole;
	var smsRole = $("input[name=smsRole]:checked").val();
	var lmsRole = $("input[name=lmsRole]:checked").val();
	var mmsRole = $("input[name=mmsRole]:checked").val();
	var notiRole = $("input[name=notiRole]:checked").val();
	var notilmsRole = $("input[name=notilmsRole]:checked").val();
	var friRole = $("input[name=friRole]:checked").val();
	var frilmsRole = $("input[name=frilmsRole]:checked").val();
	var frimmsRole = $("input[name=frimmsRole]:checked").val();
	var ip = $("#ip").val();
	var adrRole;
	var subiduse = $("input[name=subiduse]:checked").val();
	var subid = $("#subid").val();
	var staffAdr;
	
	if($("input:checkbox[name=moRole]").is(":checked") == true) {
		moRole = "Y";
	}else{
		moRole = "N";
	}
	
	if($("input:checkbox[name=adrRole]").is(":checked") == true) {
		adrRole = "Y";
	}else{
		adrRole = "N";
	}
	
	if($("input:checkbox[name=staffAdr]").is(":checked") == true) {
		staffAdr = "Y";
	}else{
		staffAdr = "N";
	}
	
	//alert(reg_user_name);
	var obj = {
			"emplyrId": user_id,
           	"password": user_pw,
           	"emplyrNm": user_name,
           	"ofcpsNm": position_id,
           	"orgnztId": part_id,
           	"moblphonNo": cellphone,
           	"offmTelno": phone,
           	"memo": memo, 
           	"emplyrSttusCode": status,
           	"useStatus": useStatus,
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
           	"partgRole": partgRole,
           	"moRole": moRole,
           	"smsRole": smsRole,
           	"lmsRole": lmsRole,
           	"mmsRole": mmsRole,
           	"notiRole": notiRole,
           	"notilmsRole": notilmsRole,
           	"friRole": friRole,
           	"frilmsRole": frilmsRole,
           	"frimmsRole": frimmsRole,
           	"ip": ip,
           	"adrRole": adrRole,
           	"subiduse": subiduse,
           	"subid": subid,
           	"staffAdr": staffAdr
	};
	
	console.log(JSON.stringify(obj));
    	$.ajax({
       	url: "<c:url value='/mng/UpdateUserPartg.do' />",
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
                toastr.success("성공적으로 등록 되었습니다.");
                $('#newstaffbtn').attr('disabled', false);
           		//close popup
           		location.href  ="/mng/user"
          	  
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
</script>
</head>
<body>
	<div class="wrap">
		<!--contents-->
		<div class="con-inner">
			<!--타이틀-->
			<h1 class="con-title">
				<ul>
					<li>사용자정보</li>
					<li class="icon_home"></li>
					<li><span class="dot"></span>사용자관리</li>
					<li><span class="dot"></span>사용자정보</li>
				</ul>
			</h1>

			<div
				class="margin-auto margin-bottom-100 width-730px padding-tb-40 background-transparent border-box">

				<!--사용자등록 -->
				<div
					class="width-100 background-f7fafc border-radius-5 margin-bottom-70 padding-top-20 padding-bottom-40">
					<!-- 입력폼-->
					<div
						class="padding-rl-65 padding-top-25 padding-bottom-10 border-box">
						<h3 class="form_tit">사용자 등록</h3>
						<form id="demo-form" data-parsley-validate="">
							<table class="width-100 margin-bottom-40">
								<tr>
									<th class="width-125px">아이디</th>
									<td><input type="text" id="user_id" name="user_id"
										required="" placeholder="아이디를 입력해주세요."
										class="width-260px padding-left-20 border-box margin-right-10"
										<c:if test="${g_hangulidFlag eq 'N' }">
											data-parsley-type="alphanum"
										</c:if>
										data-parsley-required="true" data-parsley-trigger="change" /><a
										onclick="id_check();"
										class="width-80px height-50px line-height-50px font-15px border-radius-5 background-8bc5ff font-fff text-center margin-right-10">중복확인</a></td>
								</tr>
								<tr>
									<th>패스워드</th>
									<td><input type="password" name="user_pw" id="user_pw" required=""
										placeholder="비밀번호를 입력해주세요."
										class="width-260px padding-left-20 border-box margin-right-10"
										data-parsley-required="true" data-parsley-trigger="change" />
										<div class="checkbox">
											<input type="checkbox" id="basicPw" name="basicPw" /> <label
												for="basicPw"></label> <span class="font-13px margin-left-10">체크시
												기본 패스워드</span>
										</div>
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td><input type="text" id="user_name" name="user_name"
										required="" placeholder="이름을 입력해주세요."
										class="width-260px padding-left-20 border-box"
										data-parsley-required="true" data-parsley-trigger="change" /></td>
								</tr>
								<tr>
									<th>직위(급)</th>
									<td><input type="text" id="position_id" name="position_id"
										required="" placeholder="직급을 입력해주세요."
										class="width-260px padding-left-20 border-box"
										data-parsley-required="true" data-parsley-trigger="change" /></td>
								</tr>
								<tr>
									<th>부서명</th>
									<td><select title="part_id" id="part_id" name="part_id" data-parsley-required="true" data-parsley-trigger="change"
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
									<th>상태</th>
									<td><select title="status" id="status" name="status" 
										required="" class="select_white width-260px">
											<option value="" disabled selected hidden>상태를 선택해주세요</option>
											<option value="AAA">근무</option>
											<option value="AAB">근무(파견)</option>
											<option value="ABA">휴직</option>
											<option value="DAB">전출</option>
											<option value="DAA">퇴직</option>
									</select></td>
								</tr>
								<tr>
									<th>휴대전화</th>
									<td><select title="" id="cellphone1" data-parsley-required="true" data-parsley-trigger="change"
										class="select_white width-90px inline-block ">
											<option value="" disabled selected hidden>번호를 선택해주세요</option>
											<option>010</option>
									</select> <input type="text" id="cellphone2" name="cellphone2"
										required="" placeholder=""
										class="inline-block width-90px padding-left-20 border-box margin-left-10 margin-right-10" />
										<input type="text" id="cellphone3" name="cellphone3"
										required="" placeholder=""
										class="inline-block width-90px padding-left-20 border-box" /></td>
								</tr>
								<tr>
									<th>일반전화</th>
								<td><select title="" id="phone1" name="phone1" 
									class="select_white width-90px inline-block "
									data-parsley-trigger="change">
										<option value="" disabled selected hidden>번호를 선택해주세요</option>
										<option >02</option>
										<option>031</option>
										<option >051</option>
								</select> <input type="text" id="phone2" name="phone2"
									placeholder=""
									class="inline-block width-90px padding-left-20 border-box margin-right-10"
									data-parsley-type="digits" data-parsley-maxlength="4"
									data-parsley-trigger="change" /> <input type="text"
									id="phone3" name="phone3" placeholder=""
									class="inline-block width-90px padding-left-20 border-box"
									data-parsley-type="digits" data-parsley-maxlength="4"
									data-parsley-trigger="change" /></td>
								</tr>
								<tr>
									<th>메모</th>
									<td><input type="text" id="memo" name="memo"
										placeholder="" value=""
										class="width-300px padding-left-20 border-box" /></td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td>
										<div class="relative width-100 height-60px">
											<div class="absolute position-vertical-center position-left">
												<div class="radio-box font-16px font-053c72 margin-right-20">
													<div class="radio">
														<input type="radio" id="a1" name="use" value="Y" checked />
														<label for="a1"><span></span></label>
													</div>
													사용
												</div>
												<div class="radio-box font-16px font-053c72 ">
													<div class="radio">
														<input type="radio" id="a2" name="use" value="N" /> <label
															for="a2"><span></span></label>
													</div>
													사용안함
												</div>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>기타</th>
									<td>
										<div class="relative width-100 height-50px">
											<div
												class="checkbox width-100 absolute position-vertical-center position-left">
												<input type="checkbox" id="check_2" name="staffAdr" /> <label
													for="check_2"></label> <span
													class="font-16px font-053c72 margin-left-10">직원주소록에
													추가</span>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>등급</th>
									<td><select title="status" id="level" name="level" required=""
										class="select_white width-260px">
									</select></td>
								</tr>
							</table>
						</form>
					</div>
					<!--버튼-->
					<div class="btn-center">
						<!-- <a class="pop_close background-053c72 font-fff">저장</a> -->
						<input id="newstaffbtn" type="submit" onClick="partMCheck();"
							class="background-053c72 font-fff" value="등록"> <a
							class="pop_close background-8bc5ff font-fff">취소</a>
					</div>

					<div
						class="padding-rl-65 padding-top-25 padding-bottom-10 border-box margin-top-40">
						<ul class="tabmenu_medium">
							<li id="medium_tab_1" class="btnCon"><input type="radio"
								checked name="tabmenu_medium" id="tabmenu_medium_1"> <label
								for="tabmenu_medium_1">캐시설정</label>
								<div class="medium_tabCon">
									<div class="padding-20">
										<table class="width-100">
											<tr>
												<th class="width-125px">월 건수 한도</th>
												<td>
													<ul>
														<li class="float-left width-20 text-center padding-right-10">단문<br>
															<input type="text" id="sms" name="" placeholder="" value="0" readonly="readonly"
															class="border-box text-center margin-top-5" /></li>
														<li class="float-left width-20 text-center  padding-right-10">장문<br>
															<input type="text" id="lms" name="" placeholder="" value="0" readonly="readonly"
															class="border-box text-center margin-top-5" /></li>
														<li class="float-left width-20 text-center  padding-right-10">멀티<br>
															<input type="text" id="mms" name="" placeholder="" value="0" readonly="readonly"
															class="border-box text-center margin-top-5" /></li>
														<li class="float-left width-20 text-center  padding-right-10">알람톡<br>
															<input type="text" id="alt" name="" placeholder="" value="0" readonly="readonly"
															class="border-box text-center margin-top-5" /></li>
														<li class="float-left width-20 text-center  padding-right-10">친구톡<br>
															<input type="text" id="frt" name="" placeholder="" value="0" readonly="readonly"
															class="border-box text-center margin-top-5" /></li>
														<li
															class="float-left width-100 text-center  padding-right-10 margin-top-5">
															<div class="width-100 padding-tb-25 line-height-default font-normal border-radius-5 background-fff border-box text-center margin-top-5" />
															현재 남은 부서캐쉬 : 48,589,369 <br>입력한 월 캐쉬 한도는 매월 1일 0시에
															REFRESH됩니다.
															</div>
														</li>
													</ul>

												</td>
											</tr>
										</table>
									</div>
								</div></li>
							<li id="medium_tab_2" class="btnCon"><input type="radio"
								name="tabmenu_medium" id="tabmenu_medium_2"> <label
								for="tabmenu_medium_2">권한/등급</label>
								<div class="medium_tabCon">
									<div class="padding-20">

										<table class="con_tb_row width-100" cellpadding="0"
											cellspacing="0" border="0">
											<colgroup>
												<col width="120" />
												<col width="120" />
												<col width="40" />
												<col width="120" />
												<col width="" />
											</colgroup>
											<tr>
											<th class="tit font-bold">부서장설정</th>
											<td colspan="4">
												<div class="relative width-100">
													<div
														class="absolute position-vertical-center position-left padding-left-10">
														<div
															class="radio-box_s font-12px font-053c72 margin-right-20">
															<div class="radio_s">
																<input type="radio" id="s1" name="partgRole" value="N"
																	checked />
																<label for="s1"><span></span></label>
															</div>
															부서원
														</div>
														<div class="radio-box_s font-12px font-053c72 ">
															<div class="radio_s">
																<input type="radio" id="s2" name="partgRole" value="Y"
																	/>
																<label for="s2"><span></span></label>
															</div>
															부서장
														</div>
													</div>
												</div>
											</td>
										</tr>
										<c:if test="${g_MO_USE eq 'Y' and mo_change eq 'Y'}">
										<tr>
											<th class="tit">MO사용권한</th>
											<td colspan="4">
												<div class="relative width-100">
													<div
														class="checkbox-small width-100 absolute position-vertical-center position-left padding-left-10">
														<input type="checkbox" id="c1" name="moRole"/>
														<label for="c1"></label> <span
															class="font-12px font-053c72 margin-left-10">MO사용권한</span>
													</div>
												</div>
											</td>
										</tr>
										</c:if>
										<tr>
											<th class="tit">주소록공유</th>
											<td colspan="4">
												<div class="relative width-100">
													<div
														class="checkbox-small width-100 absolute position-vertical-center position-left padding-left-10">
														<input type="checkbox" id="c2" name="adrRole"/>
														<label for="c2"></label> <span
															class="font-12px font-053c72 margin-left-10">전체공유
															권한</span>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<th class="tit" rowspan="8">메세지권한</th>
											<th>단문</th>
											<td colspan="3">
												<div class="relative width-100">
													<div
														class="absolute position-vertical-center position-left padding-left-10">
														<div
															class="radio-box_s font-12px font-053c72 margin-right-20">
															<div class="radio_s">
																<input type="radio" id="s3" name="smsRole"
																	<c:if test="${msgRole.sms eq '1'}">checked</c:if>
																	value="1" /> <label for="s3"><span></span></label>
															</div>
															사용
														</div>
													</div>
												</div>
											</td>
										</tr>
										<tr>
										<c:if test="${lms_change eq 'Y'}">
											<th>장문</th>
											<td colspan="3">
												<div class="relative width-100">
													<div
														class="absolute position-vertical-center position-left padding-left-10">
														<div
															class="radio-box_s font-12px font-053c72 margin-right-20">
															<div class="radio_s">
																<input type="radio" id="s4" name="lmsRole" value="1"
																	<c:if test="${msgRole.lms eq '1'}">checked</c:if> />
																<label for="s4"><span></span></label>
															</div>
															사용
														</div>
														<div class="radio-box_s font-12px font-053c72 ">
															<div class="radio_s">
																<input type="radio" id="s5" name="lmsRole" value="0"
																	<c:if test="${userInfo.lms eq '0'}">checked</c:if> />
																<label for="s5"><span></span></label>
															</div>
															사용안함
														</div>
													</div>
												</div>
											</td>
											</c:if>
										</tr>
										<tr>
										<c:if test="${mms_change eq 'Y'}">
											<th>멀티</th>
											<td colspan="3">
												<div class="relative width-100">
													<div
														class="absolute position-vertical-center position-left padding-left-10">
														<div
															class="radio-box_s font-12px font-053c72 margin-right-20">
															<div class="radio_s">
																<input type="radio" id="s6" name="mmsRole" value="1"
																	<c:if test="${msgRole.mms eq '1'}">checked</c:if> />
																<label for="s6"><span></span></label>
															</div>
															사용
														</div>
														<div class="radio-box_s font-12px font-053c72 ">
															<div class="radio_s">
																<input type="radio" id="s7" name="mmsRole" value="0"
																	<c:if test="${msgRole.mms eq '0'}">checked</c:if> />
																<label for="s7"><span></span></label>
															</div>
															사용안함
														</div>
													</div>
												</div>
											</td>
											</c:if>
										</tr>
										<tr>
										<c:if test="${noti_change eq 'Y'}">
											<th>알림톡</th>
											<td colspan="3">
												<div class="relative width-100">
													<div
														class="absolute position-vertical-center position-left padding-left-10">
														<div
															class="radio-box_s font-12px font-053c72 margin-right-20">
															<div class="radio_s">
																<input type="radio" id="s8" name="notiRole" value="1"
																	<c:if test="${msgRole.notice eq '1'}">checked</c:if> />
																<label for="s8"><span></span></label>
															</div>
															사용
														</div>
														<div class="radio-box_s font-12px font-053c72 ">
															<div class="radio_s">
																<input type="radio" id="s9" name="notiRole" value="0"
																	<c:if test="${msgRole.notice eq '0'}">checked</c:if> />
																<label for="s9"><span></span></label>
															</div>
															사용안함
														</div>
													</div>
												</div>
											</td>
											</c:if>
										</tr>
										<tr>
										<c:if test="${notilms_change eq 'Y'}">
											<th>알림톡대체장문</th>
											<td colspan="3">
												<div class="relative width-100">
													<div
														class="absolute position-vertical-center position-left padding-left-10">
														<div
															class="radio-box_s font-12px font-053c72 margin-right-20">
															<div class="radio_s">
																<input type="radio" id="s10" name="notilmsRole"
																	<c:if test="${msgRole.noticelms eq '1'}">checked</c:if>
																	value="1" /> <label for="s10"><span></span></label>
															</div>
															사용
														</div>
														<div class="radio-box_s font-12px font-053c72 ">
															<div class="radio_s">
																<input type="radio" id="s11" name="notilmsRole"
																	<c:if test="${msgRole.noticelms eq '0'}">checked</c:if>
																	value="0" /> <label for="s11"><span></span></label>
															</div>
															사용안함
														</div>
													</div>
												</div>
											</td>
											</c:if>
										</tr>
										<tr>
										<c:if test="${fri_change eq 'Y'}">
											<th>친구톡</th>
											<td colspan="3">
												<div class="relative width-100">
													<div
														class="absolute position-vertical-center position-left padding-left-10">
														<div
															class="radio-box_s font-12px font-053c72 margin-right-20">
															<div class="radio_s">
																<input type="radio" id="s12" name="friRole" value="1"
																	<c:if test="${msgRole.friend eq '1'}">checked</c:if> />
																<label for="s12"><span></span></label>
															</div>
															사용
														</div>
														<div class="radio-box_s font-12px font-053c72 ">
															<div class="radio_s">
																<input type="radio" id="s13" name="friRole" value="0"
																	<c:if test="${msgRole.friend eq '0'}">checked</c:if> />
																<label for="s13"><span></span></label>
															</div>
															사용안함
														</div>
													</div>
												</div>
											</td>
											</c:if>
										</tr>
										<tr>
										<c:if test="${frilms_change eq 'Y'}">
											<th>친구톡대체장문</th>
											<td colspan="3">
												<div class="relative width-100">
													<div
														class="absolute position-vertical-center position-left padding-left-10">
														<div
															class="radio-box_s font-12px font-053c72 margin-right-20">
															<div class="radio_s">
																<input type="radio" id="s14" name="frilmsRole" value="1"
																	<c:if test="${msgRole.friendlms eq '1'}">checked</c:if> />
																<label for="s14"><span></span></label>
															</div>
															사용
														</div>
														<div class="radio-box_s font-12px font-053c72 ">
															<div class="radio_s">
																<input type="radio" id="s15" name="frilmsRole" value="0"
																	<c:if test="${msgRole.friendlms eq '0'}">checked</c:if> />
																<label for="s15"><span></span></label>
															</div>
															사용안함
														</div>
													</div>
												</div>
											</td>
											</c:if>
										</tr>
										<tr>
										<c:if test="${frimms_change eq 'Y'}">
											<th>친구톡대체멀티</th>
											<td colspan="3">
												<div class="relative width-100">
													<div
														class="absolute position-vertical-center position-left padding-left-10">
														<div
															class="radio-box_s font-12px font-053c72 margin-right-20">
															<div class="radio_s">
																<input type="radio" id="s16" name="frimmsRole" value="1"
																	<c:if test="${msgRole.friendmms eq '1'}">checked</c:if> />
																<label for="s16"><span></span></label>
															</div>
															사용
														</div>
														<div class="radio-box_s font-12px font-053c72 ">
															<div class="radio_s">
																<input type="radio" id="s17" name="frimmsRole" value="0"
																	<c:if test="${msgRole.friendmms eq '0'}">checked</c:if>
																/> <label for="s17"><span></span></label>
															</div>
															사용안함
														</div>
													</div>
												</div>
											</td>
											</c:if>
										</tr>
										<tr>
											<th class="tit">서브아이디 사용</th>
											<td colspan="2">
												<div class="relative width-100">
													<div
														class="absolute position-vertical-center position-left padding-left-10">
														<div
															class="radio-box_s font-12px font-053c72 margin-right-20">
															<div class="radio_s">
																<input type="radio" id="s18" name="subiduse" value="Y"
																	/>
																<label for="s18"><span></span></label>
															</div>
															사용
														</div>
														<div class="radio-box_s font-12px font-053c72 ">
															<div class="radio_s">
																<input type="radio" id="s19" name="subiduse" value="N"
																	checked/>
																<label for="s19"><span></span></label>
															</div>
															사용안함
														</div>
													</div>
												</div>
											</td>
											<th class="tit">서브아이디</th>
											<td><input type="text" name="subid" placeholder="서브아이디"
												id="subid"
												<c:if test="${g_hangulidFlag eq 'N' }">
													data-parsley-type="alphanum"
												</c:if>
												class="height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
											</td>
										</tr>
										<tr>
											<th class="tit relative">IP 등록</th>
											<td colspan="4"><input type="text" id="ip" name="ip"
												value="${ userInfo.ip }"
												placeholder="ip 주소를 적어주세요. 2개 이상일시  , 로 구분"
												class="height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
										</tr>
										</table>
									</div>
								</div></li>
						</ul>
					</div>
					<!--버튼-->
					<div class="btn-center">
						<a class="background-053c72 font-fff" onclick="partMCheck()">저장</a>
						<a class="background-8bc5ff font-fff" href="/mng/user">취소</a>
					</div>

				</div>
			</div>
			</li>
			</ul>
		</div>
	</div>
	</div>
</body>
</html>
