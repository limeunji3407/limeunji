<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
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
div.banner-check > input[type="checkbox"] {
    display: none;
}
</style>
<script type="text/javaScript" language="javascript" defer="defer"> 
var today = new Date();
var globalId = "${loginVO.id}";
var oTableB;
$(document).ready(function() {
	$('#bannerConfBtn').on('click', function(){  
		
		$('#bannerConfBtn').attr('disabled', true);		
	
	    var bannercount = $('input[name="bannercount"]').val();	
	    var useYN = $('input[name="useYN"]').val();	
		var obj = {
			"bannercount": bannercount, 
			"useYN" : useYN,
		};
     	$.ajax({
        	url: "<c:url value='/mng/insertBannert.do' />",
        	type: "POST",
            data: obj,
            dataType: "json",
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
        		$('#bannerConfBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#bannerConfBtn').attr('disabled', false);
            },
        	success: function(jsondata){
                toastr.success('등록이 성공적으로 변경되었습니다'); 
				   //팝업닫기
				   $('#pop_add_dept').hide();
				   $('.pop_bg').hide();
        		   $('#bannerConfBtn').attr('disabled', false);
            	
        	},
        	error: function(request,status,error){
        		console.log("[ajax error]");
        		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
                toastr.success('오류:' + jsondata); 
        		$('#bannerConfBtn').attr('disabled', false);
        	}
    	});
	});

	
	
	
	$(document).on( 'click', '#tbl_banner .icon_delete', function () {
		if (confirm("정말 삭제하시겠습니까?") == true){    //확인
			var obj = oTableB.row($(this).closest('tr')).data();
		    $.ajax({
		    	url: "/deleteBanner.do?bannerId="+obj.bannerId,
		       	type: "GET",
		    	dataType: "json",
		       	success: function(jsondata){  
		            if(jsondata["data"]==0){
		                //로딩
		                alert("성공적으로 삭제 되었습니다.");
		                oTableB.ajax.reload();
		                settingTableCnt($("#banner-table-cnt"), oTableB);
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
	initB();
	
	
	$(document).on( 'click', '#tbl_banner tbody td:not(:first-child)', function (e) {
		editorB.inline( this, {
			  onBlur: 'submit'
	    });
	}); 
	
	/* 수정완료 후 Refresh() */
	editorB.on( 'preSubmit', function ( e, type ) {
		  var obj = {
         		 "bannerId": this.field('bannerId').val(),
         		 "bannerNm": this.field('bannerNm').val(),
         		 "linkUrl": this.field('linkUrl').val(),
         		 "bannerDc": this.field('bannerDc').val(),
         		 "reflctAt": this.field('reflctAt').val(),
         		 "userId": globalId
          }
		 $.ajax({
		       	url: "<c:url value='/updtBanner.do' />",
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
		oTableB.ajax.reload();
	});
	
});

var editorB;
function initB(){
	editorB = new $.fn.dataTable.Editor({
        table: "#tbl_banner",
        idSrc:  'bannerId',
        fields: [
        	{ label: "bannerId", name: "bannerId" }, 
        	{ label: "reflctAt", name: "reflctAt" }, 
        	{ label: "bannerNm", name: "bannerNm" }, 
        	{ label: "linkUrl", name: "linkUrl" }, 
        	{ label: "endDate", name: "endDate" },
        	{ label: "bannerDc", name: "bannerDc" }
        ]
    });  
	oTableB = $('#tbl_banner').DataTable({
	     dom: 'frtip',
	     ajax: {
	     	"type" : "POST",
	        "url" : "<c:url value='/getBannerList.do' />",
	        "dataType": "JSON"
	     },
	     columns: [
		    	 	   { 
			    		   "data": null,"sortable": false, 
			    	       render: function (data, type, row, meta) {
								return meta.row + meta.settings._iDisplayStart + 1;
			    	   		}  
			    	   },
	                   { data: "reflctAt" },
	                   { data: "bannerNm" },
	                   { data: "bannerImage" },
	                   { data: "linkUrl" },
	                   { data: "regDate" },
	                   { data: "endDate" },
	                   { data: "bannerDc" },
	                   { 
	                	   data: null,
		                   className: "center",
		                   defaultContent: '<a class="icon_delete">삭제</a>'   
	                   }
	     ],
	     order: [ 5, 'desc' ],
			searching: false,
		    paging:   true, 
		    info:     true,
		    language: { 	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"  }
		});
		settingTableCnt($("#banner-table-cnt"), oTableB);
}
function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;
}

function AddNewRowBanner()
{
	
	var table = document.getElementById("tbl_banner");
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
	
	cell3.innerHTML = "<form id='bannerNm-form' data-parsley-validate=''><input id='bannerNm' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff table-add-input' placeholder ='배너명' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-maxlength='20' data-parsley-minlength='2'/></form> "
	cell4.innerHTML = "<form id='bannerImage-form' data-parsley-validate=''><input type='file' id='bannerImage' class='image_inputType_file table-add-input' accept='img/*' required multiple></form>"
	cell5.innerHTML = "<form id='linkUrl-form' data-parsley-validate=''><input id='linkUrl' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff table-add-input' placeholder ='링크' data-parsley-trigger='change' required='' data-parsley-required='true' data-parsley-pattern='^(file|gopher|news|nntp|telnet|https?|ftps?|sftp):\/\/([a-z0-9-]+\.)+[a-z0-9]{2,4}.*$'/></form>"
	cell6.innerHTML = getFormatDate(today);
	cell8.innerHTML = "<form id='bannerDc-form' data-parsley-validate=''><input id='bannerDc' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff table-add-input' placeholder ='비고' data-parsley-trigger='change' data-parsley-maxlength='200'/></form>"
	cell9.innerHTML = "<button id='banBtn' onclick='AddBan()' class='icon_save'>등록</button> <button onclick='DeleteRowBan()' class='icon_delete'>취소</button>"
}

function DeleteRowBan(){
	var table_ban = document.getElementById("tbl_banner");
	var row = table_ban.deleteRow(1);
}

function AddBan(){
	
	$('#bannerNm-form').parsley().validate();
    if (!$('#bannerNm-form').parsley().isValid()) {
    	return;
    }
    
    $('#bannerImage-form').parsley().validate();
    if (!$('#bannerImage-form').parsley().isValid()) {
    	return;
    }
    
    $('#linkUrl-form').parsley().validate();
    if (!$('#linkUrl-form').parsley().isValid()) {
    	return;
    }
    
    $('#bannerDc-form').parsley().validate();
    if (!$('#bannerDc-form').parsley().isValid()) {
    	return;
    }
    
    
    ajaxUploadRealName($("#bannerImage")[0].files[0], false,function(data_url) {
    	data_url = data_url.replace(/\"/gi, "");
    	
	    var bannerNm = $("#bannerNm").val();
	    var bannerImageFile = data_url;
	    var linkUrl = $("#linkUrl").val();
	    var bannerDc = $("#bannerDc").val();
	    
	    var obj = {
	    		"bannerNm": bannerNm,
	    		"bannerImageFile": bannerImageFile,
	    		"linkUrl":linkUrl,
	    		"bannerDc": bannerDc
	    }
	    
	    $.ajax({
	       	url: "<c:url value='/addBanner.do' />",
	       	type: "POST",
	           data: obj,
	           dataType: "json",
	           beforeSend:function(){
	               $('.wrap-loading').removeClass('display-none');
	       		$('#banBtn').attr('disabled', false);
	           },
			complete:function(){
	               $('.wrap-loading').addClass('display-none');
	       		$('#banBtn').attr('disabled', false);
	        },
	       	success: function(jsondata){  
	            if(jsondata["data"]==0){
	                alert("성공적으로 입력 되었습니다.");
	                $('#banBtn').attr('disabled', false);
	                oTableB.ajax.reload();
	                settingTableCnt($("#banner-table-cnt"), oTableB);
	            }else{
	          	  alert("양식을 다시 확인하길 바랍니다.");
	            }
	       	},
	       	error: function(request,status,error){
	       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	           	$('#result').text(jsondata);
	       		$('#banBtn').attr('disabled', false);
	       	}
	    });
   	});
}
</script>
</head>
<body>


	<input type="radio" name="standard_tabmenu2" id="tabmenu-4">
	<label for="tabmenu-4">배너설정</label>
	<div class="tabCon">
		<ul class="width-100 margin-bottom-100">
			<li class="width-100 padding-top-60">
				<div class="width-100 height-540px">
				
				<!-- 
					<div
						class="background-f7fafc padding-15 border-box border-radius-bottom-5">
						<div class="inline-block float-left padding-top-5">
							<div class="font-16px inline-block margin-right-10 ">
								<div class="checkbox_big_blue banner-check" style="margin-right: 5px">
									<input type="checkbox" name="" id="check_login" name="체크"
										checked /> <label for="check_login"></label>
								</div>
								배너 사용
							</div>
							<span class="inline-block font-16px font-8793a5 margin-right-10">최대
								사용 수</span><input type="text" name="bannercount" placeholder=""
								value="3"
								class="width-70px height-40px line-height-40px border-radius-5 background-transparent border-8bc5ff border-box text-center margin-right-70" />

							<div class="font-16px inline-block margin-right-30">
								<div class="checkbox_big_blue banner-check" style="margin-right: 5px">
									<input type="checkbox" id="check_h-left" name="체크" /> <label
										for="check_h-left"></label>
								</div>
								배너 사용안함
							</div>
						</div>
						<div class="inline-block float-right padding-top-5">
							<a
								class="inline-block background-053c72 font-fff width-140px height-40px line-height-40px font-14px text-center margin-right-10"
								id="bannerConfBtn">저장</a> <a
								class="inline-block background-af0000 font-fff width-140px height-40px line-height-40px font-14px text-center">취소</a>
						</div>
					</div>
					 -->
					
					
					<div class="clear margin-bottom-20"></div>

					<div
						class="background-f7fafc padding-20 border-box border-radius-5">
						<div class="table_result_tit">
							총 <span id="banner-table-cnt">000</span>개를 검색하였습니다.
							<a class="background-826fe8" id="addRowBan"
								href="javascript:AddNewRowBanner()">배너추가</a>
						</div>
						<table id="tbl_banner" class="con_tb width-100" cellpadding="0"
							cellspacing="0" border="0" style="width: 100%;">
							<thead>
								<tr>
									<th class="width-5">번호</th>
									<th class="width-5">사용</th>
									<th class="width-15">배너명</th>
									<th class="width-15">이미지(000*000)</th>
									<th class="width-15">링크</th>
									<th class="width-14">등록일</th>
									<th class="width-14">최종수정일</th>
									<th class="width-8">비고</th>
									<th class="width-14">수정/삭제</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</li>
		</ul>
	</div>
</body>
</html>
