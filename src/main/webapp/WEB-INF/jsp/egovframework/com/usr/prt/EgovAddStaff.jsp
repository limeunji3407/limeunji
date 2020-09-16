<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_hangulidFlag" var="g_hangulidFlag"/>
<spring:message code="defaultGroup" var="defaultGroup"/>
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
$(document).ready(function(){ 
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
function validateForm() {
	$('#demo-form').parsley().validate();
    if (!$('#demo-form').parsley().isValid()) {
    	return;
    }
    if(idCheck<=0){
    	alert("아이디 중복체크를 해주세요.");
    	return;
    }
	var user_id = $("#user_id").val(); //
	var user_pw = $("#user_pw").val(); //text
	var user_name = $("#user_name").val(); //text
	var position_id = $("#position_id").val(); //text
	var part_id = $("#part_id option:selected").val(); //select
	var cellphone = $("#cellphone1 option:selected").val()+$("#cellphone2").val()+$("#cellphone3").val(); //text
	var phone = $("#phone1").val()+$("#phone2").val()+$("#phone3").val();//text
	var memo = $("#memo").val(); //text
	var status = $("#status option:selected").val(); //select
	var sms = $("#sms").val(); //text
	var lms = $("#lms").val(); //text
	var mms = $("#mms").val(); //text
	var alt = $("#alt").val(); //text
	var frt = $("#frt").val(); //text
	var lvId = $("#level").val(); //text
	
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
           	"sms": sms,
           	"lms": lms,
           	"mms": mms,
           	"nms": alt,
           	"fms": frt,
           	"lvId":lvId
	};
	
   	$.ajax({
       	url: "/usr/insertPartUserAdmin.do",
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
            	
            	var defaultGroup = "${defaultGroup}";
                if(defaultGroup == 'Y'){
             	   var param = {
             			   "title":"기본그룹",
             			   "parent":"0",
             			   "sequence":"0",
             			   "depth":"1",
             			   "type":"0",
             			   "userid":user_id
             			   
             	   }
             	   $.ajax({
             		    type : "POST",
	           	        	url: "<c:url value='/grp/AddrGroupInserts.do'/>",
	           	     		data : param,
	           	     		dataType: "json",
	           	        	success: function(jsondata){  
	           	        		if(parseInt(jsondata)>0){
	           	        			
	           	        			var srvcNm = '부서장기능 >> 부서원 관리';
	           						var methodNm = '등록';
	           						
	           						var obj = {
	           								"srvcNm":srvcNm,
	           								"methodNm":methodNm
	           						}
	           						$.ajax({
	           					    	url: "<c:url value='/usr/insertUsrLog' />",
	           					       	type: "POST",
	           				        	data: obj,
	           					    	dataType: "json",
	           					       	success: function(jsondata){
	           					       		
	           					       		if(jsondata["data"]==0){
	           					       			console.log("로그가 성공적으로 저장되었습니다.");
	           					            }else{
	           					          	  alert("로그가 저장 실패.");
	           					            }
	           					       	},
	           					       	error: function(request,status,error){
	           					       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	           					       	}
	           					   	});
	           						
	           	        			toastr.success("성공적으로 부서원이 입력 되었습니다.");
	           	                 	$('#newstaffbtn').attr('disabled', false);
	           	            		location.href  ="/usr/staff"
	           	        		}else{
	           	        			alert("기본그룹 생성중 오류가 발생하였습니다.")
	           	        		}
	           	        	},error: function(request,status,error){
	        	        		console.log(status)
	        	        		console.log(error)
	        	        	}
	           	    	});
                }else{
                	toastr.success("성공적으로 부서원이 입력 되었습니다.");
                    $('#newstaffbtn').attr('disabled', false);
               		location.href  ="/usr/staff"
                }
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
							<td><input type="text" id="user_id" name="user_id" required=""
								placeholder="아이디를 입력해주세요."
								class="width-260px padding-left-20 border-box margin-right-10"
								<c:if test="${g_hangulidFlag eq 'N' }">
								data-parsley-type="alphanum"
								</c:if>
								data-parsley-required="true" data-parsley-trigger="change" /><a onclick="id_check();"
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
								</div></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" id="user_name" name="user_name" required=""
								placeholder="이름을 입력해주세요."
								class="width-260px padding-left-20 border-box" data-parsley-pattern="^[가-힣]+$" data-parsley-maxlength="5"
								data-parsley-required="true" data-parsley-trigger="change" /></td>
						</tr>
						<tr>
							<th>직위(급)</th>
							<td><input type="text" id="position_id" name="position_id" required=""
								placeholder="직급을 입력해주세요."
								class="width-260px padding-left-20 border-box" data-parsley-pattern="^[가-힣]+$"
								data-parsley-required="true" data-parsley-trigger="change" /></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td><select title="" id="cellphone1"
								class="select_white width-90px inline-block ">
								<option selected>010</option>
							</select> <input type="text" id="cellphone2" name="cellphone2" required=""
								placeholder="1234"
								class="inline-block width-90px padding-left-20 border-box margin-left-10 margin-right-10" />
								<input type="text" id="cellphone3" name="cellphone3" required=""
								placeholder="1234"
								class="inline-block width-90px padding-left-20 border-box" /></td>
						</tr>
						<tr>
							<th>일반전화</th>
							<td><input type="text" id="phone1" name="phone1"
								placeholder=""
								class="inline-block width-90px padding-left-20 border-box margin-right-10" />
								<input type="text" id="phone2" name="phone2" placeholder=""
								class="inline-block width-90px padding-left-20 border-box margin-right-10" />
								<input type="text" id="phone3" name="phone3" placeholder=""
								class="inline-block width-90px padding-left-20 border-box" /></td>
						</tr>
						<tr>
							<th>메모</th>
							<td><input type="text" id="memo" name="memo" placeholder=""
								value="" class="width-300px padding-left-20 border-box" /></td>
						</tr>
						<tr>
							<th>상태</th>
							<td><select title="status" id="status" name="status" required=""
								class="select_white width-260px">
									<option selected value="">상태를 선택해주세요</option>
									<option value="AAA">근무</option>
									<option value="AAB">근무(파견)</option>
									<option value="ABA">휴직</option>
									<option value="DAB">전출</option>
									<option value="DAA">퇴직</option>
							</select></td>
						</tr>
						<tr>
							<th>등급</th>
							<td><select title="status" id="level" name="level" required=""
								class="select_white width-260px">
							</select></td>
						</tr>
					</table>

					<h3 class="form_tit">설정하기</h3>
					<table class="width-100 margin-bottom-10">
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
										입력한 월 캐쉬 한도는 매월 1일 0시에
										REFRESH됩니다.
										</div>
									</li>
								</ul>

							</td>
						</tr>
					</table>
					</form>
					<div class="btn-center">
						<input id="newstaffbtn" type="submit" onClick="validateForm();" class="background-053c72 font-fff" value="등록">
						<a href="/usr/staff" class="background-8bc5ff font-fff">이전 페이지</a>
					</div>
			</div>
		</div>
	</div>
</body>
</html>