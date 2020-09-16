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
<style>
#counter {
  background:rgba(255,0,0,0.5);
  border-radius: 0.5em;
  padding: .5em .5em .5em .5em;
  text-align: center;
  text-color: #fff;
  font-weight: bold;
}
</style>
<script type="text/javaScript" language="javascript" defer="defer">
$(document).ready(function(){ 
 
	/*
	제목글자수체크
	*/
	$('#title_thanks').keyup(function (e){
	    var title = $(this).val();
	    
	    //$('#counter').html("("+content.length+" / 최대 200자)");    //글자수 실시간 카운팅

	    if ( Number(byteCheck($(this))) > 30){ 
	    	//$(this).val(title.substring(0, title.length - 1));
	    	
	    	//e.preventDefault();
	    	$('#content_thanks').focus();
	    	toastr.error("최대 30BYTE까지만 입력 가능합니다.");
	    	f_chk_byte($(this),30);
	    	return onlyBackspace(e);
	        //return false;
	        
	        //$('#counter').html("(200 / 최대 200자)");
	    }
	});
	
	/*
	내용글자수체크
	*/
	$('#content_thanks').keyup(function (e){
	    var content = $(this).val();

	    if ( Number(byteCheck($(this))) == 90 ){  
	    	
	    	e.preventDefault();
	    	//$(this).attr("readonly",true); 
	    	//$('#phonelist').focus();
	    	toastr.error("단문은 최대 90BYTE까지만 입력 가능합니다.");
	    	//f_chk_byte($(this),90);
	        //$(this).val(content);
	        //return false; 
	        //$('#counter').html("(200 / 최대 200자)");
	    }
	    
	    if ( Number(byteCheck($(this))) > 1800 ){ 

	    	e.preventDefault();
	    	$('#phonelist').focus();
	    	toastr.error("최대 1800BYTE까지만 입력 가능합니다.");
	    	f_chk_byte($(this),1800);
	    }
	    
 		if( Number(byteCheck($(this))) > 90 ){
 			totalCnt = "1800";
 		}else{
 			totalCnt = "90";
 		}
 		
       /*  $(this).height(((content.split('\n').length + 1) * 1.5) + 'em'); */
        $('#counter').html(content.length + '/' + totalCnt );
	});
 

	//보내는번호입력
	
	$('input:radio[name=send_num]').change(function() {
		
		var sendnumType = $('input:radio[name=send_num]:checked').val();
		
		if(sendnumType == "3") {
			$('#thanks_rcv_number').val("");
		}else if(sendnumType == "2"){
			$('#thanks_rcv_number').val("01056351595");
		}else{
			$('#thanks_rcv_number').val("01056351595");
		}
		
	});
	 
	
	//주소록리스트에 들어온 리스트를
	$('#thanks_reg_addr').on('click', function(){
		
		var thanks_receiver =  $('ul.thanks_receiver li').get();		
		/* arrRcv = $('ul.thanks_receiver li').get(); */		
		//alert(thanks_receiver.length);
		
		for ( var i = 0; i < thanks_receiver.length; i++) {	
			var strName = thanks_receiver[i].getElementsByTagName('span')[0].childNodes[0].data;
			var strTel = thanks_receiver[i].getElementsByTagName('span')[1].innerHTML;
		 	var trData = "<tr>" + 
							"<td class=\"relative\">" + 
						 		"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
						 			"<input type=\"checkbox\" id=\"check_4\" name=\"체크\" class=\"thankscheck\" />" + 
						 			"<label for=\"check_4\"></label>" + 
						 		"</div> <a class=\"rev_name\">" + strName + "</a>" + 
						 	"</td>" + 
						 	"<td>" + strTel + "</td><td>직접입력</td>" + 
						 	"<td class=\"tb_btn\">" + 
						 		"<a class=\"open_pop icon_modify\">수정</a>" + 
			             		"<a href=\"#\" class=\"icon_delete\"onclick=\"deleteLine(this);\" >삭제</a>" + 
			             	"</td>" + 
			             "</tr>";
			  $('#tblsendthanks tbody').append(trData);  		
		}

		$(".pop_bg").css('display','none');
		$('#thanks_pop_excel').css('display','none');
		$('ul.thanks_receiver li').remove();		
	});	


	$("a.thanksGrpBtn").click(function(){
		var jb = $('ul.thanks_send_my li').get();

		for ( var i = 0; i < jb.length; i++) {
			
			alert(jb[i].innerHTML);	
			
		  	if($.inArray(jb[i].innerHTML, arrRcv) != -1) {
			  	toastr.error('이미있음' + i + ':' + jb.length);
		  	}else{
				$( 'ul.thanks_receiver' ).append( "<li>" + jb[i].innerHTML + "</li>" );
				arrRcv.push(jb[i].innerHTML);
		  	}		  	
        }
	});
	
	
	$("a.thanksPrvBtn").click(function(){
		var gb = $('ul.thanks_send_group li').get();  
		 
		for ( var i = 1; i < gb.length; i++) {
		  if($.inArray(gb[i].innerHTML, arrRcv) != -1){
			  toastr.error('이미있음' + i + ':' + gb.length);
		  }else{
			$( 'ul.thanks_receiver' ).append( "<li>" + gb[i].innerHTML + "</li>" );
			arrRcv.push(gb[i].innerHTML);
		  }
        } 
		
	});
	
	
	//제목내용 클리어
	$('#contClearBtn').on('click', function(){	 
		$('#title_thanks').val(""); 
		$('#content_thanks').val(""); 
	});	 
	
	
	//테스트입력
	$('input:radio[name=sendtime]').change(function() {
		 
		  if ($('input:radio[name=sendtime]:checked').val() == "2") {
		     $('#testinput').removeClass("none");
		  }else{
			 $('#testinput').addClass("none");
		  } 
	});
	
	//lodingbar hide
	$('.loading_bar').hide();
	
	//오늘날짜세팅 
	$('#datePicker').val(getCurrentDate());
	
	$('#sendThanksBtn').on('click', function(){	 
		
		var title = $('#title_thanks').val(); 
		var content = $('#content_thanks').val(); 
		
		console.log(title + ": " + content);
		var titleLen = getTextLength(title);
		var contentLen = getTextLength(content);
		
		//toastr.success(titleLen + ":" + contentLen);
		// alert( maxLengthCheck("content_thanks","내용",90) );
		
		if( titleLen < 10 ) { 
     		toastr.error('제목을 입력하세요'); 
     		$('#title_thanks').focus();
     		return false;
		}
		
		if( contentLen < 20 ) { 
     		toastr.error('내용을 입력하세요'); 
     		$('#content_thanks').focus();
     		return false;
		}

		if( !maxLengthCheck("title_thanks","제목",30) ){
			$('#title_thanks').focus();
			return false;
		} 


		if( !maxLengthCheck("content_thanks","내용",1800) ){
			$('#content_thanks').focus();
			return false;
		}
		      
		var checkMsgType = "0";  //SMS
		var isImage = false;
		
		if(contentLen > 90 ) checkMsgType = "1";  //LMS
		if(contentLen > 90 && isImage ) checkMsgType = "2"; //MMS
		
	 	
	 	//check snd_number  부서원소속 사무실, 사용자핸드폰, 직접입력
	 	//var sendPhoneType = $('input:radio[name=send_num]:checked').val(); 
		
		
	 	//var sendPhone = $('input:text[name=msg_rcv_number]').val(); 
	 	var sendPhone = $('select[name=thanks_rcv_number]').val();
	 	//alert("sendPhoneType: " + sendPhoneType + ": phone " + sendPhone + ": phone x " + sendP );

		/* var sendPhoneLen = getTextLength(sendPhone);
		if( sendPhoneLen < 8 ) { 
     		toastr.error('발신번호를 입력하세요'); 
     		$('input[name=thanks_rcv_number]').focus();
     		return false;
		}
	 	 */
		
		
		//수동입력체크
		/* var manualInput = $('#phonelist').val();  
		
		if(manualInput.length > 0) {
     		toastr.error('수동입력창에 자료가 남아 있습니다'); 
     		$('#phonelist').focus();
			return false;
		} */
		
		var jobOptThanks = $('select[name=jobOptThanks]').val();
		//alert(jobOpt);
		if( jobOptThanks == "0"  ){
			toastr.error("업무분류를 선택하세요");
			return false;
		}
		
	 	var startDate = getTimeStamp();
	 	
	 	//즉시 에약 테스트
	 	var sendTimeValue = $('input:radio[name=sendtime]:checked').val(); 
	 	//alert(sendTimeValue);  //on
	 	//즉시 현재시각  , 예약 예약시각 ,  테스트 즉시
	 	if( sendTimeValue == "2"){
	 		//alert("예약");
	 		var iDate = $('#datePicker').val();
	 		var iTime = $('#hour option:selected').val();
	 		var iMinute = $('#minute option:selected').val();
	 		startDate = iDate + iTime + iMinute;
	 	}
	 	
	 	
	 	
	 	$('.wrap-loading').removeClass('display-none');   
	 	
	 	
		var param = tableToJsonEvent(document.getElementById("tblsendthanks"), checkMsgType, startDate); // table id를 던지고 함수를 실행한다.


		if( !Object.keys(param).length ){
			toastr.error("수신자목록을 입력하세요");
			return false;
		}  
		
        var obj = JSON.stringify(param);  
        
        //$('#result').text(obj);  
		$('#sendThanksBtn').attr('disabled', true);	
		
		/* loding */
		

	    

	        $('.loading_bar').show(0).delay(3000).hide(0);;
	        
	 
	    
		//toastr.success("------ajax--start-------");
    	$.ajax({
        	url: "/sendSMS.do",
        	type: "POST",
            dataType: "json",          // ajax 통신으로 받는 타입
            contentType: "application/json",  // ajax 통신으로 보내는 타입
            data: obj,
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
        		$('#sendThanksBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#sendThanksBtn').attr('disabled', false);
            },
        	success: function(jsondata){
        		var res = JSON.stringify(jsondata);
        		//alert(res); //로딩
        		
        		//clear
        		if(jsondata['result_msg'] == "ok"){
        			$("#tblsendthanks tbody").remove(); 
            		$('#title_thanks').val(""); 
            		$('#content_thanks').val(""); 
        		}
        		$('#result').text("전송시간:" + res); 
                toastr.success('성공적으로 전정되었습니다'); 
                   /* $(".pop_templet").css('display','none'); */

                $('.wrap-loading').addClass('display-none');
        		$('#sendThanksBtn').attr('disabled', false);
        		//close popup
        	},
        	error: function(request,status,error){
        		  
        		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            	//$('#result').text(error);
            	//alert("serialize err");
        		$('#sendThanksBtn').attr('disabled', false);
                $('.wrap-loading').addClass('display-none');
        	}
   		});
	});
	
})


