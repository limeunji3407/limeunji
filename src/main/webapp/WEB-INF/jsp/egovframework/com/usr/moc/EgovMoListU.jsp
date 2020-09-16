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
<script type="text/javaScript" language="javascript" defer="defer"> 
$(document).ready(function() {
	
	var statYearActive = "${statYearActive}";
	if(statYearActive){
		$("#start_dt").val(statYearActive + "-01-01");
	}
	
	//엑셀다운로드
	$("#tblmoExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('tblmo', '전체수신내역' ,'전체수신내역');
	    global.htmlTableToExcel('tblmo','전체수신내역','전체수신내역', "${EXCEL_SHEET_DATA_COUNT}");
	});
	 

	var oTable = $("#tblmo").DataTable({
		
				dom : 'frtip',
			    ajax: {
			        "url" : "<c:url value='/getmolistall.do' />"
				},
				columns : [
	                   { data: "type" },
	                   { data: "receive_date" },
	                   { data: "mo_recipient" },
	                   { data: "mo_callback" },
	                   { data: "subject" },
                 	   { data: "content" }
				],
				paging : true,
				info : true,
				language : {"url" : "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"}
			});
	global.settingTableCnt($("#table-cnt"), oTable);
	
	
	$('#searchBtn').on( 'click', function () {
		oTable.columns(0).search($("#gubun-type option:selected").val());
		oTable.columns(2).search($("#numOpt option:selected").val());
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
        	        var tableDate = data[1] || 0; tableDate = global.replaceNumber(tableDate); tableDate = global.parse(tableDate);
        	        
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
	
	$('#tblmo').on('click', ':nth-child(6)', function(e) {
		var rowData = oTable.row(this).data();
		$("#tooltip").text(rowData["content"]).animate({ left: e.pageX, top: e.pageY }, 1);
		if (!$("#tooltip").is(':visible')) $("#tooltip").show()
   	})
	
    $('#tblmo').on('mouseleave', function(e) {
    	  $("#tooltip").hide()
    })
    
    ajaxCallGetNoParse("/mng/getnumberlist.do", function(res){
		var str = "";
		str +="<option value=''>#번호</option>";
		for(var i = 0 ; i < res.data.length ; i++){
			str +="<option value='"+res.data[i].mo_number+"'>"+res.data[i].mo_number+"</option>";
		}
		$("#numOpt").html(str);
	})

});
</script>
</head>
<body>

	<!--contents-->
	<div class="con-inner">
		<!--타이틀-->
		<h1 class="con-title">
			<ul>
				<li>전체수신내역</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>민원수신/문자투표</li>
				<li><span class="dot"></span>전체수신내역</li>
			</ul>
		</h1>


		<!-- 검색하기 -->
		<div
			class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
			<!-- 검색설정 -->
			<div
				class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">
				<!--구분 셀렉박스-->
				<select id="gubun-type" class="select_blank_lightblue width-100px"
					style="margin-right: 10px">
					<option selected value="">구분</option>
					<option value="민원">민원</option>
					<option value="문자투표">문자투표</option>
				</select>

				<!--#번호 셀렉박스-->
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

				<!--제목 체크박스-->
				<select id="filterOpt" class="select_blank_lightblue width-140px"
					style="margin-right: 10px">
					<option selected value="3">민원인번호</option>
					<option value="4">제목</option>
					<option value="5">내용</option>
					<option value="3">발신번호</option>
				</select>

				<!--검색-->
				<div class="inline-block width-150px">
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
					<a id="tblmoExlBtn" class="icon_btn width-100px background-00e04e"><span
						class="icon_clip"></span>엑셀 다운로드</a>
				</div>
				<div id="tooltip"></div>
				<table id="tblmo" class="display con_tb" style="width: 100%">
					<thead>
						<tr>
							<th class="width-10">구분</th>
							<th class="width-20">수신일시</th>
							<th class="width-12">#번호</th>
							<th class="width-16">발신번호/민원인번호</th>
							<th class="width-20">제목</th>
							<th class="width-25">내용</th>
						</tr>
					</thead>
				</table>

			</div>
			<!-- //검색결과 -->
		</div>
	</div>
</body>
</html>
