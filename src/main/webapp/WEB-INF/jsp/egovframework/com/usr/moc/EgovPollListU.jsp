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
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.7.12/xlsx.core.min.js"></script>
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
<script type="text/javaScript" language="javascript" defer="defer">

$(document).ready(function(){
	
	var statYearActive = "${statYearActive}";
	if(statYearActive){
		$("#start_dt_new").val(statYearActive + "-01-01");
	}
	
	$("#polllistExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('polllist', '신규투표작성' ,'신규투표작성');
	    global.htmlTableToExcel('polllist','신규투표작성','신규투표작성', "${EXCEL_SHEET_DATA_COUNT}");
	});
	
	$('.bs-callout-info').toggleClass('hidden', true);
    $('.bs-callout-warning').toggleClass('hidden', true);
	
	
	$('#npol-form').parsley().on('field:validated', function() {
	    var ok = $('.parsley-error').length === 0;
	    $('.bs-callout-info').toggleClass('hidden', !ok);
	    $('.bs-callout-warning').toggleClass('hidden', ok);
	  })
	  .on('form:submit', function() {
	    return false; // Don't submit form for this demo
	  });
	
	var oTable1 = $("#polllist").DataTable({
				dom : 'frtip',
			    ajax: {
			        "url" : "<c:url value='/getpolllist.do' />"
				},
				columns : [
					{data : "workNm"},
					{data : "reg_date"},
					{data : "subject"},
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
					{data : "mod_date"},
					{ data: "survey_seq", visible: false, searchable: false }
				],
				paging : true,
				info : true,
				language : {"url" : "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"}
	});
	global.settingTableCnt($("#table-cnt1"), oTable1);
	
	$('#polllist tbody').on( 'click', 'tr', function () {
		var obj = oTable1.row($(this).closest('tr')).data();
		$(".pop_bg").css('display','block');
		$(".pop_PollNew").css('display','block');
		
		start_date = obj.start_date;
		end_date = obj.end_date;
		
		start_date = start_date.slice(0, 10);
		end_date = end_date.slice(0, 10);
		
		$("#NewSelPollStatus").val(obj.status);
		$("#NewSelPollSubject").val(obj.subject);
		$("#NewSelPollRegName").val(obj.reg_user_name);
		$("#NewSelPollStart_dt").val(start_date);
		$("#NewSelPollEnd_dt").val(end_date);
		$("#NewSelPollnum").val(obj.mo_recipient);
		$("#NewSelPollWorkSeq").val(obj.work_seq);
		$("#NewSelPollSrtNot").val(obj.start_notice);
		$("#NewSelPollEndNot").val(obj.end_notice);
		$("#NewSelPollquestion").val(obj.question);
		$("#NewSelPollEx1").val(obj.example1);
		$("#NewSelPollEx2").val(obj.example2);
		$("#NewSelPollEx3").val(obj.example3);
		$("#NewSelPollEx4").val(obj.example4);
		$("#NewSelPollKey1").val(obj.example1_keyword);
		$("#NewSelPollKey2").val(obj.example2_keyword);
		$("#NewSelPollKey3").val(obj.example3_keyword);
		$("#NewSelPollKey4").val(obj.example4_keyword);
		$("#NewSelPollSeq").val(obj.survey_seq);
    } );
	

	$('#searchBtn2').on( 'click', function () {
		oTable1.columns(0).search($("#jobOpt2 option:selected").val());
		
		var statOptVal = "";
		if($("#statOpt2 option:selected").val() == '0') statOptVal = '등록';
		if($("#statOpt2 option:selected").val() == '1') statOptVal = '예약중';
		if($("#statOpt2 option:selected").val() == '2') statOptVal = '진행중';
		if($("#statOpt2 option:selected").val() == '3') statOptVal = '종료';
		oTable1.columns(5).search(statOptVal);
		
	   if($("#filterOpt option:selected").val()){
		   oTable1.columns( $("#filterOpt option:selected").val()  ).search( $("input[type=text][name=searchKeyword2]").val() )
	   }
	   oTable1.draw();
	});
	
	$('#newmodelbtn').on( 'click', function () {
		if (confirm("정말 삭제하시겠습니까??") == true){    //확인
			var seq = $("#NewSelPollSeq").val();
			var obj = {
					"survey_seq" : seq
			}
			
			/* send_date = obj.req_date;
			send_date = send_date.slice(0, 10);
			send_time = obj.req_date;
			send_time = send_time.slice(11, 19);
			
			if(!global.checkTime(obj.req_date, 5)){
				alert("예약 발송까지 5분 이상 남은 예약만 삭제 가능합니다.");
				return;
			} */
			
		    $.ajax({
		    	url: "<c:url value='/usr/deleteNewPoll.do' />",
		       	type: "POST",
	        	data: obj,
		    	dataType: "json",
		       	success: function(jsondata){  
		            if(jsondata["data"]==0){
		                oTable1.ajax.reload();
		                $(".pop_PollNew").css('display','none');
						$(".pop_bg").css('display','none');
		          	  
		            }else{
		            	console.log("삭제할수 없습니다.");
		            }
		       	},
		       	error: function(request,status,error){
		       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
		       	}
		   	});

		 }
	}); 
	
	$('#polllist tbody').on( 'click', '.delete', function () {
		if (confirm("정말 삭제하시겠습니까??") == true){    //확인
			var obj = oTable1.row($(this).closest('tr')).data();
		
			/* send_date = obj.req_date;
			send_date = send_date.slice(0, 10);
			send_time = obj.req_date;
			send_time = send_time.slice(11, 19);
			
			if(!global.checkTime(obj.req_date, 5)){
				alert("예약 발송까지 5분 이상 남은 예약만 삭제 가능합니다.");
				return;
			} */
			
		    $.ajax({
		    	url: "<c:url value='/usr/deleteNewPoll.do' />",
		       	type: "POST",
	        	data: obj,
		    	dataType: "json",
		       	success: function(jsondata){  
		            if(jsondata["data"]==0){
		                oTable1.ajax.reload();
						$(".pop_PollNew").css('display','none');
						$(".pop_bg").css('display','none');
		          	  
		            }else{
		            	console.log("삭제할수 없습니다.");
		            }
		       	},
		       	error: function(request,status,error){
		       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
		       	}
		   	});

		 }
	}); 
	
    
	$('#mocregbtn').on( 'click', function () {
		
		$('#npol-form').parsley().validate();
	    if (!$('#npol-form').parsley().isValid()) {
	    	return;
	    }
		
		$('#mocregbtn').attr('disabled',true);
		var reg_user_name = $("#reg_user_name").val(); //
		var subject = $("#subject").val(); //text
		var start_date = $("#start_dt_new_poll").val(); //text
		var end_date = $("#end_dt_new_poll").val(); //text
		var start_notice = $("#start_notice").val(); //text
		var end_notice = $("#end_notice").val(); //text
		var question = $("#question").val();//text
		var example1 = $("#example1").val(); //text
		var example1_keyword = $("#example1_keyword").val(); //text
		var example2 = $("#example2").val(); //text
		var example2_keyword = $("#example2_keyword").val(); //text
		var example3 = $("#example3").val(); //text
		var example3_keyword = $("#example3_keyword").val(); //text
		var example4 = $("#example4").val(); //text
		var example4_keyword = $("#example4_keyword").val(); //text
		var mo_recipient = $("#mo_recipient option:selected").val(); //select
		var work_seq = $("#work_seq option:selected").val(); //select
		var obj = {
			"reg_user_name" : reg_user_name,
			"subject" : subject,
			"start_date" : start_date,
			"end_date" : end_date,
			"start_notice" : start_notice,
			"end_notice" : end_notice,
			"question" : question,
			"example1" : example1,
			"example1_keyword" : example1_keyword,
			"example2" : example2,
			"example2_keyword" : example2_keyword,
			"example3" : example3,
			"example3_keyword" : example3_keyword,
			"example4" : example4,
			"example4_keyword" : example4_keyword,
			"mo_recipient" : mo_recipient,
			"work_seq" : work_seq
		}
		$.ajax({
			url : "<c:url value='/usr/InsertMessagingMoNewPoll.do'/>",
			type : "POST",
			data : obj,
			dataType : "json",
			beforeSend : function() {
				$('.wrap-loading').removeClass('display-none');
				$('#mocregbtn').attr('disabled',false);
			},
			complete : function() {
				$('.wrap-loading').addClass('display-none');
				$('#mocregbtn').attr('disabled',false);
			},
			success: function(jsondata){  
	            if(jsondata["data"]==0){
	            	
	            	var srvcNm = '문자투표 >> 신규투표';
					var methodNm = '작성';
					
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
	                //로딩
	                oTable1.ajax.reload();
	            	toastr.success('성공적으로 추가되었습니다');
					$(".pop_poll").css('display','none');
					$(".pop_bg").css('display','none');
					$('#mocregbtn').attr('disabled',false);
	            }else{
	            	toastr.error('양식을 확인해주세요.');
	            }
	       	},
			error : function(request,status, error) {
				toastr.error("code:"+ request.status+ "\n"+ "message:"+ request.responseText+ "\n"+ "error:"+ error);
				$('#mocregbtn').attr('disabled',false);
			}
		});
	});
	
	$('#newmoupdatebtn').on( 'click', function () {
		$('#PollNewUpd-form').parsley().validate();
	    if (!$('#PollNewUpd-form').parsley().isValid()) {
	    	return;
	    }
		
	    var seq = $("#NewSelPollSeq").val();
		var reg_user_name = $("#NewSelPollRegName").val(); //
		var subject = $("#NewSelPollSubject").val(); //text
		var start_date = $("#NewSelPollStart_dt").val(); //text
		var end_date = $("#NewSelPollEnd_dt").val(); //text
		var start_notice = $("#NewSelPollSrtNot").val(); //text
		var end_notice = $("#NewSelPollEndNot").val(); //text
		var question = $("#NewSelPollquestion").val();//text
		var example1 = $("#NewSelPollEx1").val(); //text
		var example1_keyword = $("#NewSelPollKey1").val(); //text
		var example2 = $("#NewSelPollEx2").val(); //text
		var example2_keyword = $("#NewSelPollKey2").val(); //text
		var example3 = $("#NewSelPollEx3").val(); //text
		var example3_keyword = $("#NewSelPollKey3").val(); //text
		var example4 = $("#NewSelPollEx4").val(); //text
		var example4_keyword = $("#NewSelPollKey4").val(); //text
		var mo_recipient = $("#NewSelPollnum option:selected").val(); //select
		var work_seq = $("#NewSelPollWorkSeq option:selected").val(); //select

		var obj = {
			"survey_seq" : seq,
			"reg_user_name" : reg_user_name,
			"subject" : subject,
			"start_date" : start_date,
			"end_date" : end_date,
			"start_notice" : start_notice,
			"end_notice" : end_notice,
			"question" : question,
			"example1" : example1,
			"example1_keyword" : example1_keyword,
			"example2" : example2,
			"example2_keyword" : example2_keyword,
			"example3" : example3,
			"example3_keyword" : example3_keyword,
			"example4" : example4,
			"example4_keyword" : example4_keyword,
			"mo_recipient" : mo_recipient,
			"work_seq" : work_seq
		}
		
		/* send_date = obj.req_date;
		send_date = send_date.slice(0, 10);
		send_time = obj.req_date;
		send_time = send_time.slice(11, 19);
		
		if(!global.checkTime(obj.req_date, 5)){
			alert("예약 발송까지 5분 이상 남은 예약만 수정 가능합니다.");
			return;
		} */
		
		$.ajax({
			url : "<c:url value='/usr/UpdateMessagingMoNewPoll.do'/>",
			type : "POST",
			data : obj,
			dataType : "json",
			success: function(jsondata){  
	            if(jsondata["data"]==0){
	                //로딩
	                oTable1.ajax.reload();
	            	toastr.success('성공적으로 추가되었습니다');
					$(".pop_PollNew").css('display','none');
					$(".pop_bg").css('display','none');
					
	            }else{
	            	toastr.error('양식을 확인해주세요.');
	            }
	       	},
			error : function(request,status, error) {
				toastr.error("code:"+ request.status+ "\n"+ "message:"+ request.responseText+ "\n"+ "error:"+ error+ "\n"+ jsondata);
				$('#mocregbtn').attr('disabled',false);
			}
		});
	}); 
})



