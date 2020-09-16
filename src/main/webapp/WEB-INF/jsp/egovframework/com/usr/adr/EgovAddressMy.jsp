<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="hpnoForm" var="hpnoForm"/>
<spring:message code="g_excle_max_num" var="g_excle_max_num"/>
<spring:message code="FILEMAXSIZE" var="FILEMAXSIZE" /> 
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
var globalGroupId = 0;
$(document).ready(function() {

	//엑셀다운로드
	$("#uAddrMy").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('adressbookmy', '개인주소록' ,'addressbookmy');
	    global.htmlTableToExcel('adressbookmy','개인주소록','addressbookmy', "${EXCEL_SHEET_DATA_COUNT}");
	});
	
	
    editorM = new $.fn.dataTable.Editor({
        ajax: "<c:url value='/updateaddressbook.do' />",
        table: "#adressbookmy",
        idSrc:  'address_id',
        fields: [
        	{ label: "직원여부:", name: "address_capy" }, 
        	{ label: "주소록고유ID:", name: "address_id" }, 
        	{ label: "주소록명:", name: "address_name"  }, 
        	{ label: "수신번호:", name: "address_num" }, 
        	{ label: "비고:", name: "address_ect" }
        ]
    });  
    oTableM = $("#adressbookmy").DataTable({
	    dom: "frtip",
   	    ajax: {
 	     	"type" : "POST",
 	        "url" : "<c:url value='/getaddressbookmy.do' />", 
	        "data" : function ( d ) {
	        	
	        		globalGroupId = $("#menuTreeMy").jstree('get_selected', true)[0].id;
	        		
	        		var tempAddr = $("#menuTreeMy").jstree('get_selected', true)[0].text;
		        	if(tempAddr.indexOf("(") > -1){
		        		tempAddr = tempAddr.substring(0, tempAddr.indexOf("("))
		        	}
		        	$(".adressbookmy-title").text(tempAddr);
	                d.address_grp_name = tempAddr
	                d.address_category = globalGroupId;
                
            },
 	        "dataType" : "JSON"
 		},
 	    columns: [  
 	    	{ 
		    	data: null,
                defaultContent: '',
                className: 'select-checkbox',
                orderable: false 
		    },
            { data: "address_type" },
            { data: "address_name" },
            { data: "address_num" },
        	{ data: "address_ect" },
        	{ 
        		data: null,
        		className: "center",
                defaultContent: '<a id="deleteData" class="icon_delete ">삭제</a>'
        	},
			{ data: "address_id", visible: false, searchable: false },
			{ data: "address_grp_name", visible: false, searchable: false }
		], 
        order: [ 1, 'asc' ],
        select: {
            style:    'os',
            selector: 'td:first-child'
        },
 	    paging:   true, 
	    info:     true,
	    language: {
	    	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"
	    }
    });  
	$('#addressMyFilter').on( 'click',  function () { 
		var srvcNm = '주소록 >> 개인';
		var methodNm = '검색';
		
		var obj = {
				"srvcNm":srvcNm,
				"methodNm":methodNm
		}
		$.ajax({
	    	url: "<c:url value='/usr/insertUsrLog' />",
	       	type: "POST",
        	data: obj,
	    	dataType: "json",
	       	success: function(jsondata){
	       		
	       		if(jsondata["data"]==0){
	       			console.log("로그가 성공적으로 저장되었습니다.");
	            }else{
	          	  alert("로그가 저장 실패.");
	            }
	       	},
	       	error: function(request,status,error){
	       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	       	}
	   	}); 
		
		oTableM
	       .columns( $("#search_option option:selected").val()  )
	       .search( $("input[type=text][name=searchFilterMy]").val() )
	       .draw();
	});
	
	
	$('#adressbookmy').on( 'click', 'tbody td:not(:first-child)', function (e) {
		editorM.inline( this, {
	            onBlur: 'submit',
	            submit: 'allIfChanged'
	    }); 
	}); 

	   /* 수정완료 후 Refresh() */
	editorM.on( 'submitSuccess', function ( e, type ) {
		oTableM.ajax.reload();
	});
	   
	   
	$(document).on( 'click', '#adressbookmy .icon_delete', function () {
		if (confirm("정말 삭제하시겠습니까?") == true){    //확인
			var obj = oTableM.row($(this).closest('tr')).data();
		    $.ajax({
		    	url: "/usr/add/deleteUser.do?address_id="+obj.address_id,
		       	type: "POST",
		    	dataType: "json",
		       	success: function(jsondata){  
		            if(jsondata["data"]==0){
		                oTableM.ajax.reload();
		            }else{
		            	console.log("삭제할수 없습니다.");
		            }
		       	},
		       	error: function(request,status,error){
		       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
		       	}
		   	});

		 }
	}); 
	
	$('#MyAdr_reg_excel').on('click', function(){	
		 
		
		 var files = document.getElementById("fileMyAdr").files[0]; //input file 객체를 가져온다.
		 var isSizeChk = global.fileSizeChk(files, "${FILEMAXSIZE}")
			if(isSizeChk) return;
		 
		    var reader = new FileReader();
		    reader.onload = function(){
		        var fileData = reader.result;
		        var wb = XLSX.read(fileData, {type : 'binary'});
		        wb.SheetNames.forEach(function(sheetName){
		  	       var rowJsonObj = XLSX.utils.sheet_to_json(wb.Sheets[sheetName]); 

		  	       
				    var i; 
				    var g_excle_max_num = '${g_excle_max_num}';
				    
				    if(g_excle_max_num<rowJsonObj.length){
				    	alert("엑셀 업로드는 최대 "+g_excle_max_num+"개까지 가능합니다.");
				    	return;
				    }
				    
				    for(var i in rowJsonObj){
						var address_name = rowJsonObj[i]['이름'];
					    var address_num = rowJsonObj[i]['전화번호'];
					    var address_ect = rowJsonObj[i]['메모'];
					    var address_type = "0";
					    var address_grp_name = rowJsonObj[i]['그룹명'];
					    var address_capy = "N";
						
						var obj = {
								"address_name": address_name,
								"address_num":address_num,
					           	"address_ect": address_ect,
					           	"address_grp_name": address_grp_name,
					           	"address_type": address_type,
					           	"address_capy": address_capy
						};
						
						$.ajax({
					       	url: "<c:url value='/usr/InsertaddressU.do' />",
					       	type: "POST",
					        data: obj,
					        dataType: "json",
					        beforeSend:function(){
					            $('.wrap-loading').removeClass('display-none');
					       		$('#addrBtn').attr('disabled', false);
					        },
							complete:function(){
					               $('.wrap-loading').addClass('display-none');
					       		$('#addrBtn').attr('disabled', false);
					        },
					       	success: function(jsondata){  
					            if(jsondata["data"]==0){
					                $('#addrBtn').attr('disabled', false);
					                oTableM.ajax.reload();
					            }else{
					            	console.log("양식을 다시 확인하길 바랍니다.");
					            }
					       	},
					       	error: function(request,status,error){
					           	$('#result').text(jsondata);
					       		$('#addrBtn').attr('disabled', false);
					       	}
					   	});
					}
		        })
		    };
		    reader.readAsBinaryString(files);
	});	
});

