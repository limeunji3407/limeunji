<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="EXCEL_SHEET_DATA_COUNT" var="EXCEL_SHEET_DATA_COUNT" />
<spring:message code="statYearActive" var="statYearActive" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>iGOV SMS SYSTEM</title>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/jquery.jqplot.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/plugins/jqplot.barRenderer.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/plugins/jqplot.pointLabels.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/plugins/jqplot.categoryAxisRenderer.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/plugins/jqplot.pieRenderer.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/plugins/jqplot.logAxisRenderer.js'/>"></script>
<link type="text/css" rel="stylesheet" href="<c:url value='/js/egovframework/com/plugin/jqplot/jquery.jqplot.min.css' />">

<style>
.dataTables_filter {
   display:none;
}
</style>
<script type="text/javaScript" language="javascript" defer="defer">  

$(document).ready(function() {
	
	var statYearActive = "${statYearActive}";
	if(statYearActive){
		$("#start_dt").val(statYearActive + "-01-01");
	}
	
	//엑셀다운로드
	$("#listbytypeExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('listbytype', '발송단위별전송' ,'발송단위별전송');
	    global.htmlTableToExcel('listbytype','발송단위별전송','발송단위별전송', "${EXCEL_SHEET_DATA_COUNT}");
	});
	 
		var oTable = $('#listbytype').DataTable({
		     dom: "frtip",
		     ajax:{
			    	"url" : "<c:url value='/getlistall.do' />",
		            "dataSrc": function ( jsondata ) { 
			            if( jsondata["modelAndView"]["model"]["data"] == "index.do" ) location.href = "/index.do"; 
		                return jsondata["modelAndView"]["model"]["data"];
		            }
			    },
		     columns: [ 
		    	 { data: "rcv_id" },
                 { 
 			    	data: "rcv_type",
 		    		render: function(data) { 
                            if(data == '0') {
                              return '단문'; 
 	                	   }else if(data == '1'){
 	                		   return '장문';
                            }else if(data == '2'){
 	                		   return '멀티';
                            }else if(data == '3'){
 	                		   return '알림톡';
                            }else if(data == '4'){
 	                		   return '친구톡(텍스트)';
                            }else if(data == '5'){
 	                		   return '친구톡(이미지)';
                            }else{
                         	   return '';
                            }
                          }  
 			   	   },
                 { data: "rcv_number" },
                 { data: "send_date" },
                 { data: "rcv_emply_chk" },
             	   { data: "rcv_type" },
             	   { data: "rcv_check" },
             	   { data: "rcv_etc" }
	        ],
	 	    paging:   true, 
		    info:     true,
		    language: {		    	 
		    	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"		    	
		    }
	}); 
		 global.settingTableCnt($("#table-cnt"), oTable);

		 $('#searchBtn').on( 'click', function () {
			var typeOptVal = "";
			if($("#typeOpt option:selected").val() == '0') typeOptVal = '단문';
			if($("#typeOpt option:selected").val() == '1') typeOptVal = '장문';
			if($("#typeOpt option:selected").val() == '2') typeOptVal = '멀티';
			if($("#typeOpt option:selected").val() == '3') typeOptVal = '알림톡';
			if($("#typeOpt option:selected").val() == '4') typeOptVal = '친구톡(텍스트)';
			if($("#typeOpt option:selected").val() == '5') typeOptVal = '친구톡(이미지)';
			oTable.columns(1).search(typeOptVal);
			if($("#filterOpt option:selected").val()){
				oTable.columns( $("#filterOpt option:selected").val()  ).search( $("input[type=text][name=searchKeyword]").val() )
			}
			oTable.draw(); 
		});
		 $.fn.dataTable.ext.search.push(
	   	    function( settings, data, dataIndex ) {
	   	    	if($("#start_dt").val() && $("#end_dt").val()){
	    	        var min = $('#start_dt').val(); min = global.replaceNumber(min);
	    	        var max = $('#end_dt').val(); max = global.replaceNumber(max);
	    	        var tableDate = data[3] || 0; tableDate = global.replaceNumber(tableDate); tableDate = global.parse(tableDate);
	    	        
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
});
</script> 
</head>
<body>
			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>발송단위별전송</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>전송관리</li>
						<li><span class="dot"></span>발송단위별전송</li>
					</ul>
				</h1>


				<!-- 검색하기 -->
				<div  class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
					<!-- 검색설정 -->
					<div class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">
						<!--구분 셀렉박스-->
						<select id="sendOpt" class="select_blank_lightblue width-100px" style="margin-right:10px">
							<option selected>구분</option>
							<option value="1">즉시</option>
							<option value="0">예약</option>
						</select>

						<!--유형 셀렉박스-->
						<select id="typeOpt" class="select_blank_lightblue width-140px" style="margin-right:10px">
							<option value="" selected>유형</option>
							<option value="0">단문</option>
							<option value="1">장문</option>
							<option value="2">멀티</option>
							<option value="3">알림톡</option>
							<option value="4">친구톡(텍스트)</option>
							<option value="5">친구톡(이미지)</option>
						</select>
						
						<!-- 날짜선택-->
						<div class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
							<input type="date" id="start_dt" class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent" />
						</div>
						<div class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
						<div class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
						<div class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
						<div class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box margin-right-10">
							<input type="date" id="end_dt" class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent" / >
						</div>

						<!--발신번호 체크박스-->
						<select id="filterOpt" class="select_blank_lightblue width-140px" style="margin-right:10px">
							<option selected value="2">발신번호</option>
						</select>


						<!--검색-->
						<div class="inline-block width-180px">
							<input id="searchKeyword" type="text" name="searchKeyword" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
						</div>
						<a id="searchBtn" class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
					</div>
					<!-- //검색설정 -->


					<!-- 검색결과 -->
					<div class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
						<div class="table_result_tit">
							총 <span id="table-cnt">000</span>개를 검색하였습니다.
							<a id="listbytypeExlBtn" class="icon_btn width-100px background-00e04e"><span class="icon_clip"></span>엑셀 다운로드</a>
						</div>
						<table id="listbytype" class="con_tb width-100" cellpadding="0" cellspacing="0" border="0">
							<thead>
								<tr>
									<th class="width-10">구분</th>
							<th class="width-10">유형</th>
							<th class="width-20">발신번호</th>
							<th class="width-20">발송일시</th>
							<th class="width-10">총발송</th>
							<th class="width-10">성공</th>
							<th class="width-10">실패</th>
							<th class="width-10">전송중</th>
								</tr>
							</thead>
						</table>

					</div>
					<!-- //검색결과 -->
				</div>
			</div>




		 <!-- popup_예약메세지수정 -->
         <div class="pop_wrap pop_modify width-430px" >
            <div class="pop_tit">예약메세지 수정</div>
			<div class="width-100 padding-bottom-10 border-bottom-e9eced">
				<table class="width-100" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th class="width-40 font-000 font-16px text-left vertical-align-top"><span class="inline-block margin-top-15">예약전송일시</span></th>
							<td class="text-left height-60px vertical-align-top">
								<!-- 날짜선택 -->
								<div class="inline-block relative width-100 height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box margin-bottom-10">
									<input type="date" id="update_dt" class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent" />
								</div>
								
								<!-- 셀렉박스 -->
								<select class="select_blank_lightblue width-120px" style="margin-right:9px">
									<option selected>10시</option>
									<option></option>
									<option></option>
									<option></option>
								</select>
								<select class="select_blank_lightblue width-100px">
									<option selected>20분</option>
									<option></option>
									<option></option>
									<option></option>
								</select>
							</td>
						</tr>
						<tr>
							<th class="width-40 font-000 font-16px text-left vertical-align-top"><span class="inline-block margin-top-15">예약된 수신번호</span></th>
							<td class="text-left height-60px vertical-align-top">
								<!-- 검색박스 -->
								<div class="widht-100 margin-top-10">
									<input type="text" name="" placeholder="검색할 번호를 입력하세요" class="input_blank width-100 border-box border-8bc5ff" style="padding-left:10px;" />
								</div>
								<div class="widht-100 margin-top-10 padding-left-5 height-24px line-height-24px font-16px font-174962">
									검색할 번호를 입력하세요<a class="float-right icon_modify width-55px height-20px line-height-20px background-eee border-radius-10 font-000 font-10px text-right padding-right-10 margin-top-2 border-box">수정</a>
								</div>
								<div class="widht-100 margin-top-10 padding-left-5 height-24px line-height-24px font-16px font-174962">
									검색할 번호를 입력하세요<a class="float-right icon_modify width-55px height-20px line-height-20px background-eee border-radius-10 font-000 font-10px text-right padding-right-10 margin-top-2 border-box">저장</a>
								</div>
							</td>
						</tr>
				</table>
			</div>
            <div class="width-100 font-16px font-000 text-left margin-top-20 margin-bottom-30">
				<span class="font-bold line-height-default">2개</span>의 수신번호가 <span class="font-bold">수정</span>되어 <span class="font-bold">2019-12-20 14:00 예약전송</span>으로 수정됩니다.
			</div>
			<!-- 버튼 -->
			<div class="pop_btn">
				<a class=" background-8bc5ff border-8bc5ff font-fff margin-right-20">예약수정</a>
				<a class="pop_close background-fff border-6f6f6f font-6f6f6f">취소</a>
			</div>
        </div>


		 <!-- popup 수신번호 -->
         <div class="pop_wrap pop_receive width-430px">
            <div class="width-100 font-18px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">수신번호</div>
			<!--정보가 있을 경우-->
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
				<div class="width-100 height-30px line-height-30px text-center  border-radius-5 border-eaeaea font-000 font-16px border-box margin-bottom-5">010-1234-5678</div>
				<div class="width-100 height-30px line-height-30px text-center  border-radius-5 border-eaeaea font-000 font-16px border-box margin-bottom-5">010-1234-5678</div>
			</div>

			<!--정보가 없을 경우-->
			<div class="width-100 margin-auto margin-top-40 margin-bottom-40 text-center font-16px font-000"  style="display:none;">
				직원 주소록에 정보가 존재하지 않습니다.
				<!--div class="width-100 margin-auto margin-top-20 text-center font-14px font-ff6464">*직원주소록을 사용하여 발송한 경우에만 수신자 정보가 표시 됩니다.</div-->			
			</div>
			
			<!--버튼-->
			<div class="pop_btn">
				<a class="pop_close background-8bc5ff border-8bc5ff font-fff">확인</a>
			</div>
        </div>

</body>
</html>
