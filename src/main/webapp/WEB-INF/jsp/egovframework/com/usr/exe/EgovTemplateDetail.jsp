<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_workSeqZeroCodeUseYN"
	var="g_workSeqZeroCodeUseYN" />
<spring:message code="workSeqRequiredFlag" var="workSeqRequiredFlag" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>iGOV SMS SYSTEM</title>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/jquery.form.js' />">
</script>

<script type="text/x-jsrender" id="selectRstList">
		{{for}}
<ul class="width-100" style="padding-bottom:10px;">
								
					<li class="float-left padding-right-10"><input type="text"
						id="" name="" required="" readonly="readonly"
						class="width-100px height-110px padding-left-20 border-box"
						value="{{:linkType}}" /></li>
					<li class="float-left padding-right-10"><input type="text"
						id="" name="" required="" readonly="readonly"
						class="width-100px height-110px padding-left-20 border-box"
						value="{{:name}}" /></li>
					<li class="float-right padding-bottom-10"{{if linkMo}}style="display:block"{{else}}style="display:none"{{/if}}><input type="text" id="" name=""
						required="" readonly="readonly"
						class="width-250px padding-left-20 border-box"
						value="{{:linkMo}}" /></li>
					<li class="float-right padding-bottom-10"{{if linkPc}}style="display:block"{{else}}style="display:none"{{/if}}><input type="text"
						id="" name="" required="" readonly="readonly"
						class="width-250px padding-left-20 border-box"
						value="{{:linkPc}}" /></li>
					<li class="float-right padding-bottom-10" {{if linkAnd}}style="display:block"{{else}}style="display:none"{{/if}}><input type="text" id="" name=""
						required="" readonly="readonly"
						class="width-250px padding-left-20 border-box"
						value="{{:linkAnd}}" /></li>
					<li class="float-right padding-bottom-10" {{if linkIos}}style="display:block"{{else}}style="display:none"{{/if}}><input type="text"
						id="" name="" required="" readonly="readonly"
						class="width-250px padding-left-20 border-box"
						value="{{:linkIos}}" /></li>

				</ul>
		{{/for}}
</script>
<script type="text/javaScript" language="javascript" defer="defer"> 
$(document).ready(function() {
	var butten = ${templateinfo.template_buttons};
	console.log(butten);
	
	var template = $.templates("#selectRstList"); // <!-- 템플릿 선언
    var htmlOutput = template.render(butten); // <!-- 렌더링 진행 -->
    $(".tbodyData").html(htmlOutput);

})

function name() {
	$('#demo-form').parsley().validate();
	if (!$('#demo-form').parsley().isValid()) {
		return;
	}

	var work_seq = $("#work_seq option:selected").val(); //
	var sender_key = $("#senderkey option:selected").val(); //text
	var template_type = $('[name=template_type]:checked').val(); //text
	var subject = $("#subject").val(); //text
	var tmp_name = $("#tmp_name").val(); //select
	var tmp_subject = $("#tmp_subject").val(); //text
	var butten = $("#butten").val();//text
	var tmp_code = $("#tmpCode").val();
	var template_variables = $("#tmpVar").val();

	//alert(reg_user_name);
	var obj = {
		"work_seq" : work_seq,
		"sender_key" : sender_key,
		"template_type" : template_type,
		"subject" : subject,
		"template_modify_name" : tmp_name,
		"template_modify_content" : tmp_subject,
		"template_modify_buttons" : butten,
		"template_code" : tmp_code,
		"template_modify_buttons": template_variables
	};

	alert(JSON.stringify(obj));
	$.ajax({
		url : "<c:url value='/updateTemplate.do' />",
		type : "POST",
		data : obj,
		dataType : "json",
		success : function(jsondata) {

			alert(jsondata["data"]);

			if (jsondata["data"] == 0) {
				//로딩
				alert('Template이 성공적으로 수정되었습니다');
				location.reload();
				//close popup
			} else {
				toastr.error('양식을 확인해주세요.');
			}
		},
		error : function(request, status, error) {

			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error)
			$('#result').text(jsondata);
			//alert("serialize err");
			$('#newstaffbtn').attr('disabled', false);
		}
	});
}

