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

<script type="text/javaScript" language="javascript" defer="defer"> 
function showLoadingBar() { var maskHeight = $(document).height(); var maskWidth = window.document.body.clientWidth; var mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>"; var loadingImg = ''; loadingImg += "<div id='loadingImg' style='position:absolute; left:50%; top:40%; display:none; z-index:10000;'>"; loadingImg += " <img src='./img/loading.gif'/>"; loadingImg += "</div>"; $('body').append(mask).append(loadingImg); $('#mask').css({ 'width' : maskWidth , 'height': maskHeight , 'opacity' : '0.3' }); $('#mask').show(); $('#loadingImg').show(); }
function hideLoadingBar() { $('#mask, #loadingImg').hide(); $('#mask, #loadingImg').remove(); }

$(document).ready(function() {

	$('#roleSaveBtn').on('click', function(){  
		
		$('#roleSaveBtn').attr('disabled', true);		
		
	    var lms = $('input:checkbox[name="lms"]').is(":checked");	
	    var mms = $('input:checkbox[name="mms"]').is(":checked");	
	    var notice = $('input:checkbox[name="notice"]').is(":checked");
	    var noticelms = $('input:checkbox[name="noticelms"]').is(":checked");
	    var friend = $('input:checkbox[name="friend"]').is(":checked");		
	    var friendlms = $('input:checkbox[name="friendlms"]').is(":checked");
	    var friendmms = $('input:checkbox[name="friendmms"]').is(":checked");
	    var mo = $('input:checkbox[name="mo"]').is(":checked");
		
	    //alert( sms + "--:--" + lms + "--:--" + mms + "--:--" + notice + "--:--" + noticelms + "--:--" + friend + "--:--" + friendlms + "--:--" + friendmms );
		var obj = {
			"lms" : Number(lms),
			"mms" : Number(mms),
			"notice" : Number(notice),
			"noticelms" : Number(noticelms),
			"friend" : Number(friend),
			"friendlms" : Number(friendlms),
			"friendmms" : Number(friendmms),
			"mo" : Number(mo)  
		};
        
		//alert(JSON.stringify(obj));return;
		
     	$.ajax({
        	url: "<c:url value='/mng/insertrole.do' />",
        	type: "POST",
            data: obj,
            dataType: "json",
            success: function(jsondata){
            	console.log(jsondata["data"]);
	            
	            if(jsondata["data"]==0){
	                //로딩
	                toastr.success("성공적으로 변경 되었습니다.");
	          	  
	            }else{
	            	console.log("변경 할 수 없습니다.");
	            }
        	},
        	error: function(request,status,error){
        		console.log("[ajax error]");
        		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
        	}
    	});
	});
	
	$('#partSaveBtn').on('click', function(){ 
		
		$('#partSaveBtn').attr('disabled', true);
		//alert($("#isUpdate").val()); 
		var partcash = $('#updpartcash').val();
	 
		var obj = {
				"partcash" : Number(partcash)
		}
		//alert(JSON.stringify(obj));
     	$.ajax({
        	url: "<c:url value='/mng/insMsgPartCash.do' />",
        	type: "POST",
            data: obj,
            dataType: "json",
            success: function(jsondata){

				console.log(jsondata["data"]);
	            
	            if(jsondata["data"]==0){
	                //로딩
	                toastr.success("성공적으로 변경 되었습니다.");
	          	  
	            }else{
	            	console.log("변경 할 수 없습니다.");
	            }
            	
        	},
        	error: function(request,status,error){
        		console.log("[ajax error]");
        		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
        	}
    	});
	});

	$('#userSaveBtn').on('click', function(){ 
		
		$('#userSaveBtn').attr('disabled', true);
		var usercash = $('#updusercash').val(); 
	 
		var obj = {
				"usercash" : Number(usercash)
		}
		$.ajax({
        	url: "<c:url value='/mng/insMsgUsrCash.do' />",
        	type: "POST",
            data: obj,
            dataType: "json",success: function(jsondata){

				console.log(jsondata["data"]);
	            
	            if(jsondata["data"]==0){
	                //로딩
	                toastr.success("성공적으로 변경 되었습니다.");
	          	  
	            }else{
	            	console.log("변경 할 수 없습니다.");
	            }
            	
        	},
        	error: function(request,status,error){
        		console.log("[ajax error]");
        		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
        	}
    	});
	});
});
</script>
</head>
<body>
	
							<input type="radio" name="standard_tabmenu" id="tabmenu-2">
							<label for="tabmenu-2">권한 및 기본건수 설정</label>
							<div class="tabCon">
								<div class="width-100 padding-top-60 margin-bottom-100">
									<div class="width-100  padding-rl-65 padding-tb-40 background-f7fafc border-box box-shadow">
										<table class="width-100" border="0">
											<colgroup>
												<col style="width:50%" />
												<col style="width:50%" />
											</colgroup>
											<tr>
												<td class="text-center vertical-top padding-right-30 border-box border-right-d3e6ff" rowspan="2">
													<h3 class="form_tit">사용자 메세징 권한</h3>
													<table class="width-100 margin-top-20 margin-bottom-20">
														<colgroup>
															<col style="width:42%" />
															<col style="width:29%" />
															<col style="width:29%" />
														</colgroup>
														<tr>
															<th class="text-center">유형</th>
															<th class="text-center">현재 기본권한</th>
															<th class="text-center">변경 기본권한</th>
														</tr>
														<tr>
															<td class="padding-right-10 border-box"><input type="text" name="" readonly placeholder="" value="단문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
															
															
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_1" onclick="return false;" name="체크" <c:if test="${roleVO.sms eq 1}"><c:out value="checked" /></c:if> />
																	<label for="check_1"></label>
																</div> 
															</td>
														</tr>
														<tr>
															<td class="padding-right-10 border-box"><input type="text" name="" readonly  placeholder="" value="장문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_3" onclick="return false;" name="체크"  <c:if test="${roleVO.lms eq 1}"><c:out value="checked" /></c:if> />
																	<label for="check_3"></label>
																</div> 
															</td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_4" name="lms" />
																	<label for="check_4"></label>
																</div> 
															</td>
														</tr>
														<tr>
															<td class="padding-right-10 border-box"><input type="text" name="" readonly placeholder="" value="멀티" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_5" onclick="return false;"  name="체크" <c:if test="${roleVO.mms eq 1}"><c:out value="checked" /></c:if> />
																	<label for="check_5"></label>
																</div> 
															</td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_6"name="mms" />
																	<label for="check_6"></label>
																</div> 
															</td>
														</tr>
														<tr>
															<td class="padding-right-10 border-box"><input type="text" name="" readonly placeholder="" value="알림톡" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_7" onclick="return false;"  name="체크" <c:if test="${roleVO.notice eq 1}"><c:out value="checked" /></c:if> />
																	<label for="check_7"></label>
																</div> 
															</td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_8" name="notice" />
																	<label for="check_8"></label>
																</div> 
															</td>
														</tr>
														<tr>
															<td class="padding-right-10 border-box"><input type="text" name="" readonly placeholder="" value="알림톡 대체장문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_9" onclick="return false;"  name="체크" <c:if test="${roleVO.noticelms eq 1}"><c:out value="checked" /></c:if> />
																	<label for="check_9"></label>
																</div> 
															</td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_10"  name="noticelms" />
																	<label for="check_10"></label>
																</div> 
															</td>
														</tr>
														<tr>
															<td class="padding-right-10 border-box"><input type="text" name="" readonly placeholder="" value="친구톡" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_11" onclick="return false;"  name="체크" <c:if test="${roleVO.friend eq 1}"><c:out value="checked" /></c:if> />
																	<label for="check_11"></label>
																</div> 
															</td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_12"  name="friend" />
																	<label for="check_12"></label>
																</div> 
															</td>
														</tr>
														<tr>
															<td class="padding-right-10 border-box"><input type="text" name="" readonly placeholder="" value="친구톡 대체장문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_13" onclick="return false;"  name="체크" <c:if test="${roleVO.friendlms eq 1}"><c:out value="checked" /></c:if> />
																	<label for="check_13"></label>
																</div> 
															</td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_14" name="friendlms" />
																	<label for="check_14"></label>
																</div> 
															</td>
														</tr>
														<tr>
															<td class="padding-right-10 border-box"><input type="text" name="" readonly placeholder="" value="친구톡 대체멀티" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_15" onclick="return false;" name="체크" <c:if test="${roleVO.friendmms eq 1}"><c:out value="checked" /></c:if> />
																	<label for="check_15"></label>
																</div> 
															</td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_16" name="friendmms" />
																	<label for="check_16"></label>
																</div> 
															</td>
														</tr>
														<tr>
															<td class="padding-right-10 border-box"><input type="text" name="" readonly placeholder="" value="MO" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_17" onclick="return false;" name="체크" <c:if test="${roleVO.mo eq 1}"><c:out value="checked" /></c:if> />
																	<label for="check_17"></label>
																</div> 
															</td>
															<td class="text-center">
																<div class="checkbox_big_blue">
																	<input type="checkbox" id="check_18" name="mo" />
																	<label for="check_18"></label>
																</div> 
															</td>
														</tr>
													</table>
													<!--버튼-->
													<div class="btn-center">
														<a class="background-053c72 font-fff" id="roleSaveBtn">저장</a>
													</div>
												</td>
												<td class="vertical-top padding-left-30 padding-bottom-30 border-bottom-d3e6ff border-box">
													<h3 class="form_tit">부서 생성시 기본 캐시</h3>
													
													<form id="part-form" data-parsley-validate="">
													<table class="width-100 margin-top-20">
														<colgroup>
															<col style="width:50%" />
															<col style="width:50%" />
														</colgroup>
														<tr>
															<th class="text-center">현재 기본 캐시</th>
															<th class="text-center">변경 기본 캐시</th>
														</tr>
														<tr>
															<td class="padding-right-5 border-box"><input type="text" name="partcash_ccur" placeholder="" value="<c:out value="${roleVO.partcash}" />" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                            				<td class="padding-left-5 border-box"><input type="text" id="updpartcash" placeholder="단가를 입력하세요." value="" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" required="" data-parsley-required="true" data-parsley-trigger="change" data-parsley-type="digits" /></td>
														</tr>
													</table>
													<!--버튼-->
													<div class="btn-center text-right">
														 <input type="submit" class="background-053c72 font-fff" id="partSaveBtn" style="margin-right:0;" value="저장">
                                          <!-- <a class="background-053c72 font-fff" id="partSaveBtn" style="margin-right:0;">저장</a> -->
													</div>
													</form>
													
													
													
												</td>
											</tr>
											<tr>
												<td class="vertical-top padding-left-30 padding-top-30 border-box">
													<h3 class="form_tit">사용자 생성시 기본 캐시</h3>
													
													<form id="user-form" data-parsley-validate="">
													<table class="width-100 margin-top-20">
														<colgroup>
															<col style="width:50%" />
															<col style="width:50%" />
														</colgroup>
														<tr>
															<th class="text-center">현재 기본 캐시</th>
															<th class="text-center">변경 기본 캐시</th>
														</tr>
														<tr>
                                             				<td class="padding-right-5 border-box"><input type="text" name="usercash_cur" placeholder="" value="<c:out value="${roleVO.usercash}" />" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                             				<td class="padding-left-5 border-box"><input type="text" id="updusercash" placeholder="단가를 입력하세요." value="" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center"  required="" data-parsley-required="true" data-parsley-trigger="change" data-parsley-type="digits" /></td>
                                          				</tr>
                                       				</table>
                                       				<!--버튼-->
                                       				<div class="btn-center text-right">
                                          				<input type="submit" class="background-053c72 font-fff" id="userSaveBtn" style="margin-right:0;" value="저장">
                                          				<!-- <a class="background-053c72 font-fff" id="userSaveBtn" style="margin-right:0;">저장</a> -->
                                       				</div>

													</form>
												</td>
											</tr>
										</table>
									</div>
								</div>
							</div>
</body>
</html>
