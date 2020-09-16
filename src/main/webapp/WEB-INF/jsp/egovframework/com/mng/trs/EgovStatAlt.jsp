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
$(document).ready(function() {
	$("#part_id_month").change(function(){
		var orgnztId = $(this).val();
		
		$.ajax({
        	url: "/getUserListTotal?orgnztId="+orgnztId,
        	type: "GET",
            dataType: "json",
        	success: function(jsondata){
        		var str = "<option value=''>부서원(이름)</option>";
        		for(var i = 0 ; i < jsondata.data.length ; i++){
        			str += "<option value='"+jsondata.data[i].emplyrId+"'>"+jsondata.data[i].emplyrNm+"</option>";
        		}
        		$("#tags_month").html(str)
        	}
    	});
		
		
	})
});

 	function searchVaildAls(){
 		var start_dt = document.getElementById("start_dt_alt");
 		var end_dt = document.getElementById("end_dt_alt");
 		
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
 		var work_seq = $(".type-select-month").val();
 		var part_id = $("#part_id_month").val();
 		part_id=part_id.substring(part_id.length-3, part_id.length);
 		var user_id = $("#tags_month").val();
 		getAlsData(monthMin, start_dt.value, end_dt.value, work_seq);
 		
 	}
 	function getAlsData(month, start_dt, end_dt, work_seq, part_id, user_id){
 		console.log("getDayData invoked;;");
 		ajaxCallGet("/mng/statisticsbytypeals.do?start_dt="+start_dt+"&end_dt="+end_dt+"&month="+month+"&workSeq="+work_seq+"&part_id="+part_id+"&user_id="+user_id, function(res){
 			
 			var template = $.templates("#selectRstListAls"); // <!-- 템플릿 선언
	        var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
	        $("#tbodyDataAls").html(htmlOutput);
	         
	         
			var msgType = new Array();
			var success = new Array();
			var fail = new Array();
			
			success.push("성공")
			fail.push("실패")
			
			var totalCnt = 0; //총발송건수
			var totalCnts = 0; //발송성공
			var totalCntf = 0; //발송실패
			for(var i = 0 ; i < res.data.length ; i++){
				var msg_type = res.data[i].msgPayCode;
				var total = res.data[i].total;
				var totals = res.data[i].totals;
				var totalf = res.data[i].totalf;
				
				msgType.push(msg_type)
				success.push(totals)
				fail.push(totalf)
				
				totalCnt += parseInt(total);
				totalCnts += parseInt(totals);
				totalCntf += parseInt(totalf);
			}
			$(".m-t").text(totalCnt);
			$(".m-s").text(totalCnts);
			$(".m-f").text(totalCntf);
			
			var dayChart = c3.generate({
				bindto: '#alsChart',
				data: {
			        columns: [
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
			            },
			            type: 'category',
			            categories: msgType
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
				bindto: '#alsChart2',
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
 	function tbodyMonthExcelFun(){
		global.htmlTableToExcel('tbodyMonthExcelTable','통계관리(알림톡)','통계관리(알림톡)', "${EXCEL_SHEET_DATA_COUNT}");
	}
 </script>
 <script type="text/x-jsrender" id="selectRstListAls">
		{{for data}}
					<tr>
						<th rowspan="3"><span>{{:currentDay}}</span></th>
						<td><span>전송</span></td>
						<td><span>{{:not}}</span></td><td><span>{{:notr}}</span></td>
					</tr>
					<tr>
						<td><span class="success">성공</span></td>
						<td><span class="success">{{:nots}}</span></td><td><span class="success">{{:notrs}}</span></td>
					</tr>
					<tr>
						<td><span class="fail">실패</td>	
						<td><span class="fail">{{:notf}}</span></td><td><span class="fail">{{:notrf}}</span></td>
					</tr>
		{{/for}}
</script>
</head>
<body>
		
							<input type="radio" name="tabmenu" id="tabmenu2">
							<label for="tabmenu2">알림톡</label>
							<div class="tabCon">
								<!-- 검색설정 -->
								<div class="tabmenu_search">

									<!-- 부서 셀렉박스-->
									<select class="select_blank_lightblue width-120px" style="margin-right:10px" title="part_id" id="part_id_month" name="part_id_month">
										<option selected value="">부서선택</option>
										<c:forEach var="part_id" items="${partIdList}" varStatus="status">
											<option value="${part_id.orgnztId}" ${part_id.orgnztId == provider ? 'selected="selected"' : '' }>${part_id.orgnztNm}</option>
										</c:forEach>
									</select>
					
									<!-- 부서원(ID) 셀렉박스-->
									<select id="tags_month" class="select_blank_lightblue width-140px" style="margin-right: 10px">
									</select>
									
									<!-- 업무분류 셀렉박스-->
									<select class="select_blank_lightblue width-120px type-select-month" style="margin-right:10px">
									</select>


									<!-- 날짜선택-->
									<div class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
										<input type="date" class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent" name="start_dt_alt" id="start_dt_alt" placeholder="시작날짜" />
									</div>
									<div class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
									<div class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
									<div class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
									<div class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box margin-right-10">
										<input type="date" class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent" name="end_dt_alt" id="end_dt_alt" placeholder="종료일자" / >
									</div>

									<!--검색-->
									<a onclick="searchVaildAls()" class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue font-16px">검색</a>
								</div>
								<!-- //검색설정 -->

								<!-- 검색결과 -->
								<div class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5 margin-bottom-100">
									<div class="btn-right">
										<a class="icon_btn width-100px background-00e04e"><span class="icon_clip"></span>엑셀 다운로드</a>
										<a class="margin-right-10 background-826fe8" id="btn_graphview_als">그래프 보기</a>
										<a class="margin-right-10 background-826fe8 none" id="btn_tableview_als">표 보기</a>
									</div>
									<!-- 표 내용 -->
									<div id="tableview_als">
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
													<th class="width-10" rowspan="2"><span>구분</span></th>
													<th class="width-19 row-tit" colspan="2"><span>알림톡</span></th>
												</tr>
												<tr>
													<th class="row-txt row-txt-first"><span>알림톡</span></th>
													<th class="row-txt row-txt-last"><span>알림톡 대체</span></th>
												</tr>
											</thead>
											<tbody id="tbodyDataAls"></tbody>
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
									<div id="graphview_als" class="none">
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
											<div id="alsChart"></div>
											<div id="alsChart2"></div>
										</div>
									</div>
								</div>
								<!-- //검색결과 -->
							</div>
</body>
</html>
