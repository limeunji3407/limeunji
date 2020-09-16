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
#counter {
  background:rgba(255,0,0,0.5);
  border-radius: 0.5em;
  padding: .5em .5em .5em .5em;
  text-align: center;
  text-color: #fff;
  font-weight: bold;
}
</style>
<script type="text/javaScript" language="javascript" defer="defer">
function arrUALstPop(idx){
	//console.log(arrUALst);
	var idx = arrUALst.indexOf(idx);
	//console.log("------arrUALst.length:" + arrUALst.length + "-----idx:" + idx);
	arrUALst.splice(idx,1);
	if(!arrUALst.length){
		//console.log("------disable -> enable -----:" + idx);
		arrUALstFlag = 0;
		$('#uaPopExcelBtn').removeClass("background-efefef");
		$('#uaPopExcelBtn').removeClass("disable"); 
		$('#uaPopGrpLstBtn').removeClass("background-efefef");
		$('#uaPopGrpLstBtn').removeClass("disable");
		$('#uaManualInputBtn').removeClass("background-efefef");
		$('#uaManualInputBtn').removeClass("disable");
	}
	
	$("#uaTotalCnt").text("총 " + arrUALst.length + "건");

	/*예상비용*/
	SetPrice("ua", arrUALst.length); 
}

$(document).ready(function(){ 

	
	
	/* 최초 핸드폰번호 입력*/
	if(isEmpty(uSMobile)){		
	    $("#uaSendNum").val("");
	}else{
	    $("#uaSendNum").val(uSMobile);
	}  
	
	/* 예약날짜세팅 */
	var currentDate = new Date().toISOString().substring(0, 10);
	var currentTime = new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
    $("#uaDataPicker").val(currentDate);
    $("#uaTimePicker").val(currentTime);
    
    
	/* 테스트세팅 */
	//$('#uaTitle').val("알림톡테스트입니다");
	//$('#uaContent').text("알림톡알림톡알림톡알림톡알림톡알림톡알림톡알림톡");
	//$('#phonelistalarm').text("01076700848");
	//$('#phonelistalarm').text("01042319120");
	
	
	/* 주소록 보기 */
	$("input:radio[name=tabmenu_small_alarm]").change(function() {
		var arrTabName = ["ua_pop_my_group_list","ua_pop_part_group_list","ua_pop_share_group_list","ua_pop_employ_group_list"];
		var tab = $('input:radio[name="tabmenu_small_alarm"]:checked').val(); 
		
		AjaxGroupList(tab, arrTabName[tab],"a");
	});
	
	/* 친구톡 주소록버튼클릭시 주소록리스트 */
	$('#uaPopGrpLstBtn').on('click', function(){
		var arrTabName = ["ua_pop_my_group_list","ua_pop_part_group_list","ua_pop_share_group_list","ua_pop_employ_group_list"];
		var tab = $('input:radio[name="tabmenu_small_alarm"]:checked').val(); 
		AjaxGroupList(tab, arrTabName[tab],"a");
		
		$(".pop_bg").css('display','block');
		$('#alarm_pop_group').css('display','block'); 
	}); /* msgAddressBtn click */
	/* 주소록 보기 */


	/* 그룹주소 이동버튼 */
	$("a.uaGrpPrvBtn").click(function(){ 
		
		/* 체크된 그룹탭 값 확인 */
		var tabType = $('input[name="tabmenu_small_alarm"]:checked').val();
		 
		var grp = arrUAGLst.find(x => x.rowNo === 1);		
		var grpIdx = arrUAGLst.indexOf(grp);
		if( arrUAPLst.find(x => x.code === grp.code && x.title === grp.title)){
			toastr.error("이미 선택된 그룹입니다");
			return false;
		} 
		
		arrUAPLst.push({
			isGroup : "Y", /* 그룹여부 */
			type : grp.type,  /* 타입  */
			title : grp.title,  /* 그룹명  */
			code : grp.code,     /* 그룹code Unique */
			phone : grp.groupcnt,
			type : grp.type
		});
			
		var html = "<li><div class=\"checkbox-small_2\">" +
			"<input type=\"checkbox\" id=\"check-" + grpIdx + "g\" name=\"mng_group_check_g" + grpIdx + "\"  />" +
			"<label for=\"check-" + grpIdx + "g\"></label>" + 
			"</div><span>" + grp.title + "(" + grp.groupcnt + ")</span></li>";
		$('ul.ua_pop_receiver').append(html);  
		 
	});
	
	
	
	/* 개별주소 이동버튼 */
	$("a.uaIndivPrvBtn").click(function(){
		/* 중복제거 */
		
 		$.each(arrUAGDLst, function(idx, row){ 
 			//체크인지 확인하고 PUSH
 			if(arrUAGDLst[idx].rowNo){
 				arrUAPLst.push({
 	 				isGroup : "N", /* 그룹여부 */
 	 				title : arrUAGDLst[idx].address_name,  /* 타이틀 */
 	 				code : arrUAGDLst[idx].address_id,     /* 그룹code Unique */
 	 				phone : arrUAGDLst[idx].address_num,
 	 				type : ""
 	 			});
 				var html = "<li><div class=\"checkbox-small_2\">" +
 				"<input type=\"checkbox\" id=\"check-" + idx + "i\" name=\"mng_group_check_i" + idx + "\"  />" +
 				"<label for=\"check-" + idx + "i\"></label>" + 
 				"</div><span>" + arrUAGDLst[idx].address_name + "<span>" + arrUAGDLst[idx].address_num + "</span></span></li>";
 				$('ul.ua_pop_receiver').append(html);
 			} 			
		});
 		
 		//console.log(arrUAPLst);
	});  
	
	
	/*
	* 선택제거
	*/
	$("#uaPopDelSelect").click(function(){

		var gb = $('ul.ua_pop_receiver li').get();
		//var gbInput = $('ul.mng_pop_receiver li').get();
		//console.log(gb);

		for ( var i = 0; i < gb.length; i++) {
			var gbInput = gb[i].childNodes;
			gbInput = gbInput[0].childNodes;
		  	var checked = gbInput[0].checked;
			//console.log(checked);
			if(checked){			
				$(gb[i]).remove();	
				//gb[i].innerHTML = ''; //li까지 제거해야
				arrUAPLst.splice(i-1, 1);		
			}
        } 
		
	});	

	/*
	* 전체제거
	*/
	$("#uaPopDelAll").click(function(){
		//$('ul.mng_pop_receiver li').remove();  
		$('.ua_pop_receiver').empty();	 
		arrUAPLst = [];
		arrUAGLst = {};
		arrUAGDLst = {};
	});	
	
	
	/* 팝업 취소 버튼 */
	$('#uaPopCancelBtn').click(function(){
		
		$('.ua_pop_my_group_list').empty();
		$('.ua_pop_employ_group_list').empty();
		$('.ua_pop_part_group_list').empty();
		$('.ua_pop_share_group_list').empty();
		$('.ua_pop_detail_list').empty();
		$('.ua_pop_receiver').empty();	 
		arrUAPLst = [];
		
	});
	
	/* 
	* 최종리스트 #tblSendList로 리스트이동
	* 등록하기 버튼
	*/
	$('#uaPopRegisterBtn').click(function(){

		//console.log("-----arrUAPLst []-----");
		//console.log(arrUAPLst);
		 
		
		/* arrUAPLst [] rendering */
		$.each(arrUAPLst, function(idx, row){ 
			
			/* 최종에 push */ 
			/* console.log(arrUAPLst[idx].title); */
		 	var trData = "<tr>" + 
						 "<td class=\"relative\">" + 
						 	"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
						 		"<input type=\"checkbox\" id=\"check_" + idx + "s\" name=\"체크\" class=\"mngcheck\" />" + 
						 		"<label for=\"check_" + idx + "s\"></label>" + 
						 	"</div> <a class=\"rev_name\">" + arrUAPLst[idx].title + "</a>" + 
						 "</td>" + 
						 "<td>" + arrUAPLst[idx].phone + "</td><td>주소록</td>" + 
						 "<td class=\"tb_btn\">" + 
						 	"<a class=\"open_pop icon_modify\">수정</a>" + 
			             	"<a href=\"#\" class=\"icon_delete\"onclick=\"arrUALstPop(" + arrUALst.length + ");deleteLine(this);\" >삭제</a>" + 
			             "</td>" + 
			             "</tr>";
			$('#tblsendalarm tbody').append(trData);
 
			
			/* 최종에 push */
			arrUALst.push({ 
				isGroup : row.isGroup, /* 그룹여부 */
 	 			title : "주소록",  /* 타이틀 */
 	 			code : row.code,     /* 그룹code Unique */
 	 			phone : row.phone,
 	 			name : row.title,
 	 			type : row.type
 	 		});
		}); 

		/* popup close */
		$(".pop_bg").css('display','none'); 
		/* 모든 것 clear */
		$('.ua_pop_my_group_list').empty();
		$('.ua_pop_employ_group_list').empty();
		$('.ua_pop_part_group_list').empty();
		$('.ua_pop_share_group_list').empty();
		$('.ua_pop_detail_list').empty();
		$('.ua_pop_receiver').empty();	 
		arrUAPLst = [];
		arrUAGLst = {};
		arrUAGDLst = {};

		$('#alarm_pop_group').css('display','none'); 
		//console.log(arrUALst);
		/*주소목록 모드*/
		arrUALstFlag = 1;
		$('#uaPopExcelBtn').addClass("background-efefef"); 
		$('#uaPopExcelBtn').addClass("disable");
		$("#uaTotalCnt").text("총 " + arrUALst.length + "건");

		/*예상비용*/
		SetPrice("ua", arrUALst.length)
	});	
	/************************************************* 팝업 주소록 보기 스크립트 ***********************************/
	
	
	
	/*********************************************** MMSINFO 이미지 업로드 ************************************/		
	/* 이미지등록 팝업 */
	$('#uaPopImgUploadBtn').on('click', function(){	 
		$(".pop_bg").css('display','block');
		$(".uaPopImgUpload").css('display','block');
	});
	
	/* 이미지파일 onChange */
	$('#ua_img_file').on('change', function(){
		 
	    var timeUID = Math.floor(new Date().getTime() / 1000);
	   //console.log($("#ua_img_file")[0].files[0].type); // 파일 타임
	   //console.log($("#ua_img_file")[0].files[0].size); // 파일 크기
	       
	       
		var previewTag = "<img id='thumbnailImg" + timeUID + "' src='' width='100' height='100' align='center' />";
		$('#uaContent').append(previewTag);
		
		let fileInfo = document.getElementById("ua_img_file").files[0];
		let reader = new FileReader();
		
		reader.onload = function() {
			document.getElementById("thumbnailImg" + timeUID ).src = reader.result;
			document.getElementById("ua_img_name").value = $('input[name=file]')[0].files[0].name;
			//$('#ua_img_name').val("파일명");
		}
		
		if( fileInfo ){
			reader.readAsDataURL( fileInfo );
		}
		//console.log(fileInfo);
	});
	
	
	
	/* 이미지 등록하기 */
	$('#uaImgRegBtn').on('click', function(){
		
		var formData = new FormData(document.getElementById("uaForm")); 
		//var formData = new FormData(document.getElementById("uploadForm")); 
		
		//console.log(formData);
		$.ajax({ 
			type: "POST", 
			url: '/msg/imgFileupload.do', 
			data: formData, // 필수
			processData: false, // 필수 
			contentType: false, // 필수 
			cache: false, 
			success: function (result) { 
				
				/* MMS 정보에 입력  삭제할 수도 있으니 uaContent내의 img태그를 취합해서 입력하도록 해야 */
				//arrUmMMS.push(result);
				
				//console.log(result);
				
				uaImgFile = result;
				//document.getElementById("thumbnailImg" + timeUID ).src = result;
				$(".pop_bg").css('display','none');
				$(".uaPopImgUpload").css('display','none');
			}, 
			error: function (e) { 
				toastr.error(e);
				$(".pop_bg").css('display','none');
				$(".uaPopImgUpload").css('display','none');
				
			} 
		});
 
	});
	
	/*********************************************** MMSINFO 이미지 업로드 ************************************/
 
	
	
	
	
	/* 엑셀 팝업창 */
	$('#uaPopExcelBtn').on('click', function(){	
		$(".pop_bg").css('display','block');
		$('#alarm_pop_excel').css('display','block'); 		
	});	
	
	/************************************* 템플릿 선택 및 템플릿 팝업***************************************/
	$('#uaPopTempletBtn').on('click', function(){
		 
		//console.log("-------mysaveSMS Insert Start ------");
		oTableTemplet = $('#uaTemplate').DataTable({
				dom : "frtip",
				ajax : { "url" : "<c:url value='/getTemplate' />" },
				columns : [ {
					data : "template_content",
					data : "template_code",
					data : "sender_key",
					data : "template_buttons",
					data : "template_variables"
				}],
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
					var this_row = api.rows().count();
					//console.log(rowCount);

					var td_body = "";
					if (this_row > 0) { 
						
							for (var i = 0; i < rowCount; i++) {
								 
								td_body = td_body
								+ "<div id='uaTemplate"+ rowData[i]['template_data_seq'] + "' class='column width-25 border-box padding-rl-10 margin-left-33 margin-right-33 cursor_point' "
								+ " onclick=\"selectRowUA('" + rowData[i]['template_data_seq'] + "','" + rowData[i]['sender_key'] + "','" + rowData[i]['template_code'] + "','" + rowData[i]['template_name'] + "','" + rowData[i]['template_content'] + "','" + rowData[i]['template_variables'] + "','" + escape(rowData[i]['template_buttons']) + "');\">" 
								+ "<div class='width-250'>"
								+ "<h5 class='font-14px font-normal font-174962 text-left'>"
								+ rowData[i]['template_name']
								+ "</h5>"
								+ "<div class='width-100 height-340px font-4d4f5c font-14px text-left border-e8e8e8 border-radius-5 background-transparent padding-5 line-height-default margin-bottom-10' style='overflow:auto;' >"
								+ rowData[i]['template_content'] 
								+ "</div>"
								+ "</div>"
								+ "</div>";
						
							}
							
							$("#uaTemplate tbody").addClass('row');
							$("#uaTemplate tbody").html(td_body);
							
					}
				}
			});
		
		$(".pop_bg").css('display','block');
		$('#uaTempletPopUp').css('display','block'); 		
	});	 
	 
	/************************************* 템플릿 선택 ***************************************/
	
	
	
	
	
	/************************************** 전송 체크 ***********************************/
	
	/*
	제목글자수체크
	*/
	$('#uaTitle').keyup(function (e){
	    var title = $(this).val();
	    
	    //$('#counter').html("("+content.length+" / 최대 200자)");    //글자수 실시간 카운팅

	    if ( Number(getByteLength(title)) > 30){ 
	    	//$(this).val(title.substring(0, title.length - 1));
	    	
	    	//e.preventDefault();
	    	$('#uaContent').focus();
	    	toastr.error("최대 30BYTE까지만 입력 가능합니다.");
	    	f_chk_byte($(this),30);
	    	return onlyBackspace(e);
	        //return false;
	        
	        //$('#counter').html("(200 / 최대 200자)");
	    }
	});
	
	/*
	내용글자수체크
	*/
	$('#uaContent').keyup(function (e){
	    var content = $(this).val();

	    if ( Number(getByteLength(content)) == 90 ){  
	    	
	    	e.preventDefault();
	    	//$(this).attr("readonly",true); 
	    	//$('#phonelistalarm').focus();
	    	toastr.error("단문은 최대 90BYTE까지만 입력 가능합니다.");
	    	//f_chk_byte($(this),90);
	        //$(this).val(content);
	        //return false; 
	        //$('#counter').html("(200 / 최대 200자)");
	    }
	    
	    if ( Number(getByteLength(content)) > 1800 ){ 

	    	e.preventDefault();
	    	$('#phonelistalarm').focus();
	    	toastr.error("최대 1800BYTE까지만 입력 가능합니다.");
	    	f_chk_byte($(this),1800);
	    }
	    
 		if( Number(getByteLength(content)) > 90 ){
 			totalCnt = "1800";
 		}else{
 			totalCnt = "90";
 		}
 		
       /*  $(this).height(((content.split('\n').length + 1) * 1.5) + 'em'); */
        $('#counter').html(content.length + '/' + totalCnt );
       
    	/* 전송목록이 있을때 내용처리시 예상비용이 수정되어야 한다*/
        if(arrUALst.length){
        	SetPrice("ua", arrUALst.length);
        }
	});
 

	//보내는번호입력
	
	$('input:radio[name=ua_send_num]').change(function() {
		
		var sendnumType = $('input:radio[name=ua_send_num]:checked').val();
		

		if(sendnumType === "3") {
			$('#uaSendNum').val("");
			//console.log("-------직접입력--------"+sendnumType);
		}else if(sendnumType === "1"){ //사무실
			//console.log("-------사무실번호--------" + sendnumType + ":" + uSTel);
			if( isEmpty(uSTel) ){
				uSTel = "";
				toastr.error("발송용 사무실번호가 없습니다.입력해주세요");
			}
			$('#uaSendNum').val(uSTel);
		}else{ //사무실 핸드폰
			//console.log("-------모바일번호--------" + sendnumType + ":" + uSMobile);
			if( isEmpty(uSMobile) ){
				uSMobile = "";
				toastr.error("발송용 핸드폰번호가 업습니다.입력해주세요");
			}
			$('#uaSendNum').val(uSMobile);
		}
		
	});
	
	
	//수동입력
	$('#uaManualInputBtn').on('click', function(){	 
		 
		//phonelist 내용을 배열에 담아   다른 리스트로 넣고 삭제한다 
		if(!$('#phonelistalarm').html().length){
			toastr.error("수신번호를 입력하세요");
			return;
		}
		var strTemp = $('#phonelistalarm').html();	
		//console.log(strTemp);
		strTemp = strTemp.replace("<div>","|");
		strTemp = strTemp.replace("</div><div>","|");
		strTemp = strTemp.replace("</div>","");
		var strTemp2 = strTemp.split('|'); //2번예제 분리

		//console.log(strTemp2);
		var i;
		var arrlen = arrUALst.length;
		for (i = 0; i < strTemp2.length; i++)
		{
			var trData = "<tr>" + 
							"<td class=\"relative\">" + 
						 		"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
						 			"<input type=\"checkbox\" id=\"check_4\" name=\"체크\" class=\"ftalkcheck\" />" + 
						 			"<label for=\"check_4\"></label>" + 
						 		"</div> <a class=\"rev_name\">미입력</a>" + 
						 	"</td>" + 
						 	"<td>" + strTemp2[i] + "</td><td></td>" + 
						 	"<td class=\"tb_btn\">" + 
						 		"<a class=\"open_pop icon_modify\">수정</a>" + 
			             		"<a href=\"#\" class=\"icon_delete\"onclick=\"arrUALstPop(" + arrUALst.length + ");deleteLine(this);\" >삭제</a>" + 
			             	"</td>" + 
			             "</tr>";  
		 
				    	
			             arrUALst.push({ 
				 				isGroup : "N", /* 그룹여부 */
				  	 			title : "미입력",  /* 타이틀 */
				  	 			code : null,     /* 그룹code Unique */
				  	 			phone : strTemp2[i],
				  	 			name : "미입력",
				  	 			type : ""
				  	 		});
			$('#tblsendalarm tbody').append(trData); 
		}		
		$('#phonelistalarm').html(null); 
		//console.log("-수동입력--시작카운터:"+ arrlen + "::::최종카운트 -" + arrUALst.length + ":" ); 

		arrUALstFlag = 1;
		$('#uaPopExcelBtn').addClass("background-efefef");
		$('#uaPopExcelBtn').addClass("disable");
		$("#uaTotalCnt").text("총 " + arrUALst.length + "건");

		/*예상비용*/
		SetPrice("ua", arrUALst.length) 
	});
	
	//엑셀입력
	$('#uaPopExcelRegBtn').on('click', function(){	


		/*excel upload */
/* 		if( isNull($("#uaInputImgFile").val()) ) {
			    $("#uaInputImgFile").focus();
			    alert("파일을 선택하세요.");
			    return;
		}

		var formData = new FormData();
		formData.append("excelFile", $("#excelFile")[0].files[0]);
		$.ajax({
			url: "/msg/excelFileupload.do",
			data: formData,
			processData: false,
			contentType: false,
			type: "POST",
			async: false,
			success: function(data){
				console.log(data);
			}
		}); */
		
		//loading 
		var start = console.time(); //new Date().getTime(); 
		
	    var rowJsonObj = {};
        var files = document.getElementById("uaInputImgFile").files[0]; //input file 객체를 가져온다.
		//console.log(files);
        
		var reader = new FileReader();

		reader.onload = function(){
			
		    var fileData = reader.result;
		    var wb = XLSX.read(fileData, {type : 'binary'}); 
		    wb.SheetNames.forEach(function(sheetName){ 
		  		rowJsonObj = XLSX.utils.sheet_to_json(wb.Sheets[sheetName]); 
		    });

		    var i; 
		    var trData="";    	
			
		    
		    console.time();


			if(rowJsonObj.length > 5000 ){
				$('.loading_bar').show(0).delay(50000).hide(0);
			}else{
				$('.loading_bar').show(0).delay(3000).hide(0);	 
			}
			
			
		    // 데이터로 셀렉트박스 항목 만들기
		    for(var i in rowJsonObj){ 
		      changeQueue.enqueue({
		        execute: function() {
		        	var elm = createItem(rowJsonObj[i], arrUALst.length, "arrUALstPop");
		    		$('#tblsendalarm tbody').append(elm); 
 
		    		
		    		arrUALst.push({ 
		    			isGroup : "N", /* 그룹여부 */
		    			title : "엑셀입력",  /* 타이틀 */
		    			code : null,     /* 그룹code Unique */
		    			phone : rowJsonObj[i]['수신번호'],
		    			name : rowJsonObj[i]['수신자명'],
		    			type : ""
		    		});  
		    	  
		        }		       
		      });
		    }

		    requestIdleCallback(processChanges);
		    
			
		};
		reader.readAsBinaryString(files);

 		

		arrUALstFlag = 2;
		$('#uaPopGrpLstBtn').addClass("background-efefef");
		$('#uaPopGrpLstBtn').addClass("disable");
		$('#uaManualInputBtn').addClass("background-efefef");
		$('#uaManualInputBtn').addClass("disable"); 
		$("#uaTotalCnt").text("총 " + arrUALst.length + "건"); 

		/*예상비용*/
		SetPrice("ua", arrUALst.length)
		
		
 		
 		var end = console.timeEnd();
 		
 		//console.log("finish:" + ( start - end )); 
		//console.log(arrMsg);
		    
		$(".pop_bg").css('display','none');
		$('#alarm_pop_excel').css('display','none'); 
		
		
		$('.wrap-loading').css('display','none');    	
	});	
	
	
	//alarm 엑셀수신번호입력
	$('#alarm_reg_excel').on('click', function(){	
		
		// excelExport(event, this, "#tblsendftalk tbody"); 
		 var files = document.getElementById("filealarm").files[0]; //input file 객체를 가져온다.
		 
		    var reader = new FileReader();
		    reader.onload = function(){
		        var fileData = reader.result;
		        var wb = XLSX.read(fileData, {type : 'binary'});
		        wb.SheetNames.forEach(function(sheetName){
		           //var toHtml = XLSX.utils.sheet_to_html(wb.Sheets[sheetName], { header: '' });
		  	       //target.html(toHtml); 	       
		  	       var rowJsonObj = XLSX.utils.sheet_to_json(wb.Sheets[sheetName]); 

				    //console.log(rowJsonObj);
		  	       //makeTR(json2array(rowObj), tableId); 

				    var i; 
				    for(var i in rowJsonObj){
				        //result.Push([i, json_data [i]]); 
				        //console.log(rowJsonObj[i]);
						var trData = "<tr>" + 
										"<td class=\"relative\">" + 
									 		"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
									 			"<input type=\"checkbox\" id=\"check_4\" name=\"체크\" class=\"alarmcheck\" />" + 
									 			"<label for=\"check_4\"></label>" + 
									 		"</div> <a class=\"rev_name\">" + rowJsonObj[i]['수신자명'] + "</a>" + 
									 	"</td>" + 
									 	"<td>" + rowJsonObj[i]['수신번호'] + "</td><td>엑셀입력</td>" + 
									 	"<td class=\"tb_btn\">" + 
									 		"<a class=\"open_pop icon_modify\">수정</a>" + 
						             		"<a href=\"#\" class=\"icon_delete\"onclick=\"deleteLine(this);\" >삭제</a>" + 
						             	"</td>" + 
						             "</tr>";
						
						$('#tblsendalarm tbody').append(trData); 
					}
		        })
		    };
		    reader.readAsBinaryString(files); 

			$(".pop_bg").css('display','none');
			$('#alarm_pop_excel').css('display','none'); 
		 //excelExport(event, this, "#tblsendalarm tbody");
	});	
	
	//주소록리스트에 들어온 리스트를
	$('#alarm_reg_addr').on('click', function(){
		
		var alarm_receiver =  $('ul.alarm_receiver li').get();		
		/* arrRcv = $('ul.alarm_receiver li').get(); */		
		//alert(alarm_receiver.length);
		
		for ( var i = 0; i < alarm_receiver.length; i++) {			
			//alert(alarm_receiver[i].innerHTML);
			//alert(alarm_receiver[i].getElementsByTagName('span') );
			//console.log(alarm_receiver[i]);	
			//console.log(alarm_receiver[i].getElementsByTagName('span')[0]);
			var strName = alarm_receiver[i].getElementsByTagName('span')[0].childNodes[0].data;
			var strTel = alarm_receiver[i].getElementsByTagName('span')[1].innerHTML;
			//console.log(strName + ":" + strTel);
		 	var trData = "<tr>" + 
							"<td class=\"relative\">" + 
						 		"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
						 			"<input type=\"checkbox\" id=\"check_4\" name=\"체크\" class=\"alarmcheck\" />" + 
						 			"<label for=\"check_4\"></label>" + 
						 		"</div> <a class=\"rev_name\">" + strName + "</a>" + 
						 	"</td>" + 
						 	"<td>" + strTel + "</td><td>주소록</td>" + 
						 	"<td class=\"tb_btn\">" + 
						 		"<a class=\"open_pop icon_modify\">수정</a>" + 
			             		"<a href=\"#\" class=\"icon_delete\"onclick=\"deleteLine(this);\" >삭제</a>" + 
			             	"</td>" + 
			             "</tr>";
			  $('#tblsendalarm tbody').append(trData);  		
		}

		$(".pop_bg").css('display','none');
		$('#alarm_pop_excel').css('display','none');
		$('ul.alarm_receiver li').remove();
		
	});	
	
 
	//제목내용 클리어
	$('#uaContentClearBtn').on('click', function(){
		$('#uaTitle').val(""); 
		$('#uaContent').html(""); 
	});	
	
	//테스트입력
	$('input:radio[name=uaSendTime]').change(function() {
		 
		  if ($('input:radio[name=uaSendTime]:checked').val() == "2") {
		     $('#uaTestInput').removeClass("none");
		  }else{
			 $('#uaTestInput').addClass("none");
		  } 
	});


	
	
	//lodingbar hide
	$('.loading_bar').hide();
	
	
	/*************************************************** 대체문자 지정  ***************************************************/
	/*
	*
	* RF_061_01 대체문자
	*
	*/
	$('#uaReContentCheck').on('change', function () {

	    if (!this.checked) { 
			$('#uaContentsRePopUpBtn').addClass('background-efefef');
			$('#uaContentsRePopUpBtn').removeClass('background-8bc5ff');
			$("#uaContentsRePopUpBtn").prop("disabled", true);
	    }else{
			$('#uaContentsRePopUpBtn').addClass('background-8bc5ff');
			$('#uaContentsRePopUpBtn').removeClass('background-efefef');
			$("#uaContentsRePopUpBtn").prop("disabled", false);

			/* 지정된 대체문자가 있다면 */
			if( arrUAReContent.length > 0 ){

				/* 지정버튼 활성화 */
				$('#uaReContentSMSRegBtn').addClass('background-8bc5ff');
				$('#uaReContentSMSRegBtn').removeClass('background-efefef');
				$('#uaReContentSMSRegBtn').css({ 'pointer-events': 'auto' });
				$('#uaReContentLMSRegBtn').addClass('background-8bc5ff');
				$('#uaReContentLMSRegBtn').removeClass('background-efefef');
				$('#uaReContentLMSRegBtn').css({ 'pointer-events': 'auto' });
				//$('#uaReContentMMSRegBtn').addClass('background-8bc5ff');
				//$('#uaReContentMMSRegBtn').removeClass('background-efefef');
				//$('#uaReContentMMSRegBtn').css({ 'pointer-events': 'auto' });
				
				/* 대체문자지정 배열 삭제 */
				arrUAReContent = [];
				toastr.success("대체문자지정이 취소되었습니다"); 
			}
	    }
	});
	
	
	/* 대체문자 팝업창 열기 */ 
	$('#uaContentsRePopUpBtn').on('click', function(){	
		 
		
		/* 템플릿 팝업이 없으면 */
		if( uaCurTemplate["idx"] === undefined ){
			toastr.success("선택된 템플릿이 없습니다. 템플릿을 선택해주세요");
			return;
		}
		
		
		
		var reType, reContent; 
		 
		if( arrUAReContent.length > 0 ){ 
			
			arrUAReContent.forEach(function(element){ 
	    		reType = element.type;
	    		reContent = element.content;
			}); 
		}
		 
		
		/* RF_061_01 대체문자발송 
		RF_062_01 대체문자작성 
		RF_062_02 대체문자 수정  
		RF_062_03 대체문자 용량
			자동변경
		*
		*/
		
		/* 최종선택한 형태로 대체문자발송 */ 
		/* 단문 /장문 /멀티 중 선택 */ 
		/* 팝업창 열때마다 컨텐츠 가져오기  지정이 없다면  */
	
		var subject = uaCurTemplate["title"];
		var content = uaCurTemplate["content"];
		
		var subject = $('#uaTitle').val();
		var content = $('#uaContent').text(); 
		
		

		var contentTxt = "";
		var div = document.createElement("div");
		div.innerHTML = content;
	    contentTxt = div.textContent || div.innerText || "";


		//var isImage = Object.keys(uaImgFile).length; 
		//if(isImage > 0 ){
		//	reType = "MMS";
		//}else{
		if(getTextLength(contentTxt) < 90 ){
			reType = "SMS";
		}else{
			reType = "LMS";
		}
		//}
		
		
		
		var recontentS = content;
		var recontentL = content;
		//var recontentM = content;
		
		/* 지정된 대체문자가 있을경우  */ 
		if( arrUAReContent.length > 0 ){  
			if(reType === "SMS" ){ recontentS = reContent;}	
			if(reType === "LMS" ){ recontentL = reContent;}	
			//if(reType === "MMS" ){ recontentM = reContent;}	

			$('#uaReContentSMSTitle').html(subject);
			$('#uaReContentSMSContent').html(recontentS);			
			$('#uaReContentLMSTitle').html(subject);
			$('#uaReContentLMSContent').html(recontentL);			
			//$('#uaReContentMMSTitle').html(subject);
			//$('#uaReContentMMSContent').html(recontentM);
		}else{ 
			$('#uaReContentSMSTitle').html(subject);
			$('#uaReContentSMSContent').html(contentTxt);			
			$('#uaReContentLMSTitle').html(subject);
			$('#uaReContentLMSContent').html(contentTxt);			
		//	$('#uaReContentMMSTitle').html(subject);
		//	$('#uaReContentMMSContent').html(content);
		}
		
		$(".pop_bg").css('display','block');
		$('#uaContentsRePopUp').css('display','block');
	});
	 
	
	
	
	$('#uaReContentSMSContent').keydown(function (e){
	    var content = $(this).text(); 
	    if ( Number(getByteLength(content)) > 90 ){  
	    	e.preventDefault(); 
	    	toastr.error("단문은 최대 90BYTE까지만 입력 가능합니다."); 
	    }
	});
	$('#uaReContentLMSContent').keydown(function (e){
	    var content = $(this).text(); 
	    if ( Number(getByteLength(content)) > 1800 ){  
	    	e.preventDefault(); 
	    	toastr.error("장문은 최대 1800BYTE까지만 입력 가능합니다."); 
	    }
	});
	//$('#uaReContentMMSContent').keydown(function (e){
	//    var content = $(this).text(); 
	//    if ( Number(getByteLength(content)) > 1800 ){  
	//    	e.preventDefault(); 
	//    	toastr.error("멀티는 최대 1800BYTE까지만 입력 가능합니다."); 
	//    }
	//}); 
	
	
	/* 닫기 */
	$('#uaReContentSMSCloseBtn').on('click', function(){
		$('#uaReContentSMSContent').attr("contenteditable",false);
		$(".pop_bg").css('display','none');
		$('#uaContentsRePopUp').css('display','none');
	});
	$('#uaReContentLMSCloseBtn').on('click', function(){
		$('#uaReContentLMSContent').attr("contenteditable",false);
		$(".pop_bg").css('display','none');
		$('#uaContentsRePopUp').css('display','none');
	});
	//$('#uaReContentMMSCloseBtn').on('click', function(){
	//	$('#uaReContentMMSContent').attr("contenteditable",false);
	//	$(".pop_bg").css('display','none');
	//	$('#uaContentsRePopUp').css('display','none');
	//});
	
	// CSS가 안먹혀서 스크립트로 조정
/* 	
$("#pop_tabmenu_ua01").click( function(){
		var tab = $('input[name="pop_tabmenu_ua_contents_re"]:checked').val();
		if(tab=="SMS"){ 
			$("#pop_tabmenu_ua01").prop("checked", false);
			$("#pop_tabmenu_ua02").prop("checked", true);
		}else{
			$("#pop_tabmenu_ua01").prop("checked", true);
			$("#pop_tabmenu_ua02").prop("checked", false);
		}
		
	});  
*/
	
	/*************************************************** 대체문자 지정  ***************************************************/
	
	

	


	/*************************************************** 메세지  버튼넣기추가하기  *****************************************************/  
	

	/* 미리보기용  배열 
	uaArrSendNum 초기에 선택된 번호 
	uaArrRcvNum 리스트 된 번호
	*/
	var uaPreviewSendNum = "01056355959";
	var uaPreviewRcvNumArr = ["01012345678","01012345678","01012345678"];
	
	$('#uaPreviewBtn').on('click', function(){			
		$(".pop_bg").css('display','block');
		$('#uaPreviewPopUp').css('display','block');
		
		var uaT = $('#uaTitle').val();
		//console.log("----------uaTitle-------" + uaT);
		var uaC = $('#uaContent').html();		
		//console.log(":--------------uaContent---------" + uaC);
		
		$('#uaPreviewTitle1').html(uaT);
		$('#uaPreviewTitle2').html(uaT);
		$('#uaPreviewTitle3').html(uaT);
	
		var uaC1, uaC2, uaC3;
        if(uaC.indexOf("#[이름]") != -1 ){
        	ufC1 = uaC.replaceAll("#[이름]", arrUALst[0].name);  //이름
        }
        if(uaC.indexOf("#[비고]") != -1 ){
        	uaC1 = uaC.replaceAll("#[비고]", arrUALst[0].title);  //비고
        } 
		$('#uaPreviewContents1').html(uaC1);
        if(uaC.indexOf("#[이름]") != -1 ){
        	ufC2 = uaC.replaceAll("#[이름]", arrUALst[1].name);  //이름
        }
        if(uaC.indexOf("#[비고]") != -1 ){
        	uaC2 = uaC.replaceAll("#[비고]", arrUALst[1].title);  //비고
        } 
		$('#uaPreviewContents2').html(uaC2);
        if(uaC.indexOf("#[이름]") != -1 ){
        	ufC3 = uaC.replaceAll("#[이름]", arrUALst[2].name);  //이름
        }
        if(uaC.indexOf("#[비고]") != -1 ){
        	uaC3 = uaC.replaceAll("#[비고]", arrUALst[2].title);  //비고
        } 
		$('#uaPreviewContents3').html(uaC3);
		
		$('#uaPreviewSendNum1').text(uaPreviewSendNum);
		$('#uaPreviewSendNum2').text(uaPreviewSendNum);
		$('#uaPreviewSendNum3').text(uaPreviewSendNum);
		//console.log(":--------------uaPreviewSendNum---------" + uaPreviewSendNum);
		
		$('#uaPreviewRcvNum1').text(uaPreviewRcvNumArr[0]);
		$('#uaPreviewRcvNum2').text(uaPreviewRcvNumArr[1]);
		$('#uaPreviewRcvNum3').text(uaPreviewRcvNumArr[2]);
		//console.log(":--------------uaPreviewRcvNumArr---------" + uaPreviewRcvNumArr[0]);
	});
	
	$('#uaPreviewConfirmBtn').on('click', function(){	
	});
	
	
	
	/************************************************* 전송하기 *********************************************************************/
	$('#uaSendMsgBtn').on('click', function(){	  


		var uaTitle = $('#uaTitle').val();
		var uaContent = $('#uaContent').text();
		var uaMmsinfo = $('#uaContent').html();
		var uaContentCookie = getCookie("uaBeforeContent");
		

		/* 옵션  --  직전 동일내용 전송체크 메세지 */ 
		if( g_dupMessageUseFlag == "Y" ){
			
			if( uaContent ==  uaContentCookie ){
				var r = confirm("이전 내용과  동일한 메세지내용입니다. 전송하시겠습니까?");
				if (r == true) {
				} else {
					toastr.error("전송이 취소되었습니다");
					return false;
				}
			}
		}
		
		

		/* 옵션  --  080 수신거부 메세지 첨가 */
		if(sending_refusal_check == "N"){
			uaContent += refusal_txt;
		} 
		 

		var uaTitleLen = getTextLength(uaTitle);		 
		var uaContentLen = getTextLength(uaContent);
		 
		
		if( uaTitleLen < 10 ) { 
     		toastr.error('제목을 입력하세요'); 
     		$('#ufTitle').focus();
     		return false;
		}
		 
		
		if( uaContentLen < 20 ) { 
     		toastr.error('내용을 입력하세요'); 
     		$('#ufContent').focus();
     		return false; 
		} 

		/*
		 옵션  -- 
		이미지만 보내기 가능
		*/
		if(mms_only_image == "Y"){
			
			if( uaContentLen == 0 ){
				/* continue */
			}
		}else{ 
		}
		

		if( !maxLengthCheck("uaTitle","제목",30) ){
			$('#uaTitle').focus();
			return false;
		} 


		if( !maxLengthCheck("uaContent","내용",1800) ){
			$('#uaContent').focus();
			return false;
		}
		      
		var checkMsgType = "4";   
		/* 
		var isImage = false;		
		if(contentLen > 90 ) checkMsgType = "1";  //LMS
		if(contentLen > 90 && isImage ) checkMsgType = "2"; //MMS
		*/
		
	 	
		
 
	 	//check snd_number  부서원소속 사무실, 사용자핸드폰, 직접입력
	 	var sendPhoneType = $('input:radio[name=ua_send_num]:checked').val(); 
	 	//var sendPhone = $('input:text[name=umSendNum]').val(); 
	 	var sendPhone = $('input[name=uaSendNum]').val();
	 	//alert("sendPhoneType: " + sendPhoneType + ": phone " + sendPhone + ": phone x " + sendP );

		var sendPhoneLen = getTextLength(sendPhone);
		if( sendPhoneLen < 8 ) { 
     		toastr.error('발신번호를 입력하세요'); 
     		$('input[name=uaSendNum]').focus();
     		return false;
		}
	 	
/* 	   
 		var sendPhone = $('input[name=uaSendNum]').val(); 

		var sendPhoneLen = getTextLength(sendPhone);
		if( sendPhoneLen < 8 ) { 
     		toastr.error('발신번호를 입력하세요'); 
     		$('input[name=uaSendNum]').focus();
     		return false;
		}		 
*/ 
		
		
		//수동입력체크
		var manualInput = $('#phonelistalarm').val();  
		
		if(manualInput.length > 0) {
     		toastr.error('수동입력창에 자료가 남아 있습니다'); 
     		$('#phonelistalarm').focus();
			return false;
		}
		

		/*********예약발송시 시간********************/
	 	var currentDate = getTimeStamp();

	 	var startDate = new Date();
	 	//즉시 에약 테스트
	 	var sendTimeValue = $('input:radio[name=uaSendTime]:checked').val(); 
	 	//alert(sendTimeValue);  //on
	 	//즉시 현재시각  , 예약 예약시각 ,  테스트 즉시
	 	if( sendTimeValue == "1"){
	 		//alert("예약");
	 		var iDate = $('#uaDataPicker').val();
	 		var iTime = $('#uaTimePicker').val();
	 		startDate = iDate + " " + iTime;
	 		var cDate = new Date(currentDate);
	 		var sDate = new Date(startDate); 
	 		var gap = sDate.getTime() - cDate.getTime(); 
	 		/* 10분 이후  600초 * 1000*/
	 		if( gap < 600000 ){
	 			toastr.error("--------예약일이 현재시간보다 이전입니다---------");
	 			return;
	 		}
	 	}else{
	 		startDate = '';
	 	}
 		if( sendTimeValue == "2" && isEmpty($("#uaTestInput").val())){
 			toastr.error("테스트수신번호를 입력해주세요");
 			return;
 		}
		/*********예약발송시 시간********************/
	 	
	 	
		var uaJobOpt = $('#uaJobOpt option:selected').val(); //$('select[name=uaJobOpt] selected').val();
		//console.log("==usJobOpt===" + uaJobOpt);
		if( uaJobOpt.length > 2 ) {
			//console.log("==usJobOpt===" + uaJobOpt);
			return false;
		}
		if( uaJobOpt == "0" || uaJobOpt == null ){ 
			toastr.error("업무분류를 선택하세요");
			return false;
		}
	 	
	 	
	 	$('.wrap-loading').removeClass('display-none');   
	 	 
		var param;
	 	
 		/* 테스트발송일때 한개만 발송 */
	 	if( sendTimeValue != "2"){
	 		param = tableToJsonATALK(document.getElementById("tblsendalarm"), checkMsgType, startDate, uaTitle, uaContent, uaMmsinfo, sendPhone, uaJobOpt); // table id를 던지고 함수를 실행한다.
	 	}else{
	 		param = tableToJsonATALKTest($("#uaTestInput").val(), checkMsgType, startDate, uaTitle, uaContent, uaMmsinfo, sendPhone, uaJobOpt); // table id를 던지고 함수를 실행한다.
	 	}
		
		
		if( arrUAGLst.length ){
			toastr.error("수신자목록을 입력하세요");
			return false;
		}  
		
        var obj = JSON.stringify(param); 
        //console.log(obj);
        
        //$('#result').text(obj);  
		$('#uaSendMsgBtn').attr('disabled', true);	 
		
		//loading
		$('.loading_bar').show(0).delay(3000).hide(0);
		
		//toastr.success("------ajax--start-------");
			//console.log("================================================================================")
		//console.log(param)
		//console.log("================================================================================")
    	$.ajax({
        	url: "/sendSMS.do",
        	type: "POST",
            dataType: "json",          // ajax 통신으로 받는 타입
            contentType: "application/json",  // ajax 통신으로 보내는 타입
            data: obj,
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
        		$('#uaSendMsgBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#uaSendMsgBtn').attr('disabled', false);
            },
        	success: function(jsondata){
        	     /*
       	      * 
       	      * RF_047_01 입력 번호 유효성 체크
       	      * 
       	      */
        		if(jsondata['error']){
        			toastr.error(jsondata['errorcode'] + JSON.stringify(jsondata['data']));
        			return;
        		}
        		
        		var res = JSON.stringify(jsondata);
        		//alert(res); //로딩
        		
        		//clear
        		if(jsondata['result_msg'] == "ok"){
        			$("#tblsendalarm tbody").empty();  
            		$('#uaTitle').val(""); 
            		$('#uaContent').empty();  
            		
            		uaImgFile = {};
            		
            		/* 배열 데이타 처리  */
            		arrUALst = [];
            		
                    /* CLEAR */
                    /* 입력버튼 처리 */ 
    				$('#uaPopExcelBtn').removeClass("background-efefef");
    				$('#uaPopExcelBtn').removeClass("disable"); 
    				$('#uaPopGrpLstBtn').removeClass("background-efefef");
    				$('#uaPopGrpLstBtn').removeClass("disable");
    				$('#uaManualInputBtn').removeClass("background-efefef");
    				$('#uaManualInputBtn').removeClass("disable");
        		}
        		//$('#result').text("전송시간:" + res); 
        		//console.log("전송시간:" + res);
                toastr.success('성공적으로 전정되었습니다'); 

                
                   /* $(".pop_templet").css('display','none'); */

        		/* 		바로 직전 콘텐츠 저장    		*/ 
                setCookie("uaBeforeContent",uaContent);
                   
                   
                $('.wrap-loading').addClass('display-none');
        		$('#uaSendMsgBtn').attr('disabled', false);
        		//close popup
        		
        		 var srvcNm = '전송 >> 알림톡';
           		var methodNm = '전송';
           		
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
        	},
        	error: function(request,status,error){
        		  
        		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            	//$('#result').text(error);
            	//alert("serialize err");
        		$('#uaSendMsgBtn').attr('disabled', false);
                $('.wrap-loading').addClass('display-none');
        	}
   		});
	});

	/* 최근 전송 5건 */	
	PopupRecentLst("#uaRecentLstBtn","#uaRecentLst","#uaPopRecentLayer",arrUARecentLst);
	
	
	/* 알림톡 탭이 안되는 관계로 긴급하게 만듬 */
	$("")
});
/* document.ready */




