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

			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>기록관리</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>시스템관리</li>
						<li><span class="dot"></span>기록관리</li>
					</ul>
				</h1>
				<!-- 검색하기 -->
				<div class="relative width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
					<ul class="tabmenu">
						<li id="tab1" class="btnCon"> 
				
<c:import url="/mng/loginlog.do"></c:import> 			
						</li>
						<li id="tab2" class="btnCon">
					
<c:import url="/mng/userlog.do"></c:import> 		 
						</li>
					</ul>


				</div>
			</div>




</body>
</html>
