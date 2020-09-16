<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="MEMADDREXCELEXPORT" var="MEMADDREXCELEXPORT" />
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
	$("#uAddrEmploy").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('addressemploy', '직원주소록' ,'addressemploy');
	    global.htmlTableToExcel('addressemploy','직원주소록','addressemploy', "${EXCEL_SHEET_DATA_COUNT}");
	});

	
    editorE = new $.fn.dataTable.Editor({
        ajax: "<c:url value='/updateaddressbook.do' />",
        table: "#addressemploy",
        idSrc:  'address_id',
        fields: [
        	{ label: "직원여부:", name: "address_capy" }, 
        	{ label: "주소록고유ID:", name: "address_id" }, 
        	{ label: "주소록명:", name: "address_name"  }, 
        	{ label: "수신번호:", name: "address_num" }, 
        	{ label: "비고:", name: "address_ect" }
        ]
    }); 
    
    oTableE = $("#addressemploy").DataTable({
	     dom: "frtip",
   	     ajax: {
 	     	"type" : "POST",
 	        "url" : "<c:url value='/getaddressbookemploy.do' />",
 	        "data" :  function ( d ) {
 	        	globalGroupId = $("#menuTreeEmploy").jstree('get_selected', true)[0].id;
 	        	
	            	var tempAddr = $("#menuTreeEmploy").jstree('get_selected', true)[0].text
		        	if(tempAddr.indexOf("(") > -1){
		        		tempAddr = tempAddr.substring(0, tempAddr.indexOf("("))
		        	}
		        	$(".addressemploy-title").text(tempAddr);
	                d.address_grp_name = tempAddr
	                d.address_category = globalGroupId;
            },
 	        "dataType": "JSON"
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
    

	$('#searchEmployBtn').on( 'click',  function () { 
		 
		oTableE
	       .columns( $("#searchEmployOption option:selected").val()  )
	       .search( $("input[type=text][name=searchEmployKeyword]").val() )
	       .draw();
	});

	$('#addressemploy').on( 'click', 'tbody td:not(:first-child)', function (e) {
		editorE.inline( this, {
	            onBlur: 'submit',
	            submit: 'allIfChanged'
	    }); 
	}); 

	   /* 수정완료 후 Refresh() */
	editorS.on( 'submitSuccess', function ( e, type ) {
		oTableE.ajax.reload();
	});
	
    
});
</script>
</head>
<body>

	<input type="radio" name="filetree_tabmenu" id="tabmenu-4" data-tab-type="3">
	<label for="tabmenu-4">직원</label>
	<div class="tabCon">
		<ul class="width-100 margin-bottom-100">
			<li class="float-left  width-350px margin-right-30">
				<div class="width-350px height-710px border-radius-5 background-f7fafc padding-20 border-box" style="height: 727px;">
					<h3 class="block font-19px font-bold font-000 margin-bottom-10 padding-bottom-10 border-bottom-b7b7b7">직원 그룹 <a class="btn_option float-right open_pop_group"></a></h3>
					<div class="height-340px padding-top-5 padding-bottom-10 padding-rl-10 box-sizing:border-box border-e8e8e8 border-radius-5"  style="min-height: 340px;overflow: auto;">
																	
	 					<div id="menuTreeEmploy"></div>			
					</div>
				</div>
			<li>
		<li class="float-right width-970px padding-top-60">
			<div class="width-100 height-540px">
				<!--검색하기-->
				<div class="background-f7fafc padding-15 border-box border-radius-bottom-5">
					<select id="searchEmployOption" class="select_blank_lightblue width-120px" style="margin-right:10px">
						<option selected value="2">이름</option>
						<option value="3">휴대폰번호</option>
						<option value="4">비고</option>
					</select>
		
					<!--검색-->
					<div class="inline-block width-300px">
						<input id="searchEmployKeyword" type="text" name="searchEmployKeyword" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
					</div>
					<a id="searchEmployBtn" class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
				</div>
				<!-- //검색설정 -->
				<div class="clear margin-bottom-20"></div>
		
				<!--검색내용-->
				<div class="background-f7fafc padding-20 border-box border-radius-5">
					<div class="table_result_tit">
						<c:if test="${MEMADDREXCELEXPORT eq 'Y' }">
							<a id="uAddrEmploy" class="icon_btn width-100px background-00e04e font-bold"><span class="icon_clip"></span>엑셀 다운로드</a>
						</c:if>
							<a class="open_pop_address margin-right-10 background-826fe8 font-bold">주소록복사</a>
						</div>
						<br>
						<h3 class="font-18px font-174962 margin-bottom-10"><span class="font-bold addressemploy-title"></span> <span class="font-bold">[0건]</span></h3>
						<div class="height-210px">
							<div class="">
								<table id="addressemploy" class="con_tb" width="100%">
									<thead>
										<tr>
											<th class="width-30px"></th>
											<th class="">직원</th>
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

</body>
</html>
