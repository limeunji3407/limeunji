<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="EXCEL_SHEET_DATA_COUNT" var="EXCEL_SHEET_DATA_COUNT" />
<spring:message code="statYearActive" var="statYearActive" />
<script src="https://cdn.jsdelivr.net/alasql/0.3/alasql.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.7.12/xlsx.core.min.js"></script>
<script src="/js/egovframework/com/common.js"></script>
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
.dataTables_filter {
	display: none;
}
</style>
<script type="text/x-jsrender" id="selectRstList">
{{for}}
	<ul class="font-15px">
		<li class="float-left width-20 text-center" style="margin-bottom:5px;"><input readonly type="text" name="" placeholder="작성일" value="{{:create_at}}" class="border-box text-center" style="width:87px;" /></li>
		<li class="float-left width-25 text-center  padding-left-10" style="margin-bottom:5px;"><input readonly type="text" name="" placeholder="작성자/이름/아이디" value="{{:user_name}}" class="border-box text-center" /></li>
		<li class="float-left width-40 text-center  padding-left-10" style="margin-bottom:5px;"><input {{if user_name != check_name }} readonly {{/if}} type="text" name="" placeholder="" value="{{:content}}" class="border-box text-left padding-left-20" id="content{{:memo_seq}}"/></li>
		<li class="float-left width-10 text-center  padding-left-10" style="margin-bottom:5px;">{{if user_name == check_name }}<a class="icon_modify margin-top-2 margin-bottom-5" onclick="javascript:updMemo({{:memo_seq}});">수정</a><a onclick="javascript:delMemo({{:memo_seq}});" class="icon_delete margin-top-2 margin-bottom-5">삭제</a>{{/if}}</li>
	</ul>
{{/for}}
</script>
<script type="text/x-jsrender" id="selectTypeList">
		<option value=''>업무분류</option>
		{{for data}}
			<option value='{{:code}}'>{{:codeNm}}</option>			
		{{/for}}
</script>
<script type="text/x-jsrender" id="selectTypeList2">
		{{for data}}
			{{if mo_type == '1'}}
				<option value='{{:mo_type}}'>{{:mo_number}}</option>		
			{{/if}}	
		{{/for}}
</script>
<script>
	$(function(){
		ajaxCallGetNoParse("/usr/work.do", function(res){
			var template = $.templates("#selectTypeList"); // <!-- 템플릿 선언
        	var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
        	$(".ansType").html(htmlOutput);
		})
		ajaxCallGetNoParse("/mng/getnumberlist.do", function(res){
			var template = $.templates("#selectTypeList2"); // <!-- 템플릿 선언
        	var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
        	$(".ansNum").html(htmlOutput);
		})
	})
