<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_excle_max_num" var="g_excle_max_num" />
<spring:message code="FILEMAXSIZE" var="FILEMAXSIZE" />
<spring:message code="EXCEL_SHEET_DATA_COUNT" var="EXCEL_SHEET_DATA_COUNT" />
<spring:message code="statYearActive" var="statYearActive" />
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
	display: none;
}

td.editable {
	font-weight: bold;
}
</style>
<script>
/*
$.fn.dataTableExt.afnFiltering.push(
		function( oSettings, aData, iDataIndex ) {
			var iFini = document.getElementById('start_dt').value;
			var iFfin = document.getElementById('end_dt').value;
			var iStartDateCol = 2;
			var iEndDateCol = 4;

			iFini=iFini.substring(6,10) + iFini.substring(3,5)+ iFini.substring(0,2);
			iFfin=iFfin.substring(6,10) + iFfin.substring(3,5)+ iFfin.substring(0,2);

			var datofini=aData[iStartDateCol].substring(6,10) + aData[iStartDateCol].substring(3,5)+ aData[iStartDateCol].substring(0,2);
			var datoffin=aData[iEndDateCol].substring(6,10) + aData[iEndDateCol].substring(3,5)+ aData[iEndDateCol].substring(0,2);

			 
			if ( iFini === "" && iFfin === "" )
			{
				return true;
			}
			else if ( iFini <= datofini && iFfin === "")
			{
				return true;
			}
			else if ( iFfin >= datoffin && iFini === "")
			{
				return true;
			}
			else if (iFini <= datofini && iFfin >= datoffin)
			{
				return true;
			}
			return false;
		}
);
*/
</script>
<script type="text/javaScript" language="javascript" defer="defer">  
var today = new Date();
var oTable;
var partg_role = "${loginVO.partg_role}";
$(document).ready(function() {
	var statYearActive = "${statYearActive}";
	if(statYearActive){
		$("#start_dt").val(statYearActive + "-01-01");
	}
	
	//엑셀 다운로드
	$("#receiptrefusalExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('receiptrefusal', '수신거부목록' ,'수신거부목록'); //오혜성 08.11 제거
		global.htmlTableToExcel('receiptrefusal','수신거부목록','수신거부목록', "${EXCEL_SHEET_DATA_COUNT}");
	});

	function init(){
		oTable = $('#receiptrefusal').DataTable({
		     dom: "frtip",
		     ajax:{
			    	"url" : "/getreceiptrefusalU.do?partgRole="+partg_role,
		            "dataSrc": function ( jsondata ) { 
			            if( jsondata["data"] == "index.do" ) location.href = "/index.do"; 
		                return jsondata["data"];
		            }
			    }, 
			     columns: [ 
				    { 
				    	data: null,
		                defaultContent: '',
		                className: 'select-checkbox',
		                orderable: false 
				    },
			    	{ data: "regist_date" },
			    	{ data: "register_id" },
			    	{ data: "cancel_date" },
			    	{ data: "cancel_id" },
			    	{ data: "reject_phone" },
		        	{ data: "sending_number" },
		        	{ data: "status" },
		       		{ 
		        		data: null,
		                defaultContent: "<button class='deleteData icon_delete'>해제</button>"
		        	}
		         ],
	   	 	    paging:   true, 
			    info:     true,
			    language: {		    	 
			    	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"		    	
			    }
			 });
		global.settingTableCnt($("#table-cnt"), oTable);
	}
	init();
	$('#searchBtn').on( 'click', function () {
		
		oTable.columns( 7  ).search( $("#statOpt option:selected").val() )
		if($("#filterOpt option:selected").val()){
			oTable.columns( $("#filterOpt option:selected").val()  ).search( $("input[type=text][name=searchKeyword]").val() )
		}
		oTable.draw(); 
	});
	$.fn.dataTable.ext.search.push(
   	    function( settings, data, dataIndex ) {
   	    	if($("#dateOpt").val() && $("#start_dt").val() && $("#end_dt").val()){
    	        var min = $('#start_dt').val(); min = global.replaceNumber(min);
    	        var max = $('#end_dt').val(); max = global.replaceNumber(max);
    	        var tableDate = data[$("#dateOpt").val()] || 0; tableDate = global.replaceNumber(tableDate); tableDate = global.parse(tableDate);
    	        
    	        if (min <= tableDate && tableDate <= max){
    	            return true;
    	        }else{
	    	        return false;
    	        }
   	    	}else{
   	    		return true;
   	    	}
   	    }
    );
	
	$('#receiptrefusal tbody').on( 'click', '.deleteData', function () {
		if (confirm("정말 삭제하시겠습니까?") == true){    //확인
			var obj = oTable.row($(this).closest('tr')).data();
		
			var param = {
					"id":obj.id
			}
		    $.ajax({
		    	url: "<c:url value='/usr/DeleteReceiptrefusalU.do' />",
		       	type: "POST",
	        	data: param,
		    	dataType: "json",
		       	success: function(jsondata){  
		            if(jsondata["data"]==0){
		                //로딩
		                alert("성공적으로 삭제 되었습니다.");
		                oTable.ajax.reload();		          	  
		            }else{
		          	  alert("삭제할수 없습니다.");
		            }
		       	},
		       	error: function(request,status,error){
		       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
		       	}
		   	});

		 }
	}); 
	
	$('#blocked_excel').on('click', function(){	
		
		 var files = document.getElementById("ex_filename").files[0]; //input file 객체를 가져온다.
		 var isSizeChk = global.fileSizeChk(files, "${FILEMAXSIZE}")
			if(isSizeChk) return;
		    var reader = new FileReader();
		    reader.onload = function(){
		        var fileData = reader.result;
		        var wb = XLSX.read(fileData, {type : 'binary'});
		        wb.SheetNames.forEach(function(sheetName){
		  	       var rowJsonObj = XLSX.utils.sheet_to_json(wb.Sheets[sheetName]); 

				    console.log(rowJsonObj);
		  	       
				    var i; 
				    var g_excle_max_num = '${g_excle_max_num}';
				    
				    if(g_excle_max_num<rowJsonObj.length){
				    	alert("엑셀 업로드는 최대 "+g_excle_max_num+"개까지 가능합니다.");
				    	return;
				    }
				    
				    for(var i in rowJsonObj){
				        console.log(rowJsonObj[i]);
						             
						var to_num = rowJsonObj[i]['수신거부번호'];
					    var from_num = rowJsonObj[i]['발신번호'];
						
					    var obj = {
					    		"reject_phone": to_num,
					    		"sending_number": from_num
					    }
						
						$.ajax({
					       	url: "<c:url value='/usr/InsertReceiptrefusalU.do' />",
					       	type: "POST",
					           data: obj,
					           dataType: "json",
					           beforeSend:function(){
					               $('.wrap-loading').removeClass('display-none');
					       		$('#refBtn').attr('disabled', false);
					           },
							complete:function(){
					               $('.wrap-loading').addClass('display-none');
					       		$('#refBtn').attr('disabled', false);
					        },
					       	success: function(jsondata){  
					            if(jsondata["data"]==0){
					                $('#refBtn').attr('disabled', false);
					                oTable.ajax.reload();
					          	  
					            }else{
					          	  alert("양식을 다시 확인하길 바랍니다.");
					            }
					       	},
					       	error: function(request,status,error){
					       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
					           	$('#result').text(jsondata);
					       		$('#refBtn').attr('disabled', false);
					       	}
					   	});
					}
		        })
		    };
		    reader.readAsBinaryString(files);
	});	
    
});