</script>
</head>
<body>


	<input type="radio" name="tabmenu" id="tabmenu2">
	<label for="tabmenu2">신규투표작성</label>
	<div class="tabCon">
		<!-- 검색설정 -->
		<div class="tabmenu_search">
			<!-- 상태 셀렉박스-->
			<select id="statOpt2" class="select_blank_lightblue width-100px"
				style="margin-right: 10px">
				<option selected>상태</option>
				<option value="0">등록</option>
				<option value="1">예약중</option>
				<option value="2">진행중</option>
				<option value="3">종료</option>
			</select>

			<!-- 업무분류 셀렉박스-->
			<select id="jobOpt2" class="select_blank_lightblue width-120px work_select2"
				style="margin-right: 10px">
			</select>


			<!-- 등록일 셀렉박스-->
			<select id="dateOpt2" class="select_blank_lightblue width-120px"
				style="margin-right: 10px">
				<option selected value="">날짜</option>
				<option value="1">등록일</option>
				<option value="3">투표기간</option>
			</select>

			<!-- 날짜선택-->
			<div
				class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
				<input type="date" id="start_dt_new" name="start_dt_new"
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
				<input type="date" id="end_dt_new" name="end_dt_new"
					class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"/>
			</div>

			<!--제목 체크박스-->
			<select id="filterOpt" class="select_blank_lightblue width-110px"
				style="margin-right: 10px">
				<option selected value="2">제목</option>
			</select>

			<div class="inline-block width-100px">
				<input id="searchKeyword" type="text" name="searchKeyword2"
					placeholder=""
					class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
			</div>
			<a id="searchBtn2"
				class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
		</div>
		<!-- //검색설정 -->

		<div
			class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5">
			<!-- 검색결과 -->
			<div class="table_result_tit">
				총 <span id="table-cnt1">000</span>개를 검색하였습니다.
				<a id="polllistExlBtn"
					class="icon_btn width-100px background-00e04e"><span
					class="icon_clip"></span>엑셀 다운로드</a> <a
					class="open_pop_poll margin-right-10 background-826fe8">신규 작성</a>
			</div>
			<table id="polllist" class="display con_tb" style="width: 100%">
				<thead>
					<tr>
						<th class="width-10">업무분류</th>
						<th class="width-10">등록일시</th>
						<th class="width-20">제목</th>
						<th class="width-30">투표시작날짜</th>
						<th class="width-30">투표종료날짜</th>
						<th class="width-10">상태</th>
						<th class="width-10">수정일시</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>



	<!-- 입력폼-->
	<div
		class="pop_poll pop_wrap margin-auto margin-top-30 margin-bottom-100 width-730px  padding-rl-65 padding-tb-40 background-f7fafc border-box box-shadow"
		style="display: none">
			<h3 class="form_tit">신규투표</h3>
			<form id="npol-form" data-parsley-validate="">
			<table class="width-100 margin-bottom-20">
				<tr>
					<th class="width-125px">작성자</th> 
					<td><input type="text" id="reg_user_name" value="${userName }"
						class="width-260px padding-left-20 border-box margin-right-10" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" id="subject" name=""
						placeholder="제목을 들어갑니다" class="padding-left-20 border-box"
						required="" data-parsley-required="true"
						data-parsley-trigger="change" data-parsley-maxlength="80" /></td>
				</tr>
				<tr>
					<th>기간</th>
					<td>
						<div
							class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
							<input type="date" id="start_dt_new_poll" name="start_dt"
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
							<input type="date" id="end_dt_new_poll" name="end_dt"
								class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>#번호</th>
					<td><select id="mo_recipient" title="" class="select_white width-260px"
						required="" data-parsley-required="true"
						data-parsley-trigger="change">
					</select></td>
				</tr>
				<c:if test="${workSeqRequiredFlag != 'ND'}" >	
				<tr>
					<th>업무분류</th>
					<td><select title="" id="work_seq" class="select_white width-260px" >
						
						<!--  
						<c:if test="${workSeqRequiredFlag eq 'NA'}" >	
						required=""
						data-parsley-required="true" 
						</c:if>
						data-parsley-trigger="change">
						<c:if test="${workSeqRequiredFlag != 'Y'}" >	
							<option value="">선택해주세요</option>
						</c:if>
						<c:if test="${g_workSeqZeroCodeUseYN eq 'Y'}" >	
							<option value="0">미분류</option>
						</c:if>
							<option value="1">알림톡</option>
							<option value="2">알림</option>
							<option value="3">민원</option>
							<option value="4">공지</option>
							<option value="5">비상</option>
							<option value="6">기타</option>
							-->
							
					</select></td>
				</tr>
				</c:if>
				<tr>
					<th class="vertical-top padding-top-20">시작안내문</th>
					<td><textarea type="text" id="start_notice" name=""
							placeholder=""
							class="padding-left-20 border-box"
							required="" data-parsley-required="true"
							data-parsley-trigger="change" data-parsley-maxlength="1000"></textarea>
					</td>
				</tr>
				<tr>
					<th class="vertical-top padding-top-20">종료안내문 <!--br><br>
                        <a class="background-8bc5ff font-fff width-70px text-center padding-left-10 border-radius-5">보기추가</a-->
					</th>
					<td><textarea type="text" id="end_notice" name=""
							placeholder=""
							class="padding-left-20 border-box"
							required="" data-parsley-required="true"
							data-parsley-trigger="change" data-parsley-maxlength="1000"></textarea>
					</td>
				</tr>
				<table class="width-100">
					<tr>
						<th>질문</th>
					<td class="text-center"><input type="text" name="" placeholder="" value="" id="question"
						class="width-200 padding-left-20 border-box" />
					</td>
					</tr>
					<tr>
						<th class="width-125px text-left">보기</th>
						<th class="text-center">보기내용</th>
						<th class="text-center">키워드</th>
					</tr>
					<tr>
						<td class="text-right padding-right-10 border-box">1</td>
						<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="" id="example1"
							class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
						<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="" id="example1_keyword"
							class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
					<tr>
					<tr>
						<td class="text-right padding-right-10 border-box">2</td>
						<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="" id="example2"
							class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
						<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="" id="example2_keyword"
							class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
					<tr>
					<tr>
						<td class="text-right padding-right-10 border-box">3</td>
						<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="" id="example3"
							class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
						<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="" id="example3_keyword"
							class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
					<tr>
					<tr>
						<td class="text-right padding-right-10 border-box">4</td>
						<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="" id="example4"
							class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
						<td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="" id="example4_keyword"
							class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
					<tr>
				</table>
			</table>
			</form>
			<p
				class="text-left font-172b4d font-14px margin-bottom-20 line-height-25px">
				※ 투표 참여자가 투표 문자 발송 시 내용이 키워드와 정확하게 일치해야만 집계됩니다.<br> ※ 각 보기의
				키워드에 포함되지 않은 단어는 기타건으로 처리됩니다.<br> ※ 중복으로 투표 했을 경우, 마지막 투표건이 결과에
				반영됩니다.<br> ※ 투표 전송은 현재시간보다 최소 10분 이후로 투표 시작 시점을 설정해야 전송가능합니다.<br>
			</p>
			<!--버튼-->
			<div class="btn-center">
				<input type="submit" class="background-053c72 font-fff" id="mocregbtn" value="등록">
				<!-- <a class="background-053c72 font-fff" id="mocregbtn">등록</a> -->
				<a class="pop_close background-8bc5ff font-fff">취소</a>
			</div>
	</div>
	
	<div id="pop_PollNew" class="pop_wrap pop_PollNew"
		style="padding: inherit; position: absolute; top: -100px; left: 50%; transform: translateX(-50%); margin-bottom: 50px;">
		<form id="PollNewUpd-form" data-parsley-validate="">
			<div
				class="width-730px padding-rl-65 padding-tb-40 background-f7fafc border-box box-shadow">
				<h3 class="form_tit">기본정보</h3>
				<table class="width-100 margin-bottom-20">
				<input type="text" id="NewSelPollSeq" readonly="readonly" hidden=""/>
					<tr>
						<th class="width-125px">작성자</th>
						<td><input type="text" name="" id="NewSelPollRegName" readonly="readonly"
							class="width-260px padding-left-20 border-box margin-right-10" /></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="" placeholder="" id="NewSelPollSubject"
							value="" class="padding-left-20 border-box" /></td>
					</tr>
					<tr>
						<th>기간</th>
						<td>
							<div
								class="inline-block relative width-200px height-50px line-height-50px text-right  border-radius-5 background-fff border-box">
								<input type="date" id="NewSelPollStart_dt" value="${start_date}"
									class="font-174962 font-16px padding-10 margin-0 width-100 height-50px line-height-50px background-transparent"
									style="background-position: left 15px top 16px;" />
							</div>
							<div
								class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
							<div
								class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
							<div
								class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
							<div
								class="inline-block relative width-200px height-50px line-height-50px text-right  border-radius-5 background-fff border-box margin-right-10">
								<input type="date" id="NewSelPollEnd_dt"
									class="font-174962 font-16px padding-10 margin-0 width-100 height-50px line-height-50px background-transparent"
									style="background-position: left 15px top 16px;" />
							</div>
						</td>
					</tr>
					<tr>
						<th>#번호</th>
						<td><select id="NewSelPollnum" title="" class="select_white width-260px"
							required="" data-parsley-required="true"
							data-parsley-trigger="change">
						</select></td>
					</tr>
					<tr>
						<th>업무분류</th>
						<td><select title="" id="NewSelPollWorkSeq" class="select_white width-260px"> 
							<!--  
							<c:if test="${workSeqRequiredFlag eq 'NA'}" >	
							required=""
							data-parsley-required="true" 
							</c:if>
							data-parsley-trigger="change">
							<c:if test="${workSeqRequiredFlag != 'Y'}" >	
								<option value="">선택해주세요</option>
							</c:if>
							<c:if test="${g_workSeqZeroCodeUseYN eq 'Y'}" >	
								<option value="0">미분류</option>
							</c:if>
								<option value="1">알림톡</option>
								<option value="2">알림</option>
								<option value="3">민원</option>
								<option value="4">공지</option>
								<option value="5">비상</option>
								<option value="6">기타</option>
								-->
						</select></td>
					</tr>
					<tr>
						<th class="vertical-top padding-top-20">시작안내문</th>
						<td><textarea type="text" name="" placeholder="" id="NewSelPollSrtNot" 
								class="padding-left-20 border-box"></textarea>
						</td>
					</tr>
					<tr>
						<th class="vertical-top padding-top-20">종료안내문 <!--br><br>
								<a class="background-8bc5ff font-fff width-70px text-center padding-left-10 border-radius-5">보기추가</a-->
						</th>
						<td><textarea type="text" name="" placeholder="" id="NewSelPollEndNot" 
								class="padding-left-20 border-box"></textarea>
						</td>
					</tr>
				</table>
				<table class="width-100 margin-bottom-10">
					<tr>
						<th>질문</th>
						<td class="text-center"><input type="text" name="" placeholder="" value="" id="NewSelPollquestion"
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
								</tr>
								<tr>
									<td class="text-right padding-right-10 border-box">1</td>
									<td class="padding-right-10 border-box"><input type="text" 
										name="" placeholder="" value="" id="NewSelPollEx1"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" 
										name="" placeholder="" value="" id="NewSelPollKey1"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
								<tr>
								<tr>
									<td class="text-right padding-right-10 border-box">2</td>
									<td class="padding-right-10 border-box"><input type="text" 
										name="" placeholder="" value="" id="NewSelPollEx2"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" 
										name="" placeholder="" value="" id="NewSelPollKey2"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
								<tr>
								<tr>
									<td class="text-right padding-right-10 border-box">3</td>
									<td class="padding-right-10 border-box"><input type="text" 
										name="" placeholder="" value="" id="NewSelPollEx3"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" 
										name="" placeholder="" value="" id="NewSelPollKey3"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
								<tr>
								<tr>
									<td class="text-right padding-right-10 border-box">4</td>
									<td class="padding-right-10 border-box"><input type="text" 
										name="" placeholder="" value="" id="NewSelPollEx4"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
									<td class="padding-right-10 border-box"><input type="text" 
										name="" placeholder="" value="" id="NewSelPollKey4"
										class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
								<tr>
							</table>
						</th>
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
					<a class="background-af0000 font-fff width-120px" id="newmodelbtn">삭제</a>
					<a class="background-826fe8 font-fff width-120px" id="newmoupdatebtn">수정</a>
					<a class="background-00e04e font-fff width-120px open_pop_templet open_pop_templet_before_close" >전송</a>
					<a class="pop_close background-053c72 font-fff width-120px" >취소</a>
				</div>
			</div>
		</form>
	</div>
	
	
		
				<div class="pop_wrap pop_templet width-730px background-f7fafc border-radius-5">							
					<!--내용-->
					<div class="flex-between">
						<div class="flex width-50 border-box">
							<div class="width-100">
								<textarea type="text" id="ansSubject" name="" placeholder="제목 (최대 30Byte)" class="width-100 height-40px line-height-40px border-e8e8e8 background-transparent font-16px padding-left-20 padding-right-20 border-box row-1 margin-bottom-10" /></textarea>
			
								<div class="relative width-100 padding-10 border-e8e8e8 background-transparent border-box border-radius-5 hidden" style="height: 447px">
									<textarea type="text" id="ansContent" name="" placeholder="내용 (최대 90Byte)" class="width-100 height-300px background-transparent font-16px line-height-default" /></textarea>
									<a class="icon_trash width-30px height-30px background-8bc5ff border-radius-40 absolute position-bottom-10px position-right-10px delete-msg-data"></a>
								</div>
							</div>
						</div>
						<div class="flex relative width-50 border-box" style="height:500px;">
							<div class="width-100 border-box" style="padding-left:20px ">
								<table class="width-100 margin-bottom-40">
									<tr>
										<th style="padding:10px 0;">발신번호</th>
										<td style="padding:10px 0;">
											<select class="select_blank_lightblue width-100 text-center ansNum2" id="ansNum">
											</select>										
										</td>
									</tr>
									<tr>
										<th style="padding:10px 0;">업무분류</th>
										<td style="padding:10px 0;">
											<select class="select_blank_lightblue width-100 text-center ansType2" >
											</select>										
										</td>
									</tr>
									<tr>
										<th style="padding:10px 0;">수신번호</th>
										<td style="padding:10px 0;">
											<input type="number" name="mo_num" class="select_blank_lightblue width-100 text-center" style="width: 75%">
											<button class="addNum height-45px line-height-45px text-center border-radius-5 background-efefef font-16px font-normal font-053c72" style="width: 20%;">입력</button>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<div  style="height:250px;overflow: auto;">
												<table style="width: 100%;">
													<thead>
														<tr>
															<th class="" style="width:20%;padding: 10px 10px 10px 0;">이름</th>
															<th class="" style="width:60%;padding: 10px 10px 10px 0;">전화번호</th>
															<th class="" style="width:20%;padding: 10px 10px 10px 0;">비고</th>
														</tr>
													</thead>
													<tbody class="call-to-list"></tbody>
												</table>
											</div>
										</td>
									</tr>
										
								</table>
								<ul class="width-100 absolute position-bottom position-left padding-left-30 border-box">
									<li class="float-left width-70"><a class="width-100 height-45px line-height-45px text-center  border-radius-5 background-8bc5ff font-18px font-bold  font-053c72" onclick="sendAnswer();">전송하기</a></li>
									<li class="float-left width-30 padding-left-15 border-box"><a class="pop_templet_close width-100 height-45px line-height-45px text-center border-radius-5 background-efefef font-16px font-normal font-053c72 open_pop_templet_before_show">취소</a></li>
								</ul>
							</div>
						</div>
					</div>
			   	</div>
				
				<script>
					$(function(){
						ajaxCallGetNoParse("/usr/work.do", function(res){
							var template = $.templates("#selectTypeList233"); // <!-- 템플릿 선언
				        	var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
				        	$(".ansType2").html(htmlOutput);
						})
						ajaxCallGetNoParse("/mng/getnumberlist.do", function(res){
							var template = $.templates("#selectTypeList22"); // <!-- 템플릿 선언
				        	var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
				        	$(".ansNum2").html(htmlOutput);
						})
						$(".addNum").click(function(){
							var mo_num = $("input[name='mo_num']").val();
							var str = '<tr><td style="width:20%;padding: 10px 10px 10px 0"></td><td style="width:60%;padding: 10px 10px 10px 0" class="call_to">'+mo_num+'</td><td style="width:20%;padding: 10px 10px 10px 0"><a class="icon_delete">삭제</a></td></tr>';
							
							var callTbody = $(".call-to-list");
							if(callTbody.text()){
								callTbody.find("tr:last-child").after(str);
							}else{
								callTbody.html(str);
							}
							$("input[name='mo_num']").val("");
							$("input[name='mo_num']").focus();
						})
						$(document).on("click",".call-to-list .icon_delete", function(){
							$(this).parent().parent().remove();
						})
						$(".open_pop_templet_before_close").click(function(){
							$("#pop_PollNew").hide();
						})
						$(".open_pop_templet_before_show").click(function(){
							$("#pop_PollNew").show();
						})
						$(".delete-msg-data").click(function(){
							$("#ansSubject").val("");//제목
							$("#ansContent").val("");//내용
						})
					})
				</script>
				<script type="text/x-jsrender" id="selectTypeList233">
					{{for data}}
						<option value='{{:code}}'>{{:codeNm}}</option>			
					{{/for}}
				</script>
				<script type="text/x-jsrender" id="selectTypeList22">
					{{for data}}
						{{if mo_type == '2'}}
							<option value='{{:mo_type}}'>{{:mo_number}}</option>		
						{{/if}}	
					{{/for}}
				</script>
	
				<script>
					function sendAnswer() {
						var answer_subject = $("#ansSubject").val();//제목
						var answer_content = $("#ansContent").val();//내용
						var work_seq = $(".ansType2").val();//업무분류
						var snd_number = $(".ansNum2").val();//발신자
						snd_number = "01056351595";
						
						
						var call_to_list = $(".call_to"); 
						var reverList = new Array();
						for(var i = 0 ; i < call_to_list.length ; i++){
							var temp = {
									"column1": "",
									"rcv_number":call_to_list.eq(i).text(),
									"rcv_etc":""
								}
								reverList.push(temp);
						}
						
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
								"tmpVars": "",
								"price":0
						}
						obj = JSON.stringify(obj);
						$.ajax({
					    	url: "/sendSMS.do",
					    	type: "POST",
					        dataType: "json",          		  
					        contentType: "application/json",  
					        data: obj,
					    	success: function(jsondata){
					    		if(jsondata['result_msg'] == "ok"){ 
					    			toastr.success('전송 되었습니다.');
					    		}
					    	}
						});
						
						
					}
				</script>
	
</body>
</html>
