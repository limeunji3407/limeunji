<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:message code="g_bDeptRank" var="g_bDeptRank" /> 
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
var oTableD;
$(document).ready(function() {
   
	
   /*부서정렬*/
   $(".open_pop_changPartNum").click(function(){
		 var searchCondition = $("#partOpt option:selected").val();
	     var searchKeyword = $("input[type=text][name=searchKeywordD]").val()
	     var obj = {
	    	 "searchCondition":searchCondition,
	    	 "searchKeyword":searchKeyword
	     }
	   $.ajax({
	       url: "<c:url value='/getDepartmentAll.do' />",
	       type: "POST",
	       data:obj,
	        dataType: "json",
	       success: function(jsondata){
	          var str = "";
	          for(var i = 0 ; i < jsondata.data.length ;i++){
	             var temp = jsondata.data[i];
	             var orgnztNm = temp.orgnztNm;
	             var sortNum = temp.sortNum;
	             var orgnztId = temp.orgnztId;
	             str +='\
	             <tr class="sortTr"><td style="text-align:center">'+orgnztNm+'</td><td><input style="text-align: center;border: 1px solid grey;" type="number" value="'+sortNum+'" name="sortNum"><input type="hidden"  value="'+orgnztId+'" name="orgnztId"></td></tr>\
	             ';
	          }
	          $("#fff").html(str)
	       }
	   });
   })
   
   /*엑셀다운로드*/
   $("#tbl_departmenteExlBtn").click(function(){
       global.htmlTableToExcel('tbl_department','부서정보관리','부서정보관리', "${EXCEL_SHEET_DATA_COUNT}");
   });

    $('.bs-callout-info').toggleClass('hidden', true);
    $('.bs-callout-warning').toggleClass('hidden', true);
   
   
   $('#part-form').parsley().on('field:validated', function() {
       var submitok = $('.parsley-error').length === 0;
       $('.bs-callout-info').toggleClass('hidden', !submitok);
       $('.bs-callout-warning').toggleClass('hidden', submitok);
     })
     .on('form:submit', function() { 
      return true; // Don't submit form for this demo     false
     });
   
   	function init(){
   		oTableD = $('#tbl_department').DataTable({ 
   	        dom: 'frtip',
   	        ajax: {
   	           "type" : "POST",
   	           "url" : "<c:url value='/getDepartment.do' />",
   	           "dataType": "JSON"
   	        },
   	        columns: [
   	        			 { data: "sortNum"},
   	                      { data: "orgnztNm" },
   	                      { data: "partCode" },
   	                      { data: "orgnztTel" },
   	                      { data: "cashlimitMonth" },
   	                      { data: "cashlimitTemp" },
   	                      { data: "cashlimitTemp" },
   	                      { data: "status" },
   	                      { 
   	                          data: null,
   	                            defaultContent: '<a class="icon_modify">수정</a><a class="icon_delete">삭제</a>'
   	                       },
   	                      { data: "orgnztId" }
   	        ],
   	        order: [7, "desc", 0, 'asc', 1, "asc" ],
   	        columnDefs:[{
   	             targets:[9],
   	              searchable:false,
   	              visible:false
   	        }],
   	       searching: false,
   	        paging:   true, 
   	        info:     true,
   	        language: {    "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"  }
   	    });
   		settingTableCnt($("#part-table-cnt"), oTableD);
   	}
   	init();
    
    /*부서등록*/
    $('#partInsertBtn').on( 'click', function () {
       $('#part-form').parsley().validate();
          if (!$('#part-form').parsley().isValid()) {
             return;
          }
          var cashlimitMonth = $('#cashlimitMonth').val();   
          var cashlimitTemp = $('#cashlimitTemp').val();   
          var orgnztNm = $('#orgnztNm').val();
          var orgnztTel = $('#orgnztTel').val();
          var orgnztId = $('#orgnztId').val();
          
          var sendNumberVOList = new Array();
          var sendingOrders = $("input[name='sendingOrder']");
          var sendingNumbers = $("input[name='sendingNumber']");
          for(var i = 0 ; i < sendingOrders.length ; i++){
        	  
        	  var temp = {
        			  "sendingOrder":sendingOrders.eq(i).val(),
        			  "sendingNumber":sendingNumbers.eq(i).val()
        	  }
        	  sendNumberVOList.push(temp);
          }
         var obj = {
            "cashlimitMonth": cashlimitMonth, 
            "cashlimitTemp" : cashlimitTemp,
            "orgnztNm" : orgnztNm,
            "orgnztTel" : orgnztTel,
            "partCode" : orgnztId,
            "sendNumberVOList": sendNumberVOList
         };
         console.log(obj)
           $.ajax({
              url: "<c:url value='/mng/insDeptment.do' />",
              type: "POST",
              data: JSON.stringify(obj),
               contentType:"application/json",
               dataType: "json",
               beforeSend:function(){
                   $('.wrap-loading').removeClass('display-none');
               },
            complete:function(){
                   $('.wrap-loading').addClass('display-none');
               },
              success: function(jsondata){
                   if(jsondata["data"]==0){
                       toastr.success('등록이 성공적으로 변경되었습니다'); 
                       $('#pop_add_dept').hide();
                    	$('.pop_bg').hide();
                   	oTableD.ajax.reload();settingTableCnt($("#part-table-cnt"), oTableD);
                      
                   }else{
                      alert("양식을 다시 확인하길 바랍니다.");
                   }
                  
              },
              error: function(request,status,error){
                 console.log("[ajax error]");
                 console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
                   toastr.success('오류:' + jsondata); 
              }
          });
    });
    
    /*부서수정*/
	$('#partUpdateBtn').on( 'click', function () {
       $('#part-update-form').parsley().validate();
          if (!$('#part-update-form').parsley().isValid()) {
             return;
          }
      
          var cashlimitMonth = $('#cashlimitMonth_up').val();   
          var cashlimitTemp = $('#cashlimitTemp_up').val();   
          var orgnztNm = $('#orgnztNm_up').val();
          var orgnztTel = $('#orgnztTel_up').val();
          var partCode = $('#orgnztId_up').val();
          
          var orgnztId = $('#orgId').val();
          
          var sendNumberVOList = new Array();
          var sendingOrders = $("input[name='sendingOrder']");
          var sendingNumbers = $("input[name='sendingNumber']");
          for(var i = 0 ; i < sendingOrders.length ; i++){
        	  
        	  var temp = {
        			  "sendingOrder":sendingOrders.eq(i).val(),
        			  "sendingNumber":sendingNumbers.eq(i).val()
        	  }
        	  sendNumberVOList.push(temp);
          }
          
          
         var obj = {
            "cashlimitMonth": cashlimitMonth, 
            "cashlimitTemp" : cashlimitTemp,
            "orgnztNm" : orgnztNm,
            "orgnztTel" : orgnztTel,
            "partCode" : partCode,
            "orgnztId": orgnztId,
            "sendNumberVOList":sendNumberVOList
          };
           $.ajax({
              url: "<c:url value='/mng/updDeptment.do' />",
              type: "POST",
              data: JSON.stringify(obj),
              contentType:"application/json",
               dataType: "json",
               beforeSend:function(){
                   $('.wrap-loading').removeClass('display-none');
               },
            complete:function(){
                   $('.wrap-loading').addClass('display-none');
               },
              success: function(jsondata){
                   if(jsondata["data"]==0){
                       toastr.success('수정이 성공적으로 변경되었습니다'); 
                       $('#pop_update_dept').hide();
                    $('.pop_bg').hide();
                   oTableD.ajax.reload();
                      
                   }else{
                      alert("양식을 다시 확인하길 바랍니다.");
                   }
                  
              },
              error: function(request,status,error){
                 console.log("[ajax error]");
                 console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
                   toastr.success('오류:' + jsondata); 
              }
          });
    });

    /*검색*/
      $('#searchBtnD').on( 'click', function () {
         if($("#partOpt option:selected").val() == ""){
               toastr.error("검색할 항목을 선택하세요");
               return;
         }
         var searchCondition = $("#partOpt option:selected").val();
         var searchKeyword = $("input[type=text][name=searchKeywordD]").val()
         
         oTableD.ajax.url( "/getDepartment.do?searchCondition="+searchCondition+"&searchKeyword="+searchKeyword ).load();
         settingTableCnt($("#part-table-cnt"), oTableD);
      });
      
    
    /*삭제*/
      $(document).on( 'click', '#tbl_department .icon_delete', function (e) {
         if (confirm("정말 삭제하시겠습니까?") == true){    //확인
            var obj = oTableD.row($(this).closest('tr')).data();
         	if(!obj.sendNumberVOList){
         		obj.sendNumberVOList = new Array();
         	}
             $.ajax({
                url: "<c:url value='/mng/delDeptment.do' />",
                   type: "POST",
                 data: obj,
                dataType: "json",
                   success: function(jsondata){  
                     if(jsondata["data"]==0){
                         alert("성공적으로 삭제 되었습니다.");
                         oTableD.ajax.reload();
                     }else if(jsondata["data"]==2){
                         alert("부서원이 남아있어 삭제 할 수 없습니다.");
                         oTableD.ajax.reload();
                     }else{
                        alert("삭제할수 없습니다.");
                     }
                   },
                   error: function(request,status,error){
                      alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
                   }
               });
          }
      }); 
      
      /*발신번호 수정*/
      $(document).on( 'click', '#tbl_department .icon_modify', function (e) {
    	  	$(".update-tr").remove();
             data = oTableD.row( $(this).closest('tr') ).data(); 
             var orgnztId = data.orgnztId;
             $.ajax({
                 url: "<c:url value='/getDepartmentCall.do?orgnztId="+orgnztId+"' />",
                 type: "GET",
                 dataType: "json",
                    success: function(jsondata){
                    	var list = jsondata.data;
                    	for(var i = 0 ; i < list.length ;i++){
                    		var str = '\
    					       	<tr class="update-tr">\
    	                    		<td><input type="number" name="sendingOrder" value="'+list[i].sendingOrder+'"></td>\
    	                    		<td><input type="number" name="sendingNumber"value="'+list[i].sendingNumber+'"></td>\
    	                    		<td><a class="call-tr">삭제</a></td>\
    	                    	</tr>\
    						';
    	                    $("#part-call-list-update").find("tr:last-child").after(str);
                    	}
                    
                    },
                    error: function(request,status,error){
                       alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
                    }
                });
             $("#orgnztNm_up").val(data["orgnztNm"]);
             $("#orgnztId_up").val(data["partCode"]);
             $("#orgnztTel_up").val(data["orgnztTel"]);
             $("#cashlimitMonth_up").val(data["cashlimitMonth"]);
             $("#cashlimitTemp_up").val(data["cashlimitTemp"]);
             $("#orgId").val(data["orgnztId"]);
             $('.pop_bg').show();
             $('.pop_update_part').show();
      });
      
      /*발신번호 영역 삭제*/
      $(document).on("click", ".call-tr", function(){
    	  $(this).parent().parent().remove();
      })
      
		$(document).on("click", "#insertBtn", function(){
			$(".create-tr").remove();
		})
		$(document).on("click", "#insTelBtn", function(){
			var str = '\
		       	<tr class="create-tr">\
	                 		<td><input type="number" name="sendingOrder" value="99"></td>\
	                 		<td><input type="number" name="sendingNumber"></td>\
	                 		<td><a class="call-tr">삭제</a></td>\
	                 	</tr>\
			';
	                 $("#part-call-list").find("tr:last-child").after(str);
		})
		$(document).on("click", "#insTelBtn-update", function(){
			var str = '\
		       	<tr class="update-tr">\
	                 		<td><input type="number" name="sendingOrder" value="99"></td>\
	                 		<td><input type="number" name="sendingNumber"></td>\
	                 		<td><a class="call-tr">삭제</a></td>\
	                 	</tr>\
			';
	                 $("#part-call-list-update").find("tr:last-child").after(str);
		})
});

