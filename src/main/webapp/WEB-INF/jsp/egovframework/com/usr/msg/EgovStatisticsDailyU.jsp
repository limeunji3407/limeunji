<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="EXCEL_SHEET_DATA_COUNT" var="EXCEL_SHEET_DATA_COUNT" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>iGOV SMS SYSTEM</title>
<script>
 	function searchVaild(){
 		var start_dt = document.getElementById("start_dt_day");
 		var end_dt = document.getElementById("end_dt_day");
 		
 		if(!start_dt.value){
 			alert('시작일자를 선택해주세요.')
 			start_dt.focus();
 			return;
 		}
 		if(!end_dt.value){
 			alert('종료일자를 선택해주세요.')
 			end_dt.focus();
 			return;
 		}
 		
 		var monthMin = start_dt.value.replace("-","");
 		monthMin = monthMin.substr(0, 6);
 		
 		var monthMax = end_dt.value.replace("-","");
 		monthMax = monthMax.substr(0, 6);
 		
 		console.log("monthMin : " + monthMin);
 		console.log("monthMax : " + monthMax);
 		
 		if(monthMin != monthMax){
 			alert("일별검색은 시작일자의 월과\n종료일자의 월이 같아야 합니다.");
 			return;
 		}
 		var work_seq = $(".type-select-day").val();
 		getDayData(monthMin, start_dt.value, end_dt.value, work_seq);
 		
 	}
 	function getDayData(month, start_dt, end_dt, work_seq){
 		ajaxCallGet("/usr/dailystatistics.do?start_dt="+start_dt+"&end_dt="+end_dt+"&month="+month+"&workSeq="+work_seq, function(res){
 			
 			var template = $.templates("#tbodyDataExcel_"); // <!-- 템플릿 선언
	        var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
	        $("#tbodyDataExcel").html(htmlOutput);
 			
 			var template = $.templates("#selectRstList"); // <!-- 템플릿 선언
	        var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
	        $("#tbodyData").html(htmlOutput);
	         
	         
			var day = new Array();
			var success = new Array();
			var fail = new Array();
			
			day.push("x")
			success.push("성공")
			fail.push("실패")
			
			var totalCnt = 0; //총발송건수
			var totalCnts = 0; //발송성공
			var totalCntf = 0; //발송실패
			for(var i = 0 ; i < res.data.length ; i++){
				var current_day = res.data[i].currentDay;
				var total = res.data[i].total;
				var totals = res.data[i].totals;
				var totalf = res.data[i].totalf;
				
				day.push(current_day)
				success.push(totals)
				fail.push(totalf)
				
				totalCnt += parseInt(total);
				totalCnts += parseInt(totals);
				totalCntf += parseInt(totalf);
			}
			$(".d-t").text(totalCnt);
			$(".d-s").text(totalCnts);
			$(".d-f").text(totalCntf);
			
			var dayChart = c3.generate({
				bindto: '#dayChart',
			    data: {
			        x: 'x',
			        columns: [
			        	day,
			        	success,
			        	fail
			        ],
			        type: 'bar',
			        groups:[
			        	['성공','실패']
			        ]
			    },
			    axis: {
			        x: {
			            tick: {
			                culling: {
			                    max: 1 // the number of tick texts will be adjusted to less than this value
			                }
			            }
			        }
			    }
			});
			
			
			
			var success = new Array();
			var fail = new Array();
			
			success.push("성공")
			fail.push("실패")
			
			var suCnt = totalCnts/totalCnt*100;
			var faCnt = totalCntf/totalCnt*100;
			success.push(suCnt);
			fail.push(faCnt);
			
			var dayChart2 = c3.generate({
				bindto: '#dayChart2',
			    data: {
			        columns: [
			        	success,
			        	fail,
			        ],
			        type : 'pie',
			        onclick: function (d, i) { console.log("onclick", d, i); },
			        onmouseover: function (d, i) { console.log("onmouseover", d, i); },
			        onmouseout: function (d, i) { console.log("onmouseout", d, i); }
			    }
			});
			
			
		}, function(){
			
		})
		var srvcNm = '전송관리 >> 기간별 통계';
		var methodNm = '검색';
		
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
 	}
	function tbodyDataExcelFun(){
		global.htmlTableToExcel('tbodyDataExcelTable','통계관리(일별)','통계관리(일별)', "${EXCEL_SHEET_DATA_COUNT}");
	}
 </script>

