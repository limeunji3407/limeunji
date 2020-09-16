<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
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
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javaScript" language="javascript" defer="defer"> 
var availableTags = [
    "ActionScript",
    "AppleScript",
    "Asp",
    "BASIC",
    "C",
    "C++",
    "Clojure",
    "COBOL",
    "ColdFusion",
    "Erlang",
    "Fortran",
    "Groovy",
    "Haskell",
    "Java",
    "JavaScript",
    "Lisp",
    "Perl",
    "PHP",
    "Python",
    "Ruby",
    "Scala",
    "Scheme"
  ];
$(document).ready(function() {
	
	$(".user-nm-add").click(function(){
		var emplyrId = $("#tags").val();
		var emplyrNm = $("#tags option:checked").text();
		
		var beforeVal = $("input[name='userlist']").val();
		if(beforeVal){
			$("input[name='userlist']").val(beforeVal + "," + emplyrId);
		}else{
			$("input[name='userlist']").val(emplyrId);
		}
		
		var beforeText = $(".user-list").text();
		if(beforeText){
			$(".user-list").text(beforeText + ", " + emplyrNm)
		}else{
			$(".user-list").text(emplyrNm)
		}
	})
	$("#part_id").change(function(){
		var orgnztId = $(this).val();
		
		$.ajax({
        	url: "/getUserListTotal?orgnztId="+orgnztId,
        	type: "GET",
            dataType: "json",
        	success: function(jsondata){
        		var str = "<option value=''>선택해주세요.</option>";
        		for(var i = 0 ; i < jsondata.data.length ; i++){
        			str += "<option value='"+jsondata.data[i].emplyrId+"'>"+jsondata.data[i].emplyrNm+"</option>";
        		}
        		$("#tags").html(str)
        	}
    	});
		
		
	})
	
	$('input:checkbox[name="usrcheck"]').click(function(){
		console.log("-----click-------" + $(this).prop('checked'));
		if($(this).prop('checked')){
			$('input:checkbox[name="usrcheck"]').prop('checked', false);
			$(this).prop('checked', true);			
		}
	});
	 $( "#check_user" ).autocomplete({
	      source: availableTags
	 });
	$('#roleSaveBtn').on('click', function(){  
		$('#roleSaveBtn').attr('disabled', true);	
		var usrcheck = $('input:checkbox[name="usrcheck"]:checked').val(); 
		var checktype = usrcheck;
		var user = [];
		var part = [];
        var url = "";
        if(checktype == 1){
			url = "/mng/updtMsgRole.do";
		} 
        else if(checktype == 2){ //부서목록
			url = "/mng/updtMsgRolePart.do";
			
			if(!$("#part_id").val()){
				alert("부서를 선택해주세요.")
				return;
			}
		}
        else if(checktype == 3){ //사용자모곡
			url = "/mng/updtMsgRoleUser.do";
			
			if(!$("input[name='userlist']").val()){
				alert("사용자를 추가해주세요.")
				return;
			}
			
		}else{
			alert("추가유형을 선택해주세요.")
			return;
		}
		
	    var sms = $('input:checkbox[id="a-y"]').is(":checked")? 1:0;	
	    var lms = $('input:checkbox[id="b-y"]').is(":checked")? 1:0;	
	    var mms = $('input:checkbox[id="c-y"]').is(":checked")? 1:0;	
	    var notice = $('input:checkbox[id="d-y"]').is(":checked")? 1:0;
	    var noticelms = $('input:checkbox[id="e-y"]').is(":checked")? 1:0;
	    var friend = $('input:checkbox[id="f-y"]').is(":checked")? 1:0;		
	    var friendlms = $('input:checkbox[id="g-y"]').is(":checked")? 1:0;
	    var friendmms = $('input:checkbox[id="h-y"]').is(":checked")? 1:0;
	    var mo = $('input:checkbox[id="i-y"]').is(":checked")? 1:0;
	    var orgnztId = $("#part_id").val();
	    user = $("input[name='userlist']").val().split(",");
	    
	    if(!$("input[name='userlist']").val()){
	    	user = []
	    }
	    
		var obj = { 
			"checktype" : checktype,
			"userlist" : user,
			"partlist" : part,
			"sms": sms, 
			"lms" : lms,
			"mms" : mms,
			"notice" : notice,
			"noticelms" : noticelms,
			"friend" : friend,
			"friendlms" : friendlms,
			"friendmms" : friendmms,
			"mo" : mo,
			"orgnztId":orgnztId
		};
		
		
		
		var contentType = "application/x-www-form-urlencoded";
		if(checktype == 3){ //사용자모곡
			contentType = "application/json";
			obj = JSON.stringify(obj);
		}
		
     	$.ajax({
        	url: "<c:url value='" + url + "' />",
        	type: "POST",
            data: obj,
            contentType: contentType,
            dataType: "json",
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
        		$('#priceBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#priceBtn').attr('disabled', false);
            },
        	success: function(jsondata){
                   toastr.success('메세지권한이 성공적으로 변경되었습니다'); 
        		$('#priceBtn').attr('disabled', false);
            	
        	},
        	error: function(request,status,error){
        		console.log("[ajax error]");
        		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
            	$('#result').text(jsondata);
        		$('#priceBtn').attr('disabled', false);
        	}
    	});
	});
	
	$('#cashSaveBtn').on('click', function(){ 
		var usrcheck = $('input:checkbox[name="usrcheck"]:checked').val(); 
		var checktype = usrcheck;
		
// 		$('#cashSaveBtn').attr('disabled', true);
		var usercash = $('input:text[name="user"]').val(); 
		
		var user = [];
		user = $("input[name='userlist']").val().split(",");
		
	 	if(!$("input[name='userlist']").val()){
	    	user = []
	    }
	 	
	 	var orgnztId = $("#part_id").val();
		var obj = {
				"usercash" : usercash,
				"userlist" : user,
				"orgnztId":orgnztId
		}
		
	   if(checktype == 1){
			url = "/mng/updtMsgCash.do";
		} 
        else if(checktype == 2){ //부서목록
			url = "/mng/updtMsgCashPart.do";
			if(!$("#part_id").val()){
				alert("부서를 선택해주세요.")
				return;
			}
		}
        else if(checktype == 3){ //사용자모곡
			url = "/mng/updtMsgCashUser.do";
			if(!$("input[name='userlist']").val()){
				alert("사용자를 추가해주세요.")
				return;
			}
		}else{
			alert("추가유형을 선택해주세요.")
			return;
		}
		
		
		var contentType = "application/x-www-form-urlencoded";
		if(checktype == 3){ //사용자모곡
			contentType = "application/json";
			obj = JSON.stringify(obj);
		}
		
     	$.ajax({
        	url: url,
        	type: "POST",
            data: obj,
            dataType: "json",
            contentType: contentType,
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
        		$('#roleSaveBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#roleSaveBtn').attr('disabled', false);
            },
        	success: function(jsondata){
                $('.wrap-loading').addClass('display-none');
                   toastr.success('성공적으로 수정되었습니다'); 

                $('.wrap-loading').addClass('display-none');
        		$('#roleSaveBtn').attr('disabled', false);
            	
        	},
        	error: function(request,status,error){
        		console.log("[ajax error]");
        		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
            	$('#result').text(jsondata);
                $('.wrap-loading').addClass('display-none');
        		$('#roleSaveBtn').attr('disabled', false);
        	}
    	});
	});
	 

});
</script>
</head>
<body style= "padding-bottom: 100px;">
<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>일괄부여</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>시스템관리</li>
						<li><span class="dot"></span>일괄부여</li>
					</ul>
				</h1>

				<!-- 검색하기 -->
				<div  class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
				
					<!-- 검색설정 -->
					<div class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">
					
						<div class="font-16px inline-block margin-right-40 line-height-30px">
							<div class="checkbox_big_blue" style="margin-right:5px">
								<input type="checkbox" id="check_all" name="usrcheck"  value="1"/>
								<label for="check_all"></label>
							</div> 전체
						</div>

						<div class="font-16px inline-block margin-right-5 line-height-30px">
							<div class="checkbox_big_blue" style="margin-right:5px">
								<input type="checkbox" id="check_part" name="usrcheck"  value="2"  />
								<label for="check_part"></label>
							</div> 부서
						</div>
						<!-- 부서 셀렉박스-->
						<select class="select_blank_lightblue width-120px" style="margin-right:40px" title="part_id" id="part_id" name="part_id">
							<option selected value="0">부서선택</option>
							<c:forEach var="part_id" items="${partIdList}"
										varStatus="status">
										<option value="${part_id.orgnztId}"
											${part_id.orgnztId == provider ? 'selected="selected"' : '' }>${part_id.orgnztNm}</option>
							</c:forEach>
						</select>
						<div class="font-16px inline-block margin-right-5 line-height-30px">
							<div class="checkbox_big_blue" style="margin-right:5px">
								<input type="checkbox" id="check_user" name="usrcheck"  value="3"  />
								<label for="check_user"></label>
							</div> 사용자
						</div>
						<select id="tags"  class="select_blank_lightblue input_blank width-140px border-box border-8bc5ff" style="margin-right:10px">
						</select>

						<!--검색-->
						<div class="inline-block width-260px">
							<input type="text" name="userlist" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" style="display: none"/>
							<span class="user-list"></span>
							<a class="user-nm-add width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">추가</a>
						</div>
						
				 	</div>
					<!-- //검색설정 -->
					
					
					
					<div id="result"></div>
					
					
					<!-- 검색결과 -->
					<div class="background-fff padding-top-20 padding-bottom-40 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
						<div class="width-300px margin-auto padding-top-40">
							<h3 class="form_tit">사용자 메세징 권한</h3>
							<table class="width-100 margin-top-20 margin-bottom-20">
								<colgroup>
									<col style="width:190px" />
									<col style="width:" />
								</colgroup>
								<tr>
									<th class="text-center">유형</th>
									<th class="text-center">일괄부여</th>
								</tr>
								<tr>
									<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="단문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-center">
										<div class="radio_box_check">
											<div class="checkbox_big_blue">
												<input type="checkbox" id="a-y" name="psms" <c:if test="${sms eq 1}"><c:out value="checked" /></c:if> />
												<label for="a-y"><span></span></label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="장문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-center">
										<div class="radio_box_check">
											<div class="checkbox_big_blue">
												<input type="checkbox" id="b-y" name="plms" <c:if test="${lms eq 1}"><c:out value="checked" /></c:if> />
												<label for="b-y"><span></span></label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="멀티" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-center">
										<div class="radio_box_check">
											<div class="checkbox_big_blue">
												<input type="checkbox" id="c-y" name="radio-c" <c:if test="${mms eq 1}"><c:out value="checked" /></c:if> />
												<label for="c-y"><span></span></label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="알림톡" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-center">
										<div class="radio_box_check">
											<div class="checkbox_big_blue">
												<input type="checkbox" id="d-y" name="radio-d" <c:if test="${notice eq 1}"><c:out value="checked" /></c:if> />
												<label for="d-y"><span></span></label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="알림톡 대체장문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-center">
										<div class="radio_box_check">
											<div class="checkbox_big_blue">
												<input type="checkbox" id="e-y" name="radio-e" <c:if test="${noticelms eq 1}"><c:out value="checked" /></c:if>/>
												<label for="e-y"><span></span></label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="친구톡" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-center">
										<div class="radio_box_check">
											<div class="checkbox_big_blue">
												<input type="checkbox" id="f-y" name="radio-f"   <c:if test="${friend eq 1}"><c:out value="checked" /></c:if>/>
												<label for="f-y"><span></span></label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="친구톡 대체장문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-center">
										<div class="radio_box_check">
											<div class="checkbox_big_blue">
												<input type="checkbox" id="g-y" name="radio-g" <c:if test="${friendlms eq 1}"><c:out value="checked" /></c:if>/>
												<label for="g-y"><span></span></label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="친구톡 대체멀티" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-center">
										<div class="radio_box_check">
											<div class="checkbox_big_blue">
												<input type="checkbox" id="h-y" name="radio-h" <c:if test="${friendmms eq 1}"><c:out value="checked" /></c:if> />
												<label for="h-y"><span></span></label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="MO" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-center">
										<div class="radio_box_check">
											<div class="checkbox_big_blue">
												<input type="checkbox" id="i-y" name="radio-i" <c:if test="${mo eq 1}"><c:out value="checked" /></c:if> />
												<label for="i-y"><span></span></label>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
						<!--버튼-->
						<div class="btn-center margin-bottom-40">
							<a class="background-053c72 font-fff" id="roleSaveBtn">저장</a>
						</div>



						<div class="width-730px margin-auto padding-top-40 border-box" style="padding-left:215px">
							<h3 class="form_tit">캐시</h3>
							<table class="width-100 margin-bottom-20">
								<colgroup>
									<col style="width:120px" />
									<col style="width:" />
								</colgroup>
								<tr>
									<th class="text-left">부여캐시</th>
									<td class="padding-right-10 border-box"><input type="text" name="user" id="user" placeholder="" value="<c:out value="${usercash}" />" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
								</tr>
							</table>
						</div>
						<!--버튼-->
						<div class="btn-center">
							<a class="background-053c72 font-fff" id="cashSaveBtn">저장</a>
						</div>
					</div>
					<!-- //검색결과 -->
				</div>
			</div>
</body>
</html>