</script>
<script type="text/javaScript" language="javascript" defer="defer"> 
$(document).ready(function() {
	
	var statYearActive = "${statYearActive}";
	if(statYearActive){
		$("#start_dt").val(statYearActive + "-01-01");
	}
	
	//엑셀다운로드
	$("#tblcomplainUExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('tblcomplainU', '민원관리' ,'민원관리');
	    global.htmlTableToExcel('tblcomplainU','민원관리','민원관리', "${EXCEL_SHEET_DATA_COUNT}");
	});

	var oTableC = $("#tblcomplainU").DataTable({
		dom: 'frtip',
	    ajax: {
		        "url" : "<c:url value='/getcomplain.do' />"
		},
		columns: [ 
			{ data: "date_mo" },
			{ data: "mo_recipient" },
			{ data: "mo_callback" },
			{ data: "subject" },
		    { data: "content" }
		],
        paging:   true, 
        info:     true,
        language: {
       	 	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"
        }
	});

 
	global.settingTableCnt($("#table-cnt"), oTableC);
	$('#searchBtn').on( 'click', function () {
		oTableC.columns(0).search($("#numOpt option:selected").val());
		if($("#filterOpt option:selected").val()){
			oTableC.columns( $("#filterOpt option:selected").val()  ).search( $("input[type=text][name=searchKeyword]").val() )
		}
		oTableC.draw(); 
	});
	$.fn.dataTable.ext.search.push(
	   	    function( settings, data, dataIndex ) {
	   	    	if($("#start_dt").val() && $("#end_dt").val()){
	    	        var min = $('#start_dt').val(); min = global.replaceNumber(min);
	    	        var max = $('#end_dt').val(); max = global.replaceNumber(max);
	    	        var tableDate = data[0] || 0; tableDate = global.replaceNumber(tableDate); tableDate = global.parse(tableDate);
	    	        
	    	        if (min <= tableDate && tableDate <= max){
	    	            return true;
	    	        }else{
		    	        return false;
	    	        }
	   	    	}else{
	   	    		return true;
	   	    	}
	   	    }
	    );
	
	ajaxCallGetNoParse("/mng/getnumberlist.do", function(res){
		var str = "";
		str +="<option value=''>#번호</option>";
		for(var i = 0 ; i < res.data.length ; i++){
			str +="<option value='"+res.data[i].mo_number+"'>"+res.data[i].mo_number+"</option>";
		}
		$("#numOpt").html(str);
	})
	
	$('#tblcomplainU tbody').on( 'click', 'tr', function () {
		
		var obj = oTableC.row($(this).closest('tr')).data();
		console.log(obj);
		$(".pop_bg").css('display','block');
		$(".pop_mo_detile").css('display','block');
		
		var start_date = obj.start_date;
		var end_date = obj.end_date;
		
		var param = {
				"mo_key" : obj.mo_key
		}
		console.log(param);
		$.ajax({
	    	url: "<c:url value='/moComMemoSelect.do' />",
	    	type: "POST",
	        data: param,
	        dataType: "json",
	    	success: function(jsondata){  
	    		$("#mo_seq").val(obj.mo_key);
	    		$("#date_mo").val(obj.date_mo);
	    		$("#mo_recipient").val(obj.mo_recipient);
	    		$("#mo_num").val(obj.mo_callback);
	    		$("#mo_callback").val(obj.mo_callback);
	    		$("#subject").val(obj.subject);
	    		$("#content").val(obj.content);
	    		
	    		var answer = jsondata["answer"];
	    		console.log(answer);
	    		
	    		$("#send_dt").val(answer.answer_at);
	    		$("#form_num").val(answer.answer_num);
	    		$("#partNm").val(answer.orgnzt_nm);
	    		$("#name").val(answer.answer_name);
	    		$("#user_id").val(answer.answer_id);
	    		$("#to_num").val(answer.answer_to_num);
	    		$("#res_subject").val(answer.answer_subject);
	    		$("#res_content").val(answer.answer_content);
	    		
	    		var memo = jsondata["memo"];
	    		console.log(memo);
	    		var template = $.templates("#selectRstList"); // <!-- 템플릿 선언
	    	    var htmlOutput = template.render(memo); // <!-- 렌더링 진행 -->
	    	    $("#memoTbody").html(htmlOutput);
	    	},
	    	error: function(request,status,error){
	    		alert("일치하는 정보가 없습니다.");
	    	}
		});
    });
	
	var today = new Date();
	var year = today.getFullYear(); 
	var month = new String(today.getMonth()+1); 
	var day = new String(today.getDate()); 
	var p_seq = 0;
	var date = year+"/"+month+"/"+day;
	$('#memoAdd').on('click', function(){	

		var addButtonHtml = "";
		addButtonHtml = '<ul class="font-15px">'
						+'<li class="float-left width-20 text-center" style="margin-bottom:5px;"><input readonly style="width:87px;" type="text" name="" placeholder="작성일" value="'+date+'" class="border-box text-center " /></li>'
						+'<li class="float-left width-25 text-center  padding-left-10" style="margin-bottom:5px;"><input readonly type="text" name="" placeholder="작성자/이름/아이디" value="${userName}" class="border-box text-center" /></li>'
						+'<li class="float-left width-40 text-center  padding-left-10" style="margin-bottom:5px;"><input type="text" id="memoContent'+p_seq+'" name="" placeholder="" value="" class="border-box text-left padding-left-20" /></li>'
						+'<li class="float-left width-10 text-center  padding-left-10" style="margin-bottom:5px;"><a class="icon_save margin-top-2 margin-bottom-5" onclick="javascript:addMemo('+p_seq+');">등록</a><a onclick="javascript:removeButton(this);" class="icon_delete margin-top-2 margin-bottom-5">삭제</a></li>'
						+'</ul>'
		$("#memoTbody").append(addButtonHtml);
	});
});
function removeButton(el) {
	$(el).parents("ul").remove();
}
function addMemo(p_seq) {
	var content = $("#memoContent"+p_seq).val();
	var mo_key = $("#mo_seq").val();
	
	var obj ={
			"content" : content,
			"mo_key" : mo_key
	}
	$.ajax({
    	url: "<c:url value='/moComMemoInsert.do' />",
    	type: "POST",
        data: obj,
        dataType: "json",
    	success: function(jsondata){  
           if(jsondata["data"]==0){
                   //로딩
                   toastr.success('메모가 저장되었습니다.');
           }else{
         	  toastr.error("메모를 저장 할 수 없습니다.");
           }
    	},
    	error: function(request,status,error){
    		alert("일치하는 정보가 없습니다.");
    	}
	});
}
function updMemo(memo_seq) {
	var content = $("#content"+memo_seq).val();
	var obj = {
			"content" : content,
			"memo_seq" : memo_seq
	}
	console.log(obj);
	$.ajax({
    	url: "<c:url value='/moComMemoUpdate.do' />",
    	type: "POST",
        data: obj,
        dataType: "json",
    	success: function(jsondata){  
           if(jsondata["data"]==0){
                   //로딩
                   toastr.success('메모가 수정되었습니다.');
           }else if(jsondata["data"]==1){
         	  toastr.error("메모를 수정 할 수 없습니다.");
           }else{
        	   toastr.error("메모 작성자가 아니라 수정 할 수 없습니다.");
           }
    	},
    	error: function(request,status,error){
    		alert("일치하는 정보가 없습니다.");
    	}
	});
}
function delMemo(memo_seq) {
	var obj = {
			"memo_seq" : memo_seq
	}
	if (confirm("정말 삭제하시겠습니까??") == true) {
		$.ajax({
	    	url: "<c:url value='/moComMemoDelete.do' />",
	    	type: "POST",
	        data: obj,
	        dataType: "json",
	    	success: function(jsondata){  
	    		if(jsondata["data"]==0){
	                //로딩
	                toastr.success('메모가 삭제되었습니다.');
		        }else if(jsondata["data"]==1){
		      	  toastr.error("메모를 삭제 할 수 없습니다.");
		        }else{
		     	   toastr.error("메모 작성자가 아니라 삭제 할 수 없습니다.");
		        }
	    	},
	    	error: function(request,status,error){
	    		alert("일치하는 정보가 없습니다.");
	    	}
		});
	}
}