function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;
}

function AddNewRow()
{
	
	var table = document.getElementById("receiptrefusal");
	var rowlen = table.rows.length;
	var row = table.insertRow(rowlen-(rowlen-1));
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	var cell5 = row.insertCell(4);
	var cell6 = row.insertCell(5);
	var cell7 = row.insertCell(6);
	var cell8 = row.insertCell(7);
	var cell9 = row.insertCell(8);
	
	cell2.innerHTML = getFormatDate(today);
	cell6.innerHTML = "<form id='to-form' data-parsley-validate=''><input id='to_num' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='-제외 숫자만' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='11'/></form> "
	cell7.innerHTML = "<form id='from-form' data-parsley-validate=''><input id='from_num' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='-제외 숫자만' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='11'/></form>"
	cell9.innerHTML = "<button id='refBtn' onclick='AddRef()' class='icon_save'>등록</button> <button onclick='DeleteRow()' class='icon_delete'>취소</button>"
}

function DeleteRow(){
	var table = document.getElementById("receiptrefusal");
	var row = table.deleteRow(1);
}

function AddRef(){
	
	$('#to-form').parsley().validate();
    if (!$('#to-form').parsley().isValid()) {
    	return;
    }
    
    $('#from-form').parsley().validate();
    if (!$('#from-form').parsley().isValid()) {
    	return;
    }
    
    var to_num = $("#to_num").val();
    var from_num = $("#from_num").val();
    
    var obj = {
    		"reject_phone": to_num,
    		"sending_number": from_num
    }
    $.ajax({
       	url: "<c:url value='/usr/InsertReceiptrefusalU.do' />",
       	type: "POST",
           data: obj,
           dataType: "json",
           beforeSend:function(){
               $('.wrap-loading').removeClass('display-none');
       		$('#refBtn').attr('disabled', false);
           },
		complete:function(){
               $('.wrap-loading').addClass('display-none');
       		$('#refBtn').attr('disabled', false);
        },
       	success: function(jsondata){  
            if(jsondata["data"]==0){
                alert("성공적으로 입력 되었습니다.");
                $('#refBtn').attr('disabled', false);
           		location.href  ="/usr/receiptrefusal"
          	  
            }else{
          	  alert("양식을 다시 확인하길 바랍니다.");
            }
       	},
       	error: function(request,status,error){
       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
           	$('#result').text(jsondata);
       		$('#refBtn').attr('disabled', false);
       	}
   	});
}
</script>
</head>
<body>

	<!--contents-->
	<div class="con-inner">
		<!--타이틀-->
		<h1 class="con-title">
			<ul>
				<li>수신거부목록</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>전송관리</li>
				<li><span class="dot"></span>수신거부목록</li>
			</ul>
		</h1>


		<!-- 검색하기 -->
		<div
			class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
			<!-- 검색설정 -->
			<div
				class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">
				<!--상태 셀렉박스-->
				<select id="statOpt" class="select_blank_lightblue width-100px"
					style="margin-right: 10px">
					<option selected value=" ">상태</option>
					<option value="1">등록</option>
					<option value="2">해지</option>
				</select>

				<!-- 등록일시 셀렉박스-->
				<select id="dateOpt" class="select_blank_lightblue width-140px"
					style="margin-right: 10px">
					<option selected value="">날짜</option>
					<option value="1">등록일</option>
					<option value="3">해지일</option>
				</select>


				<!-- 날짜선택-->
				<div
					class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
					<input type="date" id="start_dt" name="start_dt"
						class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent" />
				</div>
				<div
					class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
				<div
					class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
				<div
					class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
				<div
					class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box margin-right-10">
					<input type="date" id="end_dt" name="end_dt"
						class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"/>
				</div>

				<!-- 등록자ID 체크박스-->
				<select id="filterOpt" class="select_blank_lightblue width-150px"
					style="margin-right: 10px">
					<option selected value="">검색옵션</option>
					<option value="2">등록자ID</option>
					<option value="4">해지ID</option>
					<option value="5">수신거부번호</option>
					<option value="6">발신번호</option>
				</select>


				<!-- <div class="inline-block width-150px" style="margin-right:10px">검색어를 입력하세요 </div> -->
				<!--검색-->
				<div class="inline-block width-180px">
					<input id="searchKeyword" type="text" name="searchKeyword"
						placeholder=""
						class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
				</div>
				<a id="searchBtn"
					class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
			</div>
			<!-- //검색설정 -->






			<!-- 검색결과 -->
			<div
				class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
				<div class="table_result_tit">
					총 <span id="table-cnt">000</span>개를 검색하였습니다.
					<a id="receiptrefusalExlBtn"
						class="icon_btn width-100px background-00e04e"><span
						class="icon_clip"></span>엑셀 다운로드</a> <a
						class="open_pop_blocked icon_btn margin-right-10 background-ff6464"><span
						class="icon_clip"></span>엑셀 업로드</a> <a
						class="margin-right-10 background-ffcd91" id="addRow"
						href="javascript:AddNewRow()">신규등록</a>
				</div>
				<table id="receiptrefusal" class="display con_tb" cellspacing="0"
					width="100%">
					<thead>
						<tr>
							<th class="width-5"></th>
							<th class="width-15">등록일</th>
							<th class="width-10">등록자ID</th>
							<th class="width-15">해지일</th>
							<th class="width-10">해지ID</th>
							<th class="width-14">수신거부번호</th>
							<th class="width-14">발신번호</th>
							<th class="width-5">상태</th>
							<th class="width-12">등록/해지</th>
						</tr>
					</thead>
				</table>

				<div class="text-center">
				</div>
			</div>
			<!-- //검색결과 -->
		</div>
	</div>



	<div
		class="pop_wrap pop_blocked width-730px background-f7fafc border-radius-5">
		<div
			class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">수신거부
			등록 엑셀업로드</div>
		<div
			class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
			<div
				class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-90">
				엑셀파일 찾기 <input class="upload-name" value="" disabled="disabled"
					placeholder="제목 (최대 30Byte)" /> <label for="ex_filename">찾아보기</label>
				<input type="file" id="ex_filename" class="upload-hidden" />
			</div>
			<ul class="pop_notice" style="padding-left: 90px">
				<li>엑셀양식파일 : <a href="#">엑셀양식 다운로드</a></li>
				<li>최대 10만건 까지 등록할 수 있습니다.</li>
				<li>엑셀등록시 휴대폰 번호는 필수값입니다.</li>
				<li>휴대폰 번호는 반드시 0으로 시작해야 합니다.</li>
				<li>알림톡의 경우 엑셀양식파일을 다운로드하여 템플릿의 변수값을 모두 입력한 후 엑셀 등록을 해주시기 바랍니다.</li>
			</ul>
		</div>
		<!--버튼-->
		<div class="pop_btn">
			<a id="blocked_excel"
				class="pop_close background-053c72 border-053c72 font-fff margin-right-20">저장</a>
			<a class="pop_close background-8bc5ff border-8bc5ff font-fff">취소</a>
		</div>
	</div>

</body>
</html>
