<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_workSeqZeroCodeUseYN"
	var="g_workSeqZeroCodeUseYN" />
<spring:message code="workSeqRequiredFlag" var="workSeqRequiredFlag" />
<spring:message code="EXCEL_SHEET_DATA_COUNT"
	var="EXCEL_SHEET_DATA_COUNT" />
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
<script type="text/javaScript" language="javascript" defer="defer"> 
$(document).ready(function() {
	
	//엑셀다운로드
	$("#polllistExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('polllist', '문자투표현황조회' ,'문자투표현황조회');
	    global.htmlTableToExcel('polllist','문자투표현황조회','문자투표현황조회', "${EXCEL_SHEET_DATA_COUNT}");
	});
	
	$('#addSurveyBtn').on('click', function(){  
		
		//alert('test');
		
		$('#addSurveyBtn').attr('disabled', true);		
		
	    var skey = $('input[name="senderkey"]').val(); 
	    var skeytype = $('input[name="senderkey_type"]').val(); 
	    var pname = $('input[name="profile_name"]').val(); 
	    var puuid = $('input[name="profile_uuid"]').val(); 
		
	    //alert( sms + "--:--" + lms + "--:--" + mms + "--:--" + notice + "--:--" + noticelms + "--:--" + friend + "--:--" + friendlms + "--:--" + friendmms );
		var obj = {
			"senderKey": skey, 
			"senderKeyType" : skeytype,
			"profileName" : pname,
			"profileUuid" : puuid,
		};
        
		//alert(JSON.stringify(obj));return;
		
     	$.ajax({
        	url: "<c:url value='/mng/insertPoll.do' />",
        	type: "POST",
            data: obj,
            dataType: "json",
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
        		$('#addSurveyBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#addSurveyBtn').attr('disabled', false);
            },
        	success: function(jsondata){

                   //개별데이타처리                   
/*                    $.each(jsondata["TemplateVO"], function (index, item) {
                	   $("input[type=checkbox][name=" + index + "]").val(item);
                	   var result = ''; 
                	   result += index +' : ' + item; 
                	   $("#result").append(result); 
				   }); */
                   
                   //로딩
                   toastr.success('등록이 성공적으로 변경되었습니다'); 

                $('.wrap-loading').addClass('display-none');
                $('.pop_new').addClass('pop_close');
        		$('#addSurveyBtn').attr('disabled', false);
            	
        	},
        	error: function(request,status,error){
        		console.log("[ajax error]");
        		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
            	$('#result').text(jsondata);
            	//alert("serialize err");
        		$('#addSurveyBtn').attr('disabled', false);
        	}
    	});
	});

		var pollList = $("#polllist").DataTable({
			
					dom : 'frtip',
				    ajax: {
				        "url" : "<c:url value='/mng/getpolllist.do' />"
					},
					columns : [
						{data : "work_seq"},
						{data : "reg_date"},
						{data : "subject"},
						{data : "start_date"}, //end_date
						{data : "status"},
						{data : "mod_date"},
			       		{ 
			        		data: null,
			                defaultContent: '<button class="icon_delete">삭제</button>'
			        	},
						{ data: "survey_seq", visible: false, searchable: false }
					],
					paging : true,
					info : true,
					language : {"url" : "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"}
		});
	 
		$('#searchBtn').on( 'click', function () {
		   if($("#searchFilter option:selected").val() == ""){
				   toastr.error("검색할 항목을 선택하세요");
				   return;
		   }
		   pollList
		        .columns( $("#searchFilter option:selected").val()  )
		        .search( $("input[type=text][name=searchFilterKeyword]").val() )
		        .draw();  
		} );

		$('#polllist tbody').on( 'click', 'tr', function () {
			var obj = pollList.row($(this).closest('tr')).data();
			console.log(JSON.stringify(obj));
			$(".pop_bg").css('display','block');
			$(".pop_PollNew").css('display','block');
			
			start_date = obj.start_date;
			end_date = obj.end_date;
			
			start_date = start_date.slice(0, 10);
			end_date = end_date.slice(0, 10);
			
			console.log(start_date);		
			
			$("#NewSelPollStatus").val(obj.status);
			$("#NewSelPollSubject").val(obj.subject);
			$("#NewSelPollRegName").val(obj.reg_user_name);
			$("#NewSelPollStart_dt").val(start_date);
			$("#NewSelPollEnd_dt").val(end_date);
			$("#NewSelPollnum option:selected").val(obj.mo_recipient);
			$("#NewSelPollWorkSeq option:selected").val(obj.work_seq);
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
		
		$('#polllist tbody').on( 'click', '.delete', function () {
			
			console.log('DeleteRec() invoked;;');
			
			if (confirm("정말 삭제하시겠습니까??") == true){    //확인

				console.log('DeleteRec() 삭제 확인 ;;');
			
				var obj = pollList.row($(this).closest('tr')).data();
				
				console.log(JSON.stringify(obj));
			    
			    $.ajax({
			    	url: "<c:url value='/usr/deleteNewPoll.do' />",
			       	type: "POST",
		        	data: obj,
			    	dataType: "json",
			       	success: function(jsondata){  
			     	   
			       		console.log(jsondata["data"]);
			            
			            if(jsondata["data"]==0){
			                //로딩
			                console.log("성공적으로 삭제 되었습니다.");
			                pollList.ajax.reload();

							$(".pop_PollNew").css('display','none');
							$(".pop_bg").css('display','none');
			          	  
			            }else{
			            	console.log("삭제할수 없습니다.");
			            }
			       	},
			       	error: function(request,status,error){
			       		  
			       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
			           	//$('#result').text(jsondata);
			           	//console.log("serialize err");
			       		//$('#refBtn').attr('disabled', false);
			       	}
			   	});

			 }else{

				 console.log('DeleteRec() 삭제 취소;;');
			 }
		}); 
		
		$('#newmodelbtn').on( 'click', function () {
			
			console.log('DeleteRec() invoked;;');
			
			if (confirm("정말 삭제하시겠습니까??") == true){    //확인

				console.log('DeleteRec() 삭제 확인 ;;');
			
				var seq = $("#NewSelPollSeq").val();
			
				var obj = {
						"survey_seq" : seq
				}
				
				console.log(JSON.stringify(obj));
			    
			    $.ajax({
			    	url: "<c:url value='/usr/deleteNewPoll.do' />",
			       	type: "POST",
		        	data: obj,
			    	dataType: "json",
			       	success: function(jsondata){  
			     	   
			       		console.log(jsondata["data"]);
			            
			            if(jsondata["data"]==0){
			                //로딩
			                console.log("성공적으로 삭제 되었습니다.");
			                pollList.ajax.reload();

			                $(".pop_PollNew").css('display','none');
							$(".pop_bg").css('display','none');
			          	  
			            }else{
			            	console.log("삭제할수 없습니다.");
			            }
			       	},
			       	error: function(request,status,error){
			       		  
			       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
			           	//$('#result').text(jsondata);
			           	//console.log("serialize err");
			       		//$('#refBtn').attr('disabled', false);
			       	}
			   	});

			 }else{

				 console.log('DeleteRec() 삭제 취소;;');
			 }
		}); 
		
		$('#newmoupdatebtn').on( 'click', function () {
			alert("newmoupdatebtn inboked;;");
			
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

			//alert(reg_user_name);
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
			alert(JSON.stringify(obj));

			$.ajax({
				url : "<c:url value='/usr/UpdateMessagingMoNewPoll.do'/>",
				type : "POST",
				data : obj,
				dataType : "json",
				success: function(jsondata){  
			     	   
		            alert(jsondata["data"]);
		            
		            if(jsondata["data"]==0){
		                //로딩
		                
		                pollList.ajax.reload();
		            	toastr.success('성공적으로 추가되었습니다');
						$(".pop_PollNew").css('display','none');
						$(".pop_bg").css('display','none');
						
		            }else{
		            	toastr.error('양식을 확인해주세요.');
		            }
		       	},
				error : function(request,status, error) {

					//$('#result').text();
					toastr.error("code:"+ request.status+ "\n"+ "message:"+ request.responseText+ "\n"+ "error:"+ error+ "\n"+ jsondata);
					//alert("serialize err");
					$('#mocregbtn').attr('disabled',false);
				}
			});
		}); 

});
</script>
</head>
<body>

	<input type="radio" name="tabmenu" id="tabmenu2">
	<label for="tabmenu2">문자투표현황조회</label>
	<div class="tabCon">
		<!-- 검색설정 -->
		<div class="tabmenu_search">
			<!-- 상태 셀렉박스-->
			<select class="select_blank_lightblue width-100px"
				style="margin-right: 10px">
				<option selected>상태</option>
				<option>예약중</option>
				<option>대기</option>
			</select>

			<!-- 업무분류 셀렉박스-->
			<c:if test="${workSeqRequiredFlag != 'ND'}">
				<select id="jobOpt" class="select_blank_lightblue width-95px"
					style="margin-right: 10px">
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
				</select>
			</c:if>

			<!-- 등록일 셀렉박스-->
			<select class="select_blank_lightblue width-120px"
				style="margin-right: 10px">
				<option selected>등록일</option>
				<option>투표기간</option>
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

			<!--제목 체크박스-->
			<select class="select_blank_lightblue width-110px"
				style="margin-right: 10px">
				<option selected>제목</option>
			</select>

			<!--검색-->
			<div class="inline-block width-180px">
				<input type="text" name="searchFilterKeyword" placeholder=""
					class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
			</div>
			<a id="searchBtn"
				class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
		</div>
		<!-- //검색설정 -->

		<div
			class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5">
			<!-- 검색결과 -->
			<div class="table_result_tit">
				<!-- 총 00/000개를 검색하였습니다. -->
				<a id="polllistExlBtn"
					class="icon_btn width-100px background-00e04e"><span
					class="icon_clip"></span>엑셀 다운로드</a>
			</div>

			<table id="polllist" class="display" style="width: 100%">
				<thead>
					<tr>
						<th class="width-10">업무분류</th>
						<th class="width-10">등록일시</th>
						<th class="width-20">제목</th>
						<th class="width-30">투표기간</th>
						<th class="width-10">상태</th>
						<th class="width-10">수정일시</th>
						<th class="width-10">삭제</th>
					</tr>
				</thead>
				<!-- <table id="polllist" class="display" cellpadding="0" cellspacing="0" border="0" style="table-layout:fixed">
										<thead>
											<tr>
												<th class="width-10">업무분류</th>
												<th class="width-10">등록일시</th>
												<th class="width-20">제목</th>
												<th class="width-30">투표기간</th>
												<th class="width-10">상태</th>
												<th class="width-10">수정일시</th>
												<th class="width-10">삭제</th>
											</tr>
										</thead> -->
				<!-- <tbody>
											<tr>
												<td>공지</td>
												<td>2019-01-02 10:30</td>
												<td class="relative">
													<a href="#footnote_desc_1" class="footnote" id="footnote_1">
														제목이 들어갑니다.<span class="note">제목이 들어갑니다. 제목이 들어갑니다. 제목이 들어갑니다.</span>
													</a>
												</td>
												<td>2020-02-01 ~ 2020-02-06</td>
												<td>예약</td>
												<td>2020-02-06 12:30</td>
												<td class="tb_btn">
													<a href="#" class="icon_delete">삭제</a>
												</td>
											</tr>
										</tbody> -->

				<!--검색결과 없을 시>
										<tfoot>
											<tr>
												<td  colspan="7">검색 결과가 없습니다.</td>
										</tfoot-->
			</table>
			<!-- //검색결과 -->

			<!-- 페이지 네비게이션 -->
			<!-- <div class="text-center">
										<ul class="pagination">
											<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
											<li class="page-item active"><a class="page-link" href="#">1</a></li>
											<li class="page-item"><a class="page-link" href="#">2</a></li>
											<li class="page-item"><a class="page-link" href="#">3</a></li>
											<li class="page-item"><a class="page-link" href="#">4</a></li>
											<li class="page-item"><a class="page-link" href="#">5</a></li>
											<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
										</ul>
									</div> -->
			<!-- //페이지 네비게이션 -->
		</div>
	</div>
	
	<div id="pop_PollNew" class="pop_wrap pop_PollNew"
		style="position: absolute; top: -100px; left: 50%; transform: translateX(-50%); margin-bottom: 50px;">
		<form id="PollNewUpd-form" data-parsley-validate="">
			<div
				class="margin-auto margin-top-30 margin-bottom-30 width-730px  padding-rl-65 padding-tb-40 background-f7fafc border-box box-shadow">
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
								<option value="">#번호</option>
								<option>#1110</option>
						</select></td>
					</tr>
					<tr>
						<th>업무분류</th>
						<td><select title="" id="NewSelPollWorkSeq"
							class="select_white width-260px" 
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
					<a class="pop_close background-053c72 font-fff width-120px" >취소</a>
				</div>
			</div>
		</form>
	</div>
	<!-- <div class="pop_bg" style="opacity: 0.5;"></div> -->
</body>
</html>