function tableToJsonATALKTest(table, type, startDate, title, content, mmsinfo, senderNum, jobOpt) {

    var tempData = {};
	
	//MMS_CONTENTS_INFO 에 필요한 데이타
	tempData["mms_info"] = mmsinfo;
	tempData["title"] = title;
	tempData["content"] = content;
	tempData["snd_number"] = senderNum;
	tempData["rcv_type"] = type;
	tempData["snd_date"] = startDate;
	tempData["rcv_rsvt_chk"] = "1";
	tempData["rcv_mmsinfo"] = mmsinfo;
	tempData["rcv_work_seq"] = jobOpt;  /* 업무분류 */
	
	/* MMS 알림톡 */ 
	//tempData["imgFileName"] = imgFileName;
	
	/* 알림톡 */

	var reContent = "";
	var reType = ""; //4다문 6장문멀티
		
	if( arrUAReContent.length > 0 ){
		arrUAReContent.forEach(function(element){ 
    		reContent = element.content; 
    		reType = element.type;
		});  
	}
		
	var reTypeInt = 4;
	
	/* 친구톡 알림톡 */
	if( uaCurTemplate["idx"] === undefined  ){
		tempData["reContents"] = "";  
		tempData["reType"] = ""; 
		tempData["btnList"] = "";
		/* 알림톡 변수 5개 리스트 */
		tempData["tmpVars"] = ""; 
		
	}else{


		if(reType==="SMS"){
			reTypeInt = 4;
		}else{
			reTypeInt = 6;
		}
 
		tempData["reContents"] = reContent;
		tempData["reType"] = reTypeInt;
		tempData["btnList"] = uaCurTemplate["buttons"];
		/* 알림톡 변수 5개 리스트 */
		tempData["tmpVars"] = uaCurTemplate["variables"];
	}

	//console.log("=======대체문자======" + reContent + ":" + reType + tempData["btnList"] + tempData["tmpVars"]);
	 

	var row = [];
	var rowG = []; 
    	 
    var rowData = {};              
    rowData["column1"] = "테스트"; //이름
    rowData["rcv_number"] = table; //수신번호
    rowData["rcv_etc"] = "테스트발송입니다"; //비고란
 
	row.push(rowData);  

	tempData["group"] = rowG.slice();  /* 전체내용넣기 */
	tempData["data"] =  row.slice();  /* 전체내용넣기 */
	//tempData["data"] = row;
    //console.log("-------tableToJson-----------" + tempData);
     
    
	return tempData;
    
	    
	    
}


