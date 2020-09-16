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
var p_seq = 0;
var b_seq = 0;

$(document).ready(function() {
	var butten = ${templateinfo.template_buttons};
	console.log(butten);
	
	var template = $.templates("#selectRstList"); // <!-- 템플릿 선언
    var htmlOutput = template.render(butten); // <!-- 렌더링 진행 -->
    $(".tbodyData").html(htmlOutput);

})

function updateTemplet() {

		$('#demo-form').parsley().validate();
		if (!$('#demo-form').parsley().isValid()) {
			return;
		}

		var work_seq = $("#work_seq option:selected").val(); //
		var sender_key = $("#senderkey option:selected").val(); //text
		var template_type = $('[name=tmptype]:checked').val(); //text
		var subject = $("#subject").val(); //text
		var tmp_name = $("#tmp_name").val(); //select
		var tmp_subject = $("#tmp_subject").val(); //text
		var tmp_code = $("#tmpCode").val();
		var template_variables = $("#tmpVar").val();
		var template_data_seq = $("#template_data_seq").val();
		
		var sortArray = new Array();
	   	var sorts = $(".butten");
		
		for(var i = 0 ; i < p_seq ; i++){
	   		var butten_name = sorts.eq(i).find("input[type=text][name='butten_name']");
	   		var butten_link_mo = sorts.eq(i).find("input[type=text][name='butten_link_mo']");
	   		var butten_link_pc = sorts.eq(i).find("input[type=text][name='butten_link_pc']");;
	   		var butten_link_and = sorts.eq(i).find("input[type=text][name='butten_link_and']");;
	   		var butten_link_Ios = sorts.eq(i).find("input[type=text][name='butten_link_ios']");;
	   		var butten_link_type = sorts.eq(i).find("input[type=text][name='butten_link_type']");;
	   		var obj = {
	   				"name": butten_name.val(),
	   				"linkMo": butten_link_mo.val(),
	   				"linkPc": butten_link_pc.val(),
	   				"linkAnd": butten_link_and.val(),
	   				"linkIos": butten_link_Ios.val(),
	   				"linkType": butten_link_type.val(),
	   				"ordering": i+1
	   		}
	   		sortArray.push(obj);
	   	}

		//alert(reg_user_name);
		var obj = {
			"work_seq" : work_seq,
			"sender_key" : sender_key,
			"template_type" : template_type,
			"subject" : subject,
			"template_modify_name" : tmp_name,
			"template_modify_content" : tmp_subject,
			"template_modify_buttons" : JSON.stringify(sortArray),
			"template_code" : tmp_code,
			"template_modify_variables": template_variables,
			"template_data_seq":template_data_seq
		};
		
		console.log(JSON.stringify(obj));
		
		$.ajax({
			url : "<c:url value='/updateTemplate.do' />",
			type : "POST",
			data : obj,
			dataType : "json",
			beforeSend : function() {
				$('.wrap-loading').removeClass('display-none');
				$('#newstaffbtn').attr('disabled', false);
			},
			complete : function() {
				$('.wrap-loading').addClass('display-none');
				$('#newstaffbtn').attr('disabled', false);
			},
			success : function(jsondata) {

				alert(jsondata["data"]);

				if (jsondata["data"] == 0) {
					//로딩
					alert('Template가 성공적으로 수정되었습니다');
					location.href  ="/usr/template";
					//close popup
				} else {
					toastr.error('양식을 확인해주세요.');
				}
			},
			error : function(request, status, error) {

				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error)
			}
		});
	}
	
var arrTypeHtml = [
	"<span id='t_btn_name'><input type='text' name='butten_link_type' value='BK' hidden><input type='text' placeholder='버튼명' id='link_name' name='butten_name' size='14' maxlength='28' value='' style='height:24px;'></span>",
	"<span id='t_btn_name_1'><input type='text' name='butten_link_type' value='MD' hidden><input type='text' placeholder='버튼명' id='link_name_1' name='butten_name' size='14' maxlength='28' value='' style='height:24px;'></span>",
	"<input type='text' name='butten_link_type' value='AL' hidden><input type='text' placeholder='버튼명' id='link_andr_name' name='butten_name' size='14' maxlength='28' value='' style='height:24px;'>",
	"<input type='text' name='butten_link_type' value='WL' hidden><input type='text' placeholder='버튼명' id='link_mo_name' name='butten_name' size='14' maxlength='28' value='' style='height:24px;'>",
	"<span id='t_btn_input_DS'><input type='text' name='butten_link_type' value='DS' hidden>※ '배송 조회하기' 고정 문구<input type='text' name='butten_name' value='배송 조회하기' hidden></span>",
	"<span id='t_btn_input_WL'>Mobile : <input type='text' id='link_mo' name='butten_link_mo' style='width:150px; height:24px;' maxlength='500' value=''><br>PC(옵션) : <input type='text' id='link_pc' name='butten_link_pc' style='width:150px; height:24px;' maxlength='500' value=''></span>",
	"<span id='t_btn_input_AL'>URL(Android) : <input type='text' id='link_andr' name='butten_link_and' style='width:150px; height:24px;' maxlength='500' value=''><br>URL(iOS) : <input type='text'id='link_ios'  name='butten_link_ios' style='width:150px; height:24px;' maxlength='500' value=''></span>"
];
function addButton() {
	var addButtonHtml = "";
	console.log(p_seq);
	if(p_seq==5){
		toastr.error("버튼은 5개까지만 추가 가능합니다.");
		return false;
	}
	addButtonHtml = "<tr id='tr"+b_seq+"' class='butten'><td>"+ optLinkTypeList(b_seq) +"</td><td id='c_name" + b_seq +"'></td><td id='c" + b_seq +"'></td><td><a onclick='javascript:removeButton(this);' class='icon_delete'>삭제</a></td></tr>"
	$("#t_btn_1").append(addButtonHtml);
	
	p_seq = p_seq+1;
	b_seq = b_seq+1;
}

