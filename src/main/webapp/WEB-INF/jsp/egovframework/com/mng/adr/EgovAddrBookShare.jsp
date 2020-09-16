<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="hpnoForm" var="hpnoForm"/>
<spring:message code="g_excle_max_num" var="g_excle_max_num"/>
<spring:message code="FILEMAXSIZE" var="FILEMAXSIZE" />
<spring:message code="EXCEL_SHEET_DATA_COUNT" var="EXCEL_SHEET_DATA_COUNT" />
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
</style>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/addressbook.js' />"></script>
<script type="text/javaScript" language="javascript" defer="defer">
var g_addressTotalCountFlags = "${g_addressTotalCountFlag}";
var u_orgnztId = "${loginVO.orgnztId}";
var g_group_share = {};

var groupArray = [];
var groupArrayS = [];
var treedataS = []; 
var oTableS;
var jsTreeS;
var editorS;
var ajaxDataS = {};
var globalGroupArrayS = new Array();
function getListFilter(data, key, value){
	var retObj = [];
		$.each(data, function(){
			if(this[key]==value){
				retObj.push(this);
			}
		});
	return retObj;
}

$(document).ready(function() {
	var globalId = "${loginVO.id}";
	var globalOrgnztId = "${loginVO.orgnztId}";
	
function init(isRefresh){	
	groupArrayS = new Array();
	globalGroupArrayS = new Array();
	g_group_share = {};
	treedataS = []; 
	/*
		공유
	*/
		$.ajax({
	    	url: "/grp/AddrGroupListByType.do?type=2",  //msg/rcv/EgovRcvaddrList
	    	type: "POST",
	        dataType: "json",          // ajax 통신으로 받는 타입
	        contentType: "application/json",  // ajax 통신으로 보내는 타입
	        beforeSend:function(){
	            $('.wrap-loading').removeClass('display-none');
	    		$('#sendMsgBtn').attr('disabled', false);
	        },
			complete:function(){
	            $('.wrap-loading').addClass('display-none');
	    		$('#sendMsgBtn').attr('disabled', false);
	        },
	    	success: function(jsondata){ 
	    		console.log(jsondata)
	    		
	    		g_group_share = getListFilter(jsondata.data, "type", "2");
	    		
	    		g_group_share.sort(function(a,b){ //내림차순
					return a.sequence < b.sequence ? -1 : a.sequence > b.sequence ? 1 : 0;
				});
				
				g_group_share.sort(function(a,b){ //내림차순
					return a.parent < b.parent ? -1 : a.parent > b.parent ? 1:0;
				});	
				
				
				$.each(g_group_share, function(idx, row){
	
	    			if(row.parent == 0 ){ //상위그룹일때
	    				var groupInfo = {};
	    				groupInfo.code = row.code;
	    				groupInfo.id = row.code;
	    				if(g_addressTotalCountFlags == 'Y'){
		    				groupInfo.text = row.title + "(" +row.groupcnt + ")";
	    				}else{
		    				groupInfo.text = row.title;
	    				}
	    				
	    				if(globalId != row.userid){
	    					groupInfo.text = groupInfo.text+"("+row.usernm+")";
	    				}
	    				var k = g_group_share.filter(function(element){  
	    			        return element.parent == row.code;
	    			    }); 
	    					 
						var kk = k.length; 
						groupInfo.nodes = k;
						
	    				if(kk == 0){    					
	    	    			groupArrayS.push(groupInfo);   	    			
	    				}else{    					
	    					var stateInfo = {};
	    					stateInfo.opened = false;
	    					stateInfo.selected = false;
							groupInfo.status = stateInfo; 					
	    					
	    					var childArray = [];
	    					
	    					$.each(k, function(j, sub){ 
	    						var child = {};
	    						child.id = sub.code;
	    						if(g_addressTotalCountFlags == 'Y'){
	    							child.text = sub.title + "(" +sub.groupcnt + ")";
	    	    				}else{
	    	    					child.text = sub.title;
	    	    				}
	    						childArray.push(child);
	    					});
							groupInfo.children = childArray;
	    	    			groupArrayS.push(groupInfo);
	    	    			
	    	    			idx = idx + kk;    	    			
	    				} 
	    			}
	    		}); //each finish
				treedataS = [
					{ 
						'text' : '전체',
						'state' : {
							'opened' : true,
							'selected' : true
						},
						'children' : groupArrayS
					}
				];
				if(isRefresh){
	 	    		$('#menuTreeShare').jstree(true).settings.core.data = treedataS;
		    		$('#menuTreeShare').jstree(true).refresh();
	    		}else{
	    			$('#menuTreeShare').jstree({
						'core' : {
							'data' : treedataS,
							'force_text' : true,
							'check_callback' : true,
							'themes' : {
								'responsive' : false
							}
						},
						'plugins' : ['state','dnd','contextmenu','wholerow']
					}).bind("move_node.jstree", function (event, data) {
						global.jstreeUpdateSequence(data, function(){
							init(true);
						});
				    }).bind("rename_node.jstree", function (event, data) {
						global.jstreeUpdate(data, function(){
							init(true);
						});
				    });
	    		}
				globalGroupArrayS = groupArrayS;
				
				$('.wrap-loading').addClass('display-none');
	    		$('#sendMsgBtn').attr('disabled', false);
			
		    },
		    error: function(request,status,error){
		    		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    		$('#sendMsgBtn').attr('disabled', false);
		            $('.wrap-loading').addClass('display-none');
		    }
		});
}
init(false);
	//엑셀다운로드
	$("#shareExlBtn").click(function(){
	    global.htmlTableToExcel('addressshare','공유주소록','공유주소록', "${EXCEL_SHEET_DATA_COUNT}");
	});
    editor = new $.fn.dataTable.Editor({
        ajax: "<c:url value='/updateaddressbook.do' />",
        table: "#addressshare",
        idSrc:  'address_id',
        fields: [
        	{ label: "직원여부:", name: "address_capy" }, 
        	{ label: "주소록고유ID:", name: "address_id" }, 
        	{ label: "주소록명:", name: "address_name"  }, 
        	{ label: "수신번호:", name: "address_num" }, 
        	{ label: "비고:", name: "address_ect" }
        ]
    }); 
    oTableS = $("#addressshare").DataTable({
	     dom: "frtip",
   	     ajax:  {
 	     	"type" : "POST",
 	        "url" : "<c:url value='/getaddressbookshare.do' />",
 	        "data" :  function ( d ) {
 	        	globalGroupId = $("#menuTreeShare").jstree('get_selected', true)[0].id;
                var tempAddr = $("#menuTreeShare").jstree('get_selected', true)[0].text
	        	if(tempAddr.indexOf("(") > -1){
	        		tempAddr = tempAddr.substring(0, tempAddr.indexOf("("))
	        	}
	        	$(".addressshare-title").text(tempAddr);
                d.address_grp_name = tempAddr
                d.address_category = globalGroupId;
            },
 	        "dataType": "JSON"
 	},
 	    columns: [ 
            { data: "address_type" }, 
			{ data: "address_capy" },
            { data: "address_name" },
            { data: "address_num" },
            { data: "address_ect" },
        	{ 
            	data: null,
               	className: "center",
                defaultContent: '<a id="deleteShare" class="icon_delete">삭제</a>'            		
            },
			{ data: "address_id", visible: false, searchable: false }
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
    /************************* datatable Initialize ***********************************/   
    
    /* datatable 검색 */
	$('#searchBtn').on( 'click',  function () {		 
		oTableS
	       .columns( $("#searchOpt option:selected").val()  )
	       .search( $("input[type=text][name=searchKeyword]").val() )
	       .draw();
	});
    
    /* inline 수정시 */    
    $('#addressshare').on( 'click', 'tbody td:not(:first-child)', function (e) {
    	console.log("--------modifyShare--------inline-----"); 
        editor.inline( this, {
            onBlur: 'submit',
            submit: 'allIfChanged'
        }); 
    }); 

   /* 수정완료 후 Refresh() */
    editor.on( 'submitSuccess', function ( e, type ) {
        oTableS.ajax.reload();
    });
    

    
    /* 삭제버튼시 */
	$(document).on( 'click', '#addressshare .icon_delete', function () {		
		if (confirm("정말 삭제하시겠습니까?") == true){    //확인
			var obj = oTableS.row($(this).closest('tr')).data();
		    $.ajax({
		    	url: "/usr/add/deleteUser.do?address_id="+obj.address_id,
		       	type: "POST",
		    	dataType: "json",
		       	success: function(jsondata){  
		            if(jsondata["data"]==0){
		           		oTableS.ajax.reload(); 
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
	
	
	/* 그룹선택시 */
	$('#menuTreeShare').on('activate_node.jstree', function (e, data) {

		jsTreeS = data.node.text; 
    	var id = data.node.id; 
    	console.log("-----menuTreeShare_select_jstree------" + id + ":length"  + data.node.text );

        oTableS.ajax.reload();
	}); 
	
	$('#SAdr_reg_excel').on('click', function(){	
		 var files = document.getElementById("fileSAdr").files[0]; //input file 객체를 가져온다.
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
				        console.log(rowJsonObj[i]);
						             
						var address_name = rowJsonObj[i]['이름'];
					    var address_num = rowJsonObj[i]['전화번호'];
					    var address_ect = rowJsonObj[i]['메모'];
					    var address_type = "2";
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
					     	   
					       		console.log(jsondata["data"]);
					            
					            if(jsondata["data"]==0){
					                //로딩
					                console.log("성공적으로 입력 되었습니다.");
					                $('#addrBtn').attr('disabled', false);
					                oTableS.ajax.reload();
					            }else{
					            	console.log("양식을 다시 확인하길 바랍니다.");
					            }
					       	},
					       	error: function(request,status,error){
					       		  
					       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
					           	$('#result').text(jsondata);
					       		$('#addrBtn').attr('disabled', false);
					       	}
					   	});
					}
		        })
		    };
		    reader.readAsBinaryString(files);
	});
	
	
	
	$(".open_pop_group").click(function(){
		$("input[name='newGroupNm']").val("")
		var tabType = $("input[name='filetree_tabmenu']:checked").attr("data-tab-type");
		var str = "";
		var tempList = globalGroupArrayS;
		
		
		for(var i = 0 ; i < tempList.length ; i++){
			var code = tempList[i].code;
			var text = tempList[i].text;
			str += "<option value='"+code+"'>"+text+"</option>";
		}
		$(".group-add-select").html(str);
		
		
		console.log(tempList)
		str = "";
		for(var i = 0 ; i < tempList.length ; i++){
			var code = tempList[i].code;
			var text = tempList[i].text;
			str += "<option value='"+code+"' data-depth='1'>"+text+"</option>";
			for(var x = 0 ; x < tempList[i].nodes.length ; x++){
				var code2 = tempList[i].nodes[x].code;
				var text2 = tempList[i].nodes[x].title;
				str += "<option value='"+code2+"' data-depth='2'>&nbsp;&nbsp;&nbsp;"+text2+"</option>";
			}
		}
				
		$(".group-del-select").html(str);
	});	
	$("#check_group").click(function(){
		var isChk = $(this).is(":checked");
		if(isChk){
			$(".group-add-select").attr("disabled", false)
		}else{
			$(".group-add-select").attr("disabled", true)
		}
	});	
	$(".del-group-btn").click(function(){
		
	            
        var code = $(".group-del-select").val();
	    var depth = $(".group-del-select").find("option:selected").data("depth");
        
	    var param = {
        	"address_category":code
        }
        $.ajax({
   		   type : "POST",
   	    	url: "/getaddressbookshare.do",
   	 		data : param,
   	 		dataType: "json",          // ajax 통신으로 받는 타입
   	    	success: function(jsondata){  
   	    		if(jsondata.data != null && jsondata.data.length > 0){
   	    			alert("주소록이 1개 이상 남아있어 삭제가 불가능합니다.");
   	    		}else{
   	    			param = {
   	    					"code":code,
   	    					"depth":depth
   	    			}
   	    		   $.ajax({
   	    			   type : "POST",
   	    		    	url: "/grp/AddrGroupDeleteSell.do",
   	    		 		data : param,
   	    		 		dataType: "json",          // ajax 통신으로 받는 타입
   	    		    	success: function(jsondata){  
   	    		    		if(parseInt(jsondata)>0){
   	    		    			init(true);
   	    		    		}
   	    		    	},error: function(request,status,error){
   	    		     		console.log(status)
   	    		     		console.log(error)
   	    		     	}
   	    			});
   	    		}
   	    	},error: function(request,status,error){
   	     		console.log(status)
   	     		console.log(error)
   	     	}
   		});
	});	
	
	$(".add-group-btn").click(function(){
		var type = 2;
		var title = $("input[name='newGroupNm']").val();
		var parent = $(".group-add-select").val();
		
		var isChk = $("#check_group").is(":checked");
		parent = isChk ? parent : 0;
		
		var depth = 0;
		depth = parent == '0' ? "0" : 2; 
		
		var userId = globalId;
		var sequence = 0;
		
		var param = {
				"title":title,
				"parent":parent,
				"sequence":sequence,
				"depth":depth,
				"type":type,
				"userid":userId
		}
	   $.ajax({
		   type : "POST",
	    	url: "<c:url value='/grp/AddrGroupInserts.do'/>",
	 		data : param,
	 		dataType: "json",          // ajax 통신으로 받는 타입
	    	success: function(jsondata){  
	    		if(parseInt(jsondata)>0){
	    			init(true);
	    		}
	    	},error: function(request,status,error){
	     		console.log(status)
	     		console.log(error)
	     	}
		});
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
				<li>공유주소록</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>주소록</li>
				<li><span class="dot"></span>공유주소록</li>
			</ul>
		</h1>


		<div class="width-1350px height-710px margin-bottom-100">
			<ul class="filetree_tabmenu">
				<li id="tab-1" class="btnCon"><input type="radio" checked
					name="filetree_tabmenu" id="tabmenu-1"> <!--label for="tabmenu-1">공유</label-->
					<div class="tabCon">
						<ul class="width-100 margin-bottom-100">
							<li class="float-left  width-350px margin-right-30">
								<div
									class="width-350px height-580px border-radius-5 background-f7fafc padding-20 border-box">
									<h3
										class="block font-19px font-bold font-000 margin-bottom-10 padding-bottom-10 border-bottom-b7b7b7">
										공유 그룹 <a class="btn_option float-right open_pop_group"></a>
									</h3>
									<div
										class="height-340px padding-top-5 padding-bottom-10 padding-rl-10 box-sizing:border-box border-e8e8e8 border-radius-5"
										style="min-height: 340px; overflow: hidden;">

										<!--  <div id="tree1" data-url="/grp/AddrGroupSelectOne.do" ></div> -->
										<div id="menuTreeShare"></div>
									</div>
								</div>
							<li>
							<li class="float-right width-970px">
								<div class="width-100 height-580px">
									<!--검색하기-->
									<div
										class="background-f7fafc padding-15 border-box border-radius-5">
										<!-- 체크박스 -->
										<select id="searchOpt"
											class="select_blank_lightblue width-120px"
											style="margin-right: 10px">
											<option selected value="2">이름</option>
											<option value="3">휴대폰번호</option>
											<option value="4">비고</option>
										</select>
										<!-- 검색 -->
										<div class="inline-block width-250px">
											<input type="text" name="searchKeyword" placeholder=""
												class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
										</div>
										<a id="searchBtn"
											class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
									</div>
									<div class="clear margin-bottom-20"></div>

									<!--검색내용-->
									<div
										class="background-f7fafc padding-20 border-box border-radius-5 height-490px">
										<div class="table_result_tit">
											<a class="icon_btn width-100px background-00e04e font-bold"
												id="shareExlBtn"><span class="icon_clip"></span>엑셀 다운로드</a>
											
										</div>
										<br>
										<h3 class="font-18px font-174962 margin-bottom-10">
											<span class="font-bold addressshare-title"></span><span class="font-bold">[0건]</span>
										</h3>
										<div class="height-210px">
											<div class="">
												<table id="addressshare" class="display" width="100%">
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
					</div></li>
			</ul>
		</div>
	</div>




	<!-- popup 그룹 -->
	<div
		class="pop_wrap pop_group width-430px border-radius-5 background-f7fafc"
		style="padding: 0;">
		<ul class="group_wrapper border-bottom-e3e3e3">
			<li class="group_tit">그룹생성</li>
			<li class="group_inner">
					<table class="width-90 margin-auto" border="0">
						<colgroup>
							<col style="width: 100px" />
							<col style="width: 40px" />
							<col style="" />
						</colgroup>
						<tr>
							<th class="text-left">새 그룹명</th>
							<td colspan="2"><input type="text" name="newGroupNm" placeholder="" value="" class="padding-left-20 border-box" /></td>
						</tr>
						<tr>
							<th class="text-left" colspan="2">
								<div class="relative width-100 height-50px">
									<div class="checkbox-small width-1100 absolute position-vertical-center position-left">
										<input type="checkbox" checked id="check_group" name="체크" />
										<label for="check_group"></label>
										<span class="font-16px font-053c72 margin-left-5">상위 그룹 선택</span>
									</div>		
								</div>
							</th>
							<td>
								<select title="" class="select_white width-100 group-add-select">
									<option>선택해주세요</option>
								</select>
							</td>
						</tr>
					</table>
				<div class="pop_btn-medium">
						<a class="pop_close margin-right-20 width-125px background-053c72 font-fff add-group-btn">저장</a>
						<a class="pop_close width-125px background-8bc5ff font-fff">취소</a>
					</div>	
			</li>
		</ul>
		<ul class="group_wrapper">
			<li class="group_tit">그룹삭제</li>
			<li class="group_inner">
				<table class="width-90 margin-auto" border="0">
					<colgroup>
						<col style="width: 125px" />
						<col style="" />
					</colgroup>
					<tr>
							<th class="text-left font-172b4d">삭제 그룹 선택</th>
							<td>
								<select title="" class="select_white width-100 group-del-select">
									<option>선택해주세요</option>
								</select>
							</td>
					</tr>
				</table>
				<div class="pop_btn-medium">
					<a class="pop_close margin-right-20 width-125px background-053c72 font-fff del-group-btn">삭제</a>
					<a class="pop_close width-125px background-8bc5ff font-fff">취소</a>
				</div>
			</li>
		</ul>
	</div>



</body>
</html>
