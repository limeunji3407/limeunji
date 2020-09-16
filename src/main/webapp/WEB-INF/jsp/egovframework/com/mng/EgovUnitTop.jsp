<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="familyEventUseFlag" var="familyEventUseFlag" /> 
<spring:message code="g_senderkeyUse" var="g_senderkeyUse" /> 
<spring:message code="g_levelCodeUseFlag" var="g_levelCodeUseFlag" /> 
<spring:message code="g_MO_USE" var="g_MO_USE" /> 
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
</head>
<body>
		<header>
		<div>${pageContext.request.contextPath}</div>
			<div class="h-inner">
			<script>
					$(function(){
						$.ajax({
					       	url: "/getLogoList.do",
					       	type: "POST",
					        dataType: "json",
					       	success: function(jsondata){  
					       		
					       		if(jsondata != null && jsondata.data != null && jsondata.data.length > 0){
					       			var location = jsondata.data[0].location;
					       			var imageFile = jsondata.data[0].imageFile;
					       			console.log("로고 : " + location)
					       			console.log("파일경로 : " + imageFile)
					       			
					       			if(location.indexOf("L") > -1){
					       				$(".global-L").attr("src", imageFile);
					       			}
					       			
					       			if(location.indexOf("Hl") > -1){
					       				$(".global-Hl").attr("src", imageFile);
					       			}
					       			
									if(location.indexOf("Hr") > -1){
										$(".global-Hr").attr("src", imageFile);
					       			}
									
									if(location.indexOf("Fl") > -1){
										$(".global-Fl").attr("src", imageFile);
					       			}
									
									if(location.indexOf("Fr") > -1){
										$(".global-Fr").attr("src", imageFile);
					       			}
					       			
					       		}
					       	}
					   	});
					})
				</script>
				<h1 class="h_logo"><img class="global-Hl" src="/images/egovframework/com/usr/assets/h_logo.png" alt="인천광역시 서구" /></h1>
				<ul class="h-menu">
					<li><a href="#" class="icon_manage">전송관리</a>
						<ul class="sub sub1">
						<c:if test="${familyEventUseFlag eq 'Y'}" >	
							<li><a href="${pageContext.request.contextPath}/mng/congratuation">경조사 전송</a></li>
						</c:if>
						<c:if test="${g_senderkeyUse eq 'Y'}" >	
							<li><a href="${pageContext.request.contextPath}/mng/senderkey">카카오 Senderkey 관리</a></li>
						</c:if>
							<li><a href="${pageContext.request.contextPath}/mng/template">템플릿 관리</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/reservation">예약 관리</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/lstbytype">발송 단위별 전송</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/listall">전송 내역</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/statistics">기간별통계</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/statisticsbytype">유형별통계</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/statisticsbyjob">업무별통계</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/statisticsbyalt">알림톡템플릿별통계</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/statisticsbypart">부서별통계</a></li>
						</ul></li>
					<c:if test="${g_MO_USE eq 'Y'}" >	
					<li><a href="#" class="icon_vote">민원수신/문자투표</a>
						<ul class="sub sub2">
							<li><a href="${pageContext.request.contextPath}/mng/complain">민원관리</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/poll">문자투표</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/molist">전체수신내역</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/addnumber">#번호등록</a></li>
						</ul></li>
					</c:if>
						
					<li><a href="#" class="icon_system">시스템관리</a>
						<ul class="sub sub3">
							<li><a href="${pageContext.request.contextPath}/mng/sendconfig">전송기준설정</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/standardconfig">기준정보관리</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/systemlog">기록관리</a></li>
						</ul></li>
						
					<li><a href="${pageContext.request.contextPath}/mng/addressbook" class="icon_contact">주소록</a></li>
					
					<li><a href="#" class="icon_user">사용자관리</a>
						<ul class="sub sub5">
							<li><a href="${pageContext.request.contextPath}/mng/user">사용자 정보</a></li>
							<li><a href="${pageContext.request.contextPath}/mng/batchrole">일괄부여</a></li>
							<c:if test="${g_levelCodeUseFlag eq 'Y'}" >	
							<li><a href="${pageContext.request.contextPath}/mng/cashlevel">등급기준</a></li>
							</c:if>
						</ul></li>
					<li>
						<p title="${loginVO.name}">
							<span>${loginVO.name}</span> <span>님</span>
						</p>
						<div class="h_btn">
							<a href="/mng/mypage">마이페이지</a>
							<a href="${pageContext.request.contextPath}/uat/uia/actionLogout.do">로그아웃</a>
							<!--  a href="#">정보수정</a--> 
						</div>
					</li>
				</ul>
			</div>
		</header>
</body>
</html>