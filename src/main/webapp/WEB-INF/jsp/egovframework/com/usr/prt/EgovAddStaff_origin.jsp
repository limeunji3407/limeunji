<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="en">
<head>
		<meta charset="UTF-8">
		<meta name="Generator" content="EditPlus®">
		<meta name="Author" content="">
		<meta name="Keywords" content="">
		<meta name="Description" content="">
		<title>iGOV SMS SYSTEM</title>
		
<script type="text/javaScript" language="javascript" defer="defer"> 
$(document).ready(function() {
	
				$('#newstaffbtn').on('click', function(){ 
					
					$('#newstaffbtn').attr('disabled', true);
					
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
			
					//alert(reg_user_name);
					var obj = {
							"emplyrId": user_id,
			            	"password": user_pw,
			            	"emplyrNm": user_name,
			            	"ofcpsNm": position_id,
			            	"orgnztId": part_id,
			            	"moblphonNo": cellphone,
			            	"offmTelno": phone,
			            	/* "memo": memo, */
			            	"emplyrSttusCode": status,
			            	/* "sms": sms,
			            	"lms": lms,
			            	"mms": mms,
			            	"alt":alt,
			            	"frt": frt */
					}
					alert(JSON.stringify(obj));
			     	$.ajax({
			        	url: "<c:url value='/usr/InsertPartUser.do' />",
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
			
			                   //개별데이타처리                   
			                   $.each(jsondata["MessagingTemplate"], function (index, item) {
			                	   $("input[type=text][name=" + index + "]").val(item);
			                	   //var result = ''; 
			                	   //result += index +' : ' + item; 
			                	   //$("#result").append(result); 
							   });
			                   //로딩
			                   toastr.success('성공적으로 수정되었습니다'); 
			                   /* $(".pop_templet").css('display','none'); */
			
			        		$('#newstaffbtn').attr('disabled', false);
			        		//close popup
			        		
			            	
			        	},
			        	error: function(request,status,error){
			        		  
			        		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
			            	$('#result').text(jsondata);
			            	//alert("serialize err");
			        		$('#newstaffbtn').attr('disabled', false);
			        	}
			    	});
				});
			});
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
				<div class="margin-auto margin-top-30 margin-bottom-100 width-730px  padding-rl-65 padding-tb-40 background-f7fafc border-box box-shadow">
					<h3 class="form_tit">기본정보</h3>
					<table class="width-100 margin-bottom-40">
						<tr>
							<th class="width-125px">아이디</th>
							<td><input type="text" id="user_id" name="" placeholder="아이디를 입력해주세요." class="width-260px padding-left-20 border-box margin-right-10" /></td>
						</tr>
						 <tr>
							<th>패스워드</th>
							<td>
								<input type="text" name="" id="user_pw" placeholder="비밀번호를 입력해주세요." class="width-260px padding-left-20 border-box margin-right-10" />	
								<div class="checkbox">
										<input type="checkbox" id="check_1" name="체크" />
										<label for="check_1"></label>
										<span class="font-13px margin-left-10">체크시 기본 패스워드</span>
								</div>
							</td>
						</tr>
						 <tr>
							<th>이름</th>
							<td><input type="text" id="user_name" name="" placeholder="이름을 입력해주세요." value="김전송" class="width-260px padding-left-20 border-box" /></td>
						</tr>
						 <tr>
							<th>직위(급)</th>
							<td>
								<input type="text" id="position_id" name="" placeholder="직급을 입력해주세요." value="사원" class="width-260px padding-left-20 border-box" />							
							</td>
						</tr>
						 <tr>
							<th>부서명</th>
							<td>
								<select title="" id="part_id" class="select_white width-260px">
									<c:forEach var="part_id" items="${partIdList}" varStatus="status">
										<option value="${part_id.orgnztId}" ${part_id.orgnztId == provider ? 'selected="selected"' : '' }>${part_id.orgnztNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						 <tr>
							<th>휴대전화</th>
							<td>
								<select title="" id="cellphone1" class="select_white width-90px inline-block ">
									<option>010</option>
								</select>
								<input type="text" id="cellphone2" name="" placeholder="" value="1234" class="inline-block width-90px padding-left-20 border-box margin-left-10 margin-right-10" />
								<input type="text" id="cellphone3" name="" placeholder="" value="1234" class="inline-block width-90px padding-left-20 border-box" />
							</td>
						</tr>
						 <tr>
							<th>일반전화</th>
							<td>
								<input type="text" id="phone1" name="" placeholder="" class="inline-block width-90px padding-left-20 border-box margin-right-10" />
								<input type="text" id="phone2" name="" placeholder="" class="inline-block width-90px padding-left-20 border-box margin-right-10" />
								<input type="text" id="phone3" name="" placeholder="" class="inline-block width-90px padding-left-20 border-box" />
							</td>
						</tr>
						 <tr>
							<th>메모</th>
							<td><input type="text" id="memo" name="" placeholder="" value="" class="width-300px padding-left-20 border-box" /></td>
						</tr>
						 <tr>
							<th>상태</th>
							<td>
								<select title="" id="status" class="select_white width-260px">
									<option selected>상태를 선택해주세요</option>
									<option value="AAA">근무</option>
									<option value="AAB">근무(파견)</option>
									<option value="ABA">휴직</option>
									<option value="DAB">전출</option>
									<option value="DAA">퇴직</option>
								</select>
							</td>
						</tr>
					</table>

					<h3 class="form_tit">설정하기</h3>
					<table class="width-100 margin-bottom-10">
						<tr>
							<th class="width-125px">월 건수 한도</th>
							<td>
								<ul>
									<li class="float-left width-20 text-center padding-right-10">단문<br><input type="text" id="sms" name="" placeholder="" value="500" class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">장문<br><input type="text" id="lms" name="" placeholder="" value="500" class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">멀티<br><input type="text" id="mms" name="" placeholder="" value="500" class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">알람톡<br><input type="text" id="alt" name="" placeholder="" value="500" class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-20 text-center  padding-right-10">친구톡<br><input type="text" id="frt" name="" placeholder="" value="500" class="border-box text-center margin-top-5" /></li>
									<li class="float-left width-100 text-center  padding-right-10 margin-top-5">
										<div class="width-100 padding-tb-25 line-height-default font-normal border-radius-5 background-fff border-box text-center margin-top-5" />
											현재 남은 부서캐쉬 : 48,589,369 <br>입력한 월 캐쉬 한도는 매월 1일 0시에 REFRESH됩니다.
										</div>
									</li>
								</ul>
								
							</td>
						</tr>
					</table>
					<!--버튼-->
					<div class="btn-center">
						<a class="background-053c72 font-fff" id="newstaffbtn">등록</a>
						<a href="/usr/staff" class="background-8bc5ff font-fff">이전 페이지</a>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
