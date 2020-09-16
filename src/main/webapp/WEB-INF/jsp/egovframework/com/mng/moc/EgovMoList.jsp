<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	$("#tblmolistExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('tblmolist', '전체수신내역' ,'전체수신내역');
	    global.htmlTableToExcel('tblmolist','전체수신내역','전체수신내역', "${EXCEL_SHEET_DATA_COUNT}");
	});
	
	 var molist = $('#tblmolist').DataTable({
	     dom: "frtip",
	     ajax: {  
	        "url" : "<c:url value='/getmolistall.do' />" 
	     },
	    columns: [  
             { data: "type" },
             { data: "receive_date" },
             { data: "mo_callback" },
             { data: "mo_recipient" },
             { data: "subject" },
         	   { data: "content" }
	     ],
		    paging:   true, 
		    info:     true,
		    language: { 	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"  }
	 });

	  
		$('#searchBtn').on( 'click', function () {
		   if($("#searchFilter option:selected").val() == ""){
				   toastr.error("검색할 항목을 선택하세요");
				   return;
		   }
		   molist
		        .columns( $("#searchFilter option:selected").val()  )
		        .search( $("input[type=text][name=searchFilterKeyword]").val() )
		        .draw();
		} );
		
		$('#tblmolist').on('click', ':nth-child(6)', function(e) {
			var rowData = molist.row(this).data();
			$("#tooltip").text(rowData["content"]).animate({ left: e.pageX, top: e.pageY }, 1);
			if (!$("#tooltip").is(':visible')) $("#tooltip").show()
	   	})
		
	    $('#tblmolist').on('mouseleave', function(e) {
	    	  $("#tooltip").hide()
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
				<select class="select_blank_lightblue width-100px"
					style="margin-right: 10px">
					<option selected>구분</option>
					<option>민원</option>
					<option>문자투표</option>
				</select>

				<!--#번호 셀렉박스-->
				<select class="select_blank_lightblue width-140px"
					style="margin-right: 10px">
					<option selected>#번호</option>
					<option>#1110-99992</option>
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
				<select class="select_blank_lightblue width-140px"
					style="margin-right: 10px">
					<option selected>제목</option>
					<option>제목</option>
					<option>내용</option>
					<option>발신번호</option>
				</select>


				<!--검색-->
				<div class="inline-block width-170px">
					<input type="text" name="searchFilterKeyword" placeholder=""
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
					<!-- 총 00/000개를 검색하였습니다. -->
					<a id="tblmolistExlBtn"
						class="icon_btn width-100px background-00e04e"><span
						class="icon_clip"></span>엑셀 다운로드</a>
				</div>
				<div id="tooltip"></div>
				<table id="tblmolist" class="display" class="display"
					cellpadding="0" cellspacing="0" border="0"
					style="table-layout: fixed">
					<thead>
						<tr>
							<th class="width-10">구분</th>
							<th class="width-20">수신일시</th>
							<th class="width-12">#번호</th>
							<th class="width-13">발신번호/민원인번호</th>
							<th class="width-20">제목</th>
							<th class="width-25">내용</th>
						</tr>
					</thead>
					<!-- 							<tbody>
								<tr>
									<td>문자투표</td>
									<td>2019-01-02 10:30</td>
									<td>01012341234</td>
									<td>01012341234</td>
									<td class="relative">
										<a href="#footnote_desc_1" class="footnote" id="footnote_1">
											제목이 들어갑니다...<span class="note">제목이 들어갑니다. 제목이 들어갑니다. 제목이 들어갑니다.</span>
										</a>
									</td>
									<td class="relative">
										<a href="#footnote_desc_1" class="footnote" id="footnote_1">
											내용이 들어갑니다...<span class="note">내용이 들어갑니다. 내용이 들어갑니다. 내용이 들어갑니다.</span>
										</a>
									</td>
								</tr>
							</tbody> -->

					<!--검색결과 없을 시>
							<tfoot>
								<tr>
									<td  colspan="6">검색 결과가 없습니다.</td>
							</tfoot-->
				</table>

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
			</div>
			<!-- //검색결과 -->
		</div>
	</div>


</body>
</html>
