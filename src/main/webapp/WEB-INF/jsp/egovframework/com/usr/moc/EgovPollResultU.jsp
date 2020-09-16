<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_workSeqZeroCodeUseYN" var="g_workSeqZeroCodeUseYN" />
<spring:message code="workSeqRequiredFlag" var="workSeqRequiredFlag" />
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

<script type="text/javascript" language="javascript" defer="defer">
$(document).ready(function() { 
	
	var statYearActive = "${statYearActive}";
	if(statYearActive){
		$("#start_dt_res").val(statYearActive + "-01-01");
	}
	
	$("#pollresultExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('pollresult', '문자투표결과' ,'문자투표결과');
	    global.htmlTableToExcel('pollresult','문자투표결과','문자투표결과', "${EXCEL_SHEET_DATA_COUNT}");
	});

	var oTable = $("#pollresult").DataTable({
				dom : 'frtip',
			    ajax: {
			        "url" : "<c:url value='/getpollresult.do' />"
				},
				columns : [
					{data : "mo_recipient"},
					{data : "workNm"},
					{data : "subject"}, //end_date
					{data : "start_date"},
					{data : "end_date"},
					{
						data : "status",
			    		render: function(data) { 
	                           if(data == '0') {
	                             return '등록'; 
		                	   }else if(data == '1'){
		                		   return '예약중';
	                           }else if(data == '2'){
		                		   return '진행중';
	                           }else if(data == '3'){
		                		   return '종료';
	                           }else{
	                        	   return '';
	                           }
	                         }  
					},
				    { data: "etc_total_rate" },
				    { data: "reg_date" },
					{ data: "survey_seq" , visible: false, searchable: false}
				],
				paging : true,
				info : true,
				language : {"url" : "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"}
	});
	global.settingTableCnt($("#table-cnt"), oTable);

	$('#searchBtn').on( 'click', function () {
		oTable.columns(0).search($("#numOpt option:selected").val());
		oTable.columns(1).search($("#jobOpt option:selected").val());
		
		var statOptVal = "";
		if($("#statOpt option:selected").val() == '0') statOptVal = '등록';
		if($("#statOpt option:selected").val() == '1') statOptVal = '예약중';
		if($("#statOpt option:selected").val() == '2') statOptVal = '진행중';
		if($("#statOpt option:selected").val() == '3') statOptVal = '종료';
		oTable.columns(5).search(statOptVal);
		
	   if($("#titleOpt option:selected").val()){
		   oTable.columns( $("#titleOpt option:selected").val()  ).search( $("input[type=text][name=searchKeyword]").val() )
	   }
	   oTable.draw();
	});
	$.fn.dataTable.ext.search.push(
	   	    function( settings, data, dataIndex ) {
	   	    	
	   	    	var is_f = false;
	   	    	var is_s = false;
	   	    	
	   	    	if($("#dateOpt").val() && $("#start_dt_res").val() && $("#end_dt_res").val()){
	   	    		is_f = true;
	   	    	}
	   	    	if($("#dateOpt2").val() && $("#start_dt_new").val() && $("#end_dt_new").val()){
	   	    		is_s = true;
	   	    	}
	   	    	
	   	    	
	   	    	if(is_f){
	    	        var min = $('#start_dt_res').val(); min = global.replaceNumber(min);
	    	        var max = $('#end_dt_res').val(); max = global.replaceNumber(max);
	    	        
	    	        if($("#dateOpt").val() == '3'){
	    	        	var tableDateS = data[3] || 0;
	    	        	var tableDateE = data[4] || 0;
	    	        	
	    	        	tableDateS = global.replaceNumber(tableDateS);
	    	        	tableDateE = global.replaceNumber(tableDateE);
	    	        	
	    	        	tableDateS = global.parse(tableDateS);
	    	        	tableDateE = global.parse(tableDateE);
	    	        	 if (min <= tableDateS && tableDateE <= max){
	 	    	            if(!is_s) return true;
	 	    	        }else{
	 	    	        	if(!is_s) return false;
	 	    	        }
	    	        }else{
	    	        	var tableDate = data[$("#dateOpt").val()] || 0; tableDate = global.replaceNumber(tableDate); tableDate = global.parse(tableDate);
	        	        if (min <= tableDate && tableDate <= max){
	        	        	if(!is_s) return true;
	        	        }else{
	        	        	if(!is_s) return false;
	        	        }
	    	        }
	    	        
	   	    	}
	   	    	if(is_s){
	   	    		var min = $('#start_dt_new').val(); min = global.replaceNumber(min);
	    	        var max = $('#end_dt_new').val(); max = global.replaceNumber(max);
	    	        
	    	        if($("#dateOpt2").val() == '3'){
	    	        	var tableDateS = data[3] || 0;
	    	        	var tableDateE = data[4] || 0;
	    	        	
	    	        	tableDateS = global.replaceNumber(tableDateS);
	    	        	tableDateE = global.replaceNumber(tableDateE);
	    	        	
	    	        	tableDateS = global.parse(tableDateS);
	    	        	tableDateE = global.parse(tableDateE);
	    	        	console.log(tableDateS + " : " + tableDateE);
	    	        	 if (min <= tableDateS && tableDateE <= max){
	 	    	            return true;
	 	    	        }else{
	 		    	        return false;
	 	    	        }
	    	        }else{
	    	        	var tableDate = data[$("#dateOpt2").val()] || 0; tableDate = global.replaceNumber(tableDate); tableDate = global.parse(tableDate);
	        	        if (min <= tableDate && tableDate <= max){
	        	            return true;
	        	        }else{
	    	    	        return false;
	        	        }
	    	        }
	   	    	}
	   	    	return true;
	   	    	
	   	    	
	   	    }
	    );
	
	
	$('#pollresult tbody').on( 'click', 'tr', function () {
		var obj = oTable.row($(this).closest('tr')).data();
		$(".pop_bg").css('display','block');
		$(".pop_PollRes").css('display','block');
		
		console.log(obj);
		
		var start_date = obj.start_date;
		var end_date = obj.end_date;
		
		var status = obj.status;
		
		if(status == 2){

			$("#SelPollStatus").val('진행중');
		}else if(status == 3){

			$("#SelPollStatus").val('종료');
		}
		
		
		$("#SelPolletcTotalRate").val(obj.etc_total_rate);
		$("#SelPollSubject").val(obj.subject);
		$("#SelPollRegName").val(obj.reg_user_name);
		$("#SelPollStart_dt").val(start_date.substr(0, 11));
		$("#SelPollEnd_dt").val(end_date.substr(0, 11));
		$("#SelPollnum").val(obj.mo_recipient);
		$("#SelPollWorkSeq").val(obj.work_seq);
		$("#SelPollSrtNot").val(obj.start_notice);
		$("#SelPollEndNot").val(obj.end_notice);
		$("#SelPollquestion").val(obj.question);
		$("#SelPollEx1").val(obj.example1);
		$("#SelPollEx2").val(obj.example2);
		$("#SelPollEx3").val(obj.example3);
		$("#SelPollEx4").val(obj.example4);
		$("#SelPollKey1").val(obj.example1_keyword);
		$("#SelPollKey2").val(obj.example2_keyword);
		$("#SelPollKey3").val(obj.example3_keyword);
		$("#SelPollKey4").val(obj.example4_keyword);
		$("#SelPollCnt1").val(obj.example1_total_cnt);
		$("#SelPollCnt2").val(obj.example2_total_cnt);
		$("#SelPollCnt3").val(obj.example3_total_cnt);
		$("#SelPollCnt4").val(obj.example4_total_cnt);
		$("#SelPollRate1").val(obj.example1_total_rate);
		$("#SelPollRate2").val(obj.example2_total_rate);
		$("#SelPollRate3").val(obj.example3_total_rate);
		$("#SelPollRate4").val(obj.example4_total_rate);
		$("#SelPollshutDown").val(obj.shutdown_flag);
		$("#SelPollmodDate").val(obj.mod_date);
		$("#SelPollmodPart").val(obj.mod_part_name);
		$("#SelPollmodName").val(obj.mod_user_name);
		$("#SelPollmodId").val(obj.mod_user_id);
		$("#SelPollSeq").val(obj.survey_seq);
		$("#total_send").val(obj.total_send_cnt);
		$("#req_cnt").val(obj.request_cnt);
    } );
	
/* 	$("#SelPollCnt1").val(obj.example1_total_cnt);
	$("#SelPollCnt2").val(obj.example2_total_cnt);
	$("#SelPollCnt3").val(obj.example3_total_cnt);
	$("#SelPollCnt4").val(obj.example4_total_cnt); */
	
	$("#req_cnt").on( 'click', function () {
		var pollSeq = $("#SelPollSeq").val();
		
		obj = {
				"survey_seq" : pollSeq
		}
		
		console.log(obj);
		
		$.ajax({
	       	url: "<c:url value='/usr/pollResponseList.do' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){ 
            	var list = jsondata['list'];
            	
            	console.log(list);
            	if(list.length==0){
                	$(".pop_PollList2").css('display','block');
            	}else{
            		var template = $.templates("#pollResponseList"); // <!-- 템플릿 선언
                	var htmlOutput = template.render(list); // <!-- 렌더링 진행 -->
                	$("#pollResponseLis").html(htmlOutput);
                	$(".pop_PollList").css('display','block');
                	$(".pop_PollList2").css('display','none');
            	}
	       	},
	       	error: function(request,status,error){
	       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	       	}
	   	});
	});
	
	$("#SelPollCnt1").on( 'click', function () {
		var pollSeq = $("#SelPollSeq").val();
		var keyword = $("#SelPollKey1").val();
		
		obj = {
				"survey_seq" : pollSeq,
				"reple_keyword" : keyword
		}
		
		console.log(obj);
		$.ajax({
	       	url: "<c:url value='/usr/pollResponseListSelect.do' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){ 
				var list = jsondata['list'];
            	
            	console.log(list);
            	if(list.length==0){
                	$(".pop_PollList2").css('display','block');
                	$(".pop_PollList").css('display','none');
            	}else{
            		var template = $.templates("#pollResponseList"); // <!-- 템플릿 선언
                	var htmlOutput = template.render(list); // <!-- 렌더링 진행 -->
                	$("#pollResponseLis").html(htmlOutput);
                	$(".pop_PollList").css('display','block');
                	$(".pop_PollList2").css('display','none');
            	}
	       	},
	       	error: function(request,status,error){
	       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	       	}
	   	});
	});
	$("#SelPollCnt2").on( 'click', function () {
		var pollSeq = $("#SelPollSeq").val();
		var keyword = $("#SelPollKey2").val();
		
		obj = {
				"survey_seq" : pollSeq,
				"reple_keyword" : keyword
		}
		
		console.log(obj);
		$.ajax({
	       	url: "<c:url value='/usr/pollResponseListSelect.do' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){ 
				var list = jsondata['list'];
            	
            	console.log(list);
            	if(list.length==0){
                	$(".pop_PollList2").css('display','block');
                	$(".pop_PollList").css('display','none');
            	}else{
            		var template = $.templates("#pollResponseList"); // <!-- 템플릿 선언
                	var htmlOutput = template.render(list); // <!-- 렌더링 진행 -->
                	$("#pollResponseLis").html(htmlOutput);
                	$(".pop_PollList").css('display','block');
                	$(".pop_PollList2").css('display','none');
            	}
	       	},
	       	error: function(request,status,error){
	       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	       	}
	   	});
	});
	$("#SelPollCnt3").on( 'click', function () {
		var pollSeq = $("#SelPollSeq").val();
		var keyword = $("#SelPollKey3").val();
		
		obj = {
				"survey_seq" : pollSeq,
				"reple_keyword" : keyword
		}
		
		console.log(obj);
		$.ajax({
	       	url: "<c:url value='/usr/pollResponseListSelect.do' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){ 
				var list = jsondata['list'];
            	
            	console.log(list);
            	if(list.length==0){
                	$(".pop_PollList2").css('display','block');
                	$(".pop_PollList").css('display','none');
            	}else{
            		var template = $.templates("#pollResponseList"); // <!-- 템플릿 선언
                	var htmlOutput = template.render(list); // <!-- 렌더링 진행 -->
                	$("#pollResponseLis").html(htmlOutput);
                	$(".pop_PollList").css('display','block');
                	$(".pop_PollList2").css('display','none');
            	}
	       	},
	       	error: function(request,status,error){
	       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	       	}
	   	});
	});
	$("#SelPollCnt4").on( 'click', function () {
		var pollSeq = $("#SelPollSeq").val();
		var keyword = $("#SelPollKey4").val();
		
		obj = {
				"survey_seq" : pollSeq,
				"reple_keyword" : keyword
		}
		
		console.log(obj);
		$.ajax({
	       	url: "<c:url value='/usr/pollResponseListSelect.do' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){ 
				var list = jsondata['list'];
            	
            	console.log(list);
            	if(list.length==0){
                	$(".pop_PollList2").css('display','block');
                	$(".pop_PollList").css('display','none');
            	}else{
            		var template = $.templates("#pollResponseList"); // <!-- 템플릿 선언
                	var htmlOutput = template.render(list); // <!-- 렌더링 진행 -->
                	$("#pollResponseLis").html(htmlOutput);
                	$(".pop_PollList").css('display','block');
                	$(".pop_PollList2").css('display','none');
            	}
	       	},
	       	error: function(request,status,error){
	       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	       	}
	   	});
	});
	$(".pop_close2").on( 'click', function () {
		$(".pop_PollList").css('display','none');
    	$(".pop_PollList2").css('display','none');
	})
	
	ajaxCallGetNoParse("/mng/getnumberlist.do", function(res){
		var str = "";
		str +="<option value=''>#번호</option>";
		for(var i = 0 ; i < res.data.length ; i++){
			str +="<option value='"+res.data[i].mo_number+"'>"+res.data[i].mo_number+"</option>";
		}
		$("#numOpt").html(str);
		
		
		var str = "";
		str +="<option value='' selected>#번호</option>";
		for(var i = 0 ; i < res.data.length ; i++){
			str +="<option value='"+res.data[i].mo_seq+"'>"+res.data[i].mo_number+"</option>";
		}
		$("#mo_recipient").html(str);
		$("#NewSelPollnum").html(str);
	})
	ajaxCallGetNoParse("/usr/work.do", function(res){
		var template = $.templates("#selectTypeList"); // <!-- 템플릿 선언
    	var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
    	$(".work_select").html(htmlOutput);
    	$(".work_select2").html(htmlOutput);
    	
    	
    	var template = $.templates("#selectTypeList2"); // <!-- 템플릿 선언
    	var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
    	$("#work_seq").html(htmlOutput);
    	$("#NewSelPollWorkSeq").html(htmlOutput);
	})
});

