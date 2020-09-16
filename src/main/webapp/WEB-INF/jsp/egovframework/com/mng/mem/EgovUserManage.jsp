<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_UserList_Except_Approval" var="g_UserList_Except_Approval" />
<spring:message code="g_mng_userSearch" var="g_mng_userSearch" />
<spring:message code="EXCEL_SHEET_DATA_COUNT" var="EXCEL_SHEET_DATA_COUNT" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>iGOV SMS SYSTEM</title>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/jquery.form.js' />"></script>

<style>
.dataTables_filter {
	display: none;
}
</style>
<script type="text/javaScript" language="javascript" defer="defer">  
var data;

$(document).ready(function() {
	
	//엑셀다운로드
	$("#userlistExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('userlist', '사용자정보' ,'사용자정보');
	    global.htmlTableToExcel('userlist','사용자정보','사용자정보', "${EXCEL_SHEET_DATA_COUNT}");
	});
	
	var oTable = $("#userlist").DataTable({
    	 dom: 'frtip',
	     ajax: {
	     	"type" : "POST",
	        "url" : "<c:url value='/getUserList' />",
	        "dataType": "JSON"
	     },
	     columns: [
	           	{ data: "orgnztNm" },
	         	{ data: "emplyrNm" },
	          	{ data: "ofcpsNm" },
	          	{ data: "emplyrId" },
	          	{ data: "moblphonNo" },
	           	{ data: "offmTelno" },
	          	{ data: "sms" },
	          	{ data: "lms" },
	          	{ data: "mms" },
	          	{ data: "nms" },
	          	{ data: "fms" },
                { data: "sbscrbDe" },
                { 
              		data: "emplyrSttusCode",
              		render: function(data) { 
                       if(data == 'AAA') {
                          return '근무'; 
                 	   }else if(data == 'AAB'){
                 		   return '근무(파견)';
                        }else if(data == 'ABA'){
                 		   return '휴직';
                        }else if(data == 'DAB'){
                 		   return '전출';
                        }else if(data == 'DAA'){
                 		   return '퇴직';
                        }else{
                     	   return '';
                        }
                      }  
              	},
              	{ 
              		data: "useStatus",
              		render: function(data) { 
                        if(data == 'Y') {
                           return '사용중'; 
                  	   }else if(data == 'N'){
                  		   return '사용안함';
                         }else if(data == 'R'){
                  		   return '승인요청중';
                         }else{
                      	   return '';
                         }
                       }  
              	}
	     ],
	     	rowCallback: function( row, data, index ) {
	    	    if (data['lockAt'] == "0") {
	    	        $(row).hide();}
    	    },
		    paging:   true,
		    info:     true,
		    language: {
		    	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"
		    } 
    });
	global.settingTableCnt($("#table-cnt"), oTable);
	
	$('#userlist tbody').on( 'click', 'tr', function () {
       data = oTable.row( $(this).closest('tr') ).data(); 
       var userId = data["emplyrId"];
       location.href="/mng/updusr?userId="+data["emplyrId"];
	});
	
	$("#searchBtn").on('click', function () { 
		console.log($("#column6_search option:selected").val());
		  oTable.columns(0).search($("#partOpt option:selected").val());
		  oTable.columns(12).search($("#column6_search option:selected").val());
		  oTable.columns(13).search($("#column7_search option:selected").val());
		   if($("#search_option option:selected").val()){
			   oTable.columns( $("#search_option option:selected").val()  ).search( $("input[type=text][name=searchKeyword]").val() )
		   }
	       oTable.draw();  
	});
	
	
});
</script>