function workUpdate() {
	
	confirm("업무분류를 변경하시겠습니까?");
	
	var work_seq = $("#work_seq option:selected").val(); //select
	var template_data_seq = $("#template_data_seq").val();
	
	var obj = {
			"work_seq": work_seq,
			"template_data_seq": template_data_seq
	}
	
	console.log(JSON.stringify(obj));
	
	$.ajax({
       	url: "<c:url value='/usr/MessagingTemplateUpdateWorkSeq.do' />",
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
     	   
            console.log(jsondata["data"]);
            
            if(jsondata["data"]==0){
                //로딩
                alert("성공적으로 수정 되었습니다.");
                $('#newstaffbtn').attr('disabled', false);
           		//close popup
                location.reload();
          	  
            }else{
          	  alert("수정에 실패했습니다.");
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

function useYNUpdate() {
	
	confirm("사용여부를 변경하시겠습니까?");
	
	var use_yn = $("#use_yn option:selected").val(); //select
	var template_data_seq = $("#template_data_seq").val();
	
	var obj = {
			"use_yn": use_yn,
			"template_data_seq": template_data_seq
	}
	
	console.log(JSON.stringify(obj));
	
	$.ajax({
       	url: "<c:url value='/usr/MessagingTemplateUpdateUseYn.do' />",
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
     	   
            console.log(jsondata["data"]);
            
            if(jsondata["data"]==0){
                //로딩
                alert("성공적으로 수정 되었습니다.");
                $('#newstaffbtn').attr('disabled', false);
           		//close popup
                location.reload();
          	  
            }else{
          	  alert("수정에 실패했습니다.");
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

function tmpTypeUpdate() {
	
	confirm("템플릿 종류를 변경하시겠습니까?");
	
	var template_type = $("input[name=tmptype]:checked").val();
	var template_data_seq = $("#template_data_seq").val();
	
	var obj = {
			"template_type": template_type,
			"template_data_seq": template_data_seq
	}
	
	console.log(JSON.stringify(obj));
	
	$.ajax({
       	url: "<c:url value='/usr/MessagingTemplateUpdateTemplateType.do' />",
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
     	   
            console.log(jsondata["data"]);
            
            if(jsondata["data"]==0){
                //로딩
                alert("성공적으로 수정 되었습니다.");
                $('#newstaffbtn').attr('disabled', false);
           		//close popup
                location.reload();
          	  
            }else{
          	  alert("수정에 실패했습니다.");
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

function subjectUpdate() {
	
	confirm("제목을 변경하시겠습니까?");
	
	var subject = $("#subject").val();
	var template_data_seq = $("#template_data_seq").val();
	
	var obj = {
			"subject": subject,
			"template_data_seq": template_data_seq
	}
	
	console.log(JSON.stringify(obj));
	
	$.ajax({
       	url: "<c:url value='/usr/MessagingTemplateUpdateSubject.do' />",
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
     	   
            console.log(jsondata["data"]);
            
            if(jsondata["data"]==0){
                //로딩
                alert("성공적으로 수정 되었습니다.");
                $('#newstaffbtn').attr('disabled', false);
           		//close popup
                location.reload();
          	  
            }else{
          	  alert("수정에 실패했습니다.");
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
</script>
<script type="text/x-jsrender" id="selectTypeList">
<option value=''>업무분류</option>
	{{for data}}
		<option value='{{:code}}'>{{:codeNm}}</option>			
	{{/for}}
</script>
<script>
$(function(){
	ajaxCallGetNoParse("/usr/work.do", function(res){
		var template = $.templates("#selectTypeList"); // <!-- 템플릿 선언
    	var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
    	$(".templata_work_seq").html(htmlOutput);
	})
})
</script>

</head>
<body>

	<!--contents-->
	<div class="con-inner" style="padding-bottom: 80px;">

		<!--타이틀-->
		<h1 class="con-title">
			<ul>
				<li>전송</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>전송</li>
				<li><span class="dot"></span>템플릿관리</li>
			</ul>
		</h1>

		<!-- 내용 -->
		<div
			class="width-730px border-radius-5 background-f7fafc padding-bottom-30 box-shadow"
			style="margin: 20px auto;">
			<!-- 입력폼-->
			<div
				class="padding-rl-65 padding-top-25 padding-bottom-10 border-box">
				<h3 class="form_tit">템플릿 관리</h3>
				<form id="demo-form" data-parsley-validate="">
					<input type="text" id="template_data_seq" value="${templateinfo.template_data_seq}" hidden=""/>
					<table class="width-100 margin-bottom-40">
						<tr>
							<th class="width-125px">템플릿 관리자</th>
							<td><input type="text" id="" name="" required=""
								readonly="readonly"
								class="width-260px padding-left-20 border-box margin-right-10"
								value="${templateinfo.reg_id}" /></td>
						</tr>
						<tr>
							<c:if test="${workSeqRequiredFlag != 'ND'}">
								<th>업무분류</th>
								<td><select class="select_white width-120px templata_work_seq" id="serch_work_seq" style="margin-right:10px" value="${templateinfo.work_seq}">
									</select>
								<c:if test="${templateinfo.inspection_status eq '승인'}">
								<a onclick="workUpdate()"
									class="width-120px height-50px line-height-50px font-15px border-radius-5 background-8bc5ff font-fff text-center margin-right-10">업무분류변경</a>
								</c:if>
								</td>
							</c:if>
						</tr>
						<tr>
							<th>SenderKey</th>
							<td><input type="text" id="" name="" required=""
								<c:if test="${templateinfo.inspection_status != '승인반려'}"> readonly </c:if>
								class="width-260px padding-left-20 border-box"
								value="${templateinfo.sender_key}" /></td>
						</tr>
						<tr>
							<th>템플릿 코드</th>
							<td><input type="text" id="" name="" required=""
								readonly="readonly"
								class="width-260px padding-left-20 border-box"
								value="${templateinfo.template_code}" /></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td><select title="" id="use_yn" name="" required=""
								class="select_white width-260px">
									<option value="Y" <c:if test="${templateinfo.use_yn eq 'Y'}">selected</c:if>>사용</option>
									<option value="N" <c:if test="${templateinfo.use_yn eq 'N'}">selected</c:if>>사용안함</option>
							</select>
							<c:if test="${templateinfo.inspection_status eq '승인'}">
							<a onclick="useYNUpdate()"
								class="width-120px height-50px line-height-50px font-15px border-radius-5 background-8bc5ff font-fff text-center margin-right-10">사용여부변경</a>
							</c:if>
							</td>
						</tr>
						<tr>
							<th>템플릿 종류</th>
							<td>
								<div class="relative width-260px inline-block">
									<div class="absolute position-vertical-center position-left">
										<div class="radio-box font-16px font-053c72 margin-right-20">
											<div class="checkbox-small" style="margin-right: 10px;">
												<input type="radio" id="use1" name="tmptype" value="N" <c:if test="${templateinfo.template_type eq 'N'}">checked</c:if> /> <label
													for="use1"></label>
											</div>
											일반
										</div>
										<div class="radio-box font-16px font-053c72 margin-right-20">
											<div class="checkbox-small" style="margin-right: 10px;">
												<input type="radio" id="use2" name="tmptype" value="K" <c:if test="${templateinfo.template_type eq 'K'}">checked</c:if> /> <label
													for="use2"></label>
											</div>
											경조사
										</div>
										<div class="radio-box font-16px font-053c72 ">
											<div class="checkbox-small" style="margin-right: 10px;">
												<input type="radio" id="use3" name="tmptype" value="F" <c:if test="${templateinfo.template_type eq 'F'}">checked</c:if>/> <label
													for="use3"></label>
											</div>
											프리
										</div>
									</div>
								</div>
								<c:if test="${templateinfo.inspection_status eq '승인'}">
								<a onclick="tmpTypeUpdate()"
								class="width-120px height-50px line-height-50px font-15px border-radius-5 background-8bc5ff font-fff text-center margin-right-10">템플릿
									종류 변경</a>
									</c:if>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" id="subject" name="" required=""
								class="width-260px padding-left-20 border-box"
								value="${templateinfo.subject}" />
								<c:if test="${templateinfo.inspection_status eq '승인'}">
								<a onclick="subjectUpdate()"
								class="width-120px height-50px line-height-50px font-15px border-radius-5 background-8bc5ff font-fff text-center margin-right-10">제목
									변경</a>
								</c:if>
							</td>
						</tr>
						<tr>
							<th>템플릿 이름</th>
							<td><input type="text" id="" name="" required="" <c:if test="${templateinfo.inspection_status != '승인반려'}"> readonly </c:if>
								 class="width-100 padding-left-20 border-box"
								value="${templateinfo.template_name}" /></td>
						</tr>
						<tr>
							<th>템플릿 내용</th>
							<td><textarea
									class="width-100 padding-left-20 border-box height-100px"
									style="line-height: 1.8; padding: 5px; overflow: auto;" <c:if test="${templateinfo.inspection_status != '승인반려'}"> readonly </c:if>
									>${templateinfo.template_content}</textarea></td>
						</tr>
						<tr>
							<th>버튼</th>
							<td><%-- <input type="text" id="" name="" required=""
								<c:if test="${templateinfo.inspection_status != '승인반려'}"> readonly </c:if> class="width-100 padding-left-20 border-box"
								value="1개사용" /> --%></td>
						</tr>
						<tr>
							<th></th>
							<td class="tbodyData">
							</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td><input type="text" id="" name="" required=""
								value="${templateinfo.reg_date}" readonly="readonly"
								class="width-260px padding-rl-20 border-box" /></td>
						</tr>
						<tr>
							<th>상태</th>
							<td colspan="2"><input type="text" id="" name="" required=""
								readonly="readonly" class="width-260px padding-rl-20 border-box"
								value="${templateinfo.inspection_status}" /></td>
						</tr>
					</table>
				</form>
			</div>

			<!-- 이력 -->
			<div
				class="padding-rl-65 padding-bottom-10 border-box padding-top-15">
				<h3 class="form_tit">변경 이력 보기</h3>
				<form>
					<table class="width-100 margin-top-20 margin-bottom-40">
						<tbody class="width-100">
							<tr>
								<th class="text-center padding-right-10 border-box">작성일</th>
								<th class="text-center padding-right-10 border-box">부서</th>
								<th class="text-center padding-right-10 border-box">작성자</th>
								<th class="text-center padding-right-10 border-box">내용</th>
							</tr>
						</tbody>

					</table>
				</form>
			</div>

			<!-- 검수결과 -->
			<div
				class="padding-rl-65  padding-top-15 padding-bottom-10 border-box">
				<h3 class="form_tit">카카오 검수 결과</h3>
				<form>
					<table class="width-100 margin-top-20 margin-bottom-40">
						<tbody class="width-100">
							<tr>
								<th class="text-center padding-right-10 border-box">검수일</th>
								<th class="text-center padding-right-10 border-box">상태</th>
								<th class="text-center padding-right-10 border-box">내용</th>
							</tr>
							<c:forEach var="comment" items="${tmpComment}" varStatus="status">
							    <tr>
								<td class="padding-right-10 border-box" style="width:123px;"><input type="text"
									id="" name="" required="" readonly="readonly" style="width:123px;"
									class="padding-rl-20 border-box text-center" value="${comment.created_at }" />
								</td>
								<td class="padding-right-10 border-box" style="width:70px;"><input type="text"
									id="" name="" required="" readonly="readonly" style="width:70px;"
									class="padding-rl-20 border-box text-center" value="${comment.status }" /></td>
								<td class="border-box"><input type="text" id="" name=""
									required="" readonly="readonly"
									class="padding-rl-20 border-box text-center"
									value="${comment.content }" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
			</div>

			<!-- 버튼 -->
			<div class="btn-center margin-bottom-30">
			<c:if test="${templateinfo.inspection_status eq '승인반려'}">
				<a class="background-8bc5ff font-fff border-radius-5" onclick="updateTemplet();">수정</a>
			</c:if>
			<a class="background-8bc5ff font-fff border-radius-5" href="javascript:history.back();">확인</a>
			</div>
		</div>
	</div>
</body>
</html>
