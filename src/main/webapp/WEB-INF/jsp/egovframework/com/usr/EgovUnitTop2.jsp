<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_refuse_use" var="g_refuse_use" /> 
<spring:message code="g_MO_USE" var="g_MO_USE" /> 
<spring:message code="g_DeptHeadFunctionTN" var="g_DeptHeadFunctionTN" /> 
<spring:message code="g_user_alimtalk_template_manage_menu" var="g_user_alimtalk_template_manage_menu" /> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" >
$(document).ready(function () 
{
	$(".h-menu li").hover(function() {
		/* $(this).children("ul").stop().slideToggle(500); */
		
	        $(this).children("ul").stop().slideDown(300); 
	    }, function() {
	        $(this).children("ul").stop().slideUp('fast');
	   
	});

});
</script>

<title>eGovFrame 공통 컴포넌트</title>
</head>
<body>
<!--header -->
			<header>
				<div class="h-inner">
					<h1 class="h_logo"><img src="<c:url value='/images/egovframework/com/usr/assets/h_logo.png'/>" alt="인천광역시 서구" /></h1>
					<ul class="h-menu user-menu">
						<li>
							<a href="#" class="icon_manage">전송</a>
							<ul class="sub sub1">
								<li><a href="${pageContext.request.contextPath}/usr/sender">전송</a></li>
								<li><a href="${pageContext.request.contextPath}/usr/templatebox">내 저장함</a></li>
							<c:if test="${g_user_alimtalk_template_manage_menu eq 'Y'}" >	
								<li><a href="${pageContext.request.contextPath}/usr/template">템플릿 관리</a></li>
							</c:if>
							</ul>
						</li>

						<li>
							<a href="#" class="icon_system">전송관리</a>
							<ul class="sub sub2">
								<li><a href="/usr/reservation">예약관리</a></li>
								<li><a href="/usr/listbytype">발송단위별전송</a></li>
								<li><a href="/usr/listall">전체전송내역</a></li>
												
		<c:if test="${g_refuse_use eq 'Y'}" >	
						<li><a href="/usr/receiptrefusal">수신거부목록</a></li>
		</c:if>			
								
								
								<li><a href="/usr/statistics">기간별통계</a></li>
							</ul>
						</li>
						<c:if test="${g_MO_USE eq 'Y'}" >	
						<li>
							<a href="#" class="icon_vote">민원수신/문자투표</a>
							<ul class="sub sub3">
								<li><a href="/usr/complain">민원관리</a></li>
								<li><a href="/usr/poll">문자투표</a></li>
								<li><a href="/usr/molist">전체수신내역</a></li>
							</ul>
						</li>
						</c:if>
						<c:if test="${g_DeptHeadFunctionTN eq 'Y'}" >	
						<li>
							<a href="#" class="icon_user">부서장기능</a>
							<ul class="sub sub4">
								<li><a href="/usr/staff">부서원관리</a></li>
								<li><a href="/usr/translistbytype">부서발송단위별전송</a></li>
								<li><a href="/usr/translist">부서전송내역</a></li>
								<li><a href="/usr/statisticsbyjob">부서업무별통계</a></li>
							</ul>
						</li>
						</c:if>
						<li>
							<a href="/usr/adkbU" class="icon_contact">주소록</a>
						</li>

						<li>
							<p title="${loginVO.name}"><span>${loginVO.name}</span> <span>님</span></p>
							<div class="h_btn">
								<a href="/mypage">정보수정</a>
								<a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do">로그아웃</a>
							</div>
						</li>
						<li>
							<a href="#" class="">발송가능건수</a>
							<ul class="sub sub6">
								<li><a href="#">개별발송가능건수</a></li>
								<li><a href="#">친구톡(텍스트) : 00건</a></li>
								<li><a href="#">친구톡(텍스트) : 00건</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</header>


		<div class="pop_bg"></div>
		<script  type="text/javascript" src="<c:url value='/js/egovframework/com/usr/js/header-menu.js'/>"></script>
</body>
</html>
			