<script type="text/x-jsrender" id="selectRstList">
		{{for data}}
					<tr>
						<th rowspan="3"><span>{{:currentDay}}</span></th>
						<td><span>전송</span></td>
						<td><span>{{:sms}}</span></td><td><span>{{:lms}}</span></td><td><span>{{:mms}}</span></td><td><span>{{:not}}</span></td><td><span>{{:notr}}</span></td><td><span>{{:frt}}</span></td><td><span>{{:frtr}}</span></td><td><span>{{:fri}}</span></td><td><span>{{:frir}}</span></td>
					</tr>
					<tr>
						<td><span class="success">성공</span></td>
						<td><span class="success">{{:smss}}</span></td><td><span class="success">{{:lmss}}</span></td><td><span class="success">{{:mmss}}</span></td><td><span class="success">{{:nots}}</span></td><td><span class="success">{{:notrs}}</span></td><td><span class="success">{{:frts}}</span></td><td><span class="success">{{:frtrs}}</span></td><td><span class="success">{{:fris}}</span></td><td><span class="success">{{:frirs}}</span></td>
					</tr>
					<tr>
						<td><span class="fail">실패</td>	
						<td><span class="fail">{{:smsf}}</span></td><td><span class="fail">{{:lmsf}}</span></td><td><span class="fail">{{:mmsf}}</span></td><td><span class="fail">{{:notf}}</span></td><td><span class="fail">{{:notrf}}</span></td><td><span class="fail">{{:frtf}}</span></td><td><span class="fail">{{:frtrf}}</span></td><td><span class="fail">{{:frif}}</span></td><td><span class="fail">{{:frirf}}</span></td>
					</tr>
		{{/for}}
</script>
<script type="text/x-jsrender" id="tbodyDataExcel_">
		{{for data}}
					<tr>
						<td><span>{{:currentDay}}</span></td>
						<td><span>전송</span></td>
						<td><span>{{:sms}}</span></td><td><span>{{:lms}}</span></td><td><span>{{:mms}}</span></td><td><span>{{:not}}</span></td><td><span>{{:notr}}</span></td><td><span>{{:frt}}</span></td><td><span>{{:frtr}}</span></td><td><span>{{:fri}}</span></td><td><span>{{:frir}}</span></td>
					</tr>
					<tr>
						<td><span>{{:currentDay}}</span></td>
						<td><span class="success">성공</span></td>
						<td><span class="success">{{:smss}}</span></td><td><span class="success">{{:lmss}}</span></td><td><span class="success">{{:mmss}}</span></td><td><span class="success">{{:nots}}</span></td><td><span class="success">{{:notrs}}</span></td><td><span class="success">{{:frts}}</span></td><td><span class="success">{{:frtrs}}</span></td><td><span class="success">{{:fris}}</span></td><td><span class="success">{{:frirs}}</span></td>
					</tr>
					<tr>
						<td><span>{{:currentDay}}</span></td>
						<td><span class="fail">실패</td>	
						<td><span class="fail">{{:smsf}}</span></td><td><span class="fail">{{:lmsf}}</span></td><td><span class="fail">{{:mmsf}}</span></td><td><span class="fail">{{:notf}}</span></td><td><span class="fail">{{:notrf}}</span></td><td><span class="fail">{{:frtf}}</span></td><td><span class="fail">{{:frtrf}}</span></td><td><span class="fail">{{:frif}}</span></td><td><span class="fail">{{:frirf}}</span></td>
					</tr>
		{{/for}}
