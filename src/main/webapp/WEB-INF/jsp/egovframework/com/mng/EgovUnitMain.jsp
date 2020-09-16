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
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/bootstrap.min.css' />" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/bootstrap-datepicker.css' />">
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/font.css' />" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/reset.css' />" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/custom.css' />" />
<script src="<c:url value='/js/egovframework/com/jquery.min.js' />"></script>
<script src="<c:url value='/js/egovframework/com/bootstrap.min.js' />"></script>
<script src="<c:url value='/js/egovframework/com/jquery-3.2.1.js' />"></script>
<script src="<c:url value='/js/egovframework/com/bootstrap-datepicker.js' />"></script>
<script src="<c:url value='/js/egovframework/com/custom.js' />"></script>

<!-- message toast -->
<script src="<c:url value='/js/egovframework/com/cmm/jquery.js' />"></script> 
<script src="<c:url value='/js/egovframework/com/toastr.min.js' />"></script> 
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/toastr.css' />">

<link rel="stylesheet" type="text/css" href="<c:url value='/js/egovframework/com/datatable/DataTables-1.10.20/css/jquery.dataTables.min.css' />"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/css/buttons.dataTables.min.css' />"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/egovframework/com/datatable/Select-1.3.1/css/select.dataTables.min.css' />"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/egovframework/com/datatable/Editor-1.9.2/css/editor.dataTables.min.css' />"/>

<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/jquery-3.2.1.js' />"></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/jquery-3.5.1.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/DataTables-1.10.20/js/jquery.dataTables.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/dataTables.buttons.min.js' />"></script> 
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Select-1.3.1/js/dataTables.select.min.js' />"></script> 
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Editor-1.9.2/js/dataTables.editor.min.js' />"></script> 
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/buttons.flash.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/buttons.print.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/Buttons-1.6.1/js/buttons.html5.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/pdfmake-0.1.36/vfs_fonts.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/pdfmake-0.1.36/pdfmake.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/JSZip-2.5.0/jszip.min.js' />"></script>

<%-- 
<link rel="stylesheet" type="text/css" href="<c:url value='/js/egovframework/com/datatable/dataTables.min.css' />"/>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/datatable/datatables.min.js' />"></script>  --%>


<script type="text/javascript" src="<c:url value='/js/egovframework/com/xlsx.full.min.js' />"></script> 
<script type="text/javascript" src="<c:url value='/js/egovframework/com/filesaver.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/excelupdown.js' />"></script>

<script src="https://cdn.jsdelivr.net/alasql/0.3/alasql.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.7.12/xlsx.core.min.js"></script>
<script src="/js/egovframework/com/common.js"></script>
<link href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=PT+Serif:400,700&amp;display=swap" rel="stylesheet" type="text/css">

<script src="/js/egovframework/com/commonAjax.js"></script>
<script src="/js/egovframework/com/bootstrap/bootstrap.bundle.js"></script>
<script src="/js/egovframework/com/bootstrap/bootstrap.min.js"></script> 
<script src="https://www.jsviews.com/download/jsrender.js"></script>

<script src="/js/egovframework/com/tjquery-ui.min.js"></script>
<script src="/js/egovframework/com/jquery.timepicker.min.js"></script>
<link href="/css/egovframework/com/jquery.timepicker.css" rel="stylesheet">

<script type="text/javaScript" language="javascript" defer="defer"> 
function showLoadingBar() { var maskHeight = $(document).height(); var maskWidth = window.document.body.clientWidth; var mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>"; var loadingImg = ''; loadingImg += "<div id='loadingImg' style='position:absolute; left:50%; top:40%; display:none; z-index:10000;'>"; loadingImg += " <img src='./img/loading.gif'/>"; loadingImg += "</div>"; $('body').append(mask).append(loadingImg); $('#mask').css({ 'width' : maskWidth , 'height': maskHeight , 'opacity' : '0.3' }); $('#mask').show(); $('#loadingImg').show(); }
function hideLoadingBar() { $('#mask, #loadingImg').hide(); $('#mask, #loadingImg').remove(); }
</script>
<!-- loading bar -->
<style>
.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
    position: fixed;
    left:0;
    right:0;
    top:0;
    background: rgba(0,0,0,0.2); /*not in ie */
    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */ 

}

    .wrap-loading div{ /*로딩 이미지*/
        position: fixed;
        top:50%;
        left:50%;
        margin-left: -21px;
        margin-top: -21px;
    }

    .display-none{ /*감추기*/
        display:none;
    }
