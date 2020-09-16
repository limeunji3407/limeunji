<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_workSeqZeroCodeUseYN"
	var="g_workSeqZeroCodeUseYN" />
<spring:message code="workSeqRequiredFlag" var="workSeqRequiredFlag" />
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
<style type="text/css">
.dataTables_wrapper {
	width: 100%
}
</style>

<script type="text/javaScript" language="javascript" defer="defer">
var p_seq = 0;
var b_seq = 0;

var globalId = "${loginVO.id}";
	$(document).ready(function() {
		
		

	$('.bs-callout-info').toggleClass('hidden', true);
	$('.bs-callout-warning').toggleClass('hidden', true);

	$('#demo-form').parsley().on(
			'field:validated',
			function() {
				var ok = $('.parsley-error').length === 0;
				$('.bs-callout-info').toggleClass('hidden',
						!ok);
				$('.bs-callout-warning').toggleClass(
						'hidden', ok);
			}).on('form:submit', function() {
		return false; // Don't submit form for this demo
	});
	
	$("#tmpexcel").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('addressshare', '공유주소록' ,'addressshare');
	    global.htmlTemplateToExcel('template','템플릿','template', "${EXCEL_SHEET_DATA_COUNT}");
	});

	var oTable = $('#template').DataTable({
		dom : "frtip",
		ajax : {
			"url" : "<c:url value='/getTemplate' />",
		},
		columns : [
			{data : "use_yn"}
		],
		searching : false,
		paging : true,
		info : true,
		language : {
			"url" : "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"
		},

		pageLength : 4,
		drawCallback : function(settings) {
			var api = this.api();
			var rowData = api.rows({
				page : 'current'
			}).data();
			var rowCount = api.rows({
				page : 'current'
			}).count();
			var this_row = api.rows()
					.count();
			console.log(rowCount);

			var td_body = "";

			if (this_row > 0) {

				console.log(rowData);

				//for (var key in rowData) { 
				for (var i = 0; i < rowCount; i++) {

					console.log(rowData[i]);
					
					
					var status = rowData[i]['inspection_status'];
					var tt = ""
					if(status == 'REJ' || status == 'KRR') tt="color:red"; 
					var status2 = "";
					if(status == 'REG'){
						status2 = '등록';
					}else if(status == 'APR'){
						status2 = '승인';
					}else if(status == 'REQ'){
						status2 = '검수요청';
					}else if(status == 'KRR'){
						status2 = '등록거절';
					}else if(status == 'REJ'){
						status2 = '승인반려';
					}else {
						status2 = '삭제';
					}
					
					var deleteBtn
					
					if(status == 'APR' && rowData[i]['status']=='R' && rowData[i]['process_ing']=='N'){
						deleteBtn = '';
					}else {
						deleteBtn = 'hidden';
					}

					td_body = td_body
							+ "<div class='column width-20 border-box padding-rl-10 margin-left-33 margin-right-33 first-div'><div class='width-100'>"
							+ "<h5 class='font-18px font-normal font-174962 text-left template-name' style='display: inline-block;'>"
							+ rowData[i]['template_name']
							+ "</h5><p class='font-15px font-normal template-status' style='float: right;display: inline-block;"+tt+"' >"+status2+"</p>"
							+ "<div onclick='rowDetail("
							+ rowData[i]['template_data_seq']
							+ ");' class='template-content width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default margin-bottom-10'>"
							+ rowData[i]['template_content']
							+ "</div><a "+deleteBtn+" class='icon_delete margin-left-5' onclick='rowDelete("
							+ rowData[i]['template_data_seq']
							+ ");' >삭제</a>"
							+ "</div>"
							+ "</div>";

				}
				$("#template tbody").addClass('row');
				$("#template tbody").html(td_body);
			}
		}
	});
	
	$('#searchBtn').on( 'click', function () {
		
		console.log("searchBtn;;");
		
		var typeOptVal = $("#serch_work_seq option:selected").val();
		var typeOptVal2 = $("#use_yn option:selected").val();
		var typeOptVal3 = $("#tmp_status option:selected").val();
		var search_type = $("#search_type option:selected").val();
		var search_word = $("#search_word").val();
		
		var obj = {
			"work_seq":typeOptVal,
			"use_yn":typeOptVal2,
			"inspection_status":typeOptVal3,
			"search_type":search_type,
			"search_word":search_word
		}
		console.log(obj);
		
		if(search_type=="subject"){
			oTable.ajax.url( "/getTemplate?userId="+globalId+"&use_yn="+typeOptVal2+"&work_seq="+typeOptVal+"&inspection_status="+typeOptVal3+"&subject="+search_word ).load();
			console.log("/getTemplate?userId="+globalId+"&use_yn="+typeOptVal2+"&work_seq="+typeOptVal+"&inspection_status="+typeOptVal3+"&subject="+search_word);
		}else if(search_type=="template_name"){
			oTable.ajax.url( "/getTemplate?userId="+globalId+"&use_yn="+typeOptVal2+"&work_seq="+typeOptVal+"&inspection_status="+typeOptVal3+"&template_name="+search_word ).load();
			console.log("/getTemplate?userId="+globalId+"&use_yn="+typeOptVal2+"&work_seq="+typeOptVal+"&inspection_status="+typeOptVal3+"&template_name="+search_word);
		}else {
			oTable.ajax.url( "/getTemplate?userId="+globalId+"&use_yn="+typeOptVal2+"&work_seq="+typeOptVal+"&inspection_status="+typeOptVal3+"&template_content="+search_word ).load();
			console.log("/getTemplate?userId="+globalId+"&use_yn="+typeOptVal2+"&work_seq="+typeOptVal+"&inspection_status="+typeOptVal3+"&template_content="+search_word);
		}
	});
	
	global.settingTableCnt($("#table-cnt"), oTable);

	// excle 등록
	$('#tmp_reg_excel').on('click',function() {

		var files = document.getElementById("filetmp").files[0]; //input file 객체를 가져온다.
				
		
		var isSizeChk = global.fileSizeChk(files, "${FILEMAXSIZE}")
		if(isSizeChk) return;
				

		var reader = new FileReader();
		reader.onload = function() {
			var fileData = reader.result;
			var wb = XLSX.read(fileData, {
				type : 'binary'
			});
		wb.SheetNames.forEach(function(sheetName) {
			//var toHtml = XLSX.utils.sheet_to_html(wb.Sheets[sheetName], { header: '' });
			//target.html(toHtml); 	       
			var rowJsonObj = XLSX.utils.sheet_to_json(wb.Sheets[sheetName]);

			console.log(rowJsonObj);
			//makeTR(json2array(rowObj), tableId); 

			var i;
			var g_excle_max_num = '${g_excle_max_num}';
			
			if(g_excle_max_num<rowJsonObj.length){
		    	alert("엑셀 업로드는 최대 "+g_excle_max_num+"개까지 가능합니다.");
		    	return;
		    }
			
			for ( var i in rowJsonObj) {
				//result.Push([i, json_data [i]]); 
				console.log(rowJsonObj[i]);

				var work_seq = rowJsonObj[i]['업무분류(미분류, 알림톡, 알림, 민원, 공지, 비상, 기타)'];
				if (work_seq == "미분류") {
					work_seq = "0";
				} else if (work_seq == "알림톡") {
					work_seq = "1";
				} else if (work_seq == "알림") {
					work_seq = "2";
				} else if (work_seq == "민원") {
					work_seq = "3";
				} else if (work_seq == "공지") {
					work_seq = "4";
				} else if (work_seq == "비상") {
					work_seq = "5";
				} else {
					work_seq = "6";
				}
				var sender_key = rowJsonObj[i]['카카오 senderKey'];
				var template_type = rowJsonObj[i]['템플릿 종류(일반, 경조사, 프리템플릿)'];
				if (template_type == "일반") {
					template_type = "N";
				} else if (template_type == "경조사") {
					template_type = "K";
				} else {
					template_type = "F";
				}
				var subject = rowJsonObj[i]['제목'];
				var template_name = rowJsonObj[i]['템플릿 이름'];
				var template_content = rowJsonObj[i]['템플릿 내용'];
				var template_buttons = rowJsonObj[i]['버튼']
				var tmp_code = rowJsonObj[i]['템플릿 코드'];
				var template_variables = rowJsonObj[i]['변수'];
				
				var obj = {
					"work_seq" : work_seq,
					"sender_key" : sender_key,
					"template_type" : template_type,
					"subject" : subject,
					"template_name" : template_name,
					"template_content" : template_content,
					"template_buttons" : template_buttons,
					"template_code" : tmp_code,
					"template_variables": template_variables
				};
				
				console.log(obj);
				
				$.ajax({
							url : "<c:url value='/insertTemplateExcel.do' />",
							type : "POST",
							data : obj,
							dataType : "json",
							beforeSend : function() {
								$(
										'.wrap-loading')
										.removeClass(
												'display-none');
								$(
										'#newstaffbtn')
										.attr(
												'disabled',
												false);
							},
							complete : function() {
								$(
										'.wrap-loading')
										.addClass(
												'display-none');
								$(
										'#newstaffbtn')
										.attr(
												'disabled',
												false);
							},
							success : function(
									jsondata) {

								if (jsondata["data"] == 0) {
									//로딩
									console.log('Template가 성공적으로 등록되었습니다');
									$(
											'#newstaffbtn')
											.attr(
													'disabled',
													false);
									oTable.ajax
											.reload();
									//close popup
								} else {
									toastr
											.error('양식을 확인해주세요.');
								}
							},
							error : function(
									request,
									status,
									error) {

								alert("code:"
										+ request.status
										+ "\n"
										+ "message:"
										+ request.responseText
										+ "\n"
										+ "error:"
										+ error)
								$(
										'#result')
										.text(
												jsondata);
								//alert("serialize err");
								$(
										'#newstaffbtn')
										.attr(
												'disabled',
												false);
							}
						});

					}
				})
		};
		reader.readAsBinaryString(files);

		$(".pop_bg").css('display', 'none');
		$('#pop_templet').css('display','none');

	});
})

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
		var tmp_code = $("#tmpCode").val();
		var template_variables = $("#tmpVar").val();
		
		var sortArray = new Array();
	   	var sorts = $(".butten");
		
		for(var i = 0 ; i < p_seq ; i++){
	   		var butten_name = sorts.eq(i).find("input[type=text][name='butten_name']");
	   		var butten_link_mo = sorts.eq(i).find("input[type=text][name='butten_link_mo']");
	   		var butten_link_pc = sorts.eq(i).find("input[type=text][name='butten_link_pc']");;
	   		var butten_link_and = sorts.eq(i).find("input[type=text][name='butten_link_and']");;
	   		var butten_link_Ios = sorts.eq(i).find("input[type=text][name='butten_link_ios']");;
	   		var butten_link_type = sorts.eq(i).find("input[type=text][name='butten_link_type']");;
	   		var obj = {
	   				"name": butten_name.val(),
	   				"linkMo": butten_link_mo.val(),
	   				"linkPc": butten_link_pc.val(),
	   				"linkAnd": butten_link_and.val(),
	   				"linkIos": butten_link_Ios.val(),
	   				"linkType": butten_link_type.val(),
	   				"ordering": i+1
	   		}
	   		sortArray.push(obj);
	   	}

		//alert(reg_user_name);
		var obj = {
			"work_seq" : work_seq,
			"sender_key" : sender_key,
			"template_type" : template_type,
			"subject" : subject,
			"template_name" : tmp_name,
			"template_content" : tmp_subject,
			"template_buttons" : JSON.stringify(sortArray),
			"template_code" : tmp_code,
			"template_variables": template_variables
		};
		
		console.log(JSON.stringify(obj));
		
		return;
		
		$.ajax({
			url : "<c:url value='/insertTemplate.do' />",
			type : "POST",
			data : obj,
			dataType : "json",
			beforeSend : function() {
				$('.wrap-loading').removeClass('display-none');
				$('#newstaffbtn').attr('disabled', false);
			},
			complete : function() {
				$('.wrap-loading').addClass('display-none');
				$('#newstaffbtn').attr('disabled', false);
			},
			success : function(jsondata) {

				alert(jsondata["data"]);

				if (jsondata["data"] == 0) {
					//로딩
					alert('Template가 성공적으로 등록되었습니다');
					location.href  ="/usr/template";
					//close popup
				} else {
					toastr.error('양식을 확인해주세요.');
				}
			},
			error : function(request, status, error) {

				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error)
			}
		});
	}

	function rowDetail(template_data_seq) {
		console.log(template_data_seq);
		location.href = "/usr/templateDetail?tmpcode=" + template_data_seq;
	}
	
	function rowDelete(template_data_seq) {
		console.log('DeleteRec() invoked;;');

		if (confirm("정말 삭제하시겠습니까??") == true) { //확인

			console.log('DeleteRec() 삭제 확인 ;;');

			var obj = {
					"template_data_seq" : template_data_seq
			}

			console.log(JSON.stringify(obj));

			$.ajax({
				url : "<c:url value='/deleteTemplate.do' />",
				type : "POST",
				data : obj,
				dataType : "json",
				success : function(
						jsondata) {

					console.log(jsondata["data"]);

					if (jsondata["data"] == 0) {
						//로딩
						alert("성공적으로 삭제 되었습니다.");
						oTable.ajax
								.reload();

					} else {
						alert("삭제할수 없습니다.");
					}
				},
				error : function(
						request,
						status,
						error) {

					console
							.log("code:"
									+ request.status
									+ "\n"
									+ "message:"
									+ request.responseText
									+ "\n"
									+ "error:"
									+ error)
					//$('#result').text(jsondata);
					//console.log("serialize err");
					//$('#refBtn').attr('disabled', false);
				}
			});

		} else {

			console.log('DeleteRec() 삭제 취소;;');
		}
	}