function tableToJsonEvent(table, type, startDate, title, content, mmsinfo, senderNum, jobOpt, imgFileName) { 

    
    var tempData = {};
	
	//MMS_CONTENTS_INFO 에 필요한 데이타
	tempData["mms_info"] = mmsinfo;
	tempData["title"] = title;
	tempData["content"] = content;
	tempData["snd_number"] = senderNum;
	tempData["rcv_type"] = type;
	tempData["snd_date"] = startDate;
	tempData["rcv_rsvt_chk"] = "1";
	tempData["rcv_mmsinfo"] = mmsinfo;
	tempData["rcv_work_seq"] = jobOpt;  /* 업무분류 */

	/* MMS 친구톡 */ 
	tempData["imageName"] = imgFileName;
	
	/* 친구톡 */ 
	tempData["reContents"] = "";
	
	/* 친구톡 알림톡 */
	tempData["btnList"] = "";
	
	/* 알림톡 변수 5개 리스트 */
	tempData["tmpVars"] = "";
	
	var row = [];
    for (var r = 1, n = table.rows.length; r < n; r++) {
    	
       	var tableRow = table.rows[r];
        var rowData = {};              
        rowData["column1"] = tableRow.cells[0].querySelector('a').innerHTML; //이름
        rowData["rcv_number"] = tableRow.cells[1].innerHTML; //수신번호
        rowData["rcv_etc"] = tableRow.cells[2].innerHTML; //비고란 

        if(rowData["rcv_number"] == null ){
        	rowG.push(rowData); 
        }else{
	    	row.push(rowData); 
    	} 
    }   

	tempData["group"] = rowG.slice();  /* 전체내용넣기 */
	tempData["data"] =  row.slice();  /* 전체내용넣기 */
	//tempData["data"] = row;
    console.log("-------tableToJson-----------" + tempData);
    
	return tempData; 
}
</script>
</head>
<body>

			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>전송관리</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>경조사전송</li>
					</ul>
				</h1>


				<div class="width-1350px height-710px margin-bottom-100">
					<ul class="sendM_tabmenu">
						<li id="tab-1" class="btnCon">
							<input type="radio" checked name="sendM_tabmenu" id="tabmenu-1">
							<label for="tabmenu-1">경조사</label>
							<div class="tabCon">
								<ul class="width-100 margin-bottom-100">
									<li class="float-left  width-350px margin-right-30">
										<div class="width-350px height-620px border-radius-5 background-f7fafc padding-20 border-box">
											<textarea type="text" name="title_thanks" id="title_thanks"   placeholder="제목 (최대 30Byte)" class="width-100 height-50 border-e8e8e8 background-transparent font-16px padding-left-20 padding-right-20 border-box row-1 margin-bottom-5" /></textarea>
											<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden">
												<textarea type="text" name="content_thanks" id="content_thanks" placeholder="경조사 양식을 선택하세요" class="width-100 height-100 background-transparent font-16px line-height-default" style="overflow-y: auto;"></textarea>
											 
												 <!-- <div id="phonelistthanks" name="phonelistthanks"  contentEditable="true"  onkeydown='return onlyNumberEnter(event)' onkeyup='removeCharEnter(event)' placeholder="전화번호를 직접 입력하거나 메모장, 엑셀을 붙여넣기 한 후에 우측의 입력버튼을 눌러주세요. 두 개 이상의 전화번호는 꼭 엔터키로 구분해주세요."  class="width-100 height-70px background-transparent font-14px line-height-default"  style="overflow:scroll;overflow-x:hidden;overflow-y:hidden;" ></div>														
												 -->
											</div>
											<ul class="margin-bottom-20">
												<li class="float-left width-50 padding-right-5 border-box"><a class="width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">경조사 저장함</a></li>
												<li class="float-left width-50 padding-left-5 border-box"><a class="width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">저장하기</a></li>
											</ul>
											<ul>
												<li class="width-100">
													<!--***옵션:등록번호표시일 경우-->
													<div class="width-100 height-40px line-height-40px">
														<span class="inline-block width-70px height-40px line-height-40px text-left font-16px font-4d4f5c">발신번호</span>
														<select id="thanks_rcv_number" name="thanks_rcv_number"  class="select_blank_lightblue width-230px float-right" title="">
															<option value="01056351595">010-0000-0000</option>
															<option value="01056351595">010-1234-5678</option>
														</select>
													</div>
													<!--//***옵션:등록번호표시일 경우-->
												</li>
											</ul>
										</div>
									<li>
									<li class="float-right width-970px">
										<div class="width-100 height-620px padding-20 border-box border-radius-bottom-5 background-f7fafc">
											<ul class="width-100">
												<li class="width-100">
													<h3 class="inline-block float-left width-100 font-18px font-174962 margin-bottom-10">수신번호 불러오기</h3>
													<ul class="float-left width-100 height-50px">
														<li class="width-200px margin-bottom-5"><a class="open_pop_excel width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-16px font-053c72">주소록 불러오기</a></li>
													</ul>
													<div class="clear margin-bottom-20"></div>


													<h3 class="font-18px font-174962 margin-bottom-10">수신자 목록 <span class="font-bold">[0건]</span></h3>
													<div class="height-210px border-box scroll-y">
														<table id="tblsendthanks" class="con_tb width-100" cellpadding="0" cellspacing="0" border="0">
															<thead>
																<tr>
																	<th class="width-20">이름</th>
																	<th class="width-20">전화번호</th>
																	<th class="width-20">비고</th>
																	<th class="width-20">관리</th>
																</tr>
															</thead>
															<!-- <tbody>
																<tr>
																	<td class="relative">
																		<div class="absolute position-left-10px position-top-5px checkbox-small_2">
																			<input type="checkbox" id="check_1" name="체크" />
																			<label for="check_1"></label>
																		</div> 김단문
																	</td>
																	<td>010111111233</td>
																	<td>비고가 들어갑니다.</td>
																	<td class="tb_btn">
																		<a class="open_pop icon_modify">수정</a>
																		a class="icon_save">저장</a
																		<a href="#" class="icon_delete">삭제</a>
																	</td>
																</tr>
																<tr>
																	<td class="relative">
																		<div class="absolute position-left-10px position-top-5px checkbox-small_2">
																			<input type="checkbox" id="check_2" name="체크" />
																			<label for="check_2"></label>
																		</div> 김단문
																	</td>
																	<td>010111111233</td>
																	<td>비고가 들어갑니다.</td>
																	<td class="tb_btn">
																		<a class="open_pop icon_modify">수정</a>
																		a class="icon_save">저장</a
																		<a href="#" class="icon_delete">삭제</a>
																	</td>
																</tr>
																<tr>
																	<td class="relative">
																		<div class="absolute position-left-10px position-top-5px checkbox-small_2">
																			<input type="checkbox" id="check_3" name="체크" />
																			<label for="check_3"></label>
																		</div> 김단문
																	</td>
																	<td>010111111233</td>
																	<td>비고가 들어갑니다.</td>
																	<td class="tb_btn">
																		<a class="open_pop icon_modify">수정</a>
																		a class="icon_save">저장</a
																		<a href="#" class="icon_delete">삭제</a>
																	</td>
																</tr>
																<tr>
																	<td class="relative">
																		<div class="absolute position-left-10px position-top-5px checkbox-small_2">
																			<input type="checkbox" id="check_4" name="체크" />
																			<label for="check_4"></label>
																		</div> 김단문
																	</td>
																	<td>010111111233</td>
																	<td>비고가 들어갑니다.</td>
																	<td class="tb_btn">
																		<a class="open_pop icon_modify">수정</a>
																		a class="icon_save">저장</a
																		<a href="#" class="icon_delete">삭제</a>
																	</td>
																</tr>
																<tr>
																	<td class="relative">
																		<div class="absolute position-left-10px position-top-5px checkbox-small_2">
																			<input type="checkbox" id="check_5" name="체크" />
																			<label for="check_5"></label>
																		</div> 김단문
																	</td>
																	<td>010111111233</td>
																	<td>비고가 들어갑니다.</td>
																	<td class="tb_btn">
																		<a class="open_pop icon_modify">수정</a>
																		a class="icon_save">저장</a
																		<a href="#" class="icon_delete">삭제</a>
																	</td>
																</tr>
																<tr>
																	<td class="relative">
																		<div class="absolute position-left-10px position-top-5px checkbox-small_2">
																			<input type="checkbox" id="check_6" name="체크" />
																			<label for="check_6"></label>
																		</div> 김단문
																	</td>
																	<td>010111111233</td>
																	<td>비고가 들어갑니다.</td>
																	<td class="tb_btn">
																		<a class="open_pop icon_modify">수정</a>
																		a class="icon_save">저장</a
																		<a href="#" class="icon_delete">삭제</a>
																	</td>
																</tr>
																<tr>
																	<td class="relative">
																		<div class="absolute position-left-10px position-top-5px checkbox-small_2">
																			<input type="checkbox" id="check_7" name="체크" />
																			<label for="check_7"></label>
																		</div> 김단문
																	</td>
																	<td>010111111233</td>
																	<td>비고가 들어갑니다.</td>
																	<td class="tb_btn">
																		<a class="open_pop icon_modify">수정</a>
																		a class="icon_save">저장</a
																		<a href="#" class="icon_delete">삭제</a>
																	</td>
																</tr>
																<tr>
																	<td class="relative">
																		<div class="absolute position-left-10px position-top-5px checkbox-small_2">
																			<input type="checkbox" id="check_8" name="체크" />
																			<label for="check_8"></label>
																		</div> 김단문
																	</td>
																	<td>010111111233</td>
																	<td>비고가 들어갑니다.</td>
																	<td class="tb_btn">
																		<a class="open_pop icon_modify">수정</a>
																		a class="icon_save">저장</a
																		<a href="#" class="icon_delete">삭제</a>
																	</td>
																</tr>
																<tr>
																	<td class="relative">
																		<div class="absolute position-left-10px position-top-5px checkbox-small_2">
																			<input type="checkbox" id="check_9" name="체크" />
																			<label for="check_9"></label>
																		</div> 김단문
																	</td>
																	<td>010111111233</td>
																	<td>비고가 들어갑니다.</td>
																	<td class="tb_btn">
																		<a class="open_pop icon_modify">수정</a>
																		a class="icon_save">저장</a
																		<a href="#" class="icon_delete">삭제</a>
																	</td>
																</tr>
															</tbody> -->
															<!--검색결과 없을 시>
															<tfoot>
																<tr>
																	<td  colspan="4">검색 결과가 없습니다.</td>
															</tfoot-->
														</table>
													</div>

													<div class="width-100 margin-top-10 padding-left-10 border-box">
														<div class="checkbox-small_2">
															<input type="checkbox" id="check_all" name="체크" />
															<label for="check_all"></label>
														</div>
														<span class="inline-block margin-left-10 margin-right-5 font-12px font-aaa">업무분류</span>
														<select class="select_white_small width-120px">
															<option>선택해주세요</option>
															<option>알림톡</option>
															<option>미선택</option>
															<option>알림</option>
															<option>민원</option>
															<option>공지</option>
															<option>비상</option>
															<option>기타</option>
														</select>
														<span class="float-right inline-block margin-top-5 margin-right-10 font-14px font-aaa font-bold font-053c72"><span class="inline-block margin-right-10 font-12px font-aaa font-normal">예상비용</span>친구톡 대체 0원</span>
														<a class="float-right width-140px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-right-20">수신번호 중복 체크</a>
													</div>
													<div class="clear margin-bottom-20"></div>
													<div class="float-left width-650px padding-left-10 border-box margin-bottom-15 background-f9fbfd">
														<div class="checkbox-small">
																<input type="checkbox" id="check_fail" name="체크" />
																<label for="check_fail"></label>
																<span class="font-16px font-053c72 margin-left-5">친구톡 실패 시 대체문자 발송</span>
														</div><a class="open_pop_message width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-10">대체문자</a>
													</div>

													<div class="relative float-left width-650px height-110px border-box border-radius-5 margin-bottom-10 hidden box-shadow-smallest background-f9fbfd">
														<ul class="absolute position-left position-vertical-center">
															<li class="relative width-100 height-30px margin-bottom-5 padding-left-10">
																<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
																	<div class="radio_s">
																		<input type="radio" id="prompt" name="send" checked/>
																		<label for="prompt"><span></span></label>
																	</div> 즉시발송
																</div>
															</li>
															<!--li class="relative width-100 height-30px margin-bottom-5 padding-left-10">
																<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
																	<div class="radio_s">
																		<input type="radio" id="book" name="send"/>
																		<label for="book"><span></span></label>
																	</div> 예약발송
																</div>
																<!--예약발송 달력박스 
																<div class="absolute position-vertical-center width-330px" style="left:100px; display:none;"> 
																	<div class="inline-block relative width-125px height-30px line-height-30px text-right  border-radius-5 border-8bc5ff border-box margin-right-5">
																		<input type="text" id="datePicker" value="2020-02-01" class="datepicker-form text-right font-174962 font-14px padding-0 padding-right-10 margin-0 width-100 height-30px line-height-30px background-transparent" readonly  style="background-size:14px; background-position:left 10px center" />
																	</div>
																	<select class="select_blank_lightblue_small width-70px" style="margin-right:5px;">
																		<option>시</option>
																	</select>
																	<select class="select_blank_lightblue_small width-70px">
																		<option>분</option>
																	</select>
																</div>
														
															</li>
															<li class="relative width-100 height-30px padding-left-10">
																<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
																	<div class="radio_s">
																		<input type="radio" id="test" name="send"/>
																		<label for="test"><span></span></label>
																	</div> 테스트발송
																</div>
																<!--테스트발송 체크시 입력박스
																<input type="text" name="" placeholder="" class="absolute position-vertical-center width-200px height-30px line-height-30px   border-e8e8e8 background-fff border-box border-radius-5 font-14px line-height-default none" style="left:110px;" />
															</li-->
														</ul>
													</div>
													<ul class="float-right width-230px height-120px">
														<li class="width-100 margin-bottom-10"><a class="open_pop_preview width-100 height-50px line-height-50px text-center border-radius-5 background-efefef font-20px font-bold font-053c72">미리보기</a></li>
														<li id="sendThanksBtn" class="width-100"><a class="width-100 height-50px line-height-50px text-center  border-radius-5 background-8bc5ff font-20px font-bold  font-053c72">전송하기</a></li>
													</ul>
													<div class="clear"></div>
												</li>
											</ul>
										</div>
									</li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
			</div> 
		</div>