</style>
<style>
/*  주소록 그룹생성 삭제 아이콘 */
.minus {
  display:inline-block;
  width:20px;
  height:20px;
  
  background:
    linear-gradient(#fff,#fff),
    linear-gradient(#fff,#fff),
    #000;
  background-position:center;
  background-size: 50% 0px,0px 50%; /*thickness = 2px, length = 50% (25px)*/
  background-repeat:no-repeat;
}
.plus {
  display:inline-block;
  width:20px;
  height:20px;
  
  background:
    linear-gradient(#fff,#fff),
    linear-gradient(#fff,#fff),
    #000;
  background-position:center;
  background-size: 50% 2px,2px 50%; /*thickness = 2px, length = 50% (25px)*/
  background-repeat:no-repeat;
}
.alt {
  background:
    linear-gradient(#000,#000),
    linear-gradient(#000,#000);
  background-position:center;
  background-size: 50% 2px,2px 50%; /*thickness = 2px, length = 50% (25px)*/
  background-repeat:no-repeat;
}
.radius {
  border-radius:50%;
}
</style>
<link rel="stylesheet" href="<c:url value='/js/egovframework/com/jstree/dist/themes/default/style.min.css' />" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/jstree/dist/jstree.min.js' />"></script>

<%-- <link rel="stylesheet" href="<c:url value='/js/egovframework/com/jstree/dist/jqtree.css' />" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/tree.jquery.js' />"></script>  --%>


<link rel="stylesheet" href="<c:url value='/js/egovframework/com/plugin/parsley/parsley.css' />" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/parsley/parsley.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/plugin/parsley/ko.js' />"></script>

<script type="text/javaScript" language="javascript" defer="defer">
function failStatus(statusCode) {
	var failStatus;
	if(statusCode == 'p'){
		failStatus = '폰 번호가 형식에 어긋난 경우';
	}else if (statusCode == '1'){
		failStatus = 'TIME OUT';
	}else if (statusCode == 'A'){
		failStatus = '일시 서비스 정지';
	}else if (statusCode == 'B'){
		failStatus = '기타 단말기 문제';
	}else if (statusCode == 'C'){
		failStatus = '착신 거절';
	}else if (statusCode == 'D'){
		failStatus = '메시지 저장개수 초과';
	}else if (statusCode == '2'){
		failStatus = '잘못된 전화번호';
	}else if (statusCode == 'f'){
		failStatus = '아이하트 자체 형식 오류';
	}else if (statusCode == 'g'){
		failStatus = 'SMS/LMS/MMS 서비스 불가 단말기';
	}else if (statusCode == 'h'){
		failStatus = '핸드폰 호 불가 상태';
	}else if (statusCode == 'i'){
		failStatus = 'SMC 운영자가 메시지 삭제';
	}else if (statusCode == 'j'){
		failStatus = '이통사 내부 메시지 Que Full';
	}else if (statusCode == 'k'){
		failStatus = '이통사에서 spam 처리';
	}else if (statusCode == 'l'){
		failStatus = 'www.nospam.go.kr 에 등록된 번호에 대해 아이하트에서 spam 처리한 건';
	}else if (statusCode == 'd'){
		failStatus = '기타';
	}else if (statusCode == 'e'){
		failStatus = '이통사 SMC 형식 오류';
	}else if (statusCode == 's'){
		failStatus = '메시지 스팸차단(NPro 내부)';
	}else if (statusCode == 'n'){
		failStatus = '수신번호 스팸차단(NPro 내부)';
	}else if (statusCode == 'r'){
		failStatus = '회신번호 스팸차단(NPro 내부)';
	}else if (statusCode == 'R'){
		failStatus = '누락된 센터로 재전송 요청(NPro 내부)';
	}else if (statusCode == 't'){
		failStatus = '스팸차단 중 2 개 이상 중복 차단(NPro 내부)';
	}else if (statusCode == 'Z'){
		failStatus = '메시지 접수 시 기타 실패';
	}else if (statusCode == 'm'){
		failStatus = '아이하트에서 Spam 처리한 건';
	}else if (statusCode == 'n'){
		failStatus = '건수제한에 걸린 경우 (건수제한 계약이 되어 있는 경우)';
	}else if (statusCode == 'o'){
		failStatus = '메시지의 길이가 제안된 길이를 벗어난 경우';
	}else if (statusCode == 'p'){
		failStatus = '폰 번호가 형식에 어긋난 경우';
	}else if (statusCode == 'Q'){
		failStatus = '필드 형식이 잘못된 경우 (예:데이터 내용이 없는 경우)';
	}else if (statusCode == 'x'){
		failStatus = 'MMS 콘텐츠의 정보를 참조할 수 없음';
	}else if (statusCode == 'u'){
		failStatus = 'BARCODE 생성 실패';
	}else if (statusCode == 'q'){
		failStatus = '메시지 중복 키 체크(NPro 내부)';
	}else if (statusCode == 'y'){
		failStatus = '하루에 한 수신번호에 보낼 수 있는 메시지 수량초과(NPro 내부)';
	}else if (statusCode == 'w'){
		failStatus = 'SMS 전송문자에 특정키워드가 없으면 SPAM 처리하여 메시지 전송제한(NPro 내부)';
	}else if (statusCode == 'z'){
		failStatus = '처리 되지 않은 기타오류';
	}else{
		failStatus = '성공';
	}
	return failStatus;
}

function contentShort(data) {
	if (data == null){
		return '';
	}else{
		var str = data; // cast numbers
	    return str.length < 10 ? str : str.substr(0, 9-1) +'&#8230;'; 
	}
}
</script>
</head>
<body>
<div class="wrap-loading display-none">
    <div><img src="<c:url value='/images/egovframework/com/loading.gif' />" /></div>
</div>  



<div class="wrap">
<!-- header -->
<c:import url="./EgovUnitTop.jsp" />
<!-- contents -->	
<c:import url="./EgovUnitContent.jsp" />
<!-- contents -->
<!-- bottom -->
	<footer>
		<div class="footer-inner">
			인천광역시서구| 주소: 인천광역시서구서곶로307(심곡동) | 대표전화: 1234-5678 ㅣ<a href="/agree">개인정보처리방침</a><br>
			<span>Copyright © 2019 Seo-Gu, Incheon, All rights reserved.</span>
		</div>
	</footer>
</div>
<div class="pop_bg"></div>
</body>
</html>