function tableToJsonATALK(table, type, startDate, title, content, mmsinfo, senderNum, jobOpt) {
	/* 
	* RF_049_01 수신자  건수 제한
	*
	*/
	if( arrUALst.length > max_receive_cnt ){
		toastr.error("수신목록 가능한 최대갯수는 " + max_receive_cnt + "입니다");
		return;
	}
	
	
    var tempData = {};
	
	//MMS_CONTENTS_INFO 에 필요한 데이타
	tempData["mms_info"] = mmsinfo;
	tempData["title"] = title;
	tempData["content"] = content;
	tempData["snd_number"] = senderNum;
	tempData["rcv_type"] = type;
	tempData["snd_date"] = startDate;
	tempData["rcv_rsvt_chk"] = "1";
	tempData["rcv_mmsinfo"] = mmsinfo;
	tempData["rcv_work_seq"] = jobOpt;  /* 업무분류 */
	
	/* MMS 친구톡 */ 
	//tempData["imgFileName"] = imgFileName;


	
	var reContent = "";
	var reType = ""; //4다문 6장문멀티
		
	if( arrUAReContent.length > 0 ){
		arrUAReContent.forEach(function(element){ 
    		reContent = element.content; 
    		reType = element.type;
		});  
	}

	//console.log("=======대체문자======" + reContent + ":" + reType  + arrUAReContent.length);
	var reTypeInt = 4;
	
	/* 알림톡 */
	if( uaCurTemplate["idx"] === undefined  ){
		tempData["reContents"] = "";  
		tempData["reType"] = 4; 
		tempData["btnList"] = "";
		tempData["tmpVars"] = ""; 
		tempData["senderKey"] = ""; 
		tempData["templateKey"] = "";
		tempData["senderkey"] = "";
	}else{
		if(reType==="SMS"){
			reTypeInt = 4;
		}else{
			reTypeInt = 6;
		}
 
		tempData["reContents"] = reContent;
		tempData["reType"] = reTypeInt;
		tempData["btnList"] = uaCurTemplate["buttons"];
		tempData["tmpVars"] = uaCurTemplate["variables"];
		tempData["senderKey"] = uaCurTemplate["senderKey"]; 
		tempData["templateKey"] = uaCurTemplate["templateKey"]; 
		tempData["senderkey"] = uaCurTemplate["senderkey"];
	}
	
	
	tempData["payCode"] = "NOT";
	tempData["price"] = getPriceByCode("NOT");
	
	 
	var row = [];
	var rowG = [];

	for ( var r = 0; r < arrUALst.length; r++ ){ 
		
		
        var rowData = {};   
		var isGroup = "N";
		isGroup = arrUALst[r].isGroup;
        rowData["isgroup"] = arrUALst[r].isGroup; //비고란 
        
        if(isGroup == "Y"){ 
        	
            rowData["column1"] = arrUALst[r].name; //이름
            rowData["rcv_number"] = arrUALst[r].phone; //수신번호
            rowData["rcv_etc"] = ""; //비고란

            rowData["grp_category"] = arrUALst[r].code; //비고란 
            rowData["grp_name"] = arrUALst[r].name; //비고란
            rowData["grp_type"] = arrUALst[r].type; //비고란 
            rowData["grp_cnt"] = Number(arrUALst[r].phone); //비고란
        	rowG.push(rowData); 
            
        }else{

            rowData["column1"] = arrUALst[r].name; //이름
            rowData["rcv_number"] = arrUALst[r].phone; //수신번호
            rowData["rcv_etc"] = ""; //비고란
            rowData["grp_name"] = ""; //비고란
            rowData["grp_category"] = ""; //비고란 
            rowData["grp_type"] = ""; //비고란 
            rowData["grp_cnt"] = 0; //비고란
	    	row.push(rowData); 
            
        }
         
         
        arrUARecentLst.push({
			isGroup : "N", 
			title : rowData["column1"],  
			code : null,     
			phone : rowData["rcv_number"],
			name : rowData["column1"]
		});
    	
    	if(arrUARecentLst.length > 5){
    		arrUARecentLst[arrUARecentLst.length - 1]
    		arrUARecentLst.pop();
    	}
	}  
   
    
    /* 변수 전환 */ 
/* 	var tmpVar = tempData["tmpVars"].split("||");

    for( var t in tmpVar){
    	row.map( function(e){ 
    		content  = content.replace(tmpVar[t], e.column1);
        	return false;
        }); 
	}    */ 
    
    tempData["content"] = content;
    
    
    
	tempData["group"] = rowG.slice();  /* 전체내용넣기 */
	tempData["data"] =  row.slice();  /* 전체내용넣기 */
	//tempData["data"] = row;
    //console.log("-------tableToJson-----------" + tempData);
    
    var totalPrice = Number(tempData["data"].length) * Number(tempData["price"]); 
    var uCashChk = usrCashCheck(tempData["payCode"], totalPrice);
    
    if(uCashChk < 0){
		toastr.error("캐쉬 잔액이 부족합니다");
    	return false;
    }	    	
    
    
 	return tempData;
}