function AddNewRow()
{
	var hpnoForm = '${hpnoForm}';
	console.log("등록:" + jsTreeM);
	if(jsTreeM == "전체" || jsTreeM == undefined ){
		toastr.error("그룹을 선택해주세요");
		return;
	}
	var table = document.getElementById("adressbookmy");
	var rowlen = table.rows.length;
	var row = table.insertRow(rowlen-(rowlen-1));
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	var cell5 = row.insertCell(4);
	var cell6 = row.insertCell(5);
	cell3.innerHTML = "<form id='name-form' data-parsley-validate=''><input id='name' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='주소록 이름' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-maxlength='5'/></form> "
	cell4.innerHTML = "<form id='num-form' data-parsley-validate=''><input id='num' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='-제외 숫자만' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='11'/></form>"
	cell5.innerHTML = "<form id='memo-form' data-parsley-validate=''><input id='memo' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='비고' data-parsley-trigger='change' data-parsley-maxlength='200'/></form>"
	cell6.innerHTML = "<button id='addrBtn' onclick='AddRef()' class='icon_save'>등록</button> <button onclick='DeleteRow()' class='icon_delete'>취소</button>"

	if(hpnoForm=='N'){
		cell4.innerHTML = "<form id='num-form' data-parsley-validate=''><input id='num' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='-제외 숫자만' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='11'/></form>"
	}else if(hpnoForm == 'Y'){
		cell4.innerHTML = "<form id='num-form' data-parsley-validate=''><input id='num1' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='4' style='width:60px;'/>-<input id='num2' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='4' style='width:60px;'/>-<input id='num3' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='4' style='width:60px;'/></form>"
	}
}

