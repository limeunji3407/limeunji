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
<script>

 	function searchVaildMonth(){
 		var start_dt = document.getElementById("month_start_dt");
 		var end_dt = document.getElementById("month_end_dt");
 		if(!start_dt.value){
 			alert('시작 월을 선택해주세요.')
 			start_dt.focus();
 			return;
 		}
 		if(!end_dt.value){
 			alert('종료 월을 선택해주세요.')
 			end_dt.focus();
 			return;
 		}
 		var monthMin = start_dt.value.replace("-","");// 201911
 		monthMin = monthMin.substr(0, 6);
 		var monthMax = end_dt.value.replace("-",""); // 202008
 		monthMax = monthMax.substr(0, 6);
 		var x = 0;
 		var tMonth = monthMin.substr(0,4);
 		var tempMin = monthMin+"";
 		var month = new Array();
 		var size = 1;
 		for(var i = 0 ; i < 200 ; i++){
 			
 			var m;
 			if(i == 0 ) {
 				m = ((parseInt(tempMin.substr(4,2))-1));
			}else{
				m = ((parseInt(tempMin.substr(4,2))-1)+1);
			}
 			
 			
 			if(m == 12) {
 				x = 0;
 				m = 0;
 				tMonth = parseInt(tMonth)+1;
 			}
 			
 			var date = new Date(tMonth, m, "01");	
 			
			var yyyy = date.getFullYear();
			var mm = date.getMonth()+1; //January is 0!
			
			
			if(mm<10){mm='0'+mm}
			tempMin = yyyy+""+mm;
			
			if(tempMin > monthMax){
				i = 201;
			}else{
				var obj = {
						"yyyymm": tempMin,
						"size":(size++)
				}
				
				month.push(obj);
			}
			
 			
 		}
 		var work_seq = $(".type-select-month").val();
 		var param = {
 				"start_dt":monthMin,
 				"end_dt":monthMax,
 				"date_list":month,
 				"work_seq":work_seq
 				
 		}
 		
 		getMonthData(param);
 	}
 	function getMonthData(param){
 		ajaxCallPost("/usr/monthstatistics.do", param, function(res){
 			console.log('res=' + JSON.stringify(res.length));
 			
 			var template = $.templates("#tbodyDataExcel_"); // <!-- 템플릿 선언
	        var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
	        $("#tbodyMonthExcel").html(htmlOutput);
 			
 			var template = $.templates("#selectRstList"); // <!-- 템플릿 선언
	        var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
	        $("#tbodyDataMonth").html(htmlOutput);
 			
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
			$(".m-t").text(totalCnt);
			$(".m-s").text(totalCnts);
			$(".m-f").text(totalCntf);
			
			
			var monthchart = c3.generate({
				bindto: '#monthchart',
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
			
			var monthchart2 = c3.generate({
				bindto: '#monthchart2',
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
	function tbodyMonthExcelFun(){
		global.htmlTableToExcel('tbodyMonthExcelTable','통계관리(월별)','통계관리(월별)', "${EXCEL_SHEET_DATA_COUNT}");
	}
 </script>
</head>
<body>
	<input type="radio" name="tabmenu" id="tabmenu2">
	<label for="tabmenu2">월별</label>
	<div class="tabCon">
		<!-- 검색설정 -->
		<div class="tabmenu_search">

			<!-- 업무분류 셀렉박스-->
			<select class="select_blank_lightblue width-120px type-select-month" style="margin-right:10px">
			</select>
			
			<!-- 년 셀렉박스-->
			<div
				class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
				<input type="month" id="month_start_dt" name="month_start_dt"
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
				<input type="month" id="month_end_dt" name="month_end_dt"
					class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"/>
			</div>

			<!--검색-->
			<a onclick="searchVaildMonth()" class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue font-16px">검색</a>
		</div>
		<!-- //검색설정 -->

		<!-- 검색결과 -->
		<div class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5 margin-bottom-100">
			<div class="btn-right">
				<a href="javascript:tbodyMonthExcelFun()" class="icon_btn width-100px background-00e04e"><span class="icon_clip"></span>엑셀 다운로드</a>
				<a class="margin-right-10 background-826fe8" id="btn_graphview_month">그래프 보기</a>
				<a class="margin-right-10 background-826fe8 none" id="btn_tableview_month">표 보기</a>
			</div>
			<!-- 표 내용 -->
			<div id="tableview_month">
				<div class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
					 <span
						class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총
						발송 <span class="m-t">000</span>건</span> <span class="block text-center margin-bottom-20"> <span
						class="inline-block margin-right-10" style="color: #00841f">성공
							<span class="m-s">000</span>건</span> <span class="inline-block margin-left-10"
						style="color: #af0000">실패 <span class="m-f">000</span>건</span>
					</span>
				</div>
				<table class="con_tb_2 width-100" cellpadding="0" cellspacing="0" border="0" style="table-layout:fixed">
					<thead>
						<tr>
							<th class="width-10" rowspan="2"><span>전송일</span></th>
							<th class="width-9" rowspan="2"><span style="background:#f2f7fd;">구분</span></th>
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
					<tbody id="tbodyDataMonth"></tbody>
				</table>
				
				<table id="tbodyMonthExcelTable" style="display: none">
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
					<tbody id="tbodyMonthExcel"></tbody>
				</table>
				
				
			</div>
			<!-- 그래프 내용 -->
			<div id="graphview_month" class="none">
				<div class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
					 <span
						class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총
						발송 <span class="m-t">000</span>건</span> <span class="block text-center margin-bottom-20"> <span
						class="inline-block margin-right-10" style="color: #00841f">성공
							<span class="m-s">000</span>건</span> <span class="inline-block margin-left-10"
						style="color: #af0000">실패 <span class="m-f">000</span>건</span>
					</span>
				</div>
				<div class="text-center line-height-90px padding-30 font-6f6f6f font-12px">
					<div class="text-center line-height-90px padding-30 font-6f6f6f font-12px">
						<div id="monthchart"></div>
						<div id="monthchart2"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- //검색결과 -->
	</div>
</body>
</html>
