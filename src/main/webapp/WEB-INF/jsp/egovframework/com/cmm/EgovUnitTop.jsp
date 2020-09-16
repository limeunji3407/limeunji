<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/usr/font.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/usr/reset.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/usr/custom.css' />">
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery-1.12.4.min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/custom.js'/>" ></script>
<title>eGovFrame 공통 컴포넌트</title>
</head>
<body>
<!--header -->
			<header>
				<div class="h-inner">
					<h1 class="h_logo"><img src="<c:url value='/images/egovframework/com/usr/assets/h_logo.png'/>" alt="인천광역시 서구" /></h1>
					<ul class="h-menu user-menu">
						<li>
							<a href="" class="icon_manage">전송</a>
							<ul class="sub sub1">
								<li><a href="#">전송</a></li>
								<li><a href="#">내 저장함</a></li>
								<li><a href="#">템플릿 관리</a></li>
							</ul>
						</li>

						<li>
							<a href="" class="icon_system">전송관리</a>
							<ul class="sub sub2">
								<li><a href="#">예약관리</a></li>
								<li><a href="#">발송단위별전송</a></li>
								<li><a href="#">전체전송내역</a></li>
								<li><a href="#">수신거부목록</a></li>
								<li><a href="#">기간별통계</a></li>
							</ul>
						</li>
						<li>
							<a href="" class="icon_vote">민원수신/문자투표</a>
							<ul class="sub sub3">
								<li><a href="#">민원관리</a></li>
								<li><a href="#">문자투표</a></li>
								<li><a href="#">전체수신내역</a></li>
							</ul>
						</li>
						<li>
							<a href="" class="icon_user">부서장기능</a>
							<ul class="sub sub4">
								<li><a href="#">부서원관리</a></li>
								<li><a href="#">부서발송단위별전송</a></li>
								<li><a href="#">부서전송내역</a></li>
								<li><a href="#">부서업무별통계</a></li>
							</ul>
						</li>
						<li>
							<a href="" class="icon_contact">주소록</a>
							<ul class="sub sub5">
								<li><a href="#">개인주소록</a></li>
								<li><a href="#">부서주소록</a></li>
								<li><a href="#">공유주소록</a></li>
								<li><a href="#">직원주소록</a></li>
							</ul>
						</li>

						<li>
							<p><span>김전하</span> 님</p>
							<div class="h_btn">
								<a href="#">정보수정</a>
								<a href="#">로그아웃</a>
							</div>
						</li>
						<li>
							<a href="" class="">발송가능건수</a>
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
		<script src="<c:url value='/js/egovframework/com/usr/js/header-menu.js'/>"></script>
</body>
</html>
			