<!-- popup _방침-->
         <div class="pop_wrap width-300px">
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-ff6464 line-height-20px" >
				1. 공적업무외 문자전송 자제<br><span class="font-14px font-aaa">(공무원 행동강령 제13조)</span><br><br>
				2. 개인정보(주민등록번호)<br><span class="font-14px font-aaa">전송 불가</span>
			</div>
			<!--버튼-->
			<div class="pop_btn">
				<a class="pop_close background-8bc5ff border-8bc5ff font-fff">확인</a>
			</div>
        </div>

		 <!-- popup 이미지 업로드 -->
         <div class="pop_wrap pop_imgupload width-600px padding-20 border-radius-5 background-f7fafc">
            <div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">이미지 업로드</div>
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
				<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-50">
					이미지선택
					<input class="upload-name" value="" disabled="disabled" placeholder="제목 (최대 30Byte)" />
					<label for="ex_filename">찾아보기</label> 
					<input type="file" id="ex_filename" class="upload-hidden" /> 
				</div>
				<ul class="pop_notice">
					<li>확장자는 jpg만 가능합니다.</li>
					<li>오리지널 사진 업로드를 체크해제하면 700*700 기준으로 사이즈가 자동조절됩니다.</li>
					<li>파일크기 100Kbyte 이상의 사진은 등록할 수 없습니다.</li>
					<li>
						오지리널 사진 업로드
						<span>
							<div class="checkbox">
									<input type="checkbox" id="pop_check" name="체크" />
									<label for="pop_check"></label>
							</div> 체크하면 오리지널 이미지 파일이 올라갑니다.</span>
					</li>
				</ul>
			</div>
			<!--버튼-->
			<div class="pop_btn-big">
				<a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>

		 <!-- popup 내저장함 -->
         <div class="pop_wrap pop_mybox width-730px" style="background:transparent;">

			<div class="width-100">
				<ul class="pop_tabmenu">
					<li id="pop_tab1" class="btnCon">
						<input type="radio" checked name="pop_tabmenu" id="pop_tabmenu1">
						<label for="pop_tabmenu1">단문</label>
						<div class="pop_tabCon">
							<!--검색-->
							<div class="margin-bottom-20">
								<select class="select_blank_lightblue width-140px" style="margin-right:10px">
									<option selected>제목</option>
									<option >내용</option>
									<option >기간</option>
								</select>
								<div class="inline-block width-350px">
									<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
								</div>
								<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
							</div>

							<!--내용-->
							<div class="flex-between">
								<div class="flex width-50 padding-right-15 border-box">
									<div class="width-100">
										<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
										<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
									</div>
								</div>
								<div class="flex width-50 padding-left-15 border-box">
									<div class="width-100">
										<h5 class="font-18px font-normal font-174962 text-left">테스트</h2>
										<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">예약발송테스트</textarea>
									</div>	
								</div>								
							</div>
							<div class="text-center margin-bottom-10">
								<ul class="pagination">
									<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
									<li class="page-item active"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">4</a></li>
									<li class="page-item"><a class="page-link" href="#">5</a></li>
									<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
								</ul>
							</div>
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
					<li id="pop_tab2" class="btnCon">
						<input type="radio" name="pop_tabmenu" id="pop_tabmenu2">
						<label for="pop_tabmenu2">장문</label>
						<div class="pop_tabCon">
							<!--검색-->
							<div class="margin-bottom-20">
								<select class="select_blank_lightblue width-140px" style="margin-right:10px">
									<option selected>제목</option>
									<option >내용</option>
									<option >기간</option>
								</select>
								<div class="inline-block width-350px">
									<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
								</div>
								<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
							</div>

							<!--내용-->
							<div class="flex-between">
								<div class="flex width-50 padding-right-15 border-box">
									<div class="width-100">
										<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
										<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
									</div>
								</div>
								<div class="flex width-50 padding-left-15 border-box">
									<div class="width-100">
										<h5 class="font-18px font-normal font-174962 text-left">테스트</h2>
										<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">예약발송테스트</textarea>
									</div>	
								</div>								
							</div>
							<div class="text-center margin-bottom-10">
								<ul class="pagination">
									<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
									<li class="page-item active"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">4</a></li>
									<li class="page-item"><a class="page-link" href="#">5</a></li>
									<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
								</ul>
							</div>
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
					<li id="pop_tab3" class="btnCon">
						<input type="radio" name="pop_tabmenu" id="pop_tabmenu3">
						<label for="pop_tabmenu3">멀티</label>
						<div class="pop_tabCon">
							<!--검색-->
							<div class="margin-bottom-20">
								<select class="select_blank_lightblue width-140px" style="margin-right:10px">
									<option selected>제목</option>
									<option >내용</option>
									<option >기간</option>
								</select>
								<div class="inline-block width-350px">
									<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
								</div>
								<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
							</div>

							<!--내용-->
							<div class="flex-between">
								<div class="flex width-50 padding-right-15 border-box">
									<div class="width-100">
										<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
										<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
									</div>
								</div>
								<div class="flex width-50 padding-left-15 border-box">
									<div class="width-100">
										<h5 class="font-18px font-normal font-174962 text-left">테스트</h2>
										<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">예약발송테스트</textarea>
									</div>	
								</div>								
							</div>
							<div class="text-center margin-bottom-10">
								<ul class="pagination">
									<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
									<li class="page-item active"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">4</a></li>
									<li class="page-item"><a class="page-link" href="#">5</a></li>
									<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
								</ul>
							</div>
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
					<li id="pop_tab4" class="btnCon">
						<input type="radio" name="pop_tabmenu" id="pop_tabmenu4">
						<label for="pop_tabmenu4">친구톡</label>
						<div class="pop_tabCon">
							<!--검색-->
							<div class="margin-bottom-20">
								<select class="select_blank_lightblue width-140px" style="margin-right:10px">
									<option selected>제목</option>
									<option >내용</option>
									<option >기간</option>
								</select>
								<div class="inline-block width-350px">
									<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
								</div>
								<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
							</div>

							<!--내용-->
							<div class="flex-between">
								<div class="flex width-50 padding-right-15 border-box">
									<div class="width-100">
										<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
										<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
									</div>
								</div>
								<div class="flex width-50 padding-left-15 border-box">
									<div class="width-100">
										<h5 class="font-18px font-normal font-174962 text-left">테스트</h2>
										<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">예약발송테스트</textarea>
									</div>	
								</div>								
							</div>
							<div class="text-center margin-bottom-10">
								<ul class="pagination">
									<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
									<li class="page-item active"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">4</a></li>
									<li class="page-item"><a class="page-link" href="#">5</a></li>
									<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
								</ul>
							</div>
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>

		 <!-- popup 엑셀&주소록 -->
         <div class="pop_wrap pop_excel width-730px" style="background:transparent;">

			<div class="width-100">
				<ul class="pop_tabmenu_excel">
