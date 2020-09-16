<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
var oTableCC;
var editorCC;
var oTableCCInfo;
var editorCCInfo;
var globalId = "${loginVO.id}";
var globalCodeId;
$(document).ready(function() {
	
	//엑셀다운로드 상위메뉴
	$("#commoncodejobExlBtn").click(function(){
	    global.htmlTableToExcel('commoncodejob','기준정보설정','기준정보설정', "${EXCEL_SHEET_DATA_COUNT}");
	});
	
	//엑셀다운로드 하위메뉴
	$("#commoncodejobExlBtnDetail").click(function(){
	    global.htmlTableToExcel('commoncodejobDetail','업무분류','업무분류설정', "${EXCEL_SHEET_DATA_COUNT}");
	});

	
	/*기준정보 상위 데이터 불러오기*/
	function init(){
		editorCC = new $.fn.dataTable.Editor({
	        table: "#commoncodejob",
	        idSrc:  'codeId',
	        fields: [
	        	{ label: "codeId", name: "codeId" }, 
	        	{ label: "codeIdNm", name: "codeIdNm" }, 
	        	{ label: "useAt", name: "useAt" }, 
	        	{ label: "codeIdDc", name: "codeIdDc" }
	        ]
	    });
		 oTableCC = $("#commoncodejob").DataTable({
		     dom: 'frtip',
		     ajax: {
		     	"type" : "POST",
		        "url" : "<c:url value='/getCommonCodeJob.do' />",
		        "dataType": "JSON"
		     },
		     columns: [
		                   { data: "codeId" },
		                   { data: "codeIdNm" },
		                   { data: "useAt" },
		                   { data: "codeIdDc" },
		                   { 
		                		data: null,
		   	                	defaultContent: '<a class="item-info icon_modify">상세</a><a class="icon_delete">삭제</a>'
		                   }
		     ],
		     order: [[2, "desc"], [1, 'asc']],
				searching: false,
			    paging:   true, 
			    info:     true,
			    language: { 	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"  }
		 });
		 settingTableCnt($("#one-table-cnt"), oTableCC);
		 
		 
	}
	init();
	
	
	/*기준정보 하위 데이터 불러오기*/
	var isSubTable = false;
	 $(document).on( 'click', '#commoncodejob .item-info', function () {
		var obj = oTableCC.row($(this).closest('tr')).data(); 
		console.log("하위데이터");
		$(".lower_tb2").css('display','block');
		globalCodeId = obj.codeId;
		
		if(!isSubTable){
			isSubTable = true;
			editorCCInfo = new $.fn.dataTable.Editor({
		        table: "#commoncodejobDetail",
		        idSrc:  'codeId',
		        fields: [
		        	{ label: "codeId", name: "codeId" }, 
		        	{ label: "codeNm", name: "codeNm" }, 
		        	{ label: "code", name: "code" }, 
		        	{ label: "codeDc", name: "codeDc" },
		        	{ label: "useAt", name: "useAt" }
		        ]
	    	});
			
			oTableCCInfo = $("#commoncodejobDetail").DataTable({ 
			     dom: 'frtip',
			     ajax: {
			     	"type" : "GET",
			        "url" : "/getCommonCodeJobDetail.do?codeId="+obj.codeId,
			        "dataType": "JSON"
			     },
			     columns: [
			                   { data: "codeId" },
			                   { data: "codeNm" },
			                   { data: "code" },
			                   { data: "codeDc" },
			                   { data: "frstRegistPnttm" },
			                   { data: "useAt" },
			                   { 
			                		data: null,
			   	                	defaultContent: '<a class="icon_delete">삭제</a>'
			                   }
			     ],
			     order: [[4, "desc"], [3, 'desc']],
					searching: false,
				    paging:   true, 
				    info:     true,
				    language: { 	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"  }
			 });
		 
			editorCCInfo.on( 'preSubmit', function ( e, type ) {
				  var obj = {
		       		 "codeId": this.field('codeId').val(),
		       		 "code": this.field('code').val(),
		       		 "codeNm": this.field('codeNm').val(),
		       		 "codeDc": this.field('codeDc').val(),
		       		 "useAt": this.field('useAt').val(),
		       		 "lastUpdusrId": globalId
		        }
				 $.ajax({
				       	url: "<c:url value='/mng/UpdateCmmnCodeUDetail.do' />",
				       	type: "POST",
				        data: obj,
				        dataType: "json",
				       	success: function(jsondata){
				       	}
				   	});
			});
			editorCCInfo.on( 'submitSuccess', function ( e, type ) {
				oTableCCInfo.ajax.reload();
			});
		 
		}else{
			oTableCCInfo.ajax.url( "/getCommonCodeJobDetail.do?codeId="+obj.codeId ).load();
		}
		settingTableCnt($("#two-table-cnt"), oTableCCInfo);
	})
	
	 
	 /*기준정보 상위 수정*/
	 $('#commoncodejob').on( 'click', '#commoncodejob tbody td:not(:first-child)', function (e) {
			editorCC.inline( this, {
				  onBlur: 'submit'
		    });
	 }); 
	 editorCC.on( 'preSubmit', function ( e, type ) {
		var obj = {
       		 "codeId": this.field('codeId').val(),
       		 "codeIdNm": this.field('codeIdNm').val(),
       		 "useAt": this.field('useAt').val(),
       		 "codeIdDc": this.field('codeIdDc').val(),
       		 "lastUpdusrId": globalId
        }
		$.ajax({
	       	url: "<c:url value='/mng/UpdateCmmnCodeU.do' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){
	       	}
		});
	});
	editorCC.on( 'submitSuccess', function ( e, type ) {
		oTableCC.ajax.reload();
	});
	/*기준정보 상위 수정*/
	
	 /*기준정보 하위 수정*/
	 $(document).on( 'click', '#commoncodejobDetail tbody td:not(:first-child)', function (e) {
		 console.log(1)
			editorCCInfo.inline( this, {
				  onBlur: 'submit'
		    });
	 }); 
	/*기준정보 하위 수정*/
	
	
	 
	 /*기준정보 상위 삭제*/
	 $(document).on( 'click', '#commoncodejob .icon_delete', function () {
			if (confirm("정말 삭제하시겠습니까?") == true){    //확인
				var obj = oTableCC.row($(this).closest('tr')).data();
			    $.ajax({
			    	url: "<c:url value='/mng/DeleteCmmnCodeU.do' />",
			       	type: "POST",
		        	data: obj,
			    	dataType: "json",
			       	success: function(jsondata){  
			            if(jsondata["data"]==0){
			                alert("성공적으로 삭제 되었습니다.");
			                oTableCC.ajax.reload();
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
	 /*기준정보 하위 삭제*/
	 $(document).on( 'click', '#commoncodejobDetail .icon_delete', function () {
			if (confirm("정말 삭제하시겠습니까?") == true){    //확인
				var obj = oTableCCInfo.row($(this).closest('tr')).data();
			    $.ajax({
			    	url: "<c:url value='/mng/DeleteCmmnCodeUDetail.do' />",
			       	type: "POST",
		        	data: obj,
			    	dataType: "json",
			       	success: function(jsondata){  
			            if(jsondata["data"]==0){
			                alert("성공적으로 삭제 되었습니다.");
			                oTableCCInfo.ajax.reload();
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

	/*기준정보 상위 검색*/
	$('#searchBtnC').on( 'click', function () {
	   if($("#searchFilterC option:selected").val() == ""){
			   toastr.error("검색할 항목을 선택하세요");
			   return;
	   }
	   var searchCondition = $("#comOpt option:selected").val();
	      var searchKeyword = $("input[type=text][name=searchKeywordC]").val()
	      
	      oTableCC.ajax.url( "/getCommonCodeJob.do?searchCondition="+searchCondition+"&searchKeyword="+searchKeyword ).load();
	      settingTableCnt($("#one-table-cnt"), oTableCC);
	} );

});

/*기준정보 상위 추가시 동적으로 생성될 input 태그 생성 함수*/
function AddNewRowCon(){
	var table = document.getElementById("commoncodejob");
	var rowlen = table.rows.length;
	var row = table.insertRow(rowlen-(rowlen-1));
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	var cell5 = row.insertCell(4);
	cell1.innerHTML = "<form id='code-form' data-parsley-validate=''><input id='code' type='text' class='input_blank padding-left-20 border-box border-8bc5ff table-add-input' placeholder ='기준코드' required='' data-parsley-trigger='change' data-parsley-required='true' style='width:200px;' data-parsley-type='alphanum' data-parsley-maxlength='6'/><a onclick='com_check();'class='width-80px height-50px line-height-50px font-15px border-radius-5 background-8bc5ff font-fff text-center margin-right-10'style='display: inline-block;height: 50px; margin-left:10px;'>중복확인</a></form> "
	cell2.innerHTML = "<form id='name-form' data-parsley-validate=''><input id='name' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff table-add-input' placeholder ='기준명' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-maxlength='10'/></form> "
	cell4.innerHTML = "<form id='memo-form' data-parsley-validate=''><input id='memo' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff table-add-input' placeholder ='비고(메모)' data-parsley-trigger='change' data-parsley-maxlength='200'/></form>"
	cell5.innerHTML = "<button id='comBtn' onclick='AddReC()' class='icon_save'>등록</button> <button class='icon_delete' onclick='DeleteRowC()'>취소</button>"
}

function com_check() {
	var com_check = $("#code").val(); //text
	var obj = {
        	"codeId": com_check
	};
 	$.ajax({
    	url: "<c:url value='/mng/checkComCode.do' />",
    	type: "POST",
        data: obj,
        dataType: "json",
        success: function(jsondata){  
           if(jsondata["data"]==0){
                   //로딩
                   toastr.success('사용 가능한 코드입니다.'); 
                   idCheck = 1;
           }else{
         	  toastr.error("이 기준코드는 이미 사용 중이브로 등록 할 수 없습니다.");
           }
    	},
    	error: function(request,status,error){
    		alert("일치하는 정보가 없습니다.");
    	}
	});
}

/*기준정보 하위 추가시 동적으로 생성될 input 태그 생성 함수*/
function AddNewRowConDetail(){
	var table = document.getElementById("commoncodejobDetail");
	var rowlen = table.rows.length;
	var row = table.insertRow(rowlen-(rowlen-1));
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	var cell5 = row.insertCell(4);
	var cell6 = row.insertCell(5);
	var cell7 = row.insertCell(6);
	cell2.innerHTML = "<input id='ccmName' name='codeNm' type='text' style='width:100px;' placeholder ='업무분류명' class='table-add-input border-box border-8bc5ff'> <a onclick='ccmName_check();'class='width-80px height-50px line-height-50px font-15px border-radius-5 background-8bc5ff font-fff text-center margin-right-10'style='display: inline-block;height: 50px; margin-left:10px;'>중복확인</a>"
	cell3.innerHTML = "<input id='ccmCode' name='code' style='width:100px;' type='text' placeholder ='코드'  class='table-add-input border-box border-8bc5ff'> <a onclick='ccm_check();'class='width-80px height-50px line-height-50px font-15px border-radius-5 background-8bc5ff font-fff text-center margin-right-10'style='display: inline-block;height: 50px; margin-left:10px;'>중복확인</a>"
	cell4.innerHTML = "<input name='codeDc' type='text' placeholder ='추가정보'  class='table-add-input border-box border-8bc5ff'>"
	cell5.innerHTML = getFormatDate(today);
	cell6.innerHTML = "<input type='text' class='table-add-input text-center' value='Y' readonly>"
	cell7.innerHTML = "<button class='icon_save'>등록</button> <button onclick='javascript:DeleteRowCDetail()' class='icon_delete'>취소</button>"
}

function ccm_check() {
	var ccm_check = $("#ccmCode").val(); //text
	var obj = {
        	"codeId": ccm_check
	};
	console.log(obj);
 	$.ajax({
    	url: "<c:url value='/mng/checkCcmCode.do' />",
    	type: "POST",
        data: obj,
        dataType: "json",
        success: function(jsondata){  
           if(jsondata["data"]==0){
                   //로딩
                   toastr.success('사용 가능한 코드입니다.'); 
                   idCheck = 1;
           }else{
         	  toastr.error("이 업무분류코드는 이미 사용 중이브로 등록 할 수 없습니다.");
           }
    	},
    	error: function(request,status,error){
    		alert("일치하는 정보가 없습니다.");
    	}
	});
}

function ccmName_check() {
	var ccm_check = $("#ccmName").val(); //text
	var obj = {
        	"clCodeNm": ccm_check
	};
	console.log(obj);
 	$.ajax({
    	url: "<c:url value='/mng/checkCcmName.do' />",
    	type: "POST",
        data: obj,
        dataType: "json",
        success: function(jsondata){  
           if(jsondata["data"]==0){
                   //로딩
                   toastr.success('사용 가능한 코드입니다.'); 
                   idCheck = 1;
           }else{
         	  toastr.error("이 업무분류는 이미 사용 중이브로 등록 할 수 없습니다.");
           }
    	},
    	error: function(request,status,error){
    		alert("일치하는 정보가 없습니다.");
    	}
	});
}

function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;
}

/*위의 동적생성된 html 태그들 삭제*/
function DeleteRowC(){
	var table_comCode = document.getElementById("commoncodejob");
	var row = table_comCode.deleteRow(1);
}

/*위의 동적생성된 html 태그들 삭제*/
function DeleteRowCDetail(){
	var table_comCode = document.getElementById("commoncodejobDetail");
	var row = table_comCode.deleteRow(1);
}

/*실제 추가 함수*/
function AddReC(){
	$('#name-form').parsley().validate();
    if (!$('#name-form').parsley().isValid()) return;
    
    $('#code-form').parsley().validate();
    if (!$('#code-form').parsley().isValid()) return;
    
    $('#memo-form').parsley().validate();
    if (!$('#memo-form').parsley().isValid()) return;
    
    var codeIdNm = $("#name").val();
    var codeId = $("#code").val();
    var codeIdDc = $("#memo").val();
    
    var obj = {
    		"codeIdNm": codeIdNm,
    		"codeId": codeId,
    		"codeIdDc": codeIdDc
    }
    
    $.ajax({
       	url: "<c:url value='/mng/InsertCmmnCodeU.do' />",
       	type: "POST",
        data: obj,
        dataType: "json",
       	beforeSend:function(){
           	$('.wrap-loading').removeClass('display-none');
   			$('#comBtn').attr('disabled', false);
       	},
		complete:function(){
        	$('.wrap-loading').addClass('display-none');
    		$('#comBtn').attr('disabled', false);
     	},
    	success: function(jsondata){  
         	if(jsondata["data"]==0){
            	alert("성공적으로 입력 되었습니다.");
            	$('#comBtn').attr('disabled', false);
            	oTableCC.ajax.reload();settingTableCnt($("#one-table-cnt"), oTableCC);
        	}else{
      	  		alert("양식을 다시 확인하길 바랍니다.");
        	}
     	},
     	error: function(request,status,error){
     		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
         	$('#result').text(jsondata);
     		$('#comBtn').attr('disabled', false);
     	}			
   	});
}

function settingTableCnt(textCnt, table){
	 setTimeout(function(){
		 textCnt.text(table.data().count());	 
	 },1000)
}

/*실제 하위메뉴 추가함수*/
$(document).on("click",".table-add-btn",function(){
	var temp = $(this).parents("tr");
	var codeId = globalCodeId;
    var codeNm = temp.find("input[name='codeNm']").val();
    var code = temp.find("input[name='code']").val();
    var codeDc = temp.find("input[name='codeDc']").val();
    
    
    var obj = {
    		"codeId": codeId,
    		"codeNm": codeNm,
    		"code": code,
    		"codeDc": codeDc
    }
    $.ajax({
       	url: "<c:url value='/mng/InsertCmmnCodeUDetail.do' />",
       	type: "POST",
        data: obj,
        dataType: "json",
       	beforeSend:function(){
           	$('.wrap-loading').removeClass('display-none');
       	},
		complete:function(){
        	$('.wrap-loading').addClass('display-none');
     	},
    	success: function(jsondata){  
         	if(jsondata["data"]==0){
            	alert("성공적으로 입력 되었습니다.");
            	oTableCCInfo.ajax.reload();settingTableCnt($("#two-table-cnt"), oTableCCInfo);
        	}else{
      	  		alert("양식을 다시 확인하길 바랍니다.");
        	}
     	},
     	error: function(request,status,error){
     		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
         	$('#result').text(jsondata);
     	}			
   	});	
})
</script>
</head>
<body> 
	<input type="radio" name="standard_tabmenu2" id="tabmenu-2">
	<label for="tabmenu-2">기준정보설정</label>
	<div class="tabCon">
		<ul class="width-100 margin-bottom-100">
			<li class="width-100 padding-top-60">
				<div class="width-100 height-540px">
					<!--검색하기-->
					<div class="background-f7fafc padding-15 border-box border-radius-bottom-5">
					
						<!--기준정보명 셀렉박스-->
						<select id="comOpt" class="select_blank_lightblue width-140px" style="margin-right:10px">
							<option selected value="0" >기준정보명</option>
						</select>

						<!--검색-->
						<div class="inline-block width-260px">
							<input type="text" name="searchKeywordC" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
						</div>
						<a id="searchBtnC" class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
					</div>
					
					
					<div class="clear margin-bottom-20"></div>

					<!--검색내용-->
					<div class="background-f7fafc padding-20 border-box border-radius-5">
						<div class="table_result_tit">
							총 <span id="one-table-cnt">000</span>개를 검색하였습니다.
							<a class="icon_btn width-100px background-00e04e" id="commoncodejobExlBtn"><span class="icon_clip"></span>엑셀 다운로드</a>
							<a class="margin-right-10 background-826fe8" id="addRow" href="javascript:AddNewRowCon()">기준등록</a>
						</div>
						
						
						<!-- 기준정보 상위 테이블 -->
						<table  id="commoncodejob" class="con_tb width-100" cellpadding="0" cellspacing="0" border="0" style="width: 100%">
							<thead>
								<tr>
									<th class="width-13">기준코드</th>
									<th class="width-12">기준명</th>
									<th class="width-11">삭제여부(N:삭제상태)</th>
									<th class="width-20">비고</th>
									<th class="width-14">수정/삭제</th>
								</tr>
							</thead>
						</table>
						<br><br>
						
						
						<div class="table_result_tit lower_tb2" style="display: none;">
							총 <span id="two-table-cnt">000</span>개를 검색하였습니다.
							<a class="icon_btn width-100px background-00e04e" id="commoncodejobExlBtnDetail"><span class="icon_clip"></span>엑셀 다운로드</a>
							<a class="margin-right-10 background-826fe8" id="addRowDetail" href="javascript:AddNewRowConDetail()">기준등록</a>
						</div>
						<!-- 기준정보 하위 테이블 -->
						<table  id="commoncodejobDetail" class="con_tb lower_tb2 width-100" cellpadding="0" cellspacing="0" border="0" style="width: 100%; display: none;">
							<thead>
								<tr>
									<th class="width-13">기준코드</th>
									<th class="width-20">업무분류</th>
									<th class="width-20">코드</th>
									<th class="width-11">추가정보</th>
									<th class="width-20">등록일</th>
									<th class="width-14">상태(N:삭제상태)</th>
									<th class="width-14">수정/삭제</th>
								</tr>
							</thead>
						</table>
					</div>
					<!--검색내용-->
				</div>
			</li>
		</ul>
	</div> 
</body>
</html>