function comClose() {
	if(confirm("강제종료 하시겠습니까?")){
		var seq = $("#SelPollSeq").val();
		obj = {
				"survey_seq" : seq
		}
		$.ajax({
	       	url: "<c:url value='/usr/pollComClose.do' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){  
	            if(jsondata["data"]==0){
	                toastr.success("성공적으로 강제종료 되었습니다.");
	           		location.href  ="/usr/poll"
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
}
</script>
<script type="text/x-jsrender" id="selectTypeList">
		<option value='' selected>업무분류</option>
		{{for data}}
			<option value='{{:codeNm}}'>{{:codeNm}}</option>			
		{{/for}}
</script>
<script type="text/x-jsrender" id="selectTypeList2">
		<option value='' selected>업무분류</option>
		{{for data}}
			<option value='{{:code}}'>{{:codeNm}}</option>			
		{{/for}}
</script>
<script type="text/x-jsrender" id="pollResponseList">
		{{for}}
			<tr>
				<td><span>{{:rownum}}</span></td>
				<td><span>{{:mo_originator}}</span></td>
			</tr>
		{{/for}}
</script>
</head>
<body>
	<input type="radio" checked name="tabmenu" id="tabmenu1">
	<label for="tabmenu1">문자투표결과</label>
	<div class="tabCon">
	<div id="tooltip"></div>
		<!-- 검색설정 -->
		<div class="tabmenu_search">
			<!--#번호 셀렉박스-->
			<select id="numOpt" class="select_blank_lightblue width-140px"
				style="margin-right: 10px">
			</select>

			<!-- 상태 셀렉박스-->
			<select id="statOpt" class="select_blank_lightblue width-80px"
				style="margin-right: 10px">
				<option selected>상태</option>
				<option value="0">등록</option>
				<option value="1">예약중</option>
				<option value="2">진행중</option>
				<option value="3">종료</option>
			</select>

			<!-- 업무분류 셀렉박스-->
			<c:if test="${workSeqRequiredFlag != 'ND'}">
				<select id="jobOpt" class="select_blank_lightblue width-95px work_select"
					style="margin-right: 10px">
					<!--  
					<c:if test="${workSeqRequiredFlag != 'Y'}">
						<option value="">선택해주세요</option>
					</c:if>
					<c:if test="${g_workSeqZeroCodeUseYN eq 'Y'}">
						<option value="0">미분류</option>
					</c:if>
					<option value="1">알림톡</option>
					<option value="2">알림</option>
					<option value="3">민원</option>
					<option value="4">공지</option>
					<option value="5">비상</option>
					<option value="6">기타</option>
					-->
				</select>
			</c:if>

			<!-- 전송일 셀렉박스-->
			<select id="dateOpt" class="select_blank_lightblue width-80px"
				style="margin-right: 10px">
				<option value="" selected>날짜</option>
				<option value="7">전송일</option>
				<option value="3">투표기간</option>
			</select>

			<!-- 날짜선택-->
			<div
				class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
				<input type="date" id="start_dt_res" name="start_dt_res"
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
				<input type="date" id="end_dt_res" name="end_dt_res"
					class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"/>
			</div>

			<!--제목 체크박스-->
			<select id="titleOpt" name="titleOpt"
				class="select_blank_lightblue width-60px" style="margin-right: 10px">
				<option value="2" selected>제목</option>
			</select>

			<!--검색-->
			<div class="inline-block width-170px">
				<input id="searchKeyword" type="text" name="searchKeyword"
					placeholder=""
					class="input_blank width-130 padding-left-20 border-box border-8bc5ff" />
			</div>
			<a id="searchBtn"
				class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
		</div>
		<!-- //검색설정 -->

		<!-- 검색결과 -->
		<div
			class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5">
			<div class="table_result_tit">
				총 <span id="table-cnt">000</span>개를 검색하였습니다.
				<a id="pollresultExlBtn"
					class="icon_btn width-100px background-00e04e"><span
					class="icon_clip"></span>엑셀 다운로드</a>
			</div>
			<table id="pollresult" class="display width con_tb" style="width: 100%">
				<thead>
					<tr>
						<th class="width-10">#번호</th>
						<th class="width-10">업무분류</th>
						<th class="width-20">제목</th>
						<th class="width-10">투표시작날짜</th>
						<th class="width-10">투표종료날짜</th>
						<th class="width-10">상태</th>
						<th class="width-10">응답률</th>
						<th class="width-10">전송날짜</th>
						<th class="width-10">비고</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- //검색결과 -->
		
	</div>

	<div id="pop_PollRes" class="pop_wrap pop_PollRes"
		style="padding: inherit; position: absolute; top: -100px; left: 50%; transform: translateX(-50%); margin-bottom: 50px;">
		<form id="PollRes-form" data-parsley-validate="">
			<div
				class="width-730px  padding-rl-65 padding-tb-40 background-f7fafc border-box box-shadow">
				<h3 class="form_tit">기본정보</h3>
				<table class="width-100 margin-bottom-20">
				<input type="text" id="SelPollSeq" readonly="readonly" hidden=""/>
					<tr>
						<th class="width-125px">작성자</th>
						<td><input type="text" name="" id="SelPollRegName" readonly="readonly"
							class="width-260px padding-left-20 border-box margin-right-10" /></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="" placeholder="" id="SelPollSubject"
							value="" class="padding-left-20 border-box" /></td>
					</tr>
					<tr>
						<th>기간</th>
						<td>
							<div
								class="inline-block relative width-150px height-50px line-height-50px text-right  border-radius-5 background-fff border-box">
								<input type="text" id="SelPollStart_dt"
									class="font-174962 font-16px padding-10 margin-0 width-100 height-50px line-height-50px background-transparent"
									style="background-position: left 15px top 16px;" readonly />
							</div>
							<div
								class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
							<div
								class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
							<div
								class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
							<div
								class="inline-block relative width-150px height-50px line-height-50px text-right  border-radius-5 background-fff border-box margin-right-10">
								<input type="text" id="SelPollEnd_dt"
									class="font-174962 font-16px padding-10 margin-0 width-100 height-50px line-height-50px background-transparent"
									style="background-position: left 15px top 16px;" readonly / >
							</div>
						</td>
					</tr>
					<tr>
						<th>#번호</th>
						<td><input type="text" name="" placeholder="" id="SelPollnum" readonly
							value="" class="padding-left-20 border-box" /></td>
					</tr>
					<tr>
						<th>업무분류</th>
						<td><input type="text" name="" placeholder="" id="SelPollWorkSeq" readonly
							value="" class="padding-left-20 border-box" /></td>
					</tr>
					<tr>
						<th class="vertical-top padding-top-20">시작안내문</th>
						<td><textarea type="text" name="" placeholder="" id="SelPollSrtNot" readonly
								class="height-150px line-height-default padding-20 border-box"></textarea>
						</td>
					</tr>
					<tr>
						<th class="vertical-top padding-top-20">종료안내문 <!--br><br>
								<a class="background-8bc5ff font-fff width-70px text-center padding-left-10 border-radius-5">보기추가</a-->
						</th>
						<td><textarea type="text" name="" placeholder="" id="SelPollEndNot" readonly
								class="height-150px line-height-default padding-20 border-box"></textarea>
						</td>
					</tr>
				</table>
				<h3 class="form_tit">투표결과</h3>
				<table class="width-100 margin-bottom-10">
					<tr>
						<th class="width-125px ">상태</th>
						<td class="vertical-middle">
							<input type="text" id="SelPollStatus" readonly
								class="inline-block width-100px height-50px line-height-50px border-radius-5 background-fff border-box text-center font-ff0000 font-15px"/>
							<div
								class="inline-block width-120px height-50px line-height-50px border-radius-5 border-box text-center margin-right-10 font-15px">
								응답률 : <input type="text" name="" readonly id="SelPolletcTotalRate"class="inline-block width-50px height-50px line-height-50px border-radius-5 background-fff border-box text-center font-15px"/></div>
							<div
								class="relative inline-block width-200px height-50px line-height-50px border-radius-5 border-box text-center margin-right-10">
								&nbsp;
								<div
									class="inline-block line-height-25px text-center absolute position-center font-15px" style="width:250px;">
									전체전송건수 : <input type="text" class="height-30px text-right" readonly="readonly" id="total_send" style="display: inline-block; width:100px; padding-right:10px;">건<br>투표응답건수 : <input type="test" readonly="readonly" id="req_cnt" class="height-30px text-right" style="display: inline-block; width:100px; padding-right:10px;">건
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th>질문</th>
						<td class="text-center"><input type="text" name="" readonly
							placeholder="" value="" id="SelPollquestion"
							class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
						</td>
					</tr>
					<tr>
						<th colspan="2" class="padding-top-20 padding-bottom-20">
							<table class="width-100">
								<tr>
									<th class="width-125px text-left">보기</th>
									<th class="text-center">보기내용</th>
									<th class="text-center">키워드</th>
									<th class="text-center">투표건수</th>
									<th class="text-center">득표율</th>
								</tr>
								<tr>
									<td class="text-right padding-right-10 border-box">1</td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollEx1"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollKey1"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollCnt1"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-right"><input type="text" name="" readonly
										placeholder="" value="" id="SelPollRate1"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
								<tr>
								<tr>
									<td class="text-right padding-right-10 border-box">2</td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollEx2"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollKey2"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollCnt2"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-right"><input type="text" name="" readonly
										placeholder="" value="" id="SelPollRate2"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
								<tr>
								<tr>
									<td class="text-right padding-right-10 border-box">3</td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollEx3"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollKey3"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollCnt3"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-right"><input type="text" name="" readonly
										placeholder="" value="" id="SelPollRate3"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
								<tr>
								<tr>
									<td class="text-right padding-right-10 border-box">4</td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollEx4"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollKey4"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" readonly
										name="" placeholder="" value="" id="SelPollCnt4"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="text-right"><input type="text" name="" readonly
										placeholder="" value="" id="SelPollRate4"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
								<tr>
							</table>
						</th>
					</tr>
					<tr>
						<th class="vertical-top"><div
								class="height-50px line-height-50px">강제종료</div></th>
						<td class="text-center">
							<input type="text" id="SelPollshutDown" readonly="readonly" 
								class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center margin-bottom-20 font-15px"/>
							<ul class="font-15px">
								<li class="float-left width-25 text-center">수정일자<br>
								<input type="text" name="" placeholder="" id="SelPollmodDate" readonly
									class="border-box text-center margin-top-5" readonly="readonly" /></li>
								<li class="float-left width-25 text-center  padding-left-10">수정자부서<br>
								<input type="text" name="" placeholder="" id="SelPollmodPart" readonly
									class="border-box text-center margin-top-5" /></li>
								<li class="float-left width-25 text-center  padding-left-10">수정자<br>
								<input type="text" name="" placeholder="" id="SelPollmodName" readonly
									class="border-box text-center margin-top-5" /></li>
								<li class="float-left width-25 text-center  padding-left-10">수정자ID<br>
								<input type="text" name="" placeholder="" id="SelPollmodId" readonly
									class="border-box text-center margin-top-5" /></li>
							</ul>
						</td>
					</tr>
				</table>
				<!--p class="text-left font-172b4d font-14px margin-bottom-20 line-height-25px">
						※  투표 참여자가 투표 문자 발송 시 내용이 키워드와 정확하게 일치해야만 집계됩니다.<br>
						※  각 보기의 키워드에 포함되지 않은 단어는 기타건으로 처리됩니다.<br>
						※  중복으로 투표 했을 경우, 마지막 투표건이 결과에 반영됩니다.<br>
						※  투표 전송은 현재시간보다 최소 10분 이후로 투표 시작 시점을 설정해야 전송가능합니다.<br>
					</p-->
				<!--버튼-->
				<div class="btn-center">
					<a class="background-af0000 font-fff" onclick="comClose();">강제종료</a> <a
						class="pop_close background-053c72 font-fff pop_close2">확인</a>
				</div>
			</div>
		</form>
	</div>
	<div class="background-f7fafc border-box box-shadow pop_PollList" style="display: none;width: 220px;float: right;z-index: 99;position: sticky;margin-top: 345px;padding: 20px;margin-right: 80px;">
		
		<table id="detail-table" class="con_tb_2 width-100" cellpadding="0" cellspacing="0"
			border="0" style="table-layout: fixed">
			<thead>
				<tr>
					<th class="row-tit" style="width: 50px;"><span>순서</span></th>
					<th class="row-tit" style="width: 120px;"><span>번호</span></th>
				</tr>
			</thead>
			<tbody id="pollResponseLis"></tbody>
		</table>
	</div>
	<div class="background-f7fafc border-box box-shadow pop_PollList2" style="display: none;width: 220px;float: right;z-index: 99;position: sticky;margin-top: 345px;padding: 20px;margin-right: 80px;">
		
		<p> 응답자가 없습니다. </p>
	</div>
</body>
</html>