<!-- 					<li id="pop_tab_1" class="btnCon">
						<input type="radio" name="pop_tabmenu_excel" id="pop_tabmenu_1">
						<label for="pop_tabmenu_1">엑셀 등록하기</label>
						<div class="pop_tabCon">
							<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
								<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-90">
									엑셀파일 찾기
									<input class="upload-name" value="" disabled="disabled" placeholder="제목 (최대 30Byte)" />
									<label for="ex_filename">찾아보기</label> 
									<input type="file" id="ex_filename" class="upload-hidden" /> 
								</div>
								<ul class="pop_notice" style="padding-left:90px">
									<li>엑셀양식파일 : <a href="#">엑셀양식 다운로드</a></li>
									<li>최대 10만건 까지 등록할 수 있습니다.</li>
									<li>엑셀등록시 휴대폰 번호는 필수값입니다.</li>
									<li>휴대폰 번호는 반드시 0으로 시작해야 합니다.</li>
									<li>알림톡의 경우 엑셀양식파일을 다운로드하여 템플릿의 변수값을 모두 입력한 후 엑셀 등록을 해주시기 바랍니다.</li>
								</ul>
							</div>
							버튼
							<div class="pop_btn-big margin-auto text-center margin-bottom-10">
								<a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
								<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
							</div>
						</div>
					</li> -->
					<li id="pop_tab_2" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_excel" id="pop_tabmenu_2">
						<label for="pop_tabmenu_2">주소록 불러오기</label>
						<div class="pop_tabCon">
							<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000 padding-20">
							<table cellpadding="0" cellspacing="0" border="0" class="width-100 height-210px margin-auto">
								<tr>
									<td class="width-330px height-240px vertical-top">
										<h5 class="font-18px font-normal font-174962 text-left">주소록보기</h2>
										<ul class="tabmenu_small">
											<li id="small_tab_1" class="btnCon">
												<input type="radio" checked name="tabmenu_small" id="tabmenu_small_1">
												<label for="tabmenu_small_1">개인</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30">
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_2" class="btnCon">
												<input type="radio" name="tabmenu_small" id="tabmenu_small_2">
												<label for="tabmenu_small_2">직원</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30">
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_3" class="btnCon">
												<input type="radio" name="tabmenu_small" id="tabmenu_small_3">
												<label for="tabmenu_small_3">부서</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30">
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_4" class="btnCon">
												<input type="radio" name="tabmenu_small" id="tabmenu_small_4">
												<label for="tabmenu_small_4">공유</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30">
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
														</ul>
													</div>
												</div>
											</li>
										</ul>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="icon_group">그룹</a>
									</td>
									<td rowspan="2" class="vertical-top width-230px">
										<h5 class="font-18px font-normal font-174962 text-left">연락 받을 사람<a class="width-55px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest float-right">최근</a></h2>
										<div class="width-230px height-480px hidden scroll-y font-12px border-radius-5 border-e8e8e8" style="height:485px;">
											<ul class="width-100 li-h30">
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
											</ul>
										</div>
									</td>
								</tr>
								<tr>
									<td class="width-330px height-240px vertical-top ">
										<h5 class="font-18px font-normal font-174962 text-left">선택그룹 상세보기</h2>
										<div class="width-330px height-210px hidden scroll-y font-12px border-radius-5 border-e8e8e8">
											<ul class="width-100 li-h30">
												<li class="search">
													<select class="select_white_small width-70px">
														<option>이름</option>
													</select>
													<input type="text" name="" />
													<a href="#">입력</a>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
											</ul>
										</div>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="icon_each">개별</a>
									</td>
								</tr>
							</table>
							<div class="margin-top-5 text-right">
								<a class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest ">선택삭제</a>
								<a class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">전체삭제</a>
							</div>
							</div>
							<!--버튼-->
							<div class="pop_btn-big margin-auto text-center margin-bottom-10">
								<a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
								<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>

		 <!-- popup 버튼추가 -->
         <div class="pop_wrap pop_button width-730px padding-20 border-radius-5 background-fff">
            <div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">버튼입력 (2/5)</div>
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-12px font-000">
				<table class="con_tb width-100" cellpadding="0" cellspacing="0" border="0">
					<thead>
						<tr>
							<th class="width-30">버튼타입</th>
							<th class="width-20">버튼명</th>
							<th class="width-35">링크</th>
							<th class="width-15">관리</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="font-12px">
								<span class="inline-block margin-right-20">1</span>
								<select class="select_white_small width-130px" style="background-color:#f9fbfd;">
									<option>웹링크</option>
									<option>앱링크</option>
									<option>배송조회</option>
									<option>봇키워드</option>
									<option>메세지전달</option>
								</select>
							</td>
							<td class="font-12px">버튼명입력</td>
							<td class="font-12px text-center">
								<span class="inline-block font-aaa font-11px width-100px text-left">PC</span><span class="inline-block font-12px">링크가들어갑니다.</span><br>
								<span class="inline-block font-aaa font-11px width-100px text-left">mobile</span><span class="inline-block font-12px">링크가들어갑니다.</span>
							</td>
							<td class="tb_btn">
								<a href="#" class="icon_delete">삭제</a>
							</td>
						</tr>
						<tr>
							<td class="font-12px">
								<span class="inline-block margin-right-20">1</span>
								<select class="select_white_small width-130px" style="background-color:#f9fbfd;">
									<option>웹링크</option>
									<option>앱링크</option>
									<option>배송조회</option>
									<option>봇키워드</option>
									<option>메세지전달</option>
								</select>
							</td>
							<td class="font-12px">버튼명입력</td>
							<td class="font-12px text-center">
								<span class="inline-block font-aaa font-11px width-100px text-left">PC</span><span class="inline-block font-12px">링크가들어갑니다.</span><br>
								<span class="inline-block font-aaa font-11px width-100px text-left">mobile</span><span class="inline-block font-12px">링크가들어갑니다.</span>
							</td>
							<td class="tb_btn">
								<a href="#" class="icon_delete">삭제</a>
							</td>
						</tr>
						<tr>
							<td class="font-12px">
								<span class="inline-block margin-right-20">1</span>
								<select class="select_white_small width-130px" style="background-color:#f9fbfd;">
									<option>웹링크</option>
									<option>앱링크</option>
									<option>배송조회</option>
									<option>봇키워드</option>
									<option>메세지전달</option>
								</select>
							</td>
							<td class="font-12px">버튼명입력</td>
							<td class="font-12px text-center">
								<span class="inline-block font-aaa font-11px width-100px text-left">PC</span><span class="inline-block font-12px">링크가들어갑니다.</span><br>
								<span class="inline-block font-aaa font-11px width-100px text-left">mobile</span><span class="inline-block font-12px">링크가들어갑니다.</span>
							</td>
							<td class="tb_btn">
								<a href="#" class="icon_delete">삭제</a>
							</td>
						</tr>
						<tr>
							<td class="font-12px">
								<span class="inline-block margin-right-20">1</span>
								<select class="select_white_small width-130px" style="background-color:#f9fbfd;">
									<option>웹링크</option>
									<option>앱링크</option>
									<option>배송조회</option>
									<option>봇키워드</option>
									<option>메세지전달</option>
								</select>
							</td>
							<td class="font-12px">버튼명입력</td>
							<td class="font-12px text-center">
								<span class="inline-block font-aaa font-11px width-100px text-left">PC</span><span class="inline-block font-12px">링크가들어갑니다.</span><br>
								<span class="inline-block font-aaa font-11px width-100px text-left">mobile</span><span class="inline-block font-12px">링크가들어갑니다.</span>
							</td>
							<td class="tb_btn">
								<a href="#" class="icon_delete">삭제</a>
							</td>
						</tr>
						<tr>
							<td class="font-12px">
								<span class="inline-block margin-right-20">1</span>
								<select class="select_white_small width-130px" style="background-color:#f9fbfd;">
									<option>웹링크</option>
									<option>앱링크</option>
									<option>배송조회</option>
									<option>봇키워드</option>
									<option>메세지전달</option>
								</select>
							</td>
							<td class="font-12px">버튼명입력</td>
							<td class="font-12px text-center">
								<span class="inline-block font-aaa font-11px width-100px text-left">PC</span><span class="inline-block font-12px">링크가들어갑니다.</span><br>
								<span class="inline-block font-aaa font-11px width-100px text-left">mobile</span><span class="inline-block font-12px">링크가들어갑니다.</span>
							</td>
							<td class="tb_btn">
								<a href="#" class="icon_delete">삭제</a>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--버튼-->
			<div class="pop_btn-big">
				<a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>

		 <!-- popup 대체문자 -->
         <div class="pop_wrap pop_message width-540px" style="background:transparent;">
			<div class="width-100">
				<ul class="pop_tabmenu-message">
					<li id="pop_tab01" class="btnCon">
						<input type="radio" checked name="pop_tabmenu-message" id="pop_tabmenu01">
						<label for="pop_tabmenu01">단문</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
									<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
								</div>
							</div>							
							<!--버튼-->
							<div class="pop_btn-big">
								<a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
								<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
							</div>
						</div>
					</li>
					<li id="pop_tab02" class="btnCon">
						<input type="radio" name="pop_tabmenu-message" id="pop_tabmenu02">
						<label for="pop_tabmenu02">장문</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
									<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
								</div>
							</div>							
							<!--버튼-->
							<div class="pop_btn-big">
								<a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
								<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
							</div>
						</div>
					</li>
					<li id="pop_tab03" class="btnCon">
						<input type="radio" name="pop_tabmenu-message" id="pop_tabmenu03">
						<label for="pop_tabmenu03">멀티</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
									<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
								</div>
							</div>							
							<!--버튼-->
							<div class="pop_btn-big">
								<a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
								<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>

		 <!-- popup 미리보기 -->
         <div class="pop_wrap pop_preview width-800px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">미리보기</div>
				<!--내용-->
				<div class="flex-between margin-top-20">
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
							<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span>01087654387<br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span>01087654387
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">내용 (최대 30Byte)</h2>
							<div class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"><img src="img/assets/h_logo.png" alt="이미지" class="width-100" /></div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span>01087654387<br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span>01087654387
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">테스트</h2>
							<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">예약발송테스트</textarea>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span>01087654387<br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span>01087654387
							</div>
						</div>
					</div>		
				</div>
				<!--버튼-->
				<div class="margin-auto text-center margin-top-30 margin-bottom-10">
					<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
				</div>
        </div>

		 <!-- popup 템플릿 -->
         <div class="pop_wrap pop_templet width-800px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">알림톡 템플릿</div>
				<!--검색-->
				<div class="margin-top-5 margin-bottom-10">
					<select class="select_blank_lightblue width-120px" style="margin-right:10px">
						<option selected>업무분류</option>
						<option >알림톡</option>
						<option >미선택</option>
						<option >알림</option>
						<option >민원</option>
						<option >공지</option>
						<option >비상</option>
						<option >기타</option>
					</select>
					<select class="select_blank_lightblue width-120px" style="margin-right:10px">
						<option selected>제목</option>
						<option >탬플릿이름</option>
						<option >탬플릿내용</option>
					</select>
					<div class="inline-block width-350px">
						<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
					</div>
					<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
				</div>
								
				<!--내용-->
				<div class="flex-between margin-top-20">
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
							<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">내용 (최대 30Byte)</h2>
							<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">예약발송테스트</textarea>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">테스트</h2>
							<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">예약발송테스트</textarea>
						</div>
					</div>		
				</div>
							<div class="text-center margin-bottom-10">
								<ul class="pagination">
									<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
									<li class="page-item active"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">4</a></li>
									<li class="page-item"><a class="page-link" href="#">5</a></li>
									<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
								</ul>
							</div>
				<!--버튼-->
				<div class="margin-auto text-center margin-top-30 margin-bottom-10">
					<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
				</div>
        </div>



		 <!-- popup 엑셀 -->
         <div class="pop_wrap pop_call_excel width-730px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">엑셀불러오기</div>
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
				<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-90">
					엑셀파일 찾기
					<input class="upload-name" value="" disabled="disabled" placeholder="제목 (최대 30Byte)" />
					<label for="ex_filename">찾아보기</label> 
					<input type="file" id="ex_filename" class="upload-hidden" /> 
				</div>
				<ul class="pop_notice" style="padding-left:90px">
					<li>엑셀양식파일 : <a href="#">엑셀양식 다운로드</a></li>
					<li>최대 10만건 까지 등록할 수 있습니다.</li>
					<li>엑셀등록시 휴대폰 번호는 필수값입니다.</li>
					<li>휴대폰 번호는 반드시 0으로 시작해야 합니다.</li>
					<li>알림톡의 경우 엑셀양식파일을 다운로드하여 템플릿의 변수값을 모두 입력한 후 엑셀 등록을 해주시기 바랍니다.</li>
				</ul>
			</div>
			<!--버튼-->
			<div class="pop_btn-big margin-auto text-center margin-bottom-10">
				<a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>
        
        <!-- 로딩이미지 -->
        <div class="loading_bar">
		  <div></div>
		  <div></div>
		  <div></div>
		  <div></div>
		</div>



	
				<!-- popup 미리보기 -->
         <div id="ucPreviewPopUp" class="pop_wrap pop_preview width-800px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">미리보기</div>
				<!--내용-->
				<div class="flex-between margin-top-20">
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
							<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span>01087654387<br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span>01087654387
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">내용 (최대 30Byte)</h2>
							<div class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"><img src="img/assets/h_logo.png" alt="이미지" class="width-100" /></div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span>01087654387<br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span>01087654387
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">테스트</h2>
							<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">예약발송테스트</textarea>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span>01087654387<br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span>01087654387
							</div>
						</div>
					</div>		
				</div>
				<!--버튼-->
				<div class="margin-auto text-center margin-top-30 margin-bottom-10">
					<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
				</div>
        </div>	
</body>
</html>
