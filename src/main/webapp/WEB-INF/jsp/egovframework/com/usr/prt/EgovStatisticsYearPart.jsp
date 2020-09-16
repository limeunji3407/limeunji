<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
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
 	function searchVaildYear(){
 		var start_dt = document.getElementById("year_start_dt");
 		var end_dt = document.getElementById("year_end_dt");
 		if(!start_dt.value){
 			alert('시작 연도을 선택해주세요.')
 			start_dt.focus();
 			return;
 		}
 		if(!end_dt.value){
 			alert('종료 연도을 선택해주세요.')
 			end_dt.focus();
 			return;
 		}
 		var yearMin = start_dt.value.replace("-","");// 201911
 		var yearMax = end_dt.value.replace("-",""); // 202008
 		
 		yearMin = yearMin.substr(0, 4);
 		yearMax = yearMax.substr(0, 4);
 		
 		var year = new Array();
 		
 		var tempMinYear = yearMin;
 		var size = 1;
 		for(tempMinYear ; tempMinYear <= yearMax ; tempMinYear++){
 			var tempYear = tempMinYear;
				var obj = {
						"yyyy": tempYear+"",
						"size":(size++)
				}
				
				year.push(obj);
			
 			
 		}
 		
 		var work_seq = $(".type-select-year").val();
 		var userId = $("#userOpt3").val();
 		var param = {
 				"start_dt":yearMin,
 				"end_dt":yearMax,
 				"date_list":year,
 				"work_seq":work_seq,
 				"user_id":userId
 				
 		}
 		
 		getYearData(param);
 		
 	}
 	function getYearData(param){
 		ajaxCallPost("/usr/partYearStatistics.do", param, function(res){
 			
			var template = $.templates("#tbodyDataExcel_"); // <!-- 템플릿 선언
	        var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
	        $("#tbodyYearExcel").html(htmlOutput);
 			
 			var template = $.templates("#selectRstList"); // <!-- 템플릿 선언
	        var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
	        $("#tbodyDatayear").html(htmlOutput);
 			
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
				console.log(res.data[i])
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
			$(".y-t").text(totalCnt);
			$(".y-s").text(totalCnts);
			$(".y-f").text(totalCntf);
			
			
			var yearChart = c3.generate({
				bindto: '#yearchart',
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
			
			var yearChart2 = c3.generate({
				bindto: '#yearchart2',
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
 	}
	function tbodyYearExcelFun(){
		global.htmlTableToExcel('tbodyYearExcelTable','부서기간별 통계(연별)','부서기간별 통계(연별)', "${EXCEL_SHEET_DATA_COUNT}");
	}
 </script>
</head>
<body>


	<input type="radio" name="tabmenu" id="tabmenu3">
	<label for="tabmenu3">연별</label>
	<div class="tabCon">
		<!-- 검색설정 -->
		<div class="tabmenu_search">
			<c:if test="${loginVO.orgnztId eq 'ORGNZT_0000000000000' or loginVO.partg_role eq 'Y' }">
				<select id="userOpt3" class="select_blank_lightblue width-140px"
					style="margin-right: 10px">
					<option selected value="0">부서원(ID)</option>
				</select>
				
			</c:if>
			<!-- 업무분류 셀렉박스-->
			<select class="select_blank_lightblue width-120px type-select-year"
				style="margin-right: 10px">
			</select>

			<!-- 년 셀렉박스-->
			<div
				class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
				<input type="month"
					class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"
					name="year_start_dt" id="year_start_dt" placeholder="시작날짜" />
			</div>
			<div
				class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
			<div
				class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
			<div
				class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
			<div
				class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box margin-right-10">
				<input type="month"
					class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"
					name="year_end_dt" id="year_end_dt" placeholder="종료일자"/ >
			</div>

			<!--검색-->
			<a onclick="searchVaildYear()"
				class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue font-16px">검색</a>
		</div>
		<!-- //검색설정 -->

		<!-- 검색결과 -->
		<div
			class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5 margin-bottom-100">
			<div class="btn-right">
				<a href="javascript:tbodyYearExcelFun()"class="icon_btn width-100px background-00e04e"><span
					class="icon_clip"></span>엑셀 다운로드</a> <a
					class="margin-right-10 background-826fe8" id="btn_graphview_year">그래프
					보기</a> <a class="margin-right-10 background-826fe8 none"
					id="btn_tableview_year">표 보기</a>
			</div>
			<!-- 표 내용 -->
			<div id="tableview_year">
				<div
					class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
					 <span
						class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총
						발송 <span class="y-t">000</span>건</span> <span class="block text-center margin-bottom-20"> <span
						class="inline-block margin-right-10" style="color: #00841f">성공
							<span class="y-s">000</span>건</span> <span class="inline-block margin-left-10"
						style="color: #af0000">실패 <span class="y-f">000</span>건</span>
					</span>
				</div>
				<table class="con_tb_2 width-100" cellpadding="0" cellspacing="0"
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
					<tbody id="tbodyDatayear"></tbody>
					</table>
					
					
					<table id="tbodyYearExcelTable" style="display: none">
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
					<tbody id="tbodyYearExcel"></tbody>
				</table>
					
						</div>
						<!-- 그래프 내용 -->
						<div id="graphview_year" class="none">
							<div
								class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
								 <span
									class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총
									발송 <span class="y-t">000</span>건</span> <span class="block text-center margin-bottom-20">
									<span class="inline-block margin-right-10"
									style="color: #00841f">성공 <span class="y-s">000</span>건</span> <span
									class="inline-block margin-left-10" style="color: #af0000">실패
										<span class="y-f">000</span>건</span>
								</span>
							</div>
							<div
								class="text-center line-height-90px padding-30 font-6f6f6f font-12px">
								<div
									class="text-center line-height-90px padding-30 font-6f6f6f font-12px">
									<div id="yearchart"></div>
									<div id="yearchart2"></div>
								</div>
							</div>
						</div>
						</div>
						<!-- //검색결과 -->
						</div>
</body>
</html>