/* 템플릿 등록 */
function inputTemplate(){

	oTableTemplet.destroy();
	
	/* 초기화  */	
	$('#uaVariablesTitle').empty();
	$('#uaVariables').empty();
	 
	
	var idx = uaCurTemplate["idx"];
	var tab = $("input[name='sendM_tabmenu']:checked").val();
	
	if( idx != "undefined" && idx != null ){
		//console.log("-----선택사항입력있음----");
		var title = uaCurTemplate["title"];
		var content = uaCurTemplate["content"]; 
		var buttons = uaCurTemplate["buttons"]; 
		var variables = uaCurTemplate["variables"]; 

		
		$('#uaTitle').val(title);
		$('#uaContent').html(content);
  
		var arrBtn = buttons.split(",");  
		
		//button.length 체크
		var buttonCount = JSON.parse(arrBtn).length;
		//console.log("------buttonCount------:" + buttons.length);
			
		//button JSON
		if(buttonCount > 0){
			//$('#uaPopButtonBtn').addClass("umMyBox");
			$('#uaPopButtonBtn').text("버튼(" + buttonCount + "/5)");
		}
		
		//var variables = "고객명||이름";
		
		//variables JSON
		if(!isEmpty(variables)){  
			var arrVar = variables.split("||");
			var el;
			for(var i in arrVar){
				el = "<span class=\"width-50  inline-block \"><span class=\"width-50px text-center  border-box font-14px\">"+ 
				arrVar[i]+"</span><span class=\" width-100px font-14px text-left paddin-left-30 \"><div class='checkbox-small'><input type='checkbox' id='uaCheck' readonly checked /><label for='uaCheck'></label><span class='font-16px font-053c72 margin-left-5'>자동매칭</span></div></span></span>";
			}
			var len = arrVar.length;
			$('#uaVariablesTitle').append("변수입력 <span class=\"font-bold\">[" + len + "/5]</span");
			$('#uaVariables').append(el);
		}else{
			$('#uaVariablesTitle').append("변수명 입력 없음");
		}
		
		
		
	}else{ 
		console.log("-----선택사항입력없음----");
	}
	
}