function codeCheck() {
   $('#orgnztId').parsley().validate();
    if (!$('#orgnztId').parsley().isValid()) {
       return;
    }
    var orgnztId = $('#orgnztId').val();
   var obj = {
      "partCode" : orgnztId
   };
   $.ajax({
       url: "<c:url value='/mng/codeCheck.do' />",
          type: "POST",
       data: obj,
       dataType: "json",
          success: function(jsondata){  
            if(jsondata["data"]==0){
                toastr.success("사용 할 수 있는 코드입니다.");
               
            }else{
               toastr.error("중복되는 코드가 있습니다.");
            }
          },
          error: function(request,status,error){
             alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
          }
      });
}

/*부서정렬 수정*/
function updateSortform() {
   	var sortArray = new Array();
   	var sorts = $(".sortTr");
   	
   	for(var i = 0 ; i < sorts.length ; i++){
   		var orgnztId = sorts.eq(i).find("input[name='orgnztId']");
   		var sortNum = sorts.eq(i).find("input[name='sortNum']");
   		var obj = {
   				"orgnztId":orgnztId.val(),
   				"sortNum":sortNum.val()
   		}
   		sortArray.push(obj);
   	}
   $.ajax({
	      url: "<c:url value='/mng/updSortNum.do' />",
	      type: "POST",
	      data: JSON.stringify(sortArray),
	      dataType: "json",
	      contentType:"application/json",
	      success : function(jsondata){
	    	  if(jsondata.data == '0'){
	    		  
      			$(".pop_changPartNum").hide();
      			$('.pop_bg').hide();
                oTableD.ajax.reload();
	    	  }
	      },
	      error: function(request,status,error){
	      }
	   });
}
</script>
</head>
<body> 
	<input type="radio" checked name="standard_tabmenu2" id="tabmenu-1" value="">
	<label for="tabmenu-1">부서정보관리</label>
	<div class="tabCon">
	   <ul class="width-100 margin-bottom-100">
	      <li class="width-100 padding-top-60">
	         <div class="width-100 height-540px">
	         
	            <!--검색하기-->
	            <div class="background-f7fafc padding-15 border-box border-radius-bottom-5">
	               <select id="partOpt" class="select_blank_lightblue width-140px" style="margin-right:10px">
	                  <option value="">검색조건</option>
	                  <option value="0">부서명</option>
	                  <option value="1">부서코드</option>
	                  <option value="2">대표번호</option>
	               </select>
	
	               <div class="inline-block width-260px">
	                  <input type="text" name="searchKeywordD" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
	               </div>
	               <a id="searchBtnD" class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
	            </div>
	            
	            
	            
	            
	            <div class="clear margin-bottom-20"></div>
	
	            <!--검색내용-->
	            <div class="background-f7fafc padding-20 border-box border-radius-5">
	               <div class="table_result_tit">
						총 <span id="part-table-cnt">000</span>개를 검색하였습니다.
	                  	<a id="tbl_departmenteExlBtn" class="icon_btn width-100px background-00e04e" ><span class="icon_clip"></span>엑셀 다운로드</a>
		                <c:if test="${g_bDeptRank eq 'Y'}" >   
		                  <a class="open_pop_changPartNum margin-right-10 background-826fe8 margin-right-10">부서정렬</a>
		                </c:if>
	                  	<a class="open_pop_blocked margin-right-10 background-ffcd91" id="insertBtn">신규등록</a>
	               </div>
	               <table class="con_tb width-100" cellpadding="0" cellspacing="0" border="0" id="tbl_department">
	                  <thead>
	                     <tr>
	                        <th class="width-10">정렬순서</th>
	                        <th class="width-14">부서명</th>
	                        <th class="width-14">부서코드</th>
	                        <th class="width-14">대표번호</th>
	                        <th class="width-13">월한도건수</th>
	                        <th class="width-11">남은건수</th>
	                        <th class="width-14">임시추가건수</th>
	                        <th class="width-10">삭제여부(N:삭제상태)</th>
	                        <th class="width-10">수정/삭제</th>
	                        <th class="width-10" hidden>id</th>
	                     </tr>
	                  </thead>
	               </table>
	               
	               
	            </div>
	         </div>
	      </li>
	   </ul>
	</div>
    <div class="pop_wrap pop_blocked width-920px background-f7fafc border-radius-5" id="pop_add_dept">
    <div class="width-100  padding-rl-40 padding-tb-25 border-box">
    
    
       <form id="part-form" data-parsley-validate="">
	       <table class="width-100" border="0">
	          <colgroup>
	             <col style="width:50%" />
	             <col style="width:50%" />
	          </colgroup>
	          <tr>
	             <td class="text-center vertical-top padding-right-40 padding-bottom-100 border-box">
	                <h3 class="form_tit">정보상세</h3>
	                <table class="width-100 margin-top-20 margin-bottom-20">
	                   <colgroup>
	                      <col style="width:120px" />
	                      <col style="width:" />
	                   </colgroup>
	                   <tr>
	                      <th class="text-left">부서명</th>
	                      <td class="border-box"><input type="text" name="orgnztNm" id="orgnztNm" placeholder=""  data-parsley-required="true" value="부서명" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 text-left" data-parsley-required="true" data-parsley-trigger="change" data-parsley-pattern="^[가-힣]+$" data-parsley-maxlength="10" /></td>
	                   </tr>
	                   <tr>
	                      <th class="text-left">부서코드</th>
	                      <td class="relative">
	                         <input type="text" name="orgnztId" id="orgnztId" placeholder="부서코드를 입력하세요." data-parsley-required="true" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 padding-right-80 text-left" />
	                         <a class="absolute position-vertical-center position-right-10px width-60px height-36px line-height-36px font-14px border-radius-5 background-8bc5ff font-fff text-center" onclick="codeCheck()">중복검사</a>
	                      </td>
	                   </tr>
	                   <tr>
	                      <th class="text-left">대표번호</th>
	                      <td class="border-box"><input type="text" name="orgnztTel" id="orgnztTel"  data-parsley-required="true" placeholder="'-'제외 숫자만." class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 text-left"  data-parsley-type="digits" data-parsley-maxlength="11"/></td>
	                   </tr>
	                   <tr>
	                      <th class="text-left">월 한도건수</th>
	                      <td class="border-box"><input type="text" name="cashlimitMonth" id="cashlimitMonth" placeholder="" value="<c:out value="${roleVO.partcash}"/>" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 text-left" data-parsley-required="true" data-parsley-trigger="change" data-parsley-type="digits"/></td>
	                   </tr>
	                   <tr>
	                      <th class="text-left">임시 한도건수</th>
	                      <td class="border-box"><input type="text" name="cashlimitTemp" id="cashlimitTemp" placeholder="" value="0" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 text-left"  data-parsley-required="true" data-parsley-trigger="change" data-parsley-type="digits"/></td>
	                   </tr>
	                </table>
	             </td>
	             <td class="vertical-top padding-left-40 padding-bottom-100 border-box">
	                <h3 class="form_tit">발신번호</h3>
	                <table class="width-100 margin-top-20" border="0" id="orgztTel">
	                   <thead>
	                   <colgroup>
	                      <col style="width:35px" />
	                      <col style="width:75%" />
	                      <col style="width:" />
	                   </colgroup>
	                   <tr>
	                      <th class="text-left" style="width:20%">순서</th>
	                      <th class="text-center" style="width:60%">발신번호</th>
	                      <th class="text-center" style="width:20%">관리</th>
	                   </tr>
	                   </thead>
	                   <tbody id="part-call-list">
	            			<tr style="display: none"><td></td><td></td><td></td></tr>
	                     </tbody>
	                  </table>
	                  <a class="inline-block background-053c72 font-fff width-100 height-45px line-height-45px  border-radius-5 font-16px text-center margin-top-10" id="insTelBtn">추가</a>
	               </td>
	            </tr>
	         </table>
	       <!--버튼-->
	       <div class="btn-center">
	          <a class="background-053c72 font-fff" id="partInsertBtn">등록</a>
	          <a class="pop_close background-af0000 font-fff" id="partDeleteBtn">취소</a>
	       </div>
       </form>
    </div>
 </div>

