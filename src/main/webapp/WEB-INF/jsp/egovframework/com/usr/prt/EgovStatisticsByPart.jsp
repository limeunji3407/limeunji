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
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/jquery.jqplot.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/plugins/jqplot.barRenderer.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/plugins/jqplot.pointLabels.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/plugins/jqplot.categoryAxisRenderer.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/plugins/jqplot.pieRenderer.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/jqplot/plugins/jqplot.logAxisRenderer.js'/>"></script>
<link type="text/css" rel="stylesheet" href="<c:url value='/js/egovframework/com/plugin/jqplot/jquery.jqplot.min.css' />">
<!-- Load c3.css -->
<link href="/css/egovframework/com/c3.css" rel="stylesheet">
<script src="/js/egovframework/com/d3-5.8.2.min.js" charset="utf-8"></script>
<script src="/js/egovframework/com/c3.min.js"></script>
<script src="/js/egovframework/com/datePicker.js"></script>
<link href="/css/egovframework/com/jquery-ui.min.css" rel="stylesheet">


<script src="/js/egovframework/com/tjquery-ui.min.js"></script>
<script src="/js/egovframework/com/jquery.timepicker.min.js"></script>
<link href="/css/egovframework/com/jquery.timepicker.css" rel="stylesheet">

<script src="/js/egovframework/com/commonAjax.js"></script>
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
							<c:import url="/usr/partstatdaily.do"></c:import>
						</li>
						<li id="tab2" class="btnCon">
							<c:import url="/usr/partstatmonth.do"></c:import>
						</li>
						<li id="tab3" class="btnCon">
							<c:import url="/usr/partstatyear.do"></c:import>
						</li>
					</ul>
				</div>
			</div>



</body>
</html>