</script>
</head>
<body>
	<input type="radio" checked name="tabmenu" id="tabmenu1">
	<label for="tabmenu1">일별</label>
	<div class="tabCon">
		<!-- 검색설정 -->
		<div class="tabmenu_search">
			<!-- 업무분류 셀렉박스-->
			<select class="select_blank_lightblue width-140px type-select-day"
				style="margin-right: 10px">
			</select>

			<!-- 날짜선택-->
			<div
				class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
				<input type="date" id="start_dt_day" name="start_dt_day"
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
				<input type="date" id="end_dt_day" name="end_dt_day"
					class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"/>
			</div>

			<!--검색-->
			<a onclick="searchVaild()"
				class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue font-16px">검색</a>
		</div>
		<!-- //검색설정 -->

		<!-- 검색결과 -->
		<div
			class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5 margin-bottom-100">
			<div class="btn-right">
				<a  href="javascript:tbodyDataExcelFun()" class="icon_btn width-100px background-00e04e"><span
					class="icon_clip"></span>엑셀 다운로드</a> <a
					class="margin-right-10 background-826fe8 none" id="btn_graphview">그래프
					보기</a> <a class="margin-right-10 background-826fe8" id="btn_tableview">표
					보기</a>
			</div>
			<!-- 표 내용 -->
			<div id="tableview" class="none">
				<div
					class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
					 <span
						class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총
						발송 <span class="d-t">000</span>건</span> <span class="block text-center margin-bottom-20"> <span
						class="inline-block margin-right-10" style="color: #00841f">성공
							<span class="d-s">000</span>건</span> <span class="inline-block margin-left-10"
						style="color: #af0000">실패 <span class="d-f">000</span>건</span>
					</span>
				</div>
				<table id="detail-table" class="con_tb_2 width-100" cellpadding="0" cellspacing="0"
					border="0" style="table-layout: fixed">
					<thead>
						<tr>
							<th class="width-10" rowspan="2"><span>전송일</span></th>
							<th class="width-9" rowspan="2"><span
								style="background: #f2f7fd;">구분</span></th>
							<th class="width-9" rowspan="2"><span>단문</span></th>
							<th class="width-9" rowspan="2"><span>장문</span></th>
							<th class="width-9" rowspan="2"><span>멀티</span></th>
							<th class="width-19 row-tit" colspan="2"><span>알림톡</span></th>
							<th class="width-35 row-tit" colspan="4"><span>친구톡</span></th>
						</tr>
						<tr>
							<th class="row-txt row-txt-first"><span>알림톡</span></th>
							<th class="row-txt row-txt-last"><span>알림톡 대체</span></th>
							<th class="row-txt row-txt-first"><span>텍스트</span></th>
							<th class="row-txt"><span>텍스트대체</span></th>
							<th class="row-txt"><span>이미지</span></th>
							<th class="row-txt row-txt-last"><span>이미지 대체</span></th>
						</tr>
					</thead>
					<tbody id="tbodyData"></tbody>
				</table>
				
				<table id="tbodyDataExcelTable" style="display: none">
					<thead>
						<tr>
							<th>전송일</th>
							<th>구분</th>
							<th>단문</th>
							<th>장문</th>
							<th>멀티</th>
							<th>알림톡</th>
							<th>알림톡 대체</th>
							<th>친구톡 텍스트</th>
							<th>친구톡 텍스트대체</th>
							<th>친구톡 이미지</th>
							<th>친구톡 이미지 대체</th>
						</tr>
					</thead>
					<tbody id="tbodyDataExcel"></tbody>
				</table>
				
			</div>
			<!-- 그래프 내용 -->
			<div id="graphview">
				<div
					class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
					 <span
						class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총
						발송 <span class="d-t">000</span>건</span> <span class="block text-center margin-bottom-20"> <span
						class="inline-block margin-right-10" style="color: #00841f">성공
							<span class="d-s">000</span>건</span> <span class="inline-block margin-left-10"
						style="color: #af0000">실패 <span class="d-f">000</span>건</span>
					</span>
				</div>
				<div
					class="text-center line-height-90px padding-30 font-6f6f6f font-12px">
					<div id="dayChart"></div>
					<div id="dayChart2"></div>
				</div>
			</div>
		</div>
		<!-- //검색결과 -->
	</div>
</body>
</html>
