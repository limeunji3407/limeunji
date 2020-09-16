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
<style>
.dataTables_filter {
	display: none;
}
</style>
</head>
<script type="text/javaScript" language="javascript" defer="defer"> 
$(document).ready(function() { 

	
	 var oTable = $('#tbl_loginlog').DataTable({ 
	     dom: 'frtip',
	     ajax: {
	     	"type" : "POST",
	        "url" : "<c:url value='/getLoginLog.do' />",
	        "dataType": "JSON"
	     },
	     columns: [
	                   { data: "loginId" },
	                   { data: "loginNm" },
	                   { data: "creatDt" },
	                   { data: "loginIp" },
	                   { data: "loginMthd" }
	     ],
	     order: [ 2, 'desc' ],
			searching: false,
		    paging:   true, 
		    info:     true,
		    language: { 	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"  }
	 });

	 global.settingTableCnt($("#table-cnt"), oTable);
		var arr = ["a","b","c","d","aa","bb"];
     $('#searchid').autocomplete({
    	    source: arr,
    	    minLength: 1,
    	    delay: 100
    	}); 
     
     
		$('#searchBtn').on( 'click', function () {
		   if($("#searchFilter option:selected").val() == ""){
				   toastr.error("검색할 항목을 선택하세요");
				   return;
		   }
		   oTable
		        .columns( $("#filterOpt option:selected").val()  )
		        .search( $("input[type=text][name=searchKeyword]").val() )
		        .draw();  
		} );
});
</script>
<body>

	<!-- javascript warning tag  -->
	<noscript class="noScriptTitle">
		<spring:message code="common.noScriptTitle.msg" />
	</noscript>


	<input type="radio" checked name="tabmenu" id="tabmenu1">
	<label for="tabmenu1">접속기록조회</label>
	<div class="tabCon">
		<!-- 검색설정 -->
		<div class="tabmenu_search">
			<!-- 날짜선택-->
			<div
				class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
				<input type="date" id="start_dt_login" name="start_dt_login"
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
				<input type="date" id="end_dt_login" name="end_dt_login"
					class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"/>
			</div>

			<!--결과 체크박스-->
			<select class="select_blank_lightblue width-140px"
				style="margin-right: 10px">
				<option selected>결과</option>
				<option value="1">로그인성공</option>
				<option value="0">로그인실패</option>
				<option value="2">로그아웃</option>
			</select>


			<!--ID 자동완성-->
			<div class="inline-block width-260px">
				<input id="searchid" type="text" name="searchidU placeholder="
					" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
			</div>

			<!--이름 체크박스-->
			<select class="select_blank_lightblue width-140px"
				style="margin-right: 10px">
				<option selected>이름</option>
			</select>
			<!--검색-->
			<a id="searchBtn"
				class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
		</div>
		<!-- //검색설정 -->

		<!-- 검색결과 -->
		<div
			class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5">
			<div class="table_result_tit">총 <span id="table-cnt">000</span>개를 검색하였습니다.</div>
			<table id="tbl_loginlog" class="con_tb width-100" cellpadding="0"
				cellspacing="0" border="0">
				<thead>
					<tr>
						<th class="width-15">ID</th>
						<th class="width-10">이름</th>
						<th class="width-15">일시</th>
						<th class="width-15">IP</th>
						<th class="width-15">결과</th>
					</tr>
				</thead>
				<!--  
				<tbody>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="6"><spring:message code="common.nodata.msg" /></td>
						</tr>
					</c:if>
					<c:forEach items="${resultList}" var="result" varStatus="status">
						<tr>
							<td><c:out value='${result.logId}' /></td>
							<td><c:out value='${result.loginNm}' /></td>
							<td><c:out value='${fn:substring(result.creatDt,0,10)}' /></td>
							<td><c:out value='${result.loginIp}' /></td>
							<td>로그인 성공<c:out value='${result.loginMthd}' /></td>
							<td><img
								src="<c:url value='/images/egovframework/com/cmm/btn/btn_search.gif'/>"
								class="cursor"
								onclick="fn_egov_detail_loginLog('<c:out value="${result.logId}"/>'); return false;"
								alt="<spring:message code="title.detail" />"
								title="<spring:message code="title.detail" />"> <c:out
									value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}" /></td>
						</tr>
					</c:forEach>
				</tbody>
				-->
			</table>
		</div>
		<!-- //검색결과 -->
	</div>

</body>
</html>