/* 선택하기 */
function selectRowUA(a,senderkey,tmpkey,title, contents,variables,buttons){  
	 
  	var idx = "uaTemplate" + a;
  	
	if( $("#"+idx).hasClass("umMybox") === true ) { 
		
		$("#"+idx).removeClass("umMybox");  
		uaCurTemplate = []; //초기화
		toastr.error("선택이 해제되었습니다");
		return;
	}

	/* 현재 el 클래스 추가 */
	$('#'+idx).addClass("umMybox"); 
	
	if( ( uaCurTemplate["idx"] != null ) && ( uaCurTemplate["idx"] != "undefined" ) ){

			$('#uaTemplate'+ uaCurTemplate["idx"]).removeClass("umMybox");
	}  


	uaCurTemplate["idx"] = a;
	uaCurTemplate["senderkey"] =  senderkey;
	uaCurTemplate["templateKey"] =  tmpkey;
	uaCurTemplate["title"] = title;
	uaCurTemplate["content"] = contents; 
	uaCurTemplate["variables"] = variables;
	uaCurTemplate["buttons"] =  unescape(buttons);
 
	
}
  
</script>

<style>

#uaContent {
    width:280px;
    height:300px;
    overflow-y: auto;
}

[contenteditable]:focus {
    outline: 0px solid transparent;
}


