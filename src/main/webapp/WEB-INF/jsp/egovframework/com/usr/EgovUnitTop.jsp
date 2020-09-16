<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<spring:message code="g_refuse_use" var="g_refuse_use" /> 
<spring:message code="g_MO_USE" var="g_MO_USE" /> 
<spring:message code="g_DeptHeadFunctionTN" var="g_DeptHeadFunctionTN" /> 
<spring:message code="g_user_alimtalk_template_manage_menu" var="g_user_alimtalk_template_manage_menu" /> 
<spring:message code="g_dispCashImage" var="g_dispCashImage" /> 
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
					<h1 class="h_logo"><img class="global-Hl" src="<c:url value='/images/egovframework/com/usr/assets/h_logo.png'/>" alt="인천광역시 서구" /></h1>
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
							<c:choose>
								<c:when test="${loginVO.mo_role eq 'Y' or loginVO.orgnztId eq 'ORGNZT_0000000000000' }">
									<li>
										<a href="#" class="icon_vote">민원수신/문자투표</a>
										<ul class="sub sub3">
												<li><a href="/usr/complain">민원관리</a></li>
											<li><a href="/usr/poll">문자투표</a></li>
											<li><a href="/usr/molist">전체수신내역</a></li>
										</ul>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="#" class="icon_vote">민원수신/문자투표</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${g_DeptHeadFunctionTN eq 'Y' and loginVO.partg_role eq 'Y' }" >	
							<li>
								<a href="#" class="icon_user">부서장기능</a>
								<ul class="sub sub4">
									<li><a href="/usr/staff">부서원관리</a></li>
									<li><a href="/usr/translistbytype">부서발송단위별전송</a></li>
									<li><a href="/usr/translist">부서전송내역</a></li>
									<li><a href="/usr/partstatistics">부서기간별통계</a></li>
									<li><a href="/usr/statisticsbyjob">부서업무별통계</a></li>
								</ul>
							</li>
						</c:if>
						<c:if test="${g_DeptHeadFunctionTN ne 'Y' or loginVO.partg_role ne 'Y' }" >	
							<li>
								<a href="#" class="icon_user">부서장기능</a>
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
						<li style="width:158px;margin-right: unset;">
							<script>
								$(function(){
									$.ajax({
								       	url: "<c:url value='/usr/getCash.do'/>",
								       	type: "POST",
								        dataType: "json",
								       	success: function(jsondata){ 
								       		var cash = jsondata["cash"];
								       		var sms_fee = cash.SMS;
								       		var lms_fee = cash.LMS;
								       		var mms_fee = cash.MMS;
								       		var nms_fee = cash.NOT;
								       		var fmt_fee = cash.FRT;
								       		var fmi_fee = 0;
								       		console.log(nms_fee);
								       		if("${g_dispCashImage}" == 'num'){
													var loginVO_sms = "${loginVO.sms}";
													var priceVO_sms = "${egovMsgLinePriceVO.sms}";
													var sms = parseInt(parseInt(loginVO_sms)-parseInt(sms_fee));
													sms = parseInt(parseInt(sms)/parseInt(priceVO_sms));
													sms = parseInt(priceVO_sms) <= 0 || parseInt(loginVO_sms) <= 0 ? 0 : sms;
													$(".header-sms-gun").text(sms);
													
													var loginVO_lms = "${loginVO.lms}";
													var priceVO_lms = "${egovMsgLinePriceVO.lms}";
													var lms = parseInt(parseInt(loginVO_lms)-parseInt(lms_fee));
													lms = parseInt(parseInt(lms)/parseInt(priceVO_lms));
													lms = parseInt(priceVO_lms) <= 0 || parseInt(loginVO_lms) <= 0 ? 0 : lms;
													$(".header-lms-gun").text(lms);
													
													var loginVO_mms = "${loginVO.mms}";
													var priceVO_mms = "${egovMsgLinePriceVO.mms}";
													var mms = parseInt(parseInt(loginVO_mms)-parseInt(mms_fee));
													mms = parseInt(parseInt(mms)/parseInt(priceVO_mms));
													mms = parseInt(priceVO_mms) <= 0 || parseInt(loginVO_mms) <= 0 ? 0 : mms;
													$(".header-mms-gun").text(mms);
													
													var loginVO_nms = "${loginVO.nms}";
													var priceVO_nms = "${egovMsgLinePriceVO.notice}";
													console.log(loginVO_nms);
													console.log(priceVO_nms);
													var nms = parseInt(parseInt(loginVO_nms)-parseInt(nms_fee));
													nms = parseInt(parseInt(nms)/parseInt(priceVO_nms));
													nms = parseInt(priceVO_nms) <= 0 || parseInt(loginVO_nms) <= 0 ? 0 : nms;
													$(".header-nms-gun").text(nms);
													
													var loginVO_fmt = "${loginVO.fms}";
													var priceVO_fmt = "${egovMsgLinePriceVO.friendTxt}";
													var fmt = parseInt(parseInt(loginVO_fmt)-parseInt(fmt_fee));
													fmt = parseInt(parseInt(fmt)/parseInt(priceVO_fmt));
													fmt = parseInt(priceVO_fmt) <= 0 || parseInt(loginVO_fmt) <= 0 ? 0 : fmt;
													$(".header-fmt-gun").text(fmt);
													
													var loginVO_fmi = "${loginVO.fms}";
													var priceVO_fmi = "${egovMsgLinePriceVO.friendImg}";
													var fmi = parseInt(parseInt(loginVO_fmi)-parseInt(fmi_fee));
													fmi = parseInt(parseInt(fmi)/parseInt(priceVO_fmi));
													fmi = parseInt(priceVO_fmi) <= 0 || parseInt(loginVO_fmi) <= 0 ? 0 : fmi;
													
													$(".header-fmi-gun").text(fmi);
												}
								       		}
										})
								   	});
								
							</script>
							<c:if test="${g_dispCashImage eq 'num'}" >	
								<a href="#" class="">발송가능건수</a>
								<ul class="sub sub6">
									<li><a href="#">단문 : <span class="header-sms-gun"></span>건</a></li> 
									<li><a href="#">장문 : <span class="header-lms-gun"></span>건</a></li> 
									<li><a href="#">멀티 : <span class="header-mms-gun"></span>건</a></li> 
									<li><a href="#">알림톡 : <span class="header-nms-gun"></span>건</a></li> 
									<li><a href="#">친구톡(텍스트) : <span class="header-fmt-gun"></span>건</a></li> 
									<li><a href="#">친구톡(이미지) : <span class="header-fmi-gun"></span>건</a></li> 
								</ul>
							</c:if>
							<c:if test="${g_dispCashImage eq 'cash'}" >	
								<a href="#" class="">발송가능캐쉬</a>
								<ul class="sub sub6">
									<li><a href="#">단문 : ${loginVO.sms }원</a></li>
									<li><a href="#">장문 : ${loginVO.lms }원</a></li>
									<li><a href="#">멀티 : ${loginVO.mms }원</a></li>
									<li><a href="#">알림톡 : ${loginVO.nms }원</a></li>
									<li><a href="#">친구톡(텍스트) : ${loginVO.fms }원</a></li>
									<li><a href="#">친구톡(이미지) : ${loginVO.fms }원</a></li>
								</ul>
							</c:if>
						</li>
					</ul>
				</div>
			</header>


		<div class="pop_bg"></div>
		<script  type="text/javascript" src="<c:url value='/js/egovframework/com/usr/js/header-menu.js'/>"></script>
</body>
</html>
			