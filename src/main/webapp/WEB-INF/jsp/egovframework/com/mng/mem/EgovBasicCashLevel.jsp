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

<script type="text/javascript">  
var oTableB;
var editorB;
var globalId = "${loginVO.id}";
var today = new Date();
$(document).ready(function() {
	
	$(document).on( 'click', '#cashlevel .icon_delete', function () {
		if (confirm("정말 삭제하시겠습니까?")){    //확인
			var obj = oTableB.row($(this).closest('tr')).data();
		    $.ajax({
		    	url: "/mng/DeleteLevel.do?lvid="+obj.lvid,
		       	type: "GET",
		    	dataType: "json",
		       	success: function(jsondata){  
		            if(jsondata["data"]==0){
		                //로딩
		                alert("성공적으로 삭제 되었습니다.");
		                oTableB.ajax.reload();
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
	
	function init(){
		editorB = new $.fn.dataTable.Editor({
	        table: "#cashlevel",
	        idSrc:  'lvid',
	        fields: [
	        	{ label: "lvid", name: "lvid" }, 
	        	{ label: "lvname", name: "lvname" }, 
	        	{ label: "sms", name: "sms" }, 
	        	{ label: "lms", name: "lms" }, 
	        	{ label: "mms", name: "mms" },
	        	{ label: "notice", name: "notice" },
	        	{ label: "friend", name: "friend" }
	        ]
	    });
		
		oTableB = $('#cashlevel').DataTable({
		     dom: "frtip",
	   	     ajax: {
	  	        url : "<c:url value='/getCashlevel.do' />",
	 	     	type : "POST",
	 	        dataType: "json"
	 	     },
		     columns: [
				    	   { 
				    		   "data": null,"sortable": false, 
				    	       render: function (data, type, row, meta) {
									return meta.row + meta.settings._iDisplayStart + 1;
				    	   		}  
				    	   },
		                   { data: "lvname" },
		                   { data: "sms" },
		                   { data: "lms" },
		                   { data: "mms" },
		                   { data: "notice" },
		                   { data: "friend" },
		                   { data: "regDate" },
		                   { data: "updatedate",defaultContent: "" },
		                   { 
		                	   data: null,
			                   className: "center",
			                   defaultContent: '<a class="icon_delete">삭제</a>'   
		                   }
		     ],
		    order: [ 7, 'desc' ],
		    paging:   true, 
		    info:     true,
		    searching: false,
		    language: {
		    	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"
		    } 
		 });
	}
	init();
	$('#cashlevel').on( 'click', 'tbody td:not(:first-child)', function (e) {
		editorB.inline( this, {
			  onBlur: 'submit'
	    });
	}); 
	editorB.on( 'preSubmit', function ( e, type ) {
		  var obj = {
       		 "lvid": this.field('lvid').val(),
       		 "lvname": this.field('lvname').val(),
       		 "sms": this.field('sms').val(),
       		 "lms": this.field('lms').val(),
       		 "mms": this.field('mms').val(),
       		 "notice": this.field('notice').val(),
       		 "friend": this.field('friend').val(),
       		 "userId": globalId
        }
		 $.ajax({
		       	url: "<c:url value='/mng/updateLevel.do' />",
		       	type: "POST",
		        data: obj,
		        dataType: "json",
		       	success: function(jsondata){
		       		oTableB.ajax.reload();
		       	}
		   	});
	});
	/* 수정완료 후 Refresh() */
	editorB.on( 'submitSuccess', function ( e, type ) {
		alert("수정되었습니다.");
		oTableB.ajax.reload();
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

function AddNewRowS()
{
	var table = document.getElementById("cashlevel");
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
	var cell10 = row.insertCell(9);
	
	cell2.innerHTML = "<form id='names-form' data-parsley-validate=''><input id='names' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='등급명' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-maxlength='5'/></form> ";
	cell3.innerHTML = "<form id='nums1-form' data-parsley-validate=''><input id='nums1' type='number' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='3'/></form>";
	cell4.innerHTML = "<form id='nums2-form' data-parsley-validate=''><input id='nums2' type='number' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='3'/></form>";
	cell5.innerHTML = "<form id='nums3-form' data-parsley-validate=''><input id='nums3' type='number' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder =''  required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='3'/></form>";
	cell6.innerHTML = "<form id='nums4-form' data-parsley-validate=''><input id='nums4' type='number' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='3'/></form>";
	cell7.innerHTML = "<form id='nums5-form' data-parsley-validate=''><input id='nums5' type='number' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='3'/></form>";
	cell10.innerHTML = "<button id='addrSBtn' onclick='AddCashLevel()' class='icon_save'>등록</button> <button onclick='DeleteRowS()' class='icon_delete'>취소</button>";
	cell8.innerHTML = getFormatDate(today);

}

function DeleteRowS(){
	var table = document.getElementById("cashlevel");
	var row = table.deleteRow(1);
}

function AddCashLevel(){
	 
	$('#names-form').parsley().validate();
    if (!$('#names-form').parsley().isValid()) {
    	return;
    } 
    
    $('#nums1-form').parsley().validate();
    if (!$('#nums1-form').parsley().isValid()) {
    	return;
    } 

    $('#nums2-form').parsley().validate();
    if (!$('#nums2-form').parsley().isValid()) {
    	return;
    }

    $('#nums3-form').parsley().validate();
    if (!$('#nums3-form').parsley().isValid()) {
    	return;
    }

    $('#nums4-form').parsley().validate();
    if (!$('#nums4-form').parsley().isValid()) {
    	return;
    }

    $('#nums5-form').parsley().validate();
    if (!$('#nums5-form').parsley().isValid()) {
    	return;
    } 
    var name = $("#names").val();
    var sms = $("#nums1").val();
    var lms = $("#nums2").val();
    var mms = $("#nums3").val();
    var alarm = $("#nums4").val();
    var ftalk = $("#nums5").val(); 
    
    var obj = {
    	"lvname": name,
    	"sms": sms,
    	"lms": lms,
    	"mms": mms,
    	"notice": alarm,
    	"friend": ftalk
    }
    $.ajax({
       	url: "<c:url value='/mng/InsertcashLevel.do' />",
       	type: "POST",
           data: obj,
           dataType: "json",
           beforeSend:function(){
               	$('.wrap-loading').removeClass('display-none');
       			$('#addrSBtn').attr('disabled', false);
           },
		complete:function(){
               	$('.wrap-loading').addClass('display-none');
       			$('#addrSBtn').attr('disabled', false);
        },
       	success: function(jsondata){  
            if(jsondata["data"]==0){
                toastr.success("성공적으로 입력 되었습니다.");
                $('#addrSBtn').attr('disabled', false);
                oTableB.ajax.reload();
            }else{
          	  toastr.error("양식을 다시 확인하길 바랍니다.");
            }
       	},
       	error: function(request,status,error){
       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
           	$('#result').text(error);
       		$('#addrSBtn').attr('disabled', false);
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
						<li>등급기준</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>시스템관리</li>
						<li><span class="dot"></span>등급기준</li>
					</ul>
				</h1>

				<div  class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
					<div class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
			<div class="table_result_tit" style="color:#000; font-weight:bold;">
				<a class="background-826fe8 font-normal" id="addLevelBtn"  href="javascript:AddNewRowS()" >등급추가</a>
			</div>				
 
			<table id="cashlevel" class="display con_tb"  >
			<thead>
			<tr>
				<th style="width:10px;"><span>번호</span></th>
				<th style="width:100px;"><span>등급명</span></th>
				<th style="width:100px;"><span>단문</span></th>
				<th style="width:100px;"><span>장문</span></th>
				<th style="width:100px;"><span>멀티</span></th>
				<th style="width:100px;"><span>알림톡</span></th>
				<th style="width:100px;"><span>친구톡</span></th>
				<th style="width:150px;"><span>등록일</span></th>
				<th style="width:150px;"><span>최종수정일</span></th>
				<th style="width:30px;"><span>수정/삭제</span></th>
			</tr>
			<thead>
			</table>
						 
					</div>
				</div>
			</div>

<div id="pop_level">
</div>
</body>
</html>
