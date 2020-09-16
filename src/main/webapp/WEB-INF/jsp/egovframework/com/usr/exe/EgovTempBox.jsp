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
.padding-rl-10{padding 0 10px;}
.row {
  display: flex;
  flex-wrap: wrap;
  padding: 0 4px;
}

/* Create four equal columns that sits next to each other */
.column {
/*   flex: 25%; */
  max-width: 25%;
  padding: 0 4px;
}

.column div {
  margin-top: 8px;
  vertical-align: middle;
/*   width: 100%; */
}

/* Responsive layout - makes a two column-layout instead of four columns */
@media screen and (max-width: 800px) {
  .column {
/*     flex: 50%; */
    max-width: 50%;
  }
}

/* Responsive layout - makes the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .column {
/*     flex: 100%; */
    max-width: 100%;
  }
}
.dataTables_wrapper {
	width: 100%
}
</style>
<script type="text/javaScript" language="javascript" defer="defer">
var oTableS;
var oTableL;
var oTableM;
var oTabelF;
var oTableC;

var globalId = "${loginVO.id}";
$(document).ready(function(){
	
	$(document).on("click", ".temp-item", function(){
		if(confirm("전송페이지로 이동하시겠습니까?")){
			var div = $(this).parent();
			var title = div.find(".temp-title").text();
			var content = div.find(".temp-content").text();
			location.href="/usr/sender?tempTitle="+title+"&tempContent="+content;
		}
	})
	
	$(".search-btn").click(function(){
		var dom = $(this).parents(".tabmenu_search");
		var searchKey = dom.find("select[name='searchKey']").val();
		var searchValue = dom.find("input[name='searchValue']").val();
		var tab = $("input[name='tabmenu']:checked").val();
		
		var param = {
				"userId":globalId,
				"searchCnd":searchKey,
				"searchWrd":searchValue
		}
		
		if(tab == 'S'){
			oTableS.ajax.url( "/getMySaveS.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'L'){
			oTableL.ajax.url( "/getMySaveL.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'M'){
			oTableM.ajax.url( "/getMySaveM.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'F'){
			oTableF.ajax.url( "/getMySaveF.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'C'){
			oTableC.ajax.url( "/getMySaveC.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}
	})
	
	
	function init(talbeId, url, cntTextId){
		var tempTable = $('#'+talbeId).DataTable({
			dom : "frtip",
			ajax : {
				"url" : url+"?userId="+globalId,
				"type" : "GET",
			},
			columns : [ {
				data : "subject"
			} ],
			searching : false,
			paging : true,
			info : true,
			language : {
				"url" : "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"
			},

			pageLength : 4,
			drawCallback : function(settings) {
				var api = this.api();
				var rowData = api.rows({page : 'current'}).data();
				var rowCount = api.rows({page : 'current'}).count();
				var this_row = api.rows().count();

				var td_body = "";

				if (this_row > 0) {

					for (var i = 0; i < rowCount; i++) {

						console.log(rowData[i]);

						td_body = td_body
								+ "<div class='column width-20 border-box padding-rl-10 margin-left-33 margin-right-33'><div class='width-100 temp-item'>"
								+ "<h5 class='font-18px font-normal font-174962 text-left temp-title'>"
								+ rowData[i]['title']
								+ "</h5>"
								+ "<div onclick='rowDetail("
								+ rowData[i]['mysaveSeq']
								+ ");' class='width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent temp-content padding-10 line-height-default margin-bottom-10'>"
								+ rowData[i]['subject']
								+ "</div>"
								+ "<a href='#' class='icon_delete margin-left-5' onclick='delRow("+rowData[i]['mysaveSeq']+ ");' >삭제</a>"
								+ "</div>"
								+ "</div>   ";

					}
					$("#"+talbeId+" tbody").addClass('row');
					$("#"+talbeId+" tbody").html(td_body);
				}
				$("#"+cntTextId).text(rowCount);
			}
		});
		
		
		return tempTable;
	}
	
	oTableS = init("templateS", "/getMySaveS.do", "cntS");
	if("${loginVO.lms_role}" == '1') {
		oTableL = init("templateL", "/getMySaveL.do", "cntL");
	}
	if("${loginVO.mms_role}" == '1') {
		oTableM = init("templateM", "/getMySaveM.do", "cntM");
	}
	if("${loginVO.fri_role}" == '1') {
		oTableF = init("templateF", "/getMySaveF.do", "cntF");
	}
	oTableC = init("templateC", "/getMySaveC.do", "cntC");
	tabeLeftSetting()

	
	$('.bs-callout-info').toggleClass('hidden', true);
    $('.bs-callout-warning').toggleClass('hidden', true);
	

	
})

function delRow(mysave_seq){
	if (confirm("정말 삭제하시겠습니까?") == true){    //확인
	    $.ajax({
	    	url: "/deleteMySave.do?mysaveSeq="+mysave_seq,
	       	type: "GET",
	    	dataType: "json",
	       	success: function(jsondata){  
	            if(jsondata["data"]==0){
	                alert("성공적으로 삭제 되었습니다.");
	                reloadTable();
	            }else{
	            	alert("삭제할수 없습니다.");
	            }
	       	},
	       	error: function(request,status,error){
	       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	       	}
	   	});

	 }
}

function reloadTable(){
	oTableS.ajax.reload();
	if("${loginVO.lms_role}" == '1') {
		oTableL.ajax.reload();
	}
	if("${loginVO.mms_role}" == '1') {
		oTableM.ajax.reload();
	}
	if("${loginVO.fri_role}" == '1') {
		oTableF.ajax.reload();
	}
	oTableC.ajax.reload();
	tabeLeftSetting()
	
}
function tabeLeftSetting(){
	var btnCons = $(".btnCon");
	var labels = $("ul.tabmenu > li label");
	var x = 0;
	for(var i = 0 ; i < btnCons.length ;i++){
		if(btnCons.eq(i).css("display") != 'none'){
			labels.eq(i).css("left",(270*(x++)));
		}
	}
}
/*
function validateForm() {
	
	$('#demo-form').parsley().validate();
    if (!$('#demo-form').parsley().isValid()) {
    	return;
    }
    
	var work_seq = $("#work_seq option:selected").val(); //
	var sender_key = $("#senderkey option:selected").val(); //text
	var template_type = $('[name=template_type]:checked').val(); //text
	var subject = $("#subject").val(); //text
	var tmp_name = $("#tmp_name").val(); //select
	var tmp_subject = $("#tmp_subject").val(); //text
	var butten = $("#butten").val();//text
	
	var obj = {
			"work_seq": work_seq,
        	"sender_key": sender_key,
        	"template_type": template_type,
        	"subject": subject,
        	"template_name": tmp_name,
        	"template_content": tmp_subject,
        	"butten": butten
	};
	
 	$.ajax({
    	url: "<c:url value='/insertTemplate.do' />",
    	type: "POST",
        data: obj,
        dataType: "json",
        beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
    		$('#newstaffbtn').attr('disabled', false);
        },
		complete:function(){
            $('.wrap-loading').addClass('display-none');
    		$('#newstaffbtn').attr('disabled', false);
        },
        success: function(jsondata){  
            if(jsondata["data"]==0){
                //로딩
                toastr.success('Template가 성공적으로 변경되었습니다'); 
                $('#newstaffbtn').attr('disabled', false);
            }else{
            	toastr.error('양식을 확인해주세요.'); 
            }
       	},
    	error: function(request,status,error){
    		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
        	$('#result').text(jsondata);
    		$('#newstaffbtn').attr('disabled', false);
    	}
	});
}
*/
</script>
</head>
<body>
			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>내 저장함</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>전송</li>
						<li><span class="dot"></span>내 저장함</li>
					</ul>
				</h1>


				<!-- 검색하기 -->
				<div class="relative width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
					<ul class="tabmenu">
						<li id="tab1" class="btnCon">
							<input type="radio" checked name="tabmenu" id="tabmenu1" value="S">
							<label for="tabmenu1">단문</label>
							<div class="tabCon">
								<%@ include file="EgovTempBoxSearch.jsp" %>
								<!-- 검색결과 -->
									<div class="background-fff padding-15 margin-bottom-100 border-box box-shadow-small border-radius-5">
										<div class="table_result_tit">
											총 <span id="cntS">000</span>개를 검색하였습니다.
										</div>
						
										<!--내용-->
										<div class="flex-between margin-top-20">
						
											<table id="templateS" style="padding-bottom: 10px; width: 100%">
												<thead height="0" style="display: none;">
													<tr height="0">
														<th height="0">검수상태</th>
														<th height="0">내용</th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								<!-- //검색결과 -->
							</div>
						</li>
						<li id="tab2" class="btnCon" style="<c:if test="${loginVO.lms_role ne '1' }">display:none</c:if>">
							<input type="radio" name="tabmenu" id="tabmenu2" value="L">
							<label for="tabmenu2">장문</label>
							<div class="tabCon">
							
								<%@ include file="EgovTempBoxSearch.jsp" %>
								<!-- 검색결과 -->
									<div class="background-fff padding-15 margin-bottom-100 border-box box-shadow-small border-radius-5">
										<div class="table_result_tit">
											총 <span id="cntL">000</span>개를 검색하였습니다.
										</div>
						
										<!--내용-->
										<div class="flex-between margin-top-20">
						
											<table id="templateL" style="padding-bottom: 10px; width: 100%">
												<thead height="0" style="display: none;">
													<tr height="0">
														<th height="0">검수상태</th>
														<th height="0">내용</th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								<!-- //검색결과 -->
							</div>
						</li>
						<li id="tab3" class="btnCon" style="<c:if test="${loginVO.mms_role ne '1' }">display:none</c:if>">
							<input type="radio" name="tabmenu" id="tabmenu3" value="M">
							<label for="tabmenu3">멀티</label>
							<div class="tabCon">
							
								<%@ include file="EgovTempBoxSearch.jsp" %>
								<!-- 검색결과 -->
									<div class="background-fff padding-15 margin-bottom-100 border-box box-shadow-small border-radius-5">
										<div class="table_result_tit">
											총 <span id="cntM">000</span>개를 검색하였습니다.
										</div>
						
										<!--내용-->
										<div class="flex-between margin-top-20">
						
											<table id="templateM" style="padding-bottom: 10px; width: 100%">
												<thead height="0" style="display: none;">
													<tr height="0">
														<th height="0">검수상태</th>
														<th height="0">내용</th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								<!-- //검색결과 -->
							</div>
						</li>
						<li id="tab4" class="btnCon" style="<c:if test="${loginVO.fri_role ne '1' }">display:none</c:if>">
							<input type="radio" name="tabmenu" id="tabmenu4" value="F">
							<label for="tabmenu4">친구톡</label>
							<div class="tabCon">
								
								<%@ include file="EgovTempBoxSearch.jsp" %>
								<!-- 검색결과 -->
									<div class="background-fff padding-15 margin-bottom-100 border-box box-shadow-small border-radius-5">
										<div class="table_result_tit">
											총 <span id="cntF">000</span>개를 검색하였습니다.
										</div>
						
										<!--내용-->
										<div class="flex-between margin-top-20">
						
											<table id="templateF" style="padding-bottom: 10px; width: 100%">
												<thead height="0" style="display: none;">
													<tr height="0">
														<th height="0">검수상태</th>
														<th height="0">내용</th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								<!-- //검색결과 -->
							</div>
						</li>
						<li id="tab5" class="btnCon">
							<input type="radio" name="tabmenu" id="tabmenu5" value="C">
							<label for="tabmenu5">경조사</label>
							<div class="tabCon">
							
								<%@ include file="EgovTempBoxSearch.jsp" %>
								<!-- 검색결과 -->
									<div class="background-fff padding-15 margin-bottom-100 border-box box-shadow-small border-radius-5">
										<div class="table_result_tit">
											총 <span id="cntC">000</span>개를 검색하였습니다.
										</div>
						
										<!--내용-->
										<div class="flex-between margin-top-20">
						
											<table id="templateC" style="padding-bottom: 10px; width: 100%">
												<thead height="0" style="display: none;">
													<tr height="0">
														<th height="0">검수상태</th>
														<th height="0">내용</th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								<!-- //검색결과 -->
							</div>
						</li>
					</ul>
				</div>
			</div>


</body>
</html>
