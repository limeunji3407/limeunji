<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title><spring:message code="titleName" /></title><!-- 로그인 -->
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/bootstrap.min.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/bootstrap-datepicker.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/font.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/reset.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/custom.css' />">

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery-1.12.4.min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/bootstrap.min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/bootstrap-datepicker.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/custom.js'/>" ></script>
		
	
<script language="javascript">
function chk_all(val) {

	var arr_chk = document.getElementsByName("chk");

		if (val == "Y") {

			for(i=0;i< arr_chk.length; i++) {
				arr_chk[i].checked =true;
			}
		}
		else if(val == "N") {
			for(i=0;i< arr_chk.length; i++) {
				arr_chk[i].checked =false;
			}
		}
}

</script>	
</head>
<body>

<div class="wrap">

<!-- header -->
<c:import url="/EgovTop.do" />

<!-- contents -->	
<c:import url="/EgovContent.do" />
<!-- contents -->

<!-- bottom -->

	<footer>
		<div class="footer-inner">
			인천광역시서구| 주소: 인천광역시서구서곶로307(심곡동) | 대표전화: 1234-5678 ㅣ<a href="/agree">개인정보처리방침</a><br>
			<span>Copyright © 2019 Seo-Gu, Incheon, All rights reserved.</span>
		</div>
	</footer>
</div>

</body>
</html>
