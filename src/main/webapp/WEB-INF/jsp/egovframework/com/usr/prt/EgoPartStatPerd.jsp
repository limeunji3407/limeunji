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
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-datepicker.css">
<link rel="stylesheet" href="css/font.css" />
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/custom.css" />
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery-3.2.1.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/custom.js"></script>
</head>
<body>
			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>부서 기간별 통계</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>부서장기능</li>
						<li><span class="dot"></span>부서기간별통계</li>
					</ul>
				</h1>


				<!-- 검색하기 -->
				<div class="relative width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
					<ul class="tabmenu">
						<li id="tab1" class="btnCon">
							<input type="radio" checked name="tabmenu" id="tabmenu1">
							<label for="tabmenu1">일별</label>
							<div class="tabCon">
								<!-- 검색설정 -->
								<div class="tabmenu_search">
									<!-- 부서원(ID) 셀렉박스-->
									<select class="select_blank_lightblue width-140px" style="margin-right:10px">
										<option selected>부서원(ID)</option>
									</select>


									<!-- 업무분류 셀렉박스-->
									<select class="select_blank_lightblue width-140px" style="margin-right:10px">
										<option selected>업무분류</option>
										<option>알림톡</option>
										<option>미선택</option>
										<option>알림</option>
										<option>민원</option>
										<option>공지</option>
										<option>비상</option>
										<option>기타</option>
									</select>
									
									<!-- 날짜선택-->
									<div class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
										<input type="text" id="datePicker" value="2020-02-01" class="datepicker-form text-right font-174962 font-16px padding-0 padding-right-15 margin-0 width-100 height-40px line-height-40px background-transparent" readonly />
									</div>
									<div class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
									<div class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
									<div class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
									<div class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box margin-right-10">
										<input type="text" id="datePicker" value="2020-02-02" class="datepicker-form text-right font-174962 font-16px padding-0 padding-right-15 margin-0 width-100 height-40px line-height-40px background-transparent" readonly / >
									</div>

									<!--검색-->
									<a class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue font-16px">검색</a>
								</div>
								<!-- //검색설정 -->

								<!-- 검색결과 -->
								<div class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5 margin-bottom-100">
									<div class="btn-right">
										<a class="icon_btn width-100px background-00e04e"><span class="icon_clip"></span>엑셀 다운로드</a>
										<a class="margin-right-10 background-826fe8" id="btn_graphview">그래프 보기</a>
										<a class="margin-right-10 background-826fe8 none" id="btn_tableview">표 보기</a>
									</div>
									<!-- 표 내용 -->
									<div id="tableview">
										<div class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
											2019.12.1~2019.12.9 XXX메시지
											<span class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총 발송 000건</span>
											<span class="block text-center margin-bottom-20">
												<span class="inline-block margin-right-10" style="color:#00841f">성공 000건</span>
												<span class="inline-block margin-left-10" style="color:#af0000">실패 000건</span>
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
											<tbody>
												<!-- 1 -->
												<tr>
													<th rowspan="3"><span>2020-02-06</span></th>
													<td><span>전송</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="success">성공</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="fail">실패</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
												</tr>
												<!-- //1 -->

												<!-- 2 -->
												<tr>
													<th rowspan="3"><span>2020-02-07</span></th>
													<td><span>전송</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="success">성공</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="fail">실패</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
												</tr>
												<!-- //2 -->

												<!-- 3 -->
												<tr>
													<th rowspan="3"><span>2020-02-07</span></th>
													<td><span>전송</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="success">성공</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="fail">실패</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
												</tr>
												<!-- //3 -->

												<!-- 4 -->
												<tr>
													<th rowspan="3"><span>합계</span></th>
													<td><span>전송</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="success">성공</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="fail">실패</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
												</tr>
												<!-- //4 -->
											</tbody>

											<!--검색결과 없을 시
											<tfoot>
												<tr>
													<td  colspan="11">검색 결과가 없습니다.</td>
											</tfoot>-->
										</table>
										<!-- 페이지 네비게이션 -->
										<div class="text-center">
											<ul class="pagination">
												<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
												<li class="page-item active"><a class="page-link" href="#">1</a></li>
												<li class="page-item"><a class="page-link" href="#">2</a></li>
												<li class="page-item"><a class="page-link" href="#">3</a></li>
												<li class="page-item"><a class="page-link" href="#">4</a></li>
												<li class="page-item"><a class="page-link" href="#">5</a></li>
												<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
											</ul>
										</div>
										<!-- //페이지 네비게이션 -->
									</div>
									<!-- 그래프 내용 -->
									<div id="graphview" class="none">
										<div class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
											2019.12.1~2019.12.9 XXX메시지
											<span class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총 발송 000건</span>
											<span class="block text-center margin-bottom-20">
												<span class="inline-block margin-right-10" style="color:#00841f">성공 000건</span>
												<span class="inline-block margin-left-10" style="color:#af0000">실패 000건</span>
											</span>
										</div>
										<div class="text-center line-height-90px padding-30 font-6f6f6f font-12px">
											그래프 영역
										</div>
									</div>
								</div>
								<!-- //검색결과 -->
							</div>
						</li>
						<li id="tab2" class="btnCon">
							<input type="radio" name="tabmenu" id="tabmenu2">
							<label for="tabmenu2">월별</label>
							<div class="tabCon">
								<!-- 검색설정 -->
								<div class="tabmenu_search">

									<!-- 부서원(ID) 셀렉박스-->
									<select class="select_blank_lightblue width-140px" style="margin-right:10px">
										<option selected>부서원(ID)</option>
									</select>

									<!-- 업무분류 셀렉박스-->
									<select class="select_blank_lightblue width-140px" style="margin-right:10px">
										<option selected>업무분류</option>
										<option>알림톡</option>
										<option>미선택</option>
										<option>알림</option>
										<option>민원</option>
										<option>공지</option>
										<option>비상</option>
										<option>기타</option>
									</select>
									
									<!-- 년 셀렉박스-->
									<select class="select_blank_lightblue width-80px" style="">
										<option selected>2019</option>
										<option>2018</option>
									</select><span class="inline-block font-16px margin-left-5 margin-right-5">년</span>

									<!-- 월 셀렉박스-->
									<select class="select_blank_lightblue width-70px">
										<option selected>12</option>
										<option>11</option>
										<option>10</option>
										<option>9</option>
										<option>8</option>
										<option>7</option>
										<option>6</option>
										<option>5</option>
										<option>4</option>
										<option>3</option>
										<option>2</option>
										<option>1</option>
									</select><span class="inline-block font-16px margin-left-5 margin-right-10">월 ~</span>
									<!-- 년 셀렉박스-->
									<select class="select_blank_lightblue width-80px">
										<option selected>2019</option>
										<option>2018</option>
									</select><span class="inline-block font-16px margin-left-5 margin-right-5">년</span>

									<!-- 월 셀렉박스-->
									<select class="select_blank_lightblue width-70px">
										<option selected>12</option>
										<option>11</option>
										<option>10</option>
										<option>9</option>
										<option>8</option>
										<option>7</option>
										<option>6</option>
										<option>5</option>
										<option>4</option>
										<option>3</option>
										<option>2</option>
										<option>1</option>
									</select><span class="inline-block font-16px margin-left-5 margin-right-10">월</span>
						
									<!--검색-->
									<a class="width-40px height-40px line-height-40px font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue font-16px">검색</a>
								</div>
								<!-- //검색설정 -->

								<!-- 검색결과 -->
								<div class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5 margin-bottom-100">
									<div class="btn-right">
										<a class="icon_btn width-100px background-00e04e"><span class="icon_clip"></span>엑셀 다운로드</a>
										<a class="margin-right-10 background-826fe8" id="btn_graphview_month">그래프 보기</a>
										<a class="margin-right-10 background-826fe8 none" id="btn_tableview_month">표 보기</a>
									</div>
									<!-- 표 내용 -->
									<div id="tableview_month">
										<div class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
											2019.12.1~2019.12.9 XXX메시지
											<span class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총 발송 000건</span>
											<span class="block text-center margin-bottom-20">
												<span class="inline-block margin-right-10" style="color:#00841f">성공 000건</span>
												<span class="inline-block margin-left-10" style="color:#af0000">실패 000건</span>
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
											<tbody>
												<!-- 1 -->
												<tr>
													<th rowspan="3"><span>2020-02-06</span></th>
													<td><span>전송</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="success">성공</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="fail">실패</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
												</tr>
												<!-- //1 -->
												<!-- 2 -->
												<tr>
													<th rowspan="3"><span>2020-02-07</span></th>
													<td><span>전송</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="success">성공</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="fail">실패</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
												</tr>
												<!-- //2 -->
											</tbody>

											<!--검색결과 없을 시
											<tfoot>
												<tr>
													<td  colspan="11">검색 결과가 없습니다.</td>
											</tfoot>-->
										</table>
										<!-- 페이지 네비게이션 -->
										<div class="text-center">
											<ul class="pagination">
												<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
												<li class="page-item active"><a class="page-link" href="#">1</a></li>
												<li class="page-item"><a class="page-link" href="#">2</a></li>
												<li class="page-item"><a class="page-link" href="#">3</a></li>
												<li class="page-item"><a class="page-link" href="#">4</a></li>
												<li class="page-item"><a class="page-link" href="#">5</a></li>
												<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
											</ul>
										</div>
										<!-- //페이지 네비게이션 -->
									</div>
									<!-- 그래프 내용 -->
									<div id="graphview_month" class="none">
										<div class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
											2019.12.1~2019.12.9 XXX메시지
											<span class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총 발송 000건</span>
											<span class="block text-center margin-bottom-20">
												<span class="inline-block margin-right-10" style="color:#00841f">성공 000건</span>
												<span class="inline-block margin-left-10" style="color:#af0000">실패 000건</span>
											</span>
										</div>
										<div class="text-center line-height-90px padding-30 font-6f6f6f font-12px">
											그래프 영역
										</div>
									</div>
								</div>
								<!-- //검색결과 -->
							</div>
						</li>
						<li id="tab3" class="btnCon">
							<input type="radio" name="tabmenu" id="tabmenu3">
							<label for="tabmenu3">연별</label>
							<div class="tabCon">
								<!-- 검색설정 -->
								<div class="tabmenu_search">

									<!-- 부서원(ID) 셀렉박스-->
									<select class="select_blank_lightblue width-140px" style="margin-right:10px">
										<option selected>부서원(ID)</option>
									</select>

									<!-- 업무분류 셀렉박스-->
									<select class="select_blank_lightblue width-140px" style="margin-right:10px">
										<option selected>업무분류</option>
										<option>알림톡</option>
										<option>미선택</option>
										<option>알림</option>
										<option>민원</option>
										<option>공지</option>
										<option>비상</option>
										<option>기타</option>
									</select>
									
									<!-- 년 셀렉박스-->
									<select class="select_blank_lightblue width-80px" style="">
										<option selected>2019</option>
										<option>2018</option>
									</select><span class="inline-block font-16px margin-left-5 margin-right-5">년 ~</span>

									<!-- 년 셀렉박스-->
									<select class="select_blank_lightblue width-80px">
										<option selected>2019</option>
										<option>2018</option>
									</select><span class="inline-block font-16px margin-left-5 margin-right-10">년</span>
						
									<!--검색-->
									<a class="width-40px height-40px line-height-40px font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue font-16px">검색</a>
								</div>
								<!-- //검색설정 -->

								<!-- 검색결과 -->
								<div class="background-fff padding-15 background-f7fafc border-box box-shadow-small border-radius-5 margin-bottom-100">
									<div class="btn-right">
										<a class="icon_btn width-100px background-00e04e"><span class="icon_clip"></span>엑셀 다운로드</a>
										<a class="margin-right-10 background-826fe8" id="btn_graphview_year">그래프 보기</a>
										<a class="margin-right-10 background-826fe8 none" id="btn_tableview_year">표 보기</a>
									</div>
									<!-- 표 내용 -->
									<div id="tableview_year">
										<div class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
											2019.12.1~2019.12.9 XXX메시지
											<span class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총 발송 000건</span>
											<span class="block text-center margin-bottom-20">
												<span class="inline-block margin-right-10" style="color:#00841f">성공 000건</span>
												<span class="inline-block margin-left-10" style="color:#af0000">실패 000건</span>
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
											<tbody>
												<!-- 1 -->
												<tr>
													<th rowspan="3"><span>2020-02-06</span></th>
													<td><span>전송</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="success">성공</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="fail">실패</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
												</tr>
												<!-- //1 -->
												<!-- 2 -->
												<tr>
													<th rowspan="3"><span>2020-02-07</span></th>
													<td><span>전송</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
													<td><span>9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="success">성공</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
													<td><span class="success">9,999,999</span></td>
												</tr>
												<tr>
													<td><span class="fail">실패</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
													<td><span class="fail">9,999,999</span></td>
												</tr>
												<!-- //2 -->
											</tbody>

											<!--검색결과 없을 시
											<tfoot>
												<tr>
													<td  colspan="11">검색 결과가 없습니다.</td>
											</tfoot>-->
										</table>
										<!-- 페이지 네비게이션 -->
										<div class="text-center">
											<ul class="pagination">
												<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
												<li class="page-item active"><a class="page-link" href="#">1</a></li>
												<li class="page-item"><a class="page-link" href="#">2</a></li>
												<li class="page-item"><a class="page-link" href="#">3</a></li>
												<li class="page-item"><a class="page-link" href="#">4</a></li>
												<li class="page-item"><a class="page-link" href="#">5</a></li>
												<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
											</ul>
										</div>
										<!-- //페이지 네비게이션 -->
									</div>
									<!-- 그래프 내용 -->
									<div id="graphview_year" class="none">
										<div class="text-center padding-10 border-bottom-96ccff font-6f6f6f font-12px margin-bottom-20">
											2019.12.1~2019.12.9 XXX메시지
											<span class="block text-center font-18px font-000 margin-top-10 margin-bottom-15">총 발송 000건</span>
											<span class="block text-center margin-bottom-20">
												<span class="inline-block margin-right-10" style="color:#00841f">성공 000건</span>
												<span class="inline-block margin-left-10" style="color:#af0000">실패 000건</span>
											</span>
										</div>
										<div class="text-center line-height-90px padding-30 font-6f6f6f font-12px">
											그래프 영역
										</div>
									</div>
								</div>
								<!-- //검색결과 -->
							</div>
						</li>
					</ul>
				</div>
			</div>

</body>
</html>
