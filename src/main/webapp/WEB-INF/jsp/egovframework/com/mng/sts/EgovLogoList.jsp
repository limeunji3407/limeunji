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
div.logo-check > input[type="checkbox"] {
    display: unset;
    -webkit-appearance:auto;
}
</style>
<script type="text/javaScript" language="javascript" defer="defer"> 
var today = new Date();
var globalId = "${loginVO.id}";
$(document).ready(function() {

	$(document).on("change", ".change-img", function(){
		if(confirm("이미지를 변경하시겠습니까?")){
			ajaxUploadRealName($(".change-img")[0].files[0], false,function(data_url) {
				data_url = data_url.replace(/\"/gi, "");
				
			    var LogoImageFile = data_url;
			    
			    var obj = {
			    		"imageFile": LogoImageFile,
			    		"userId": globalId
			    }
			    $.ajax({
			       	url: "<c:url value='/updateLogoImg.do' />",
			       	type: "POST",
			           data: obj,
			           dataType: "json",
			       	success: function(jsondata){  
			            if(jsondata["data"]==0){
			                oTable.ajax.reload();
			            }
			       	},
			   	});
			})
		}
	})
	
	
	$('#logoSaveBtn').on('click', function(){  
		var locations = $(".location");
		var str = "";
		for(var i = 0 ; i < locations.length ; i++){
			if(locations.eq(i).is(":checked")){
				str += locations.eq(i).val()+",";
			}
		}
		if(str){
			str = str.substring(0, (str.length-1))
		}
		
		
		  var obj = {
	         		 "location": str
	          }
			 $.ajax({
			       	url: "<c:url value='/updateLogoLocation.do' />",
			       	type: "POST",
			        data: obj,
			        dataType: "json",
			       	success: function(jsondata){
			       		if(jsondata["data"] == 0){
			       			alert("로고 저장을 완료하였습니다.")
			       		}
			       	}
			   	});
	});
	$(document).on( 'click', '#tbl_logo .icon_delete', function () {
		if (confirm("정말 삭제하시겠습니까?") == true){    //확인
			var obj = oTable.row($(this).closest('tr')).data();
		    $.ajax({
		    	url: "/delLogo.do?imageId="+obj.imageId,
		       	type: "POST",
		    	dataType: "json",
		       	success: function(jsondata){  
		            if(jsondata["data"]==0){
		                alert("성공적으로 삭제 되었습니다.");
		                oTable.ajax.reload();
		                settingTableCnt($("#logo-table-cnt"), oTable);
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

	
	init();
	
	
	$(document).on( 'click', '#tbl_logo tbody td:not(:first-child)', function (e) {
		editorM.inline( this, {
			  onBlur: 'submit'
	    });
	}); 
	/* 수정완료 후 Refresh() */
	editorM.on( 'preSubmit', function ( e, type ) {
		  var obj = {
         		 "imageId": this.field('imageId').val(),
         		 "imageNm": this.field('imageNm').val(),
         		 "imageDc": this.field('imageDc').val(),
         		 "userId": globalId
          }
		 $.ajax({
		       	url: "<c:url value='/updateLogo.do' />",
		       	type: "POST",
		        data: obj,
		        dataType: "json",
		       	success: function(jsondata){
		       		oTable.ajax.reload();
		       	}
		   	});
	});
	/* 수정완료 후 Refresh() */
	editorM.on( 'submitSuccess', function ( e, type ) {
		oTable.ajax.reload();
	});
	
});

var editorM;
var globalParam = "";
function init(){
    editorM = new $.fn.dataTable.Editor({
        table: "#tbl_logo",
        idSrc:  'imageId',
        fields: [
        	{ label: "imageId", name: "imageId" }, 
        	{ label: "imageNm", name: "imageNm"  }, 
        	{ label: "endDate", name: "endDate" },
        	{ label: "imageDc", name: "imageDc" }
        ]
    });  
    
	oTable = $('#tbl_logo').DataTable({ 
	     dom: 'frtip',
	     ajax: {
	     	"type" : "POST",
	        "url" : "/getLogoList.do",
	        "dataType": "json"
	     },
	     columns: [
			    	   { 
			    		   "data": null,"sortable": false, 
			    	       render: function (data, type, row, meta) {
								return meta.row + meta.settings._iDisplayStart + 1;
			    			}  
			    	   }, 
	                   { data: "imageNm" },
	                   { data: "imageFile",
	                	   render: function (data, type, row, meta) {
	                		   	var html = '<br><input type="file"  value="" class="change-img" style="text-align: center;display: inline-block;width:unset;height:unset;line-height:unset;">';
	                			return data+html;
			    			}     
	                   },
	                   { data: "regDate" },
	                   { data: "endDate" },
	                   { data: "imageDc" },
	                   { 
	                	    data: "location",
	                	    render: function (data, type, row, meta) {
	                	    	var locations = $(".location");
	                			for(var i = 0 ; i < locations.length ; i++){
	                				
	                				var locs = data.split(",");
	                				for(var y = 0 ; y < locs.length ; y++){
		                				if(locations.eq(i).val() == locs[y]){
		                					locations.eq(i).attr("checked", true);
		                				}
	                				}
	                			}
	                			return '';
			    			}  
	                   }
	     ],
			searching: false,
		    paging:   true, 
		    info:     true,
		    language: { 	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"  }
	 });
	settingTableCnt($("#logo-table-cnt"), oTable);
}

function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;
}
function AddNewRowLogo()
{
	
	var table = document.getElementById("tbl_logo");
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
	
	cell2.innerHTML = "<form id='Location-form' data-parsley-validate=''><select id='location' class='table-add-input'><option value='L'>로그인 화면</option><option value='HL'>헤더 좌측</option><option value='HR'>헤더 우측</option><option value='FL'>푸터 좌측</option><option value='FR'>푸터 우측</option></select></form> "
	cell4.innerHTML = "<form id='LogoNm-form' data-parsley-validate=''><input id='LogoNm' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff table-add-input' placeholder ='로고명' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-maxlength='20' data-parsley-minlength='2'/></form> "
	cell5.innerHTML = "<form id='LogoImage-form' data-parsley-validate=''><input type='file' id='LogoImage' class='image_inputType_file table-add-input' accept='img/*' required multiple></form>"
	cell6.innerHTML = getFormatDate(today);
	cell8.innerHTML = "<form id='LogoDc-form' data-parsley-validate=''><input id='LogoDc' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff table-add-input' placeholder ='비고' data-parsley-trigger='change' data-parsley-maxlength='200'/></form>"
	cell9.innerHTML = "<button id='LogoBtn' onclick='AddLogo()' class='icon_save'>등록</button> <button onclick='DeleteRowLogo()' class='icon_delete'>취소</button>"
}

function DeleteRowLogo(){
	var table_logo = document.getElementById("tbl_logo");
	var row = table_logo.deleteRow(1);
}
function AddLogo(){
	
    
	$('#LogoNm-form').parsley().validate();
    if (!$('#LogoNm-form').parsley().isValid()) {
    	return;
    }
    
    $('#LogoImage-form').parsley().validate();
    if (!$('#LogoImage-form').parsley().isValid()) {
    	return;
    }
    
    $('#LogoDc-form').parsley().validate();
    if (!$('#LogoDc-form').parsley().isValid()) {
    	return;
    }
    
    
    
    ajaxUploadRealName($("#LogoImage")[0].files[0], false,function(data_url) {
		data_url = data_url.replace(/\"/gi, "");
		
		var location = $("#location").val();
		var LogoNm = $("#LogoNm").val();
	    var LogoImageFile = data_url;
	    var LogoDc = $("#LogoDc").val();
	    
	    var obj = {
	    		"location": location,
	    		"imageNm": LogoNm,
	    		"imageFile": LogoImageFile,
	    		"imageDc": LogoDc,
	    		"userId": globalId
	    }
	    $.ajax({
	       	url: "<c:url value='/addLogo.do' />",
	       	type: "POST",
	           data: obj,
	           dataType: "json",
	           beforeSend:function(){
	               $('.wrap-loading').removeClass('display-none');
	       		$('#LogoBtn').attr('disabled', false);
	           },
			complete:function(){
	               $('.wrap-loading').addClass('display-none');
	       		$('#LogoBtn').attr('disabled', false);
	        },
	       	success: function(jsondata){  
	            if(jsondata["data"]==0){
	                //로딩
	                alert("성공적으로 입력 되었습니다.");
	                $('#LogoBtn').attr('disabled', false);
	                $("#tbl_logo tbody").find("tr").eq(0).remove();
	                oTable.ajax.reload();
	                settingTableCnt($("#logo-table-cnt"), oTable);
	          	  
	            }else{
	          	  alert("양식을 다시 확인하길 바랍니다.");
	            }
	       	},
	       	error: function(request,status,error){
	       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	           	$('#result').text(jsondata);
	       		$('#LogoBtn').attr('disabled', false);
	       	}
	   	});
	})
    
}
</script>
</head>
<body>  
	<input type="radio" name="standard_tabmenu2" id="tabmenu-5">
	<label for="tabmenu-5">로고설정</label>
	<div class="tabCon">
		<ul class="width-100 margin-bottom-100">
			<li class="width-100 padding-top-60">
				<div class="width-100 height-540px">
					<div class="background-f7fafc padding-left-15 padding-right-15 padding-top-25 padding-bottom-20 border-box border-radius-bottom-5">
						<div class="font-16px inline-block margin-right-30 line-height-30px">
							<div class="checkbox_big_blue logo-check" style="margin-right:5px">
								<input type="checkbox" id="check_login" name="체크" value="L" class="location" style="height: 15px;" />로그인 화면
							</div>
						</div>
						<div class="font-16px inline-block margin-right-40 line-height-30px">
							<div class="checkbox_big_blue logo-check" style="margin-right:5px">
								<input type="checkbox" id="check_h-left" name="체크" value="Hl" class="location"  style="height: 15px;" />헤더 좌측
							</div>
						</div>
						<div class="font-16px inline-block margin-right-40 line-height-30px">
							<div class="checkbox_big_blue logo-check" style="margin-right:5px">
								<input type="checkbox" id="check_h-right" name="체크" value="Hr" class="location" style="height: 15px;" />헤더 우측
							</div>
						</div>
						<div class="font-16px inline-block margin-right-40 line-height-30px">
							<div class="checkbox_big_blue logo-check" style="margin-right:5px">
								<input type="checkbox" id="check_f-left" name="체크" value="Fl" class="location" style="height: 15px;" />푸터 좌측
							</div>
						</div>
						<div class="font-16px inline-block line-height-30px">
							<div class="checkbox_big_blue logo-check" style="margin-right:5px">
								<input type="checkbox" id="check_f-right" name="체크" value="Fr" class="location" style="height: 15px;" />푸터 우측
							</div>
						</div>
					</div>
					<div class="clear margin-bottom-20"></div>

					<div class="background-f7fafc padding-20 border-box border-radius-5">
					<div class="table_result_tit">
						총 <span id="logo-table-cnt">000</span>개를 검색하였습니다.
						<!-- <a class="background-826fe8" id="addRowLogo" href="javascript:AddNewRowLogo()">로고추가</a> -->
					</div>
						<table class="con_tb width-100" cellpadding="0" cellspacing="0" border="0" id="tbl_logo" style="width: 100%;">
							<thead>
								<tr>
									<th class="width-5">번호</th>
									<th class="width-17">로고명</th>
									<th class="width-17">이미지(000*000)</th>
									<th class="width-16">등록일</th>
									<th class="width-16">최종수정일</th>
									<th class="width-15">비고</th>
									<th class="width-15">-</th>
								</tr>
							</thead>
						</table>
						<!--버튼-->
						<div class="btn-center">
							<a class="background-053c72 font-fff" id="logoSaveBtn" >저장</a>
							<a class="background-af0000 font-fff">취소</a>
						</div>
					</div>
				</div>
			</li>
		</ul>
	</div> 

</body>
</html>
