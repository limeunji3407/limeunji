<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_master_user_regist_menu" var="g_master_user_regist_menu" /> 
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
<style>
.dataTables_filter {
   display:none;
}
</style>
 
<script type="text/javaScript" language="javascript" defer="defer">  
$(document).ready(function() {
	
	//엑셀다운로드
	$("#tblstaffExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('tblstaff', '부서원' ,'부서원');
	    global.htmlTableToExcel('tblstaff','부서원','부서원', "${EXCEL_SHEET_DATA_COUNT}");
	});
    
   var oTable = $('#tblstaff').DataTable({
       dom: "frtip",
       ajax: "<c:url value='/getUserList' />",
       columns: [ 
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
          	},
          	{ data: "lvName" },
            { data: null,
                "defaultContent": "<button class='modify'>수정</button>" 
            }
       ],
	    paging:   true, 
	    info:     true,
	    language: {
	    	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"
	    }
   });
   global.settingTableCnt($("#table-cnt"), oTable);
   
   $('#tblstaff tbody').on( 'click', '.modify', function () {
       var data = oTable.row( $(this).closest('tr') ).data(); 
       var userId = data["emplyrId"];
       location.href="/usr/prtstaff?userId=" +data["emplyrId"];
   });

   $('#filter').on( 'click',   function () { 
	   oTable.columns(10).search($("#column6_search option:selected").val());
	   oTable.columns(11).search($("#column7_search option:selected").val());
	   if($("#search_option option:selected").val()){
		   oTable.columns( $("#search_option option:selected").val()  ).search( $("input[type=text][name=searchFilterStaff]").val() )
	   }
       oTable.draw();   
   });
});

</script>
</head>
<body>
         <!--contents-->
         <div class="con-inner">
            <!--타이틀-->
            <h1 class="con-title">
               <ul>
                  <li>부서원 관리</li>
                  <li class="icon_home"></li>
                  <li><span class="dot"></span>부서장기능</li>
                  <li><span class="dot"></span>부서원관리</li>
               </ul>
            </h1>


            <!-- 검색하기 -->
            <div  class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
               <!-- 검색설정 -->
               <div class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">
                  <!-- 상세선택 셀렉박스--> 
                  <select id="column6_search" class="select_blank_lightblue width-140px" style="margin-right:10px">
                     <option selected value="">상세선택</option>
                     <option value="근무">근무</option>
                     <option value="근무(파견)">근무(파견)</option>
                     <option value="휴직">휴직</option>
                     <option value="전출">전출</option>
                     <option value="퇴직">퇴직</option>
                  </select>

                  <!--유형 셀렉박스-->
                  <select id="column7_search" class="select_blank_lightblue width-140px" style="margin-right:10px">
                     <option selected value="">사용여부</option>
                    <option value="사용중">사용중</option>
                     <option value="사용안함">사용안함</option>
                     <option value="승인요청중">승인요청중</option>
                  </select>

                  <!-- 상태 셀렉박스-->
                  <select id="search_option" class="select_blank_lightblue width-140px" style="margin-right:10px">
                     <option selected value="">검색옵션</option>
                     <option value="0">이름</option>
                     <option value="2">아이디</option>
                     <option value="3">휴대전화</option>
                     <option value="4">일반전화</option>
                  </select>

                  <!--검색-->
                  <div class="inline-block width-300px">
                     <input id="searchFilterStaff" type="text" name="searchFilterStaff" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
                  </div>
                  <a id="filter" class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
               </div>
               <!-- //검색설정 -->


               <!-- 검색결과 -->
               <div class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
                  <div class="table_result_tit">
                    	총 <span id="table-cnt">000</span>개를 검색하였습니다.
                     <a id="tblstaffExlBtn" class="icon_btn width-100px background-00e04e"><span class="icon_clip"></span>엑셀 다운로드</a>
                     <c:if test="${g_master_user_regist_menu eq 'Y'}" >	
                     	<a class="margin-right-10 background-826fe8" href="/usr/addstaff">부서원 등록</a>
                     </c:if>
                  </div>
                  
                  <table id="tblstaff" class="display con_tb" width="100%">
                     <thead> 
                        <tr>
                           <th class="width-5" rowspan="2">이름</th>
                           <th class="width-9" rowspan="2">직위(급)</th>
                           <th class="width-10" rowspan="2">아이디</th>
                           <th class="width-10" rowspan="2">휴대전화</th>
                           <th class="width-10" rowspan="2">일반전화</th>
                           <th class="width-15" colspan="5">남은건수</th>
                           <th class="width-5" rowspan="2">상태</th>
                           <th class="width-5" rowspan="2">사용여부</th>
                           <th class="width-5" rowspan="2">등급</th>
                           <th class="width-10" rowspan="2">수정</th>
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