<script type="text/javaScript" language="javascript" defer="defer">
function fnCheckAll() {
    var checkField = document.listForm.checkField;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

function fnDeleteUser() {
    var checkField = document.listForm.checkField;
    var id = document.listForm.checkId;
    var checkedIds = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + id[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkedIds = id.value;
            }
        }
    }
    if(checkedIds.length > 0) {
        if(confirm("<spring:message code="common.delete.msg" />")){
        	document.listForm.checkedIdForDel.value=checkedIds;
            document.listForm.action = "<c:url value='/uss/umt/EgovUserDelete.do'/>";
            document.listForm.submit();
        }
    }
}
function fnSelectUser(id) {
    document.listForm.selectedId.value = id;
    array = id.split(":");
    if(array[0] == "") {
    } else {
        userTy = array[0];
        userId = array[1];
    }
   	document.listForm.selectedId.value = userId;
    document.listForm.action = "<c:url value='/uss/umt/EgovUserSelectUpdtView.do'/>";
    document.listForm.submit();

}
function fnAddUserView() {
    document.listForm.action = "<c:url value='/uss/umt/EgovUserInsertView.do'/>";
    document.listForm.submit();
}
function fnLinkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/EgovUserManage.do'/>";
    document.listForm.submit();
}
function fnSearch(){
	document.listForm.pageIndex.value = 1;
	document.listForm.action = "<c:url value='/mng/mem/EgovUserManage.do'/>";
    document.listForm.submit();
}
function fnViewCheck(){
    if(insert_msg.style.visibility == 'hidden'){
    	insert_msg.style.visibility = 'visible';
    }else{
    	insert_msg.style.visibility = 'hidden';
    }
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>


</script>
</head>
<body>

	<!--contents-->
	<div class="con-inner">




		<!--타이틀-->
		<h1 class="con-title">
			<ul>
				<li>사용자정보</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>사용자관리</li>
				<li><span class="dot"></span>사용자정보</li>
			</ul>
		</h1>

		<c:if test="${g_mng_userSearch eq 'Y'}" >	
		<form name="listForm"
			action="<c:url value='/mng/mem/EgovUserManage.do'/>" method="post">


			<!-- 검색하기 -->
			<div
				class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 "
				title="<spring:message code="common.searchCondition.msg" />">
				<!-- 검색설정 -->
				<div
					class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">
					<!-- 부서 셀렉박스-->
					<select id="partOpt" class="select_blank_lightblue width-140px"
						style="margin-right: 10px">
						<option selected>부서선택</option>
						<c:forEach var="part_id" items="${partIdList}"
							varStatus="status">
							<option value="${part_id.orgnztNm}"
								${part_id.orgnztId} == provider ? 'selected="selected"' : '' }>${part_id.orgnztNm}</option>
						</c:forEach>
					</select>

					<!-- 상태 셀렉박스-->
					<select id="column6_search" class="select_blank_lightblue width-140px"
						style="margin-right: 10px">
						 <option selected value="">상세선택</option>
	                     <option value="근무">근무</option>
	                     <option value="근무(파견)">근무(파견)</option>
	                     <option value="휴직">휴직</option>
	                     <option value="전출">전출</option>
	                     <option value="퇴직">퇴직</option>
					</select>
					<!-- 사용여부 셀렉박스-->
					<select id="column7_search" class="select_blank_lightblue width-140px"
						style="margin-right: 10px">
						   <option selected value="">사용여부</option>
                     <option value="사용중">사용중</option>
                     <option value="사용안함">사용안함</option>
                     <option value="승인요청중">승인요청중</option>
                     
					</select> <select id="search_option" class="select_blank_lightblue width-140px"
						style="margin-right: 10px">
						  <option selected value="">검색옵션</option>
                     <option value="1">이름</option>
                     <option value="3">아이디</option>
                     <option value="4">휴대전화</option>
                     <option value="5">일반전화</option>
					</select>

					<!--검색-->
					<div class="inline-block width-180px">
						<input
							class="input_blank width-100 padding-left-20 border-box border-8bc5ff"
							class="s_input" name="searchKeyword" type="text" size="35"
							title="<spring:message code="title.search" /> <spring:message code="input.input" />"
							value=''
							maxlength="255">

					</div>
					<a id="searchBtn"
						class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
				</div>
		</form>
		</c:if>

		<!-- 검색결과 -->
		<div
			class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
			<div class="table_result_tit">
			총 <span id="table-cnt">000</span>개를 검색하였습니다.
				<a class="icon_btn width-100px background-00e04e"
					id="userlistExlBtn"><span class="icon_clip"></span>엑셀 다운로드</a>
				<a class="margin-right-10 background-826fe8" href="/mng/addusr"
					title="<spring:message code="button.create" /> <spring:message code="input.button" />"><spring:message
						code="button.create" />사용자등록</a>

			</div>
			<table id="userlist" class="con_tb width-100" cellpadding="0"
				cellspacing="0" border="0" style="table-layout: fixed">
				<thead>
					<tr>
						<th class="width-10" rowspan="2">부서</th>
						<th class="width-10" rowspan="2">이름</th>
						<th class="width-11" rowspan="2">직위(급)</th>
						<th class="width-10" rowspan="2">아이디</th>
						<th class="width-13" rowspan="2">휴대전화</th>
						<th class="width-13" rowspan="2">일반전화</th>
						<th class="width-20" colspan="5">남은건수</th>
						<th class="width-10" rowspan="2">등록일시</th>
						<th class="width-5" rowspan="2">상태</th>
						<th class="width-10" rowspan="2">사용여부</th>
					</tr>
					<tr>
						<th>단문</th>
						<th>장문</th>
						<th>멀티</th>
						<th>알림톡</th>
						<th>친구톡</th>
					</tr>
				</thead>

			</table>
		</div>
		<!-- //검색결과 -->
	</div>
	</div>
</body>
</html>