</style>
</head>
<body>
		<input type="radio"  name="sendM_tabmenu" id="tabmenu-3" />
		<label for="tabmenu-3">알림톡</label>
		<div class="tabCon">
			<ul class="width-100 margin-bottom-100">
				<li class="float-left  width-350px margin-right-30">
					<div class="width-350px height-620px border-radius-5 background-f7fafc padding-20 border-box">
						
						
						<textarea type="text"  name="uaTitle" id="uaTitle" placeholder="템플릿을 선택하세요" readonly class="width-100 height-50 border-e8e8e8 background-transparent font-16px padding-left-20 padding-right-20 border-box row-1 margin-bottom-5"></textarea>
						
						
						
											<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 50px;">
										
								
								<div id="uaContent" contentEditable="true" class="border-box border-radius-5"></div>				
												
												<!-- <a class="icon_photo width-30px height-30px background-8bc5ff border-radius-40 absolute position-bottom-10px position-left-10px open_pop_imgupload"></a> -->
												<a id="uaContentClearBtn" class="icon_trash width-30px height-30px background-8bc5ff border-radius-40 absolute position-bottom-10px position-right-10px"></a>
											</div>
											<ul class="margin-bottom-20">
												<li class="float-left width-50 padding-right-5 border-box"><a id="uaPopTempletBtn" class="width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">템플릿 선택</a></li>
												<li class="float-left width-50 padding-left-5 border-box"><a id="uaPopButtonBtn" class=" width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">버튼(0/5)</a></li>
											</ul>
											<ul>
											
								<li class="width-100"> 
									<ul class="width-100 height-70px">
										<li class="float-left width-80px height-70px">
											<span class="inline-block width-80px height-40px margin-top-40 text-left font-16px font-4d4f5c">발신번호</span>
										</li>
										
										<!--***옵션:직접선택일 경우-->
										<li id="uaSendNumDirect" class="float-right width-230px height-70px padding-top-5"> 
											<div class="radio-box_s font-14px font-053c72 margin-right-10">
												<div class="radio_s">
													<input type="radio" id="uaOfficeNum" name="ua_send_num" value="1"   />
													<label for="uaOfficeNum"><span></span></label>
												</div> 사무실
											</div>
											<div class="radio-box_s font-14px font-053c72 margin-right-10">
												<div class="radio_s">
													<input type="radio" id="uaPhoneNum" name="ua_send_num" value="2" checked />
													<label for="uaPhoneNum"><span></span></label>
												</div> 핸드폰
											</div>						
											<div class="radio-box_s font-14px font-053c72 ">
												<div class="radio_s">
													<input type="radio" id="uaDirectNum" name="ua_send_num" value="3" />
													<label for="uaDirectNum"><span></span></label>
												</div> 직접입력
											</div>				
											<input name="uaSendNum" id="uaSendNum" type="text" maxlength="12" value="" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'  class="width-230px background-transparent font-14px height-40px line-height-40px border-e8e8e8 border-radius-5 padding-left-10 margin-top-10"  />
										</li>
										<!--//***옵션:직접선택일 경우-->
										
										<!--***옵션:등록번호콤보표시일 경우-->
										<li id="uaSendNumCombo" class="float-right width-230px height-70px padding-top-5">	 
											<!--***옵션:등록번호표시일 경우-->
											<select id="uaSendNum" class="select_blank_lightblue width-230px float-right" style="margin-top:10px;">
												<option>010-0000-0000</option>
												<option>010-1234-5678</option>
											</select> 
										</li>
										<!--//***옵션:등록번호콤보표시일 경우-->
										
									</ul>
								</li>  
												
												
												
											</ul>
										</div>
				<li>
				<li class="float-right width-970px">
										<div class="width-100 height-650px padding-20 border-box border-radius-bottom-5 background-f7fafc">
											<ul class="width-100">
												<li class="width-100">
													<h3 class="inline-block float-left width-650px font-18px font-174962 margin-bottom-10 margin-right-10">수신번호 직접입력</h3>
													<h3 class="inline-block float-left width-140px font-18px font-174962 margin-bottom-10">수신번호 불러오기</h3>
													<div class="float-left width-650px height-90px padding-10 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden ">
													
															<div id="phonelistalarm" name="phonelistalarm"  contentEditable="true"  onkeydown='return onlyNumberEnter(event)' onkeyup='removeCharEnter(event, this)' placeholder="전화번호를 직접 입력하거나 메모장, 엑셀을 붙여넣기 한 후에 우측의 입력버튼을 눌러주세요. 두 개 이상의 전화번호는 꼭 엔터키로 구분해주세요."  class="width-100 height-70px background-transparent font-14px line-height-default"  style="overflow:scroll;overflow-x:hidden;overflow-y:hidden;" ></div>														
													
													</div>
													<ul class="float-left width-160px height-90px margin-left-10">
														<li class="width-100 margin-bottom-5"><a id="uaPopGrpLstBtn" class=" width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-16px font-053c72">주소록 불러오기</a></li>
														<li class="width-100"><a id="uaPopExcelBtn" class=" width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-16px font-053c72">엑셀 불러오기</a></li>
													</ul>
													<a id="uaManualInputBtn" class="float-right width-100px height-90px line-height-90px font-16px background-8bc5ff font-053c72 text-center border-radius-5">입력</a>
													<div class="clear margin-bottom-20"></div>


													<h3 class="font-18px font-174962 margin-bottom-10">수신자 목록 <span class="font-bold" id="uaRcvCnt"></span></h3>
													<div class="height-110px border-box scroll-y">
														<table id="tblsendalarm" class="con_tb width-100" cellpadding="0" cellspacing="0" border="0">
															<thead>
																<tr>
																	<th class="width-20">이름</th>
																	<th class="width-20">전화번호</th>
																	<th class="width-20">비고</th>
																	<th class="width-20">관리</th>
																</tr>
															</thead>
															<tbody></tbody>
															<!--검색결과 없을 시>
															<tfoot>
																<tr>
																	<td  colspan="4">검색 결과가 없습니다.</td>
															</tfoot-->
														</table>
													</div>
													<div class="margin-top-20 margin-bottom-10">
														<h3 id="uaVariablesTitle" class="font-18px font-174962 float-left"></h3>
														<!-- <button class="plus_btn float-left"><span>+</span></button> -->
													</div>
													<div class="" >
														<div id="uaVariables"></div>
														
														
														<table id="" class="con_tb width-100" cellpadding="0" cellspacing="0" border="0">
															<tbody id="">
															</tbody>
														</table>
													</div>

													<div class="width-100 margin-top-10 padding-left-10 border-box">
														<c:if test="${workSeqRequiredFlag != 'ND'}" >
														<!-- <a class="width-55px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">입력</a> -->
														<span class="inline-block margin-left-20 margin-right-5 font-12px font-aaa">업무분류</span>
														<select id="uaJobOpt" name="uaJobOpt" class="select_white_small width-120px">
										 
														</select>
														</c:if>
														<span id="uaCost" class="inline-block float-right inline-block margin-top-5 margin-right-10 font-14px font-aaa font-bold font-053c72"><span class="inline-block margin-right-10 font-12px font-aaa font-normal">예상비용</span><span id="uaPrice"></span></span>
													</div>
													<div class="clear margin-bottom-15"></div>
													<div class="float-left width-430px padding-left-10 border-box margin-bottom-15 background-f9fbfd">
														<div class="checkbox-small">
																<input type="checkbox" checked id="uaReContentCheck" name="uaReContents" />
																<label for="uaReContentCheck"></label>
																<span class="font-16px font-053c72 margin-left-5">알림톡 실패 시 대체문자 발송</span>
														</div><a id="uaContentsRePopUpBtn" class=" width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-10">대체문자</a>
													</div>
						
													<div class="relative float-left width-650px height-110px border-box border-radius-5 margin-bottom-10 hidden box-shadow-smallest background-f9fbfd">
														<ul class="absolute position-left position-vertical-center">
															<li class="relative width-100 height-30px margin-bottom-5 padding-left-10">
																<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
																	<div class="radio_s">
																		<input type="radio" id="s_4" name="uaSendTime" value="0" checked/>
																		<label for="s_4"><span></span></label>
																	</div> 즉시발송
																</div>
															</li>
															<li class="relative width-100 height-30px margin-bottom-5 padding-left-10">
																<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
																	<div class="radio_s">
																		<input type="radio" id="s_5" name="uaSendTime" value="1" />
																		<label for="s_5"><span></span></label>
																	</div> 예약발송
																</div>
																<!--예약발송 달력박스 -->
 
																
												<!--예약발송 달력박스 -->
												<div class="absolute position-vertical-center width-330px" style="left:100px; _display:none;">  
													<div class="inline-block relative width-140px height-30px line-height-30px text-right  border-radius-5 border-8bc5ff border-box margin-right-5">
 	
										<input type="date" id="uaDataPicker" name="uaDataPicker"	value="" 
													class="text-right font-174962 font-14px padding-0 margin-0 height-30px line-height-30px background-transparent" />
													</div>
													<div class="inline-block relative width-140px height-30px line-height-30px text-right  border-radius-5 border-8bc5ff border-box margin-right-5">
 	
										<input type="time" id="uaTimePicker" name="uaTimePicker" value=""
													class="text-right font-174962 font-14px padding-0 margin-0 height-30px line-height-30px background-transparent" />

													</div>
												</div> 
														
															</li>
															<li class="relative width-100 height-30px padding-left-10">
																<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
																	<div class="radio_s">
																		<input type="radio" id="s_6" name="uaSendTime"  value="2" />
																		<label for="s_6"><span></span></label>
																	</div> 테스트발송
																</div>
																<!--테스트발송 체크시 입력박스--> 
																<input type="text" id="uaTestInput" name="testcontent" placeholder="테스트발송할 번호를 입력하세요" class="absolute position-vertical-center width-200px height-30px line-height-30px   border-e8e8e8 background-fff border-box border-radius-5 font-14px line-height-default none" style="left:110px;" />
 
															</li>
														</ul>
													</div>
													
													<ul class="float-right width-230px height-120px">
														<li class="width-100 margin-bottom-10"><a  id="uaPreviewBtn"  class="width-100 height-45px line-height-45px text-center border-radius-5 background-efefef font-20px font-bold font-053c72">미리보기</a></li>
														<li id="uaSendMsgBtn" class="width-100"><a class="width-100 height-45px line-height-45px text-center  border-radius-5 background-8bc5ff font-20px font-bold  font-053c72"><span id="uaTotalCnt"></span>전송하기</a></li>
													</ul>
													<div class="clear"></div>
												</li>
											</ul>
										</div>
									</li>
			</ul>
		</div> 
							
							 
						
			
 		<!-- popup 엑셀 -->			
		<div id="alarm_pop_excel" class="pop_wrap width-730px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">알림톡 엑셀 등록하기</div>
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
			  
			  	<form id="uaFrmModal" action=/msg/excelFileupload.do" method="post" enctype="multipart/form-data">
				<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-90">
					엑셀파일 찾기
					<input class="upload-name" value="" disabled="disabled" placeholder="파일명" />
					<label for="uaInputImgFile">찾아보기</label> 
					<input type="file" id="uaInputImgFile" class="upload-hidden" /> 
				</div>
				</form>
				<ul class="pop_notice" style="padding-left:90px">
					<li>엑셀양식파일 : <a href="#">엑셀양식 다운로드</a></li>
					<li>최대 10만건 까지 등록할 수 있습니다.</li>
					<li>엑셀등록시 휴대폰 번호는 필수값입니다.</li>
					<li>휴대폰 번호는 반드시 0으로 시작해야 합니다.</li>
					<li>알림톡의 경우 엑셀양식파일을 다운로드하여 템플릿의 변수값을 모두 입력한 후 엑셀 등록을 해주시기 바랍니다.</li>
				</ul> 
			</div>
			<!--버튼-->
			<div class="pop_btn">
				<a id="uaPopExcelRegBtn" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>					
						
			
			
 		<!-- popup 주소록 -->
        <div id="alarm_pop_group" class="pop_wrap width-730px" style="background:transparent;">
			<div class="width-100">
				<ul class="pop_tabmenu_excel_alarm">
					<li id="pop_tab_2" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_excel_alarm" id="pop_tabmenu_excel_alarm_2">
						<label for="pop_tabmenu_excel_alarm_2">주소록 불러오기</label>
						<div class="pop_tabCon">
							<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000 padding-20">
							<table cellpadding="0" cellspacing="0" border="0" class="width-100 height-210px margin-auto">
								<tr>
									<td class="width-330px height-240px vertical-top">
										<h5 class="font-18px font-normal font-174962 text-left">주소록보기</h2>
										<ul class="tabmenu_small_alarm">
											<li id="small_tab_1" class="btnCon">
												<input type="radio" checked name="tabmenu_small_alarm" id="tabmenu_small_alarm_1" value="0">
												<label for="tabmenu_small_alarm_1">개인</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="ua_pop_my_group_list alarm_send_my width-100 li-h30">
														 
														</ul>
													</div>
												</div>
											</li>
											
											
											<li id="small_tab_2" class="btnCon uaPartTab">
												<input type="radio" name="tabmenu_small_alarm" value="1" id="tabmenu_small_alarm_2">
												<label for="tabmenu_small_alarm_2" id="uaPartTab"></label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="ua_pop_part_group_list  width-100 li-h30">
														</ul>
													</div>
												</div>
											</li>											
											<li id="small_tab_3" class="btnCon uaEmployTab">
												<input type="radio" name="tabmenu_small_alarm" value="3" id="tabmenu_small_alarm_3">
												<label for="tabmenu_small_alarm_3">직원</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scrol-y font-12px">
														<ul class="ua_pop_employ_group_list  width-100 li-h30">
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_4" class="btnCon uaShareTab">
												<input type="radio" name="tabmenu_small_alarm"  value="2" id="tabmenu_small_alarm_3_4">
												<label for="tabmenu_small_alarm_3_4" id="uaShareTab"></label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="ua_pop_share_group_list width-100 li-h30">
														</ul>
													</div>
												</div>
											</li> 
											 
										</ul>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="uaGrpPrvBtn alarmGrpBtn icon_group">그룹</a>
									</td>
									<td rowspan="2" class="vertical-top width-230px">
										<h5 class="font-18px font-normal font-174962 text-left">연락 받을 사람<a class="width-55px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest float-right">최근</a></h2>
										 
