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
<style>
.dataTables_filter {
   display:none;
}
</style>
 
<script type="text/javaScript" language="javascript" defer="defer">  
$(document).ready(function() { 
	 
	var oTable = $('#tblstaff').DataTable({
		dom: "Bfrtip",
		ajax: "<c:url value='/getUserList' />",
		columns: [ 
			{ data: "userNm" },
		    { data: "userId" },
		    { data: "moblphonNo" },
		    { data: "sbscrbDe" },
	        { data: "rn" },
		    { data: null },
	        { data: "sttus" },
	       	{ 
	        	data: null,
	            defaultContent: "<button>수정</button> <button>해제</button>"
	        }
	    ]
	});

	$('#searchFilterStaff').on( 'keyup', function () {
		oTable.search( this.value ).draw();
	});
});
</script>
</head>
<body>
			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>부서원 관리</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>부서장기능</li>
						<li><span class="dot"></span>부서원관리</li>
					</ul>
				</h1>


				<!-- 검색하기 -->
				<div  class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
					<!-- 검색설정 -->
					<div class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">
						<!-- 상세선택 셀렉박스-->
						<!-- <select class="select_blank_lightblue width-140px" style="margin-right:10px">
							<option selected>상세선택</option>
							<option >근무</option>
							<option >근무(파견)</option>
							<option >휴직</option>
							<option >전출</option>
							<option >퇴직</option>
						</select> -->

						<!--유형 셀렉박스-->
						<!-- <select class="select_blank_lightblue width-140px" style="margin-right:10px">
							<option selected>사용여부</option>
							<option>사용</option>
							<option>미사용</option>
							<option>승인요청</option>
						</select> -->

						<!-- 상태 셀렉박스-->
						<!-- <select class="select_blank_lightblue width-140px" style="margin-right:10px">
							<option selected>검색옵션</option>
							<option>이름</option>
							<option>아이디</option>
							<option>휴대전화</option>
							<option>일반전화</option>
						</select> -->

						<div class="inline-block width-150px" style="margin-right:10px">검색어를 입력하세요 </div>
						<!--검색-->
						<div class="inline-block width-300px">
							<input id="searchFilterStaff" type="text" name="searchFilterStaff" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
						</div>
						<!-- <a class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a> -->
					</div>
					<!-- //검색설정 -->


					<!-- 검색결과 -->
					<div class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
						<div class="table_result_tit">
							총 00/000개를 검색하였습니다.
							<a class="icon_btn width-100px background-00e04e"><span class="icon_clip"></span>엑셀 다운로드</a>
							<a class="margin-right-10 background-826fe8" href="/usr/addstaff">부서원 등록</a>
						</div>
						
						<table id="tblstaff" class="display" width="100%">
							<thead>
								<tr>
									<th class="width-10">이름</th>
									<th class="width-11">직위(급)</th>
									<th class="width-10">아이디</th>
									<th class="width-13">휴대전화</th>
									<th class="width-13">일반전화</th>
									<th class="width-20">
										남은건수<br><span class="inline-block margin-top-5">단문 | 장문 | 멀티 | 알림톡 | 친구톡</span>
									</th>
									<th class="width-10">상태</th>
									<th class="width-13">사용여부</th>
								</tr>
							</thead>
							<!-- <tbody>
								<tr>
									<td>홍길동</td>
									<td>직위직급</td>
									<td>ascb1234</td>
									<td>01012341234</td>
									<td>01012341234</td>
									<td>
										<span class="inline-block margin-right-15">50</span>
										<span class="inline-block margin-right-15">50</span>
										<span class="inline-block margin-right-15">50</span>
										<span class="inline-block margin-right-15">50</span>
										<span class="inline-block">50</span>
									</td>
									<td>근무</td>
									<td>사용안함</td>
								</tr>
							</tbody> -->

							<!--검색결과 없을 시>
							<tfoot>
								<tr>
									<td  colspan="8">검색 결과가 없습니다.</td>
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