function DeleteRow(){
	var table = document.getElementById("adressbookmy");
	var row = table.deleteRow(1);
}

function AddRef(){
	var hpnoForm = '${hpnoForm}';
	
	$('#name-form').parsley().validate();
    if (!$('#name-form').parsley().isValid()) {
    	return;
    }
    console.log("name-form ;;");
    
    $('#num-form').parsley().validate();
    if (!$('#num-form').parsley().isValid()) {
    	return;
    }
    
    $('#memo-form').parsley().validate();
    if (!$('#memo-form').parsley().isValid()) {
    	return;
    }
     
    var name = $("#name").val();
    var memo = $("#memo").val();
    var type = "0";
    var address_capy = "N"
   	var num;
        
    if(hpnoForm=='N'){
    	num = $("#num").val();
    }else if(hpnoForm == 'Y'){
    	num = $("#num1").val()+""+$("#num2").val()+""+$("#num3").val();	
    }
    
    var obj = {
    		"address_grp_name": jsTreeM,
    		"address_name": name,
    		"address_num": num,
    		"address_ect": memo,
    		"address_type": type,
    		"address_capy": address_capy,
    		"address_category":globalGroupId
    }
    
    $.ajax({
       	url: "<c:url value='/usr/InsertaddressU.do' />",
       	type: "POST",
        data: obj,
        dataType: "json",
        beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
       		$('#addrBtn').attr('disabled', false);
        },
		complete:function(){
               $('.wrap-loading').addClass('display-none');
       		$('#addrBtn').attr('disabled', false);
        },
       	success: function(jsondata){  
            if(jsondata["data"]==0){
                //로딩
                var srvcNm = '주소록 >> 개인';
				var methodNm = '추가';
				
				var obj = {
						"srvcNm":srvcNm,
						"methodNm":methodNm
				}
				$.ajax({
			    	url: "<c:url value='/usr/insertUsrLog' />",
			       	type: "POST",
		        	data: obj,
			    	dataType: "json",
			       	success: function(jsondata){
			       		
			       		if(jsondata["data"]==0){
			       			console.log("로그가 성공적으로 저장되었습니다.");
			            }else{
			          	  alert("로그가 저장 실패.");
			            }
			       	},
			       	error: function(request,status,error){
			       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
			       	}
			   	});
                $('#addrBtn').attr('disabled', false);
                oTableM.ajax.reload();
                myAddressFun(true);
            }else{
            	console.log("양식을 다시 확인하길 바랍니다.");
            }
       	},
       	error: function(request,status,error){
           	$('#result').text(jsondata);
       		$('#addrBtn').attr('disabled', false);
       	}
   	});
}
</script>
</head>
<body>
<input type="radio" checked name="filetree_tabmenu" id="tabmenu-1" data-tab-type="0">
							<label for="tabmenu-1">개인</label>
							<div class="tabCon">
								<ul class="width-100 margin-bottom-100">
									<li class="float-left  width-350px margin-right-30">
										<div class="width-350px height-710px border-radius-5 background-f7fafc padding-20 border-box" style="height: 727px;">
											<h3 class="block font-19px font-bold font-000 margin-bottom-10 padding-bottom-10 border-bottom-b7b7b7">${loginVO.name} 님의 그룹 <a class="btn_option float-right open_pop_group"></a></h3>
											<div class="height-440px padding-top-5 padding-bottom-10 padding-rl-10 box-sizing:border-box border-e8e8e8 border-radius-5" style="min-height: 340px;overflow: auto;">
											
	 <div id="menuTreeMy"></div>							
											</div>
										</div>
									<li>
									<li class="float-right width-970px padding-top-60">
										<div class="width-100 height-540px">
											<!--검색하기-->
											<div class="background-f7fafc padding-15 border-box border-radius-bottom-5"> 
												<select id="search_option" class="select_blank_lightblue width-120px" style="margin-right:10px">
													<option selected value="2">이름</option>
													<option value="3">휴대폰번호</option>
													<option value="4">비고</option>
												</select> 
														
												<!--검색-->
												<div class="inline-block width-300px">
													<input  id="searchFilterMy" type="text" name="searchFilterMy" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
												</div>
												<a id="addressMyFilter" class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a> 
											</div>
											<!-- //검색설정 -->
											<div class="clear margin-bottom-20"></div>

											<!--검색내용-->
											<div class="background-f7fafc padding-20 border-box border-radius-5">
												<div class="table_result_tit">
													<a id="uAddrMy" class="icon_btn width-100px background-00e04e font-bold"><span class="icon_clip"></span>엑셀 다운로드</a>
													<a class="open_pop_call_excel_my  width-100px icon_btn margin-right-10 background-00e04e font-bold"><span class="icon_clip"></span>엑셀주소등록</a>
													<a class="open_pop_address margin-right-10 background-826fe8 font-bold">주소록복사</a>
													<a class="margin-right-10 background-ffcd91" id="addRow" href="javascript:AddNewRow()">신규등록</a>
												</div>
												<br>
												<h3 class="font-18px font-174962 margin-bottom-10"><span class="font-bold adressbookmy-title"></span> <span class="font-bold">[0건]</span></h3>
												<div class="height-210px">
													<div class="">
														<table id="adressbookmy" width="100%" class="con_tb">
															<thead>
																<tr>
																	<th class="width-30px"></th>
																	<th class="width-0">직원</th>
																	<th class="width-20">이름</th>
																	<th class="width-20">전화번호</th>
																	<th class="width-20">비고</th>
																	<th class="width-20">관리</th>
																</tr>
															</thead>
														</table>
													</div>
												</div>
											</div>
										</div>
									</li>
								</ul>
							</div>			
							
							
		<div class="pop_wrap pop_call_excel_my width-970px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">엑셀 주소 등록</div>
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
				<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-90">
					엑셀파일 찾기
					<input class="upload-name" value="" disabled="disabled" placeholder="선택된 파일 없음" />
					<label for="fileMyAdr">찾아보기</label> 
					<input type="file" id="fileMyAdr" class="upload-hidden" /> 
				</div>
				<ul class="pop_notice" style="padding-left:90px">
					<li>엑셀양식파일 : <a href="#">엑셀양식 다운로드</a></li>
					<li>최대 10만건 까지 등록할 수 있습니다.</li>
					<li>엑셀등록시 휴대폰 번호는 필수값입니다.</li>
					<li>휴대폰 번호는 반드시 0으로 시작해야 합니다.</li>
				</ul>
			</div>
			<!--버튼-->
			<div class="pop_btn-big margin-auto text-center margin-bottom-10">
				<a id="MyAdr_reg_excel" class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>
</body>
</html>