<div id="uaPopRecentLayer">
<ul id="uaRecentLst"></ul>
</div>
<!-- //폼 레이어  -->										
										
										<div class="width-230px height-480px hidden scroll-y font-12px border-radius-5 border-e8e8e8" style="height:485px;">
											<ul class="ua_pop_receiver width-100 li-h30">
											
											</ul>
										</div>
									</td>
								</tr>
								<tr>
									<td class="width-330px height-240px vertical-top ">
										<h5 class="font-18px font-normal font-174962 text-left">선택그룹 상세보기</h2>
										<div class="width-330px height-210px hidden scroll-y font-12px border-radius-5 border-e8e8e8">
											<ul class="ua_pop_detail_list alarm_send_group width-100 li-h30">
												<li class="search">
													<select class="select_white_small width-70px">
														<option>이름</option>
													</select>
													<input type="text" name="" />
													<a href="#">입력</a>
												</li>
											</ul>
										</div>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="uaIndivPrvBtn alarmPrvBtn icon_each">개별</a>
									</td>
								</tr>
							</table>
							<div class="margin-top-5 text-right">
								<a id="uaPopDelSelect" class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest ">선택삭제</a>
								<a id="uaPopDelAll" class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">전체삭제</a>
							</div>
							</div>
							<!--버튼-->
							<div class="pop_btn-big margin-auto text-center margin-bottom-10">
								<a id="uaPopRegisterBtn" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
								<a id="uaPopCancelBtn" class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>				
	
	
	
	
	 
