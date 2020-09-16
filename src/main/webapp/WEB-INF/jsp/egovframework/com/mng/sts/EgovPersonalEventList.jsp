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
<style>
.dataTables_filter {
   display:none;
}
</style>
</head>
<script type="text/javaScript" language="javascript" defer="defer"> 
var today = new Date();
var oTableHH;
var editorHH;
var globalId = "${loginVO.id}";
$(document).ready(function() {
	function init(){
		editorHH = new $.fn.dataTable.Editor({
	        table: "#tbl_holiday",
	        idSrc:  'ctsnnId',
	        fields: [
	        	{ label: "ctsnnId", name: "ctsnnId" }, 
	        	{ label: "ctsnnNm", name: "ctsnnNm" }, 
	        	{ label: "ctsnnCd", name: "ctsnnCd" }, 
	        	{ label: "repetitive", name: "repetitive" }, 
	        	{ label: "occrrncDE", name: "occrrncDE" },
	        	{ label: "status", name: "status" }
	        ]
	    });
		oTableHH = $('#tbl_holiday').DataTable({ 
		     dom: 'frtip',
		     ajax: {
		     	"type" : "POST",
		        "url" : "<c:url value='/getHoliday.do' />",
		        "dataType": "JSON"
		     },
		     columns: [
		                   { data: "ctsnnNm" },
		                   { data: "ctsnnCd",
		                	   render: function(data) { 
		                           if(data == 0) {
		                             return '양력'; 
			                	   }else if(data == 1){
			                		   return '음력';
		                           }else{
		                        	   return data;
		                           }
		                         }     
		                   },
		                   { data: "repetitive" },
		                   { data: "occrrncDE" },
		                   { data: "frstRegisterPnttm" },
		                   { data: "status" },
		                   { 
		               	   		data: null,
		  	               		defaultContent: '<a class="icon_delete">삭제</a>' 
		   	               }
		     ],
		     order: [[5, "desc"], [4, "desc"]],
				searching: false,
			    paging:   true, 
			    info:     true,
			    language: { 	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"  }
		 });
		settingTableCnt($("#personal-table-cnt"), oTableHH);
	}
	init();
	
	$(document).on( 'click', '#tbl_holiday tbody td', function (e) {
		editorHH.inline( this, {
			  onBlur: 'submit'
	    });
	}); 
 	editorHH.on( 'preSubmit', function ( e, type ) {
		 var obj = {
       		 "ctsnnId": this.field('ctsnnId').val(),
       		 "ctsnnNm": this.field('ctsnnNm').val(),
       		 "ctsnnCd": this.field('ctsnnCd').val(),
       		 "repetitive": this.field('repetitive').val(),
       		 "occrrDe": this.field('occrrncDE').val(),
       		 "status": this.field('status').val(),
       		 "lastUpdusrId": globalId
         } 
		 $.ajax({
		       	url: "<c:url value='/updtCtsnnManage.do' />",
		       	type: "POST",
		        data: obj,
		        dataType: "json",
		       	success: function(jsondata){
		       	}
		   	});
	});
	/* 수정완료 후 Refresh() */
	editorHH.on( 'submitSuccess', function ( e, type ) {
		oTableHH.ajax.reload();
	});
	
	$(document).on( 'click', '#tbl_holiday .icon_delete', function () {
		if (confirm("정말 삭제하시겠습니까?") == true){    //확인
			var obj = oTableHH.row($(this).closest('tr')).data();
		    $.ajax({
		    	url: "<c:url value='/mng/deleteCtsnnManage.do' />",
		       	type: "POST",
	        	data: obj,
		    	dataType: "json",
		       	success: function(jsondata){  
		            if(jsondata["data"]==0){
		                alert("성공적으로 삭제 되었습니다.");
		                oTableHH.ajax.reload();
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

});


function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;
}

function AddNewRow(){
	
	var table = document.getElementById("tbl_holiday");
	var rowlen = table.rows.length;
	var row = table.insertRow(rowlen-(rowlen-1));
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	var cell5 = row.insertCell(4);
	var cell6 = row.insertCell(5);
	var cell7 = row.insertCell(6);
	
	cell1.innerHTML = "<form id='ctsnnNm-form' data-parsley-validate=''><input id='ctsnnNm' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff table-add-input' placeholder ='휴일명' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-maxlength='10'/></form> "
	cell2.innerHTML = "<form id='ctsnnCd-form' data-parsley-validate=''><select id='ctsnnCd' class='select_blank_lightblue width-120px table-add-input' style='margin-right:9px'><option value='0' selected>양력</option><option value='1'>음력</option></form>"
	cell3.innerHTML = "<form id='repetitive-form' data-parsley-validate=''><select id='repetitive' class='select_blank_lightblue width-120px table-add-input' style='margin-right:9px'><option value='년' selected>년</option><option value='월'>월</option><option value='일'>일</option></form>"
	cell4.innerHTML = "<form id='occrrDe-form' data-parsley-validate=''><input type='date' id='occrrDe' class='text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent table-add-input' /></form>"
	cell5.innerHTML = getFormatDate(today);
	cell7.innerHTML = "<button id='ctsBtn' onclick='AddRef()' class='icon_save'>등록</button> <button onclick='DeleteRow()' class='icon_delete'>취소</button>"
}

function DeleteRow(){
	var table_evn = document.getElementById("tbl_holiday");
	var row = table_evn.deleteRow(1);
}
function AddRef(){
	$('#ctsnnNm-form').parsley().validate();
    if (!$('#ctsnnNm-form').parsley().isValid()) {
    	return;
    }
    
    $('#ctsnnCd-form').parsley().validate();
    if (!$('#ctsnnCd-form').parsley().isValid()) {
    	return;
    }
    
    $('#occrrDe-form').parsley().validate();
    if (!$('#occrrDe-form').parsley().isValid()) {
    	return;
    }
    
    $('#repetitive-form').parsley().validate();
    if (!$('#repetitive-form').parsley().isValid()) {
    	return;
    }
    
    var ctsnnNm = $("#ctsnnNm").val();
    var ctsnnCd = $("#ctsnnCd").val();
    var occrrDe = $("#occrrDe").val().replace(/-/gi, ""); ;
    var repetitive = $("#repetitive").val();
    
    var obj = {
    		"ctsnnNm": ctsnnNm,
    		"ctsnnCd": ctsnnCd,
    		"occrrDe": occrrDe,
    		"repetitive": repetitive
    }
    
    $.ajax({
       	url: "<c:url value='/mng/insertCtsnnManage.do' />",
       	type: "POST",
           data: obj,
           dataType: "json",
           beforeSend:function(){
               $('.wrap-loading').removeClass('display-none');
       			$('#ctsBtn').attr('disabled', false);
           },
		complete:function(){
               $('.wrap-loading').addClass('display-none');
       		$('#ctsBtn').attr('disabled', false);
        },
       	success: function(jsondata){  
            if(jsondata["data"]==0){
                alert("성공적으로 입력 되었습니다.");
                $('#ctsBtn').attr('disabled', false);
                oTableHH.ajax.reload();
                settingTableCnt($("#personal-table-cnt"), oTableHH);
            }else{
          	  alert("양식을 다시 확인하길 바랍니다.");
            }
       	},
       	error: function(request,status,error){
       		  
       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
           	$('#result').text(jsondata);
       		$('#ctsBtn').attr('disabled', false);
       	}
   	});
}
</script>
<body> 
	<input type="radio" name="standard_tabmenu2" id="tabmenu-6">
	<label for="tabmenu-6">경조사휴일관리</label>
	<div class="tabCon">
		<div class="width-100 padding-top-60 margin-bottom-100">
			<div class="width-100  padding-rl-20 padding-tb-40 background-f7fafc border-radius-bottom-5 border-box box-shadow">
				<div class="table_result_tit">
					총 <span id="personal-table-cnt">000</span>개를 검색하였습니다.
					<a class="background-826fe8" id="addRow" href="javascript:AddNewRow()">휴일추가</a>
				</div>
				<table class="con_tb width-100" cellpadding="0" cellspacing="0" border="0" id="tbl_holiday" style="width: 100%;">
					<thead>
						<tr>
							<th class="width-30">휴일명</th>
							<th class="width-8">구분</th>
							<th class="width-8">반복주기</th>
							<th class="width-14">년월일시</th>
							<th class="width-15">등록일시</th>
							<th class="width-10">삭제여부(N:삭제상태)</th>
							<th class="width-15">수정/삭제</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

</body>
</html>