var arrTypeHtml = [
	"<span id='t_btn_name'><input type='text' name='butten_link_type' value='BK' hidden><input type='text' placeholder='버튼명' id='link_name' name='butten_name' size='14' maxlength='28' value='' style='height:24px;'></span>",
	"<span id='t_btn_name_1'><input type='text' name='butten_link_type' value='MD' hidden><input type='text' placeholder='버튼명' id='link_name_1' name='butten_name' size='14' maxlength='28' value='' style='height:24px;'></span>",
	"<input type='text' name='butten_link_type' value='AL' hidden><input type='text' placeholder='버튼명' id='link_andr_name' name='butten_name' size='14' maxlength='28' value='' style='height:24px;'>",
	"<input type='text' name='butten_link_type' value='WL' hidden><input type='text' placeholder='버튼명' id='link_mo_name' name='butten_name' size='14' maxlength='28' value='' style='height:24px;'>",
	"<span id='t_btn_input_DS'><input type='text' name='butten_link_type' value='DS' hidden>※ '배송 조회하기' 고정 문구<input type='text' name='butten_name' value='배송 조회하기' hidden></span>",
	"<span id='t_btn_input_WL'>Mobile : <input type='text' id='link_mo' name='butten_link_mo' style='width:150px; height:24px;' maxlength='500' value=''><br>PC(옵션) : <input type='text' id='link_pc' name='butten_link_pc' style='width:150px; height:24px;' maxlength='500' value=''></span>",
	"<span id='t_btn_input_AL'>URL(Android) : <input type='text' id='link_andr' name='butten_link_and' style='width:150px; height:24px;' maxlength='500' value=''><br>URL(iOS) : <input type='text'id='link_ios'  name='butten_link_ios' style='width:150px; height:24px;' maxlength='500' value=''></span>"
];
	
	function addButton() {
		var addButtonHtml = "";
		console.log(p_seq);
		if(p_seq==5){
			toastr.error("버튼은 5개까지만 추가 가능합니다.");
			return false;
		}
		addButtonHtml = "<tr id='tr"+b_seq+"' class='butten'><td>"+ optLinkTypeList(b_seq) +"</td><td id='c_name" + b_seq +"'></td><td id='c" + b_seq +"'></td><td><a onclick='javascript:removeButton(this);' class='icon_delete'>삭제</a></td></tr>"
		$("#t_btn_1").append(addButtonHtml);
		
		p_seq = p_seq+1;
		b_seq = b_seq+1;
	}

	function removeButton(el) {
			$(el).parents("tr").remove();
			p_seq = p_seq-1;
			console.log(p_seq);
	}

	function chgBtntype(b_seq) {
		var btn_name = "";
		var buttonsHtml = "";
		var s_index = $("#link_type"+b_seq+"").val();
		console.log(s_index);
		console.log(arrTypeHtml[s_index]);
		console.log($("td[id=c_name"+b_seq+"]").html(arrTypeHtml[s_index]));
		
		$("td[id=c_name"+b_seq+"]").html(arrTypeHtml[s_index]); 
		
		console.log(s_index);
		if(s_index==3){
			console.log(s_index);
			$("td[id=c"+b_seq+"]").html(arrTypeHtml[5]); 
		}else if(s_index==2){
			console.log(s_index);
			$("td[id=c"+b_seq+"]").html(arrTypeHtml[6]); 
		}else if(s_index==''){
			console.log(s_index);
			$("td[id=c"+b_seq+"]").html(""); 
			$("td[id=c_name"+b_seq+"]").html(""); 
		}else{
			$("td[id=c"+b_seq+"]").html(""); 
		}
	}
	
	function optLinkTypeList(b_seq) {
		var optLinkTypeList = "<select class='select_white_small width-130px' style='background-color:#f9fbfd;' id='link_type"+b_seq+"' name='butten_link_type' onchange='javascript:chgBtntype("+b_seq+");'><option value=''>=선택=</option><option value='4'>배송조회</option><option value='3'>웹링크</option><option value='2'>앱링크</option><option value='0'>봇키워드</option><option value='1'>메시지전달</option></select>";
		var repOptLinkTypeList = optLinkTypeList.replace(/\*\*TEMPSEQ\*\*/g, b_seq);
		repOptLinkTypeList = repOptLinkTypeList.replace(/\*\*BTNSEQ\*\*/g, b_seq);
		return repOptLinkTypeList;
	}
	
	function code_check() {
		
		$('#tmpCode').parsley().validate();
		if (!$('#tmpCode').parsley().isValid()) {
			return;
		}
		
		var checkcode = $("#tmpCode").val(); //text
		var obj = {
            	"checkcode": checkcode
		};
     	$.ajax({
        	url: "<c:url value='/tmpCodeCheck.do' />",
        	type: "POST",
            data: obj,
            dataType: "json",
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
        		$('#idCheckBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#idCheckBtn').attr('disabled', false);
            },
        	success: function(jsondata){  
               if(jsondata["data"]==0){
	                   //로딩
	                   toastr.success('사용 가능한 코드입니다.');
               }else{
             	  toastr.error("중복되는 코드가 있습니다.");
               }
        	},
        	error: function(request,status,error){
        		alert("일치하는 정보가 없습니다.");
        	}
    	});
	}