<!-- popup 수정-->
         <div class="pop_wrap pop_update_part width-920px background-f7fafc border-radius-5" id="pop_update_dept">
         <div class="width-100  padding-rl-40 padding-tb-25 border-box">
            <form id="part-update-form" data-parsley-validate="">
            <table class="width-100" border="0">
               <colgroup>
                  <col style="width:50%" />
                  <col style="width:50%" />
               </colgroup>
               <tr>
                  <td class="text-center vertical-top padding-right-40 padding-bottom-100 border-box">
                     <h3 class="form_tit">정보상세</h3>
                     <table class="width-100 margin-top-20 margin-bottom-20">
                        <colgroup>
                           <col style="width:120px" />
                           <col style="width:" />
                        </colgroup>
                        <tr>
                           <th class="text-left">부서명</th>
                           <td class="border-box"><input type="text" id="orgnztNm_up" placeholder=""  data-parsley-required="true" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 text-left" data-parsley-required="true" data-parsley-trigger="change" data-parsley-maxlength="10" /></td>
                        </tr>
                        <tr>
                           <th class="text-left">부서코드</th>
                           <td class="relative">
                              <input type="text" id="orgnztId_up" placeholder="" data-parsley-required="true" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 padding-right-80 text-left" />
                           </td>
                        </tr>
                        <tr>
                           <th class="text-left">대표번호</th>
                           <td class="border-box"><input type="text" id="orgnztTel_up"  data-parsley-required="true" placeholder="'-'제외 숫자만." class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 text-left"  data-parsley-type="digits" data-parsley-maxlength="11"/></td>
                        </tr>
                        <tr>
                           <th class="text-left">월 한도건수</th>
                           <td class="border-box"><input type="text" id="cashlimitMonth_up" placeholder="" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 text-left" data-parsley-required="true" data-parsley-trigger="change" data-parsley-type="digits"/></td>
                        </tr>
                        <tr>
                           <th class="text-left">임시 한도건수</th>
                           <td class="border-box"><input type="text" id="cashlimitTemp_up" placeholder="" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 text-left"  data-parsley-required="true" data-parsley-trigger="change" data-parsley-type="digits"/></td>
                        </tr>
                        <tr hidden="">
                           <th class="text-left">오리진 아이디</th>
                           <td class="border-box"><input type="text" id="orgId" placeholder="" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box padding-left-20 text-left"  data-parsley-required="true" data-parsley-trigger="change"/></td>
                        </tr>
                     </table>
                  </td>
                  <td class="vertical-top padding-left-40 padding-bottom-100 border-box">
                     <h3 class="form_tit">발신번호</h3>
                     <table class="width-100 margin-top-20" border="0" id="orgztTel">
                        <thead>
                        <colgroup>
                           <col style="width:35px" />
                           <col style="width:75%" />
                           <col style="width:" />
                        </colgroup>
                        <tr>
                           <th class="text-left">순서</th>
                           <th class="text-center">발신번호</th>
                           <th class="text-center">관리</th>
                        </tr>
                        </thead>
                        <tbody id="part-call-list-update">
                 			<tr style="display: none"><td></td><td></td><td></td></tr>
                        </tbody>
                     </table>
                     <a class="inline-block background-053c72 font-fff width-100 height-45px line-height-45px  border-radius-5 font-16px text-center margin-top-10" id="insTelBtn-update">추가</a>
                  </td>
               </tr>
            </table>
            <!--버튼-->
            <div class="btn-center">
               <a class="background-053c72 font-fff" id="partUpdateBtn">수정</a>
               <a class="pop_close background-af0000 font-fff" id="partDeleteBtn">취소</a>
            </div>
            </form>
         </div>
      </div>
      
      <div id="pop_changPartNum" class="pop_wrap pop_changPartNum width-430px">
      <form id="changPartNum-form" data-parsley-validate="">
         <div class="pop_tit">부서명</div>
         <div class="width-100 padding-bottom-10 border-bottom-e9eced" style="overflow-y: scroll;max-height: 520px;">
            <table class="con_tb width-100" cellpadding="0" cellspacing="0" border="0" id="tbl_departName">
               <thead>
                     <tr>
                        <th class="width-14">부서명</th>
                        <th class="width-10">정렬순서</th>
                     </tr>
               </thead>
               <tbody id="fff">

               </tbody>
            </table>
         </div>
         <!-- 버튼 -->
         <div class="pop_btn" style="height: 150px;">
            <input type="button" id="updateSortBtn"
               class="background-8bc5ff border-8bc5ff font-fff margin-right-20" style="    margin-bottom: 20px;"
               onclick="updateSortform()" value="변경">
               <a style="width: 100%;"
               class="pop_close background-fff border-6f6f6f font-6f6f6f">취소</a>
         </div>
      </form>
   </div>
</body>
</html>