<style>
ul.pop_tabmenu_ua_contents_re { position:relative; width:100%; padding:60px 0 0; margin:0; }
ul.pop_tabmenu_ua_contents_re > li{ display:inline-block; width:100%; float:left; text-align:center;  background :transparent; padding:0; margin:0;;}
ul.pop_tabmenu_ua_contents_re > li > label{position:absolute; left:0; top:0; display:block; width:180px;  height:60px; line-height:60px; background-image: linear-gradient(to left, #c1d4ed, #b4cae8); color:#688ba6; border-radius:5px 5px 0 0; text-align:center; font-weight:bold; font-size:20px;}
ul.pop_tabmenu_ua_contents_re > li:nth-child(2) > label{position:absolute; left:180px; top:0; }
ul.pop_tabmenu_ua_contents_re > li:nth-child(3) > label{position:absolute; left:340px; top:0; }
ul.pop_tabmenu_ua_contents_re > li > input{display:none;}
ul.pop_tabmenu_ua_contents_re > li > div.pop_tabCon{ display:none;  text-align:left;  width:540px; padding:20px; background:#f7fafc; box-sizing:border-box; border-radius:0 0 5px 5px;}
ul.pop_tabmenu_ua_contents_re input:checked ~ label{ background:#f7fafc; color:#174962;}
ul.pop_tabmenu_ua_contents_re input:checked ~ .pop_tabCon{ display:block;}
</style>
		 <!-- popup 대체문자 -->
         <div id="uaContentsRePopUp" class="pop_wrap width-730px" style="background:transparent;">
			<div class="width-100">
				<ul class="pop_tabmenu_ua_contents_re">
				
					<li id="pop_tab01" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_ua_contents_re" id="pop_tabmenu_ua01" value="SMS">
						<label for="pop_tabmenu_ua01">단문</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 id="uaReContentSMSTitle" class="font-18px font-bold font-174962 text-center background-8bc5ff padding-10 "></h2>
									<div id="uaReContentSMSContent" class="word-break-break-all width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"></div>
								</div>
							</div>							
							<!--버튼-->
							<div class="pop_btn-big">
							    <a OnClick="ReContentEditMode('uaReContentSMSContent','uaReContentSMSRegBtn')"  class="margin-right-30 font-053c72 font-bold width-100px background-8bc5ff box-shadow">편집하기</a>
								<a id="uaReContentSMSRegBtn" OnClick="ReContentRegister('uaReContentSMSContent','uaReContentSMSRegBtn','SMS','UA')" class="margin-right-30 font-053c72 font-bold width-200px background-8bc5ff box-shadow">대체문자로 지정</a>
								<a id="uaReContentSMSCloseBtn" class="background-efefef width-70px font-053c72 font-normal">닫기1</a>
							</div>
						</div>
					</li>
					<li id="pop_tab02" class="btnCon">
						<input type="radio" name="pop_tabmenu_ua_contents_re" id="pop_tabmenu_ua02" value="LMS">
						<label for="pop_tabmenu_ua02">장문</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 id="uaReContentLMSTitle" class="font-18px font-bold font-174962 text-center background-8bc5ff padding-10"></h2>
									<div id="uaReContentLMSContent" class="word-break-break-all width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"></div>
								</div>
							</div>							
							<!--버튼-->
							<div class="pop_btn-big">
								<a OnClick="ReContentEditMode('uaReContentLMSContent','uaReContentLMSRegBtn')" class="margin-right-30 font-053c72 font-bold width-100px background-8bc5ff box-shadow">편집하기</a>
								<a id="uaReContentLMSRegBtn"  OnClick="ReContentRegister('uaReContentLMSContent','uaReContentLMSRegBtn','LMS','UA')" class="margin-right-30 font-053c72 font-bold width-200px background-8bc5ff box-shadow">대체문자로 지정</a>
								<a id="uaReContentLMSCloseBtn" class="background-efefef width-70px font-053c72 font-normal">닫기</a>
							</div>
						</div>
					</li>
					<!-- <li id="pop_tab03" class="btnCon">
						<input type="radio" name="pop_tabmenu_ua_contents_re" id="pop_tabmenu03" value="MMS">
						<label for="pop_tabmenu03">멀티</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 id="uaReContentMMSTitle" class="font-18px font-bold font-174962 text-center background-8bc5ff  padding-10"></h2>									
									<div id="uaReContentMMSContent" class="word-break-break-all width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"></div>
								</div>
							</div>							
							버튼
							<div class="pop_btn-big">
								<a OnClick="ReContentEditMode('uaReContentMMSContent','uaReContentMMSRegBtn')" class="margin-right-30 font-053c72 font-bold width-100px background-8bc5ff box-shadow">편집하기</a>
								<a id="uaReContentMMSRegBtn"  OnClick="ReContentRegister('uaReContentMMSContent','uaReContentMMSRegBtn','MMS','UF')"  class="margin-right-30 font-053c72 font-bold width-200px background-8bc5ff box-shadow">대체문자로 지정</a>
								<a id="uaReContentMMSCloseBtn" class="background-efefef width-70px font-053c72 font-normal">닫기</a>
							</div>
						</div>
					</li> -->
				</ul>
			</div>
        </div> 
				
				


        <!-- popup 미리보기 -->
        <div id="uaPreviewPopUp" class="pop_wrap width-800px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">미리보기</div>
				<!--내용-->
				<div class="flex-between margin-top-20">
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="uaPreviewTitle1"></h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="uaPreviewContents1"   contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="uaPreviewRcvNum1">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="uaPreviewRcvNum1">01087654387</span>
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="uaPreviewTitle2">내용 (최대 30Byte)</h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="uaPreviewContents2"   contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="uaPreviewRcvNum2">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="uaPreviewSendNum2">01087654387</span>
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="uaPreviewTitle3">테스트</h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="uaPreviewContents3"  contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="uaPreviewRcvNum3">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="uaPreviewSendNum3">01087654387</span>
							</div>
						</div>
					</div>		
				</div>
				<!--버튼-->
				<div class="margin-auto text-center margin-top-30 margin-bottom-10">
					<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
				</div>
        </div>
        
        
        <!-- popup 템플릿 -->
        <div id="uaTempletPopUp" class="pop_wrap width-1190px min-width-1110px background-f7fafc border-radius-5" >
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">알림톡 템플릿</div>

		<div class="margin-top-5 margin-bottom-10"> 

				<!--업무분류 셀렉박스-->
				<select class="select_blank_lightblue width-120px"
					style="margin-right: 10px">
					<option value="">선택해주세요</option>
					<c:if test="${g_workSeqZeroCodeUseYN eq 'Y'}">
						<option value="0">미분류</option>
					</c:if>
					<option value="1">알림톡</option>
					<option value="2">알림</option>
					<option value="3">민원</option>
					<option value="4">공지</option>
					<option value="5">비상</option>
					<option value="6">기타</option>
				</select>

				<!--제목  셀렉박스-->
				<select class="select_blank_lightblue width-120px"
					style="margin-right: 10px">
					<option selected>제목</option>
					<option>템플릿이름</option>
					<option>내용</option>
				</select>

				<!--검색-->
				<div class="inline-block width-250px">
					<input type="text" name="" placeholder=""
						class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
				</div>
				<a	class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
			</div>
			<!-- //검색설정 -->				
				<!--내용-->
				<div class="flex-between margin-top-20">
					
					<table id="uaTemplate" style="padding-bottom: 10px; width: 100%">
						<thead height="0" style="display: none;">
							<tr height="0">
								<th height="0">검수상태</th>
								<th height="0">내용</th>
							</tr>
						</thead>
					</table>
					
<!-- 					
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">제목 (최대 30Byte)</h2>
							<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">[이름]</textarea>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">내용 (최대 30Byte)</h2>
							<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">예약발송테스트</textarea>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left">테스트</h2>
							<textarea class="width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default">예약발송테스트</textarea>
						</div>
					</div>	 -->	
				</div>
							<!-- <div class="text-center margin-bottom-10">
								<ul class="pagination">
									<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
									<li class="page-item active"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">4</a></li>
									<li class="page-item"><a class="page-link" href="#">5</a></li>
									<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
								</ul>
							</div> -->
				<!--버튼-->
				<div class="margin-auto text-center margin-top-30 margin-bottom-10">
					<a id="uaRegTemplateBtn" OnClick="inputTemplate();" class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
				</div>
        </div>
        
        
        
        

</body>
</html>