function sendAnswer() {
	var answer_subject = $("#ansSubject").val();
	var answer_content = $("#ansContent").val();
	var answer_to_num = $("#mo_num").val();
	answer_to_num = "01076700848"
		
	
	var answer_num = $("#ansNum").val();
	var mo_key = $("#mo_seq").val();
	var work_seq = $(".ansType").val();
	
	var snd_number = $(".ansNum").val();
	snd_number = "01056351595";
	
	var reverList = new Array();
	var temp = {
		"column1": "",
		"rcv_number":answer_to_num,
		"rcv_etc":""
	}
	reverList.push(temp);
	
	var obj = {
			"btnList":"",
			"content":answer_content,
			"data":reverList,
			"fileType": "",
			"group": new Array(),
			"imgFileName": "",
			"mms_info": "",
			"rcv_mmsinfo": answer_content,
			"rcv_rsvt_chk": "1",
			"rcv_type": "1", //1 : sms , 2 :lms
			"rcv_work_seq": work_seq,
			"reContents": "",
			"reType": 0,
			"snd_date": "",
			"snd_number": snd_number,
			"title": answer_subject,
			"tmpVars": ""
	}
	 obj = JSON.stringify(obj);
	/*
	btnList: ""
	content: "단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트"
	data: [{…}] {column1: "미입력", rcv_number: "01076700848", rcv_etc: ""}
	fileType: ""
	group: []
	imgFileName: ""
	mms_info: ""
	rcv_mmsinfo: "단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트단문테스트"
	rcv_rsvt_chk: "1"
	rcv_type: "1"
	rcv_work_seq: "2"
	reContents: ""
	reType: 0
	snd_date: ""
	snd_number: "01056351595"
	title: "단문테스트입니다"
	tmpVars: ""
	
	*/
	$.ajax({
    	url: "/sendSMS.do",
    	type: "POST",
        dataType: "json",          		  
        contentType: "application/json",  
        data: obj,
    	success: function(jsondata){
    		if(jsondata['result_msg'] == "ok"){ 
    			var obj = {
    					"answer_content":answer_content,
    					"answer_subject":answer_subject,
    					"answer_num":answer_num,
    					"answer_to_num":answer_to_num,
    					"mo_key":mo_key
    			}
    			$.ajax({
    		    	url: "<c:url value='/moComAnswer.do' />",
    		    	type: "POST",
    		        data: obj,
    		        dataType: "json",
    		    	success: function(jsondata){  
    		    		if(jsondata["data"]==0){
    		                //로딩
    		                toastr.success('전송 되었습니다.');
    			        }else{
    			     	   toastr.error("전송  할 수 없습니다.");
    			        }
    		    	},
    		    	error: function(request,status,error){
    		    		alert("양식을 다시 확인하세요.");
    		    	}
    			});
    		}
    	}
	});
	
	
}
</script>
</head>
<body>
	<!--contents-->
	<div class="con-inner">
		<!--타이틀-->
		<h1 class="con-title">
			<ul>
				<li>민원관리</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>민원수신/문자투표</li>
				<li><span class="dot"></span>민원관리</li>
				<li><span class="dot"></span>민원수신내역</li>
			</ul>
		</h1>


		<!-- 검색하기 -->
		<div
			class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
			<!-- 검색설정 -->
			<div
				class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">

				<!--번호 셀렉박스-->
				<select id="numOpt" class="select_blank_lightblue width-140px"
					style="margin-right: 10px">
				</select>

				<!-- 날짜선택-->
				<div
					class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
					<input type="date" id="start_dt" name="start_dt"
						class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent" />
				</div>
				<div
					class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
				<div
					class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
				<div
					class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
				<div
					class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box margin-right-10">
					<input type="date" id="end_dt" name="end_dt"
						class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"/>
				</div>

				<!--민원인번호 체크박스-->
				<select id="filterOpt" class="select_blank_lightblue width-120px"
					style="margin-right: 10px">
					<option selected value="2">민원인번호</option>
					<option value="3">제목</option>
					<option value="4">내용</option>
				</select>

				<!--검색-->
				<div class="inline-block width-180px">
					<input id="searchKeyword" type="text" name="searchKeyword"
						placeholder=""
						class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
				</div>
				<a id="searchBtn"
					class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
			</div>
			<!-- //검색설정 -->


			<!-- 검색결과 -->
			<div
				class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
				<div class="table_result_tit">
					총 <span id="table-cnt">000</span>개를 검색하였습니다.
					<a id="tblcomplainUExlBtn"
						class="icon_btn width-100px background-00e04e"><span
						class="icon_clip"></span>엑셀 다운로드</a>
				</div>
				<table id="tblcomplainU" class="con_tb">
					<thead>
						<tr>
							<th class="width-15">수신일시</th>
							<th class="width-13">#번호</th>
							<th class="width-12">민원인번호</th>
							<th class="width-30 text-center">제목</th>
							<th class="width-30 text-center">내용</th>
						</tr>
					</thead>
				</table>

			</div>
			<!-- //검색결과 -->
		</div>
	</div>
	
	<div class="pop_wrap pop_mo_detile width-730px" style="transform:translateX(-50%); background: transparent; top:50px;" >
		<div class="margin-auto margin-top-30 margin-bottom-100 width-730px  padding-rl-65 padding-tb-40 background-f7fafc border-box box-shadow" style="overflow-y:auto; overflow-x:hidden; width:745px; height:900px;">
			<h3 class="form_tit">민원상세</h3>
			<table class="width-100 margin-bottom-40">
			<input type="text" id="mo_seq" readonly="readonly" hidden>
				<tr>
					<th class="width-125px">수신일시</th>
					<td><input type="text" id="date_mo" name="" placeholder="" value="" class="width-260px padding-left-20 border-box margin-right-10" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>#번호</th>
					<td><input type="text" id="mo_recipient" name="" placeholder="" value="" class="width-260px padding-left-20 border-box margin-right-10" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>민원인번호</th>
					<td><input type="text" id="mo_callback" name="" placeholder="" value="" class="width-260px padding-left-20 border-box margin-right-10" readonly="readonly" /></td>
				</tr>
				 <tr>
					<th>제목</th>
					<td>
						<input type="text" id="subject" name="" placeholder="" value="" class="padding-left-20 border-box" readonly="readonly" />	
					</td>
				</tr>
				 <tr>
					<th class="vertical-top padding-top-20">내용</th>
					<td>
						<textarea type="text" id="content" name="" placeholder="" class="height-150px line-height-default padding-20 border-box" readonly="readonly" ></textarea>	
					</td>
				</tr>
			</table>

			<h3 class="form_tit">발신내역</h3>
			<table class="width-100 margin-bottom-40">
				<tr>
					<th class="width-125px">전송일시</th>
					<td><input type="text" id="send_dt" name="" placeholder="" value="" class="width-260px padding-left-20 border-box margin-right-10" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>회신번호</th>
					<td><input type="text" id="form_num" name="" placeholder="" value="" class="width-260px padding-left-20 border-box margin-right-10" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td class="text-center">
						<ul class="font-15px">
							<li class="float-left width-25 text-center"><input type="text" id="partNm" name="" placeholder="부서명" value="" class="border-box text-center" readonly="readonly" /></li>
							<li class="float-left width-25 text-center  padding-left-10"><input id="name" type="text" name="" placeholder="이름" value="" class="border-box text-center" readonly="readonly" /></li>
							<li class="float-left width-25 text-center  padding-left-10"><input id="user_id" type="text" name="" placeholder="아이디" value="" class="border-box text-center" readonly="readonly" /></li>
						</ul>
					</td>
				</tr>
				<tr>
					<th>민원인번호</th>
					<td><input type="text" id="to_num" name="" placeholder="" value="" class="width-260px padding-left-20 border-box margin-right-10" readonly="readonly" /></td>
				</tr>
				 <tr>
					<th>제목</th>
					<td>
						<input type="text" id="res_subject" name="" placeholder="" value="" class="padding-left-20 border-box" readonly="readonly" />	
					</td>
				</tr>
				 <tr>
					<th class="vertical-top padding-top-20">내용</th>
					<td>
						<textarea type="text" id="res_content" name="" placeholder="" class="height-150px line-height-default padding-20 border-box" readonly="readonly"></textarea>	
					</td>
				</tr>
			</table>


			<h3 class="form_tit" style="display:inline-block;">메모</h3>
			<button id="memoAdd" class="plus_btn" style="margin-top: -3px;"><span>+</span></button>
			<br>
			<table class="width-100  margin-bottom-40">
				<tr>
					<!-- <td class="text-center">
						<ul class="font-15px">
							<li class="float-left width-20 text-center">작성일</li>
							<li class="float-left width-25 text-center  padding-left-10">작성자<br><input type="text" name="" placeholder="작성자/이름/아이디" value="작성자/이름/아이디" class="border-box text-center margin-top-5" /></li>
							<li class="float-left width-40 text-center  padding-left-10">내용<br><input type="text" name="" placeholder="" value="내용이 들어갑니다." class="border-box text-left padding-left-20 margin-top-5" /></li>
							<li class="float-left width-10 text-center  padding-left-10">관리<br><a class="icon_modify margin-top-7 margin-bottom-5">수정</a> <a href="#" class="icon_delete">삭제</a></li>
						</ul>
					</td> -->
					<th class="float-left width-20 text-center">작성일</th>
					<th class="float-left width-25 text-center  padding-left-10">작성자</th>
					<th class="float-left width-40 text-center  padding-left-10">내용</th>
					<th class="float-left width-10 text-center  padding-left-10">관리</th>
				</tr>
				<tr>
					<td id="memoTbody" class="text-center">
					</td>
				</tr>
			</table>


			<!--버튼-->
			<div class="btn-center">
				<a class="pop_close background-8bc5ff font-fff">취소</a>
			</div>
		</div>
	</div>
	
	<div class="pop_wrap pop_templet width-730px background-f7fafc border-radius-5">							
		<!--내용-->
		<div class="flex-between">
			<div class="flex width-50 border-box">
				<div class="width-100">
					<textarea type="text" id="ansSubject" name="" placeholder="제목 (최대 30Byte)" class="width-100 height-40px line-height-40px border-e8e8e8 background-transparent font-16px padding-left-20 padding-right-20 border-box row-1 margin-bottom-10" /></textarea>

					<div class="relative width-100 height-300px padding-10 border-e8e8e8 background-transparent border-box border-radius-5 hidden">
						<textarea type="text" id="ansContent" name="" placeholder="내용 (최대 90Byte)" class="width-100 height-300px background-transparent font-16px line-height-default" /></textarea>
						<a class="icon_trash width-30px height-30px background-8bc5ff border-radius-40 absolute position-bottom-10px position-right-10px"></a>
					</div>
				</div>
			</div>
			<div class="flex relative width-50 border-box" style="height:353px;">
				<div class="width-100 border-box padding-left-50">
					<table class="width-100 margin-bottom-40">
						<tr>
							<th class="width-80px" style="padding:0;">수신번호</th>
							<td style="padding:0;"><textarea type="text" name="" id="mo_num" placeholder="" class="width-100 height-40px line-height-40px border-e8e8e8 background-transparent font-16px font-053c72 padding-left-20 padding-right-20 border-box row-1" readonly="readonly"/></textarea></td>
						</tr>
						<tr>
							<th style="padding:10px 0;">발신번호</th>
							<td style="padding:10px 0;">
								<select class="select_blank_lightblue width-100 text-center ansNum" id="ansNum">
								</select>										
							</td>
						</tr>
						<tr>
							<th style="padding:10px 0;">업무분류</th>
							<td style="padding:10px 0;">
								<select class="select_blank_lightblue width-100 text-center ansType" >
								</select>										
							</td>
						</tr>
					</table>
					<ul class="width-100 absolute position-bottom position-left padding-left-30 border-box">
						<li class="float-left width-70"><a class="width-100 height-45px line-height-45px text-center  border-radius-5 background-8bc5ff font-18px font-bold  font-053c72" onclick="sendAnswer();">전송하기</a></li>
						<li class="float-left width-30 padding-left-15 border-box"><a class="pop_templet_close width-100 height-45px line-height-45px text-center border-radius-5 background-efefef font-16px font-normal font-053c72">취소</a></li>
					</ul>
				</div>
			</div>
		</div>
   	</div>
</body>
</html>
