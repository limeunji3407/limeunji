<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="familyEventUseFlag" var="familyEventUseFlag" /> 
<spring:message code="g_partUse" var="g_partUse" /> 
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
<c:if test="${g_partUse eq 'Y'}" >	
			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>기준정보관리</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>시스템관리</li>
						<li><span class="dot"></span>기준정보관리</li>
					</ul>
				</h1>


				<div class="width-1350px height-710px margin-bottom-100">
					<ul class="standard_tabmenu2">
					
						<li id="tab-1" class="btnCon">
<c:import url="/mng/department.do"></c:import> 
						</li>
						
						<li id="tab-2" class="btnCon">
<c:import url="/mng/commoncodejob.do"></c:import>	
						</li>
						<li id="tab-3" class="btnCon">
<c:import url="/mng/passwordconfig.do"></c:import>
						</li>
						<li id="tab-4" class="btnCon">
<c:import url="/mng/bannerlist.do"></c:import>	
						</li>
						<li id="tab-5" class="btnCon">
<c:import url="/mng/logolist.do"></c:import>	
						</li>
						<c:if test="${familyEventUseFlag eq 'Y'}" >	
						<li id="tab-6" class="btnCon">
<c:import url="/mng/personalevent.do"></c:import>	
						</li>
						</c:if>
					</ul>
				</div>
			</div>
			
</c:if>

<c:if test="${g_partUse eq 'N'}" >
<script>
$('#tabmenu-2').attr('checked', true);
</script>

<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>기준정보관리</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>시스템관리</li>
						<li><span class="dot"></span>기준정보관리</li>
					</ul>
				</h1>
				<div class="width-1110px height-710px margin-bottom-100">
					<ul class="standard_tabmenu2">
						
						<li id="tab-1" class="btnCon">
<c:import url="/mng/commoncodejob.do"></c:import>	
						</li>
						<li id="tab-2" class="btnCon">
<c:import url="/mng/passwordconfig.do"></c:import>
						</li>
						<li id="tab-3" class="btnCon">
<c:import url="/mng/bannerlist.do"></c:import>	
						</li>
						<li id="tab-4" class="btnCon">
<c:import url="/mng/logolist.do"></c:import>	
						</li>
						<c:if test="${familyEventUseFlag eq 'Y'}" >	
						<li id="tab-5" class="btnCon">
<c:import url="/mng/personalevent.do"></c:import>	
						</li>
						</c:if>
					</ul>
				</div>
			</div>
</c:if>
</body>
</html>