</script>
<script type="text/x-jsrender" id="selectTypeList">
		<option value=''>업무분류</option>
		{{for data}}
			<option value='{{:code}}'>{{:codeNm}}</option>			
		{{/for}}
</script>
<script>
	$(function(){
		ajaxCallGetNoParse("/usr/work.do", function(res){
			var template = $.templates("#selectTypeList"); // <!-- 템플릿 선언
        	var htmlOutput = template.render(res); // <!-- 렌더링 진행 -->
        	$(".templata_work_seq").html(htmlOutput);
		})
	})
</script>
</head>
<body>
	<!--contents-->
	<div class="con-inner">
		<!--타이틀-->
		<h1 class="con-title">
			<ul>
				<li>템플릿관리</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>전송</li>
				<li><span class="dot"></span>템플릿관리</li>
			</ul>
		</h1>


		<!-- 검색하기 -->
		<div
			class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
			<!-- 검색설정 -->
			<div
				class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">
				<!--사용여부 셀렉박스-->
				<select class="select_blank_lightblue width-120px" id="use_yn"
					style="margin-right: 10px">
					<option selected value=''>사용여부</option>
					<option value="Y">사용</option>
					<option value="N">미사용</option>
				</select>

				<!--업무분류 셀렉박스-->
				<select class="select_blank_lightblue width-120px templata_work_seq" id="serch_work_seq" style="margin-right:10px">
				</select>

				<!--템플릿상태 셀렉박스-->
				<select class="select_blank_lightblue width-160px" id="tmp_status"
					style="margin-right: 10px">
					<option selected value=''>템플릿상태</option>
					<option value="REG">등록</option>
					<option value="REQ">검수요청</option>
					<option value="APR">승인</option>
					<option value="KRR">등록거절</option>
					<option value="REJ">승인반려</option>
					<option value="DEL">삭제</option>
				</select>

				<!--제목  셀렉박스-->
				<select class="select_blank_lightblue width-120px" id="search_type"
					style="margin-right: 10px">
					<option selected value="subject">제목</option>
					<option value="template_name">템플릿이름</option>
					<option value="template_content">내용</option>
				</select>

				<!--검색-->
				<div class="inline-block width-250px">
					<input type="text" name="" placeholder="" id="search_word"
						class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
				</div>
				<a	id="searchBtn"
					class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
				<p style="display:inline-block; font-size:8px; float:right; margin-top:30px;">상태가 [등록], [검수요청], [심사중], [등록거절], [승인반려] 인 건은 삭제할 수 없습니다.</p>
			</div>
			<!-- //검색설정 -->


			<!-- 검색결과 -->
			<div
				class="background-fff padding-15 margin-bottom-100 border-box box-shadow-small border-radius-5">
				<div class="table_result_tit">
					총 <span id="table-cnt">000</span>개를 검색하였습니다. <a id="tmpexcel"
						class="icon_btn width-100px background-00e04e"><span
						class="icon_clip"></span>엑셀 다운로드</a> <a
						class="open_pop_templet margin-right-10 background-826fe8">템플릿등록</a>
				</div>

				<!--내용-->
				<div class="flex-between margin-top-20">

					<table id="template" style="padding-bottom: 10px; width: 100%">
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
	</div>




	<!-- popup 템플릿등록 -->
	<div class="pop_wrap pop_templet width-730px"
		style="transform:translateX(-50%); background: transparent; top:50px;">
		<div class="width-100">
			<ul class="pop_tabmenu_excel">
				<li id="pop_tab_1" class="btnCon" style="overflow-y:auto; overflow-x:hidden; width:745px; height:900px;"><input type="radio" checked
					name="pop_tabmenu_excel" id="pop_tabmenu_1"> <label
					for="pop_tabmenu_1">단건등록</label>
					<div class="pop_tabCon">
						<form id="demo-form" data-parsley-validate="">
							<!-- 입력폼-->
							<div class="padding-rl-65 padding-tb-25 border-box">
								<h3 class="form_tit">템플릿 등록</h3>
								<table class="width-100 margin-bottom-40">
									<c:if test="${workSeqRequiredFlag != 'ND'}">
										<tr>
											<th class="width-125px">업무분류</th>
											<td><select title="" id="work_seq"
												class="select_white width-260px" required=""
												data-parsley-required="false" data-parsley-trigger="change">
													<c:if test="${workSeqRequiredFlag != 'Y'}">
														<option value="">선택해주세요</option>
													</c:if>
													<c:if test="${g_workSeqZeroCodeUseYN eq 'Y'}">
														<option value="0">미분류</option>
													</c:if>
													<option value="1">알림톡</option>
													<option value="2">알림</option>
													<option value="3">민원</option>
													<option value="4">공지</option>
													<option value="5">비상</option>
													<option value="6">기타</option>
											</select></td>
										</tr>
									</c:if>
									<tr>
										<th>SenderKey</th>
										<td><select title="" id="senderkey"
											class="select_white width-260px" required=""
											data-parsley-required="false" data-parsley-trigger="change">
										<c:forEach var="senderKey" items="${senderKeyList}"
											varStatus="status">
											<option value="${senderKey.senderKey}"
												${senderKey.senderKey == provider ? 'selected="selected"' : '' }>${senderKey.senderKey}</option>
										</c:forEach>
										</select></td>
										
									</tr>
									<tr>
										<th>템플릿 종류</th>
										<td>
											<div class="relative width-100 height-50px">
												<div
													class="checkbox-small width-100px absolute position-vertical-center position-left">
													<input required="" data-parsley-trigger="change"
														type="radio" checked id="check_1" name="template_type"
														value="N" /> <label for="check_1"></label> <span
														class="font-16px font-053c72 margin-left-5">일반</span>
												</div>
												<div
													class="checkbox-small width-100px absolute position-vertical-center"
													style="left: 100px">
													<input required="" data-parsley-trigger="change"
														type="radio" id="check_2" name="template_type" value="K" />
													<label for="check_2"></label> <span
														class="font-16px font-053c72 margin-left-5">경조사</span>
												</div>
												<div
													class="checkbox-small width-100px absolute position-vertical-center"
													style="left: 200px">
													<input required="" data-parsley-trigger="change"
														type="radio" id="check_3" name="template_type" value="F" />
													<label for="check_3"></label> <span
														class="font-16px font-053c72 margin-left-5">프리템플릿</span>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th>Templet Code</th> 
										<td><input type="text" id="tmpCode" name="" maxlength="8" data-parsley-pattern="^(?=.*[a-zA-Z])(?=.*[0-9]).{1,8}$"
											placeholder="영문자, 숫자 조합 8자 이내" value=""
											class="padding-left-20 border-box" required=""
											data-parsley-required="true" data-parsley-trigger="change" style="width:335px; margin-right:5px;"/>
											<a onclick="code_check();" class="width-80px height-50px line-height-50px font-15px border-radius-5 background-8bc5ff font-fff text-center margin-right-10">중복확인</a>
										</td>
									</tr>
									<tr>
										<th>변수 명</th>
										<td><input type="text" id="tmpVar" name=""
											placeholder="\#{변수명} 으로 작성, 두개 이상일시 || 로 구분해주세요." value=""
											class="padding-left-20 border-box" data-parsley-trigger="change"/></td>
									</tr>
									<tr>
										<th>제목</th>
										<td><input type="text" id="subject" name=""
											placeholder="제목이 들어갑니다" value=""
											class="padding-left-20 border-box" required=""
											data-parsley-required="true" data-parsley-trigger="change"
											maxlength="20" /></td>
									</tr>
									<tr>
										<th>템플릿 이름</th>
										<td><input type="text" id="tmp_name" name=""
											placeholder="템플릿 이름이 들어갑니다" value=""
											class="padding-left-20 border-box" required=""
											data-parsley-required="true" data-parsley-trigger="change"
											maxlength="20" /></td>
									</tr>
									<tr>
										<th class="vertical-top padding-top-20">탬플릿 내용</th>
										<td><textarea id="tmp_subject" name="tmp_subject"
												placeholder="탬플릿 내용을 들어갑니다."
												class="height-150px line-height-default padding-20 border-box"
												required="" data-parsley-required="true"
												data-parsley-trigger="change" maxlength="200"></textarea></td>
									</tr>
								</table>
							</div>
						</form>

						<div class="width-100">
							<table class="con_tb width-100" cellpadding="0" cellspacing="0" id="t_btn_1"
								border="0">
								<thead>
									<tr>
										<th class="width-30">버튼타입</th>
										<th class="width-20">버튼명</th>
										<th class="width-35">링크</th>
										<th class="width-15">관리</th>
									</tr>
								</thead>
								<tbody id="t_btn_1">
								</tbody>
							</table>

							<!--추가 버튼-->
							<div class="pop_btn" style="margin-bottom: 40px">
								<a class="background-8bc5ff border-8bc5ff font-fff"
									style="width: 120px;" onclick="addButton();">버튼추가</a>
							</div>



							<!--버튼-->
							<div class="pop_btn">
								<input type="submit" onClick="validateForm();"
									class="background-053c72 font-fff" id="newstaffbtn" value="등록">
								<!-- <a class="pop_close background-053c72 font-fff">등록</a> -->
								<a class="pop_close background-8bc5ff font-fff">취소</a>
							</div>
						</div>
					</div>
				</li>
				<li id="pop_tab_2" class="btnCon"><input type="radio"
					name="pop_tabmenu_excel" id="pop_tabmenu_2"> <label
					for="pop_tabmenu_2">대량등록</label>
					<div class="pop_tabCon" style="position:absolute; top:60px; left:0;">
						<div
							class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">

							<ul class="pop_notice" style="padding-left: 90px">
								<li class="tit">엑셀등록방법</li>
								<li class="no-list">1. 업로드 예제 엑셀다운로드양식으로 된 엑셀을 엽니다.</li>
								<li class="no-list">2. 유의사항을 참고하여 템플릿 내용을 입력하고 저장합니다.</li>
								<li class="no-list">3. [찾아보기] 또는[파일선택]을 눌러 대상 엑셀파일을 선택합니다.</li>
								<li class="no-list">4. [파일체크] 버튼을 클릭하여 엑셀파일에 이상이 있는지 확인합니다.</li>
								<li class="no-list">5. 파일체크 후 이상이 없다면[등록] 버튼을 클릭하여 등록합니다.</li>
								<li class="no-list"><font class="block margin-top-20"
									style="margin-bottom: 7px;">* TIP *</font> <font
									class="block margin-bottom-5">엑셀파일의 전체 속성은 일반, 텍스트로 지정을
										해야 하며 함수 등 연산이 입력되면 등록실패 처리 될 수 있습니다.</font> <font
									class="block margin-bottom-20">필수 항목에 공백이 있으면 등록이 실패할 수
										있으므로 필수 정보는 모두 입력해주세요.</font></li>
							</ul>
							<div
								class="filebox filebox_img bs3-primary text-left padding-left-90">
								<a
									class="width-140px height-30px line-height-30px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">엑셀양식
									다운로드</a> <input class="upload-name" value="" disabled="disabled"
									placeholder="제목 (최대 30Byte)" /> <label for="filetmp">찾아보기</label>
								<input type="file" id="filetmp" class="upload-hidden" />
							</div>
						</div>
						<!--버튼-->
						<div class="pop_btn" style="margin-bottom: 40px;display:none" >
							<a class="pop_close background-8bc5ff border-8bc5ff font-fff"
								style="width: 120px;">파일체크</a>
						</div>
						<div class="pop_btn">
							<a
								class="pop_close background-053c72 border-053c72 font-fff margin-right-20"
								id="tmp_reg_excel">등록</a> <a
								class="pop_close background-8bc5ff border-8bc5ff font-fff">취소</a>
						</div>
						<br>
					</div>
				</li>
			</ul>
		</div>
	</div>

</body>
</html>