function removeButton(el) {
		$(el).parents("tr").remove();
		p_seq = p_seq-1;
		console.log(p_seq);
}

function chgBtntype(b_seq) {
	var btn_name = "";
	var buttonsHtml = "";
	var s_index = $("#link_type"+b_seq+"").val();
	console.log(s_index);
	console.log(arrTypeHtml[s_index]);
	console.log($("td[id=c_name"+b_seq+"]").html(arrTypeHtml[s_index]));
	
	$("td[id=c_name"+b_seq+"]").html(arrTypeHtml[s_index]); 
	
	console.log(s_index);
	if(s_index==3){
		console.log(s_index);
		$("td[id=c"+b_seq+"]").html(arrTypeHtml[5]); 
	}else if(s_index==2){
		console.log(s_index);
		$("td[id=c"+b_seq+"]").html(arrTypeHtml[6]); 
	}else if(s_index==''){
		console.log(s_index);
		$("td[id=c"+b_seq+"]").html(""); 
		$("td[id=c_name"+b_seq+"]").html(""); 
	}else{
		$("td[id=c"+b_seq+"]").html(""); 
	}
}

function optLinkTypeList(b_seq) {
	var optLinkTypeList = "<select class='select_white_small width-130px' style='background-color:#f9fbfd;' id='link_type"+b_seq+"' name='butten_link_type' onchange='javascript:chgBtntype("+b_seq+");'><option value=''>=선택=</option><option value='4'>배송조회</option><option value='3'>웹링크</option><option value='2'>앱링크</option><option value='0'>봇키워드</option><option value='1'>메시지전달</option></select>";
	var repOptLinkTypeList = optLinkTypeList.replace(/\*\*TEMPSEQ\*\*/g, b_seq);
	repOptLinkTypeList = repOptLinkTypeList.replace(/\*\*BTNSEQ\*\*/g, b_seq);
	return repOptLinkTypeList;
}

function code_check() {
	
	$('#tmpCode').parsley().validate();
	if (!$('#tmpCode').parsley().isValid()) {
		return;
	}
	
	var checkcode = $("#tmpCode").val(); //text
	var obj = {
        	"checkcode": checkcode
	};
 	$.ajax({
    	url: "<c:url value='/tmpCodeCheck.do' />",
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
                   toastr.success('사용 가능한 코드입니다.');
           }else{
         	  toastr.error("중복되는 코드가 있습니다.");
           }
    	},
    	error: function(request,status,error){
    		alert("일치하는 정보가 없습니다.");
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
								<td><select class="select_white width-120px templata_work_seq" id="work_seq" style="margin-right:10px" value="${templateinfo.work_seq}">
									</select>
								</td>
							</c:if>
						</tr>
						<tr>
							<th>SenderKey</th>
							<td><select title="" id="senderkey"
								class="select_white width-260px" required=""
								data-parsley-required="false" data-parsley-trigger="change">
							<c:forEach var="senderKey" items="${senderKey}"
								varStatus="status">
								<option value="${senderKey.senderKey}"
									${senderKey.senderKey == provider ? 'selected="selected"' : '' }>${senderKey.senderKey}</option>
							</c:forEach>
							</select></td>
						</tr>
						<tr>
							<th>템플릿 코드</th>
							<td><input type="text" id="tmpCode" name="" required=""
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
							</td>
						</tr>
						<tr style="height:50px;">
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
							</td>
						</tr>
						<tr>
							<th>변수 명</th>
							<td><input type="text" id="tmpVar" name=""
								placeholder="\#{변수명} 으로 작성, 두개 이상일시 || 로 구분해주세요." value="${templateinfo.template_variables}"
								class="padding-left-20 border-box" data-parsley-trigger="change"/></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" id="subject" name="" required=""
								class="width-260px padding-left-20 border-box"
								value="${templateinfo.subject}" />
							</td>
						</tr>
						<tr>
							<th>템플릿 이름</th>
							<td><input type="text" id="tmp_name" name="" required=""
								 class="width-100 padding-left-20 border-box"
								value="${templateinfo.template_name}" /></td>
						</tr>
						<tr>
							<th>템플릿 내용</th>
							<td><textarea id="tmp_subject"
									class="width-100 padding-left-20 border-box height-100px"
									style="line-height: 1.8; padding: 5px; overflow: auto;"
									>${templateinfo.template_content}</textarea></td>
						</tr>
					</table>
				</form>
				<div class="width-100">
					<table class="con_tb width-100" cellpadding="0" cellspacing="0" id="t_btn_1"
						border="0">
						<thead>
							<tr>
								<th class="width-30">버튼타입</th>
								<th class="width-20">버튼명</th>
								<th class="width-35">링크</th>
								<th class="width-15">관리</th>
							</tr>
						</thead>
						<tbody id="t_btn_1">
						</tbody>
					</table>

					<!--추가 버튼-->
					<div class="pop_btn" style="margin-bottom: 40px">
						<a class="background-8bc5ff border-8bc5ff font-fff"
							style="width: 120px;" onclick="addButton();">버튼추가</a>
					</div>
				</div>
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
				<a class="background-053c72 font-fff border-radius-5" onclick="updateTemplet();">수정</a>
				<a class="background-8bc5ff font-fff border-radius-5" href="javascript:history.back();">취소</a>
			</div>
		</div>
	</div>
</body>
</html>
