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
</head>
<body> 



							<input type="radio" checked name="standard_tabmenu2" id="tabmenu-1">
							<label for="tabmenu-1">부서대표번호정보관리</label>
							<div class="tabCon">
								<ul class="width-100 margin-bottom-100">
									<li class="width-100 padding-top-60">
										<div class="width-100 height-540px">
											
											
											
											<!--검색하기-->
											<div class="background-f7fafc padding-15 border-box border-radius-bottom-5">
												<!--부서대표번호명 셀렉박스-->
												<select class="select_blank_lightblue width-140px" style="margin-right:10px">
													<option selected>부서대표번호명</option>
													<option>부서대표번호코드</option>
													<option>대표번호</option>
												</select>

												<!--검색-->
												<div class="inline-block width-260px">
													<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
												</div>
												<a class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
											</div>
											<div class="clear margin-bottom-20"></div>

											<!--검색내용-->
											<div class="background-f7fafc padding-20 border-box border-radius-5">
												<div class="table_result_tit">
													총 00/000개를 검색하였습니다.
													<a class="icon_btn width-100px background-00e04e"><span class="icon_clip"></span>엑셀 다운로드</a>
													<a class="margin-right-10 background-826fe8 margin-right-10">부서대표번호정렬</a>
													<a class="open_pop_blocked margin-right-10 background-ffcd91">신규등록</a>
												</div>
												<table class="con_tb width-100" cellpadding="0" cellspacing="0" border="0" id="tbl_department">
													<thead>
														<tr>
															<th class="width-14">부서대표번호명</th>
															<th class="width-14">부서대표번호코드</th>
															<th class="width-14">대표번호</th>
															<th class="width-13">월한도건수</th>
															<th class="width-11">남은건수</th>
															<th class="width-14">임시추가건수</th>
															<th class="width-10">상태</th>
															<th class="width-10">삭제</th>
														</tr>
													</thead>
													
 
<%-- 	<c:forEach var="deptManage" items="${deptManageList}" varStatus="status">
	<tr>
		<td><a href="<c:url value='/uss/umt/dpt/getDeptManage.do'/>?pageIndex=${deptManageVO.pageIndex}&searchKeyword=${deptManageVO.searchKeyword}&orgnztId=${deptManage.orgnztId}"><c:out value="${deptManage.orgnztId}"/></a></td>
		<td class="left"><a href="<c:url value='/uss/umt/dpt/getDeptManage.do'/>?pageIndex=${deptManageVO.pageIndex}&searchKeyword=${deptManageVO.searchKeyword}&orgnztId=${deptManage.orgnztId}"><c:out value="${deptManage.orgnztNm}"/></a></td>
		<td class="left"></td>
	</tr>
	</c:forEach>
	</tbody> --%>
<%-- 													<tbody>
														<c:if test="${fn:length(deptManageList) == 0}">
														<tr>
															<td colspan="8"><spring:message code="common.nodata.msg" /></td>
														</tr>
														</c:if>
														<c:forEach var="deptManage" items="${deptManageList}" varStatus="status">
														<tr>
															<td>${deptManage.orgnztNm}</td>
															<td>${deptManage.orgnztId}</td>
															<td>02-070-1234</td>
															<td>0</td>
															<td>0</td>
															<td><c:out value="${deptManage.orgnztDc}"/></td>
															<td>등록</td>
															<td class="tb_btn">
																<a href="#" class="icon_delete">삭제</a>
															</td>
														</tr>
														</c:forEach>
													</tbody> --%>

													<!--검색결과 없을 시>
													<tfoot>
														<tr>
															<td  colspan="8">검색 결과가 없습니다.</td>
													</tfoot-->
												</table>
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
											</div>
											
											
											
											
											
											
										</div>
									</li>
								</ul>
							</div>








</body>
</html>
