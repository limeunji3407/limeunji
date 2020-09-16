<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 
<spring:message code="g_workSeqZeroCodeUseYN" var="g_workSeqZeroCodeUseYN" /> 
<spring:message code="workSeqRequiredFlag" var="workSeqRequiredFlag" /> 
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
function arrUFLstPop(idx){
	////console.log(arrUFLst);
	var idx = arrUFLst.indexOf(idx);
	//console.log("------arrUFLst.length:" + arrUFLst.length + "-----idx:" + idx);
	arrUFLst.splice(idx,1);
	if(!arrUFLst.length){
		//console.log("------disable -> enable -----:" + idx);
		arrUFLstFlag = 0;
		$('#ufPopExcelBtn').removeClass("background-efefef");
		$('#ufPopExcelBtn').removeClass("disable"); 
		$('#ufPopGrpLstBtn').removeClass("background-efefef");
		$('#ufPopGrpLstBtn').removeClass("disable");
		$('#ufManualInputBtn').removeClass("background-efefef");
		$('#ufManualInputBtn').removeClass("disable");
	}
	
	$("#ufTotalCnt").text("총 " + arrUFLst.length + "건");
	SetPrice("uf",arrUFLst.length);
}

$(document).ready(function(){ 	

	
	
	/* 최초 핸드폰번호 입력*/
	if(isEmpty(uSMobile)){
	    $("#ufSendNum").val("");
	}else{
	    $("#ufSendNum").val(uSMobile);
	} 
	
	/* 예약날짜세팅 */
	var currentDate = new Date().toISOString().substring(0, 10);
	var currentTime = new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
    $("#ufDataPicker").val(currentDate);
    $("#ufTimePicker").val(currentTime);
    
	
	
	
	
	/* 주소록 보기 */
	$("input:radio[name=tabmenu_small_ftalk]").change(function() {
		var arrTabName = ["uf_pop_my_group_list","uf_pop_part_group_list","uf_pop_share_group_list","uf_pop_employ_group_list"];
		var tab = $('input:radio[name="tabmenu_small_ftalk"]:checked').val(); 
		
		AjaxGroupList(tab, arrTabName[tab],"f");
	});
	
	/* 친구톡 주소록버튼클릭시 주소록리스트 */
	$('#ufPopGrpLstBtn').on('click', function(){
		var arrTabName = ["uf_pop_my_group_list","uf_pop_part_group_list","uf_pop_share_group_list","uf_pop_employ_group_list"];
		var tab = $('input:radio[name="tabmenu_small_ftalk"]:checked').val(); 
		AjaxGroupList(tab, arrTabName[tab],"f");
		
		$(".pop_bg").css('display','block');
		$('#ftalk_pop_group').css('display','block'); 
	}); /* msgAddressBtn click */
	/* 주소록 보기 */
	
	 
 
	
	/* 그룹주소 이동버튼 */
	$("a.ufGrpPrvBtn").click(function(){		
		
		
		/* 체크된 그룹탭 값 확인 */
		var tabType = $('input[name="tabmenu_small_ftalk"]:checked').val();
		 
		var grp = arrUFGLst.find(x => x.rowNo === 1);		
		var grpIdx = arrUFGLst.indexOf(grp);
		if( arrUFPLst.find(x => x.code === grp.code && x.title === grp.title)){
			toastr.error("이미 선택된 그룹입니다");
			return false;
		} 
		
		arrUFPLst.push({
			isGroup : "Y", /* 그룹여부 */
			type : grp.type,  /* 타입  */
			title : grp.title,  /* 그룹명  */
			code : grp.code,     /* 그룹code Unique */
			phone : grp.groupcnt	 				
		});
			
		var html = "<li><div class=\"checkbox-small_2\">" +
			"<input type=\"checkbox\" id=\"check-" + grpIdx + "g\" name=\"mng_group_check_g" + grpIdx + "\"  />" +
			"<label for=\"check-" + grpIdx + "g\"></label>" + 
			"</div><span>" + grp.title + "(" + grp.groupcnt + ")</span></li>";
		$('ul.uf_pop_receiver').append(html); 
		 
	});
	
	
	
	/* 개별주소 이동버튼 */
	$("a.ufIndivPrvBtn").click(function(){
		/* 중복제거 */
		
 		$.each(arrUFGDLst, function(idx, row){ 
 			 
 			//console.log("-----rowNo:" + arrUFGDLst[idx].rowNo);
 			
 			if(arrUFGDLst[idx].rowNo){
 				arrUFPLst.push({
 	 				isGroup : "N", /* 그룹여부 */
 	 				title : arrUFGDLst[idx].address_name,  /* 타이틀 */
 	 				code : arrUFGDLst[idx].address_id,     /* 그룹code Unique */
 	 				phone : arrUFGDLst[idx].address_num 	 				
 	 			});
 				var html = "<li><div class=\"checkbox-small_2\">" +
 				"<input type=\"checkbox\" id=\"check-" + idx + "i\" name=\"mng_group_check_i" + idx + "\"  />" +
 				"<label for=\"check-" + idx + "i\"></label>" + 
 				"</div><span>" + arrUFGDLst[idx].address_name + "<span>" + arrUFGDLst[idx].address_num + "</span></span></li>";
 				$('ul.uf_pop_receiver').append(html);
 			} 			
		});
 		
 		//console.log(arrUFGDLst);
 		//console.log(arrUFPLst);
	});  
	
	
	/*
	* 선택제거
	*/
	$("#ufPopDelSelect").click(function(){

		var gb = $('ul.uf_pop_receiver li').get();
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
				arrUFPLst.splice(i-1, 1);		
			}
        } 
		
	});	

	/*
	* 전체제거
	*/
	$("#ufPopDelAll").click(function(){
		//$('ul.mng_pop_receiver li').remove();  
		$('.uf_pop_receiver').empty();	 
		arrUFPLst = [];
	});	
	
	
	/* 팝업 취소 버튼 */
	$('#ufPopCancelBtn').click(function(){
		
		$('.uf_pop_my_group_list').empty();
		$('.uf_pop_employ_group_list').empty();
		$('.uf_pop_part_group_list').empty();
		$('.uf_pop_share_group_list').empty();
		$('.uf_pop_detail_list').empty();
		$('.uf_pop_receiver').empty();	 
		arrUFPLst = [];
		arrUFGLst = {};
		arrUFGDLst = {};
		
	});
	
	/* 
	* 최종리스트 #tblsendftalk로 리스트이동
	* 등록하기 버튼
	*/
	$('#ufPopRegisterBtn').click(function(){


		//console.log(arrUFPLst);
		 
		
		/* arrMCPLst [] rendering */
		$.each(arrUFPLst, function(idx, row){ 
			
			/* 최종에 push */
			/* //console.log(arrMCPLst[idx].title); */
		 	var trData = "<tr>" + 
						 "<td class=\"relative\">" + 
						 	"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
						 		"<input type=\"checkbox\" id=\"check_" + idx + "s\" name=\"체크\" class=\"mngcheck\" />" + 
						 		"<label for=\"check_" + idx + "s\"></label>" + 
						 	"</div> <a class=\"rev_name\">" + arrUFPLst[idx].title + "</a>" + 
						 "</td>" + 
						 "<td>" + arrUFPLst[idx].phone + "</td><td>주소록</td>" + 
						 "<td class=\"tb_btn\">" + 
						 	"<a class=\"open_pop icon_modify\">수정</a>" + 
			             	"<a href=\"#\" class=\"icon_delete\"onclick=\"arrUFLstPop(" + arrUFLst.length + ");deleteLine(this);\" >삭제</a>" + 
			             "</td>" + 
			             "</tr>";
			$('#tblsendftalk tbody').append(trData);
			  
			
			/* 최종에 push */
			arrUFLst.push({ 
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
		$('.uf_pop_my_group_list').empty();
		$('.uf_pop_employ_group_list').empty();
		$('.uf_pop_part_group_list').empty();
		$('.uf_pop_share_group_list').empty();
		$('.uf_pop_detail_list').empty();
		$('.uf_pop_receiver').empty();	 
		arrUFPLst = [];
		arrUFGLst = {};
		arrUFGDLst = {};

		$('#ftalk_pop_group').css('display','none'); 
		//console.log(arrUFLst);
		/*주소목록 모드*/
		arrUFLstFlag = 1;
		$('#ufPopExcelBtn').addClass("background-efefef"); 
		$('#ufPopExcelBtn').addClass("disable");
		$("#ufTotalCnt").text("총 " + arrUFLst.length + "건");

		/*예상비용*/
		SetPrice("uf",arrUFLst.length); 
	});
/**************************************************    팝업 주소록 보기 스크립트        ******************************************/


/*********************************************** MMSINFO 이미지 업로드 ************************************/
		
	/* 이미지등록 팝업 */
	$('#ufPopImgUploadBtn').on('click', function(){	 
		$(".pop_bg").css('display','block');
		$(".ufPopImgUpload").css('display','block');
	});
	
	/* 이미지파일 onChange */
	$('#uf_img_file').change( function(){
		 
	    var timeUID = Math.floor(new Date().getTime() / 1000);
	   //console.log($("#uf_img_file")[0].files[0].type); // 파일 타임
	   //console.log($("#uf_img_file")[0].files[0].size); // 파일 크기
	       
	       
		var previewTag = "<img id='thumbnailImg" + timeUID + "' src='' width='200' height='200' align='center' />";
		$('#ufContent').append(previewTag);
		
		let fileInfo = document.getElementById("uf_img_file").files[0];
		let reader = new FileReader();
		
		reader.onload = function() {
			document.getElementById("thumbnailImg" + timeUID ).src = reader.result;
			if($('input[name=uf_img_file]')[0].files[0].name !== undefined){
				document.getElementById("uf_img_name").value = $('input[name=uf_img_file]')[0].files[0].name;
			}
			//$('#uf_img_name').val("파일명");
		}
		
		if( fileInfo ){
			reader.readAsDataURL( fileInfo );
		}
		//console.log(fileInfo);
	});
	
	
	
	/* 이미지 등록하기 */
	$('#ufImgRegBtn').on('click', function(){
		
		//로딩바
		
		var formData = new FormData(document.getElementById("ufForm")); 
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
				
				/* MMS 정보에 입력  삭제할 수도 있으니 ufContent내의 img태그를 취합해서 입력하도록 해야 */
				//arrUmMMS.push(result);
				
				console.log(result);
				
				ufImgFile = result; 
				//document.getElementById("thumbnailImg" + timeUID ).src = result;
				$(".pop_bg").css('display','none');
				$(".ufPopImgUpload").css('display','none');
			}, 
			error: function (e) { 
				toastr.error(e);
				$(".pop_bg").css('display','none');
				$(".ufPopImgUpload").css('display','none');
				
			} 
		});
		
		reType = "MMS";
 
	});
	
	/*********************************************** MMSINFO 이미지 업로드 ************************************/




	/* 엑셀 팝업창 */
	$('#ufPopExcelBtn').on('click', function(){	
		$(".pop_bg").css('display','block');
		$('#ftalk_pop_excel').css('display','block'); 		
	});	

	
	
	/*
	제목글자수체크
	*/
	$('#ufTitle').keydown(function (e){
	    var title = $(this).val();
	    
	    //$('#counter').html("("+content.length+" / 최대 200자)");    //글자수 실시간 카운팅

	      if ( Number(byteCheck($(this))) == 90 ){ 
	    	//$(this).val(title.substring(0, title.length - 1));
	    	
	    	//e.preventDefault();
	    	$('#ufContent').focus();
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
	$('#ufContent').keydown(function (e){
	    var content = $(this).val();

	    if ( Number(getByteLength(content)) == 90 ){  
	    	
	    	e.preventDefault();
	    	//$(this).attr("readonly",true); 
	    	//$('#phonelistftalk').focus();
	    	toastr.error("단문은 최대 90BYTE까지만 입력 가능합니다.");
	    	//f_chk_byte($(this),90);
	        //$(this).val(content);
	        //return false; 
	        //$('#counter').html("(200 / 최대 200자)");
	    }
	    
	    if ( Number(byteCheck($(this))) > 1800 ){ 

	    	e.preventDefault();
	    	$('#phonelistftalk').focus();
	    	toastr.error("최대 1800BYTE까지만 입력 가능합니다.");
	    	f_chk_byte($(this),1800);
	    }
	    
	    if( Number(byteCheck($(this))) > 90 ){
 			totalCnt = "1800";
 		}else{
 			totalCnt = "90";
 		}
 		
        /* $(this).height(((content.split('\n').length + 1) * 1.5) + 'em'); */
         $('#counter').html(content.length + '/' + totalCnt );
        
		/* 전송목록이 있을때 내용처리시 예상비용이 수정되어야 한다*/
        if(arrUFLst.length){
        	SetPrice("uf", arrUFLst.length);
        }
		
	});
 

	//보내는번호입력	
	$('input:radio[name=uf_send_num]').change(function() {
		
		var sendnumType = $('input:radio[name=uf_send_num]:checked').val();
		
		
		if(sendnumType === "3") {
			$('#ufSendNum').val("");
			//console.log("-------직접입력--------"+sendnumType);
		}else if(sendnumType === "1"){ //사무실
			//console.log("-------사무실번호--------" + sendnumType + ":" + uSTel);
			if( isEmpty(uSTel) ){
				uSTel = "";
				toastr.error("발송용 사무실번호가 없습니다.입력해주세요");
			}
			$('#ufSendNum').val(uSTel);
		}else{ //사무실 핸드폰
			//console.log("-------모바일번호--------" + sendnumType + ":" + uSMobile);
			if( isEmpty(uSMobile) ){
				uSMobile = "";
				toastr.error("발송용 핸드폰번호가 업습니다.입력해주세요");
			}
			$('#ufSendNum').val(uSMobile);
		}
		
	});
	

	//document.getElementById('phonelistftalk').addEventListener('paste', handlePaste);
	
	//수동입력
	$('#ufManualInputBtn').on('click', function(){	 
		//phonelist 내용을 배열에 담아   다른 리스트로 넣고 삭제한다 
		if(!$('#phonelistftalk').html().length){
			toastr.error("수신번호를 입력하세요");
			return;
		}
		var strTemp = $('#phonelistftalk').html();	
		////console.log(strTemp);
		strTemp = strTemp.replace("<div>","|");
		strTemp = strTemp.replace("</div><div>","|");
		strTemp = strTemp.replace("</div>","");
		var strTemp2 = strTemp.split('|'); //2번예제 분리

		//console.log(strTemp2);
		var i;
		var arrlen = arrUFLst.length;
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
			             		"<a href=\"#\" class=\"icon_delete\"onclick=\"arrUFLstPop(" + arrUFLst.length + ");deleteLine(this);\" >삭제</a>" + 
			             	"</td>" + 
			             "</tr>";
			              
				    		
			 			arrUFLst.push({ 
			 				isGroup : "N", /* 그룹여부 */
			  	 			title : "미입력",  /* 타이틀 */
			  	 			code : null,     /* 그룹code Unique */
			  	 			phone : strTemp2[i],
			  	 			name : "미입력",
			  	 			type : ""
			  	 		});
			$('#tblsendftalk tbody').append(trData); 
		}		
		$('#phonelistftalk').html(null);
		//console.log("-수동입력--시작카운터:"+ arrlen + "::::최종카운트 -" + arrUFLst.length + ":" ); 
		
		arrUFLstFlag = 1;
		$('#ufPopExcelBtn').addClass("background-efefef");
		$('#ufPopExcelBtn').addClass("disable");
		$("#ufTotalCnt").text("총 " + arrUFLst.length + "건");

		/*예상비용*/
		SetPrice("uf",arrUFLst.length);
	});
	
	
	//엑셀입력
	$('#ufPopExcelRegBtn').on('click', function(){	
		/*excel upload */
/* 		if( isNull($("#ufInputImgFile").val()) ) {
			    $("#ufInputImgFile").focus();
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
				//console.log(data);
			}
		}); */
		
		//loading 
		var start = console.time(); //new Date().getTime(); 
		
	    var rowJsonObj = {};
        var files = document.getElementById("ufInputImgFile").files[0]; //input file 객체를 가져온다.
		////console.log(files);
        
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
		        	var elm = createItem(rowJsonObj[i], arrUFLst.length, "arrUFLstPop");
		    		$('#tblsendalarm tbody').append(elm);   
		    		arrUFLst.push({ 
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

 		

		arrUFLstFlag = 2;
		$('#ufPopGrpLstBtn').addClass("background-efefef");
		$('#ufPopGrpLstBtn').addClass("disable");
		$('#ufManualInputBtn').addClass("background-efefef");
		$('#ufManualInputBtn').addClass("disable"); 
		$("#ufTotalCnt").text("총 " + arrUFLst.length + "건");
		

		/*예상비용*/
		SetPrice("uf",arrUFLst.length);
		
		
 		
 		var end = console.timeEnd();
 		
 		//console.log("finish:" + ( start - end )); 
		//console.log(arrMsg);
		    
		$(".pop_bg").css('display','none');
		$('#ftalk_pop_excel').css('display','none'); 
		
		
		$('.wrap-loading').css('display','none');    	
	});	
	
	
	
	//FTALK 엑셀수신번호입력
	$('#ftalk_reg_excel').on('click', function(){			
		
		/*excel upload */
		if( isNull($("#fileftalk").val()) ) {
			    $("#fileftalk").focus();
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
				//console.log(data);
			}
		});

		//$("#mdlExcelUpload").modal("toggle");
		
		// excelExport(event, this, "#tblsendftalk tbody"); 
		 var files = document.getElementById("fileftalk").files[0]; //input file 객체를 가져온다.
		 
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
									 			"<input type=\"checkbox\" id=\"check_4\" name=\"체크\" class=\"msgcheck\" />" + 
									 			"<label for=\"check_4\"></label>" + 
									 		"</div> <a class=\"rev_name\">" + rowJsonObj[i]['수신자명'] + "</a>" + 
									 	"</td>" + 
									 	"<td>" + rowJsonObj[i]['수신번호'] + "</td><td>엑셀입력</td>" + 
									 	"<td class=\"tb_btn\">" + 
									 		"<a class=\"open_pop icon_modify\">수정</a>" + 
						             		"<a href=\"#\" class=\"icon_delete\"onclick=\"deleteLine(this);\" >삭제</a>" + 
						             	"</td>" + 
						             "</tr>";
						
						$('#tblsendftalk tbody').append(trData); 
					}
		        })
		    };
		    reader.readAsBinaryString(files); 

			$(".pop_bg").css('display','none');
			$('#ftalk_pop_excel').css('display','none');  
	});	
	
	//예약 발송
/* 	$('input:radio[name=ufSendTime]').change(function() { 
		  if ($('input:radio[name=ufSendTime]:checked').val() == "1") {
		  }else{
		  } 
	}); */
	
	//테스트입력
	$('input:radio[name=ufSendTime]').change(function() { 
		  if ($('input:radio[name=ufSendTime]:checked').val() == "2") {
			 $('#frd_test_send').removeClass("none");
		     $('#ufTestInput').removeClass("none");
		  }else{
			 $('#frd_test_send').addClass("none");
			 $('#ufTestInput').addClass("none");
		  } 
	});
	
	//오늘날짜세팅 
	//lodingbar hide
	$('.loading_bar').hide();
	

	//제목내용 클리어
	$('#ufContentClearBtn').on('click', function(){
		$('#ufTitle').val(""); 
		$('#ufContent').html(""); 
	});	
	

	$('#ufPopMyBox').on('click', function(){		

		var dom = $(this).parents(".tabmenu_search");
		var searchKey = dom.find("select[name='searchKey']").val();
		var searchValue = dom.find("input[name='searchValue']").val();
		var tab = $("input[name='pop_tabmenu_um_mybox']:checked").val();
		
		var param = {
				"userId":globalId,
				"searchCnd":searchKey,
				"searchWrd":searchValue
		}
		
		if(tab == 'S'){
			umSaveTableS.ajax.url( "/getMySaveS.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'L'){
			umSaveTableL.ajax.url( "/getMySaveL.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'M'){
			umSaveTableM.ajax.url( "/getMySaveM.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'F'){
			umSaveTableF.ajax.url( "/getMySaveF.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}else if(tab == 'C'){
			umSaveTableC.ajax.url( "/getMySaveC.do?userId="+globalId+"&searchCnd="+searchKey+"&searchWrd="+searchValue ).load();
		}

		umSaveTableS = umSaveTableInit("umTemplateS", "/getMySaveS.do", "cntS");
		umSaveTableL = umSaveTableInit("umTemplateL", "/getMySaveL.do", "cntL");
		umSaveTableM = umSaveTableInit("umTemplateM", "/getMySaveM.do", "cntM");
		umSaveTableF = umSaveTableInit("umTemplateF", "/getMySaveF.do", "cntF");
		umSaveTableC = umSaveTableInit("umTemplateC", "/getMySaveC.do", "cntC");

		//console.log("----------------내저장함---------------");
		$(".pop_bg").css('display','block');
		$('#umMyBoxPopUp').css('display','block');	
	});
	
	
	/************* 내저장함에 저장하기 ****************/
	$('#ufMyBoxSave').on('click', function(){
			
		var title = $("#ufTitle").val();
		var subject = $("#ufContent").html();
		var status = "F";
		
		var obj = {
			"title" : title,
			"subject" : subject,
			"status" : status
		}
		
		//console.log("obj :: "+JSON.stringify(obj));
		
		$.ajax({
	       	url: "<c:url value='/usr/insertMySave' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){  
	     	   
	       		//console.log(jsondata["data"]);
	            
	            if(jsondata["data"]==0){
	                //로딩
	                alert("저장되었습니다.");
	            }else{
	            	alert("양식을 다시 확인해주시기 바랍니다.");
	            }
	       	},
	       	error: function(request,status,error){
	       		  
	       		//console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	           	$('#result').text(jsondata);
	           	////console.log("serialize err");
	       		$('#addrBtn').attr('disabled', false);
	       	}
	   	});
	});
	
	
	 

	/* 개별문자 입력 ufContentsChangeBtn */	
	$('#ufContentsChangeBtn').on('click', function(){
		
		/*최종전송목록체크*/
		//console.log("----arrUFLst-----" + arrUFLst);
		if(!arrUFLst.length){
			 toastr.error("수신자 전송목록이 비어있습니다");
			 return;			
		}
		//console.log('----------------개별문자입력---------------' + $('#ufContentsChangeOpt option:selected').val());
		var variable = "#[" + $('#ufContentsChangeOpt option:selected').val() + "]";
		$('#ufContent').append(variable);
		 
		arrUFVariables.push(variable); /* 동일한 컬럼변수가 있으면 푸시안함  */
		toastr.success("개별문자가 입력되었습니다");
		
	});
	
	

	/*************************************************** 대체문자 지정  ***************************************************/
	/*
	* RF_061_01 대체문자
	*/
	$('#ufReContentCheck').on('change', function () {
		////console.log(this.checked);
	    if (!this.checked) { 
			$('#ufContentsRePopUpBtn').addClass('background-efefef');
			$('#ufContentsRePopUpBtn').removeClass('background-053c72');
			$("#ufContentsRePopUpBtn").prop("disabled", true);
	    }else{
			$('#ufContentsRePopUpBtn').addClass('background-053c72');
			$('#ufContentsRePopUpBtn').removeClass('background-efefef');
			$("#ufContentsRePopUpBtn").prop("disabled", false);

			/* 지정된 대체문자가 있다면 */
			if( arrUFReContent.length > 0 ){

				/* 지정버튼 활성화 */
				$('#ufReContentSMSRegBtn').addClass('background-8bc5ff');
				$('#ufReContentSMSRegBtn').removeClass('background-efefef');
				$('#ufReContentSMSRegBtn').css({ 'pointer-events': 'auto' });
				$('#ufReContentLMSRegBtn').addClass('background-8bc5ff');
				$('#ufReContentLMSRegBtn').removeClass('background-efefef');
				$('#ufReContentLMSRegBtn').css({ 'pointer-events': 'auto' });
				$('#ufReContentMMSRegBtn').addClass('background-8bc5ff');
				$('#ufReContentMMSRegBtn').removeClass('background-efefef');
				$('#ufReContentMMSRegBtn').css({ 'pointer-events': 'auto' });
				
				/* 대체문자지정 배열 삭제 */
				arrUFReContent = [];
				toastr.success("대체문자지정이 취소되었습니다"); 
			}
	    }
	});
	
	
	/* 대체문자 팝업창 열기 */ 
	$('#ufContentsRePopUpBtn').on('click', function(){	

		var reType, reContent;
		
		/* ////console.log("==========length=============" + arrUFReContent.length); */
		if( arrUFReContent.length > 0 ){
			
			arrUFReContent.forEach(function(element){ 
	    		reType = element.type;
	    		reContent = element.content; 
			}); 
		}
		/*////console.log("----------------대체문자 팝업창 열기---------------" +JSON.stringify(arrUFReContent) + reType  + reContent); */
		
		/* 
		RF_061_01 대체문자 발송 
		RF_062_01 대체문자 작성 
		RF_062_02 대체문자 수정  
		RF_062_03 대체문자 용량    자동변경
		*
		*/
		
		/* 최종선택한 형태로 대체문자발송 */ 
		/* 단문 /장문 /멀티 중 선택 */		
		/* 팝업창 열때마다 컨텐츠 가져오기  지정이 없다면  */
	
		var subject = $('#ufTitle').val();
		var content = $('#ufContent').html(); 
		
		

		var contentTxt = "";
		var div = document.createElement("div");
		div.innerHTML = content;
	    contentTxt = div.textContent || div.innerText || "";


		var isImage = Object.keys(ufImgFile).length; 
		
		if(isImage > 0 ){
			reType = "MMS";
		}else{
			if(getTextLength(contentTxt) < 90 ){

				reType = "SMS";
			}else{

				reType = "LMS";
			}
		}
		
		var recontentS = content,recontentL = content, recontentM = content;
		
		/* 지정된 대체문자가 있을경우  */
		if( arrUFReContent.length > 0 ){
			if(reType === "SMS" ){ recontentS = reContent;}	
			if(reType === "LMS" ){ recontentL = reContent;}	
			if(reType === "MMS" ){ recontentM = reContent;}	

			$('#ufReContentSMSTitle').html(subject);
			$('#ufReContentSMSContent').text(recontentS);			
			$('#ufReContentLMSTitle').html(subject);
			$('#ufReContentLMSContent').text(recontentL);			
			$('#ufReContentMMSTitle').html(subject);
			$('#ufReContentMMSContent').html(recontentM);
		}else{
			$('#ufReContentSMSTitle').html(subject);
			$('#ufReContentSMSContent').text(contentTxt);			
			$('#ufReContentLMSTitle').html(subject);
			$('#ufReContentLMSContent').text(contentTxt);			
			$('#ufReContentMMSTitle').html(subject);
			$('#ufReContentMMSContent').html(content);
		}
		
		$(".pop_bg").css('display','block');
		$('#ufContentsRePopUp').css('display','block');
	});
	
	
	
	$('#ufReContentSMSContent').keydown(function (e){
	    var content = $(this).text(); 
	    if ( Number(getByteLength(content)) > 90 ){  
	    	e.preventDefault(); 
	    	toastr.error("단문은 최대 90BYTE까지만 입력 가능합니다."); 
	    }
	});
	$('#ufReContentLMSContent').keydown(function (e){
	    var content = $(this).text(); 
	    if ( Number(getByteLength(content)) > 1800 ){  
	    	e.preventDefault(); 
	    	toastr.error("장문은 최대 1800BYTE까지만 입력 가능합니다."); 
	    }
	});
	$('#ufReContentMMSContent').keydown(function (e){
	    var content = $(this).text(); 
	    if ( Number(getByteLength(content)) > 1800 ){  
	    	e.preventDefault(); 
	    	toastr.error("멀티는 최대 1800BYTE까지만 입력 가능합니다."); 
	    }
	}); 
	
	
	/* 닫기 */
	$('#ufReContentSMSCloseBtn').on('click', function(){
		$('#ufReContentSMSContent').attr("contenteditable",false);
		$(".pop_bg").css('display','none');
		$('#ufContentsRePopUp').css('display','none');
	});
	
	/*************************************************** 대체문자 지정  ***************************************************/
 
	
	


	
	
	/*************************************************** 메세지  버튼넣기추가하기  *****************************************************/ 
	
	/* 초기화 팝업시 */ 
	$('#ufPopBtnAddBtn').on('click', function(){
		$(".pop_bg").css('display','block');
		$('#ufMsgBtnPopUp').css('display','block');	
		
		$('#ufButtonTitle').text("친구톡버튼 (" + arrButtonF.length + " / 5 )");
		$('#ufPopBtnAddBtn').text("버튼 (" + arrButtonF.length + " / 5 )");
	});	

	/* 버튼 추가시 */
	$('#ufButtonAdd').on('click', function(){	

		var addButtonHtml = "";
		////console.log(p_seq);
		if(p_seq==5){
			toastr.error("버튼은 5개까지만 추가 가능합니다.");
			return false;
		}
		addButtonHtml = "<tr id='tr"+p_seq+"'><td>"+ optLinkTypeList(p_seq) +"</td><td id='c" + p_seq +"'></td><td></td><td><a onclick='javascript:removeButton(this," + p_seq +");' class='icon_delete'>삭제</a></td></tr>"
		$("#ufButtonTbody").append(addButtonHtml);
		arrButtonF.push(p_seq); 
		
		p_seq = p_seq+1; 

		/* 배열요소의 p_seq값만 저장해서 테이블정보를 불러옴 */

		
		$('#ufButtonTitle').text("친구톡버튼 (" + arrButtonF.length + " / 5 )");
		$('#ufPopBtnAddBtn').text("버튼 (" + arrButtonF.length + " / 5 )");
	});
	
	
   
	 

	/* 미리보기용  배열 
	ufArrSendNum 초기에 선택된 번호 
	ufArrRcvNum 리스트 된 번호
	*/
	var ufPreviewSendNum = "01056355959";
	var ufPreviewRcvNumArr = ["01012345678","01012345678","01012345678"];
	
	$('#ufPreviewBtn').on('click', function(){			
		$(".pop_bg").css('display','block');
		$('#ufPreviewPopUp').css('display','block');
		
		var ufT = $('#ufTitle').val(); 
		var ufC = $('#ufContent').html();		 
		
		$('#ufPreviewTitle1').html(ufT);
		$('#ufPreviewTitle2').html(ufT);
		$('#ufPreviewTitle3').html(ufT);
		var ufC1, ufC2, ufC3;
        if(ufC.indexOf("#[이름]") != -1 ){
        	ufC1 = ufC.replaceAll("#[이름]", arrUFLst[0].name);  //이름
        }
        if(ufC.indexOf("#[비고]") != -1 ){
        	ufC1 = ufC.replaceAll("#[비고]", arrUFLst[0].title);  //비고
        }         
		$('#ufPreviewContents1').html(ufC1);
		
        if(ufC.indexOf("#[이름]") != -1 ){
        	ufC2 = ufC.replaceAll("#[이름]", arrUFLst[1].name);  //이름
        }
        if(ufC.indexOf("#[비고]") != -1 ){
        	ufC2 = ufC.replaceAll("#[비고]", arrUFLst[1].title);  //비고
        }
		$('#ufPreviewContents2').html(ufC2);
		
        if(ufC.indexOf("#[이름]") != -1 ){
        	ufC3 = ufC.replaceAll("#[이름]", arrUFLst[2].name);  //이름
        }
        if(umC.indexOf("#[비고]") != -1 ){
        	ufC3 = ufC.replaceAll("#[비고]", arrUFLst[2].title);  //비고
        }
		$('#ufPreviewContents3').html(ufC3);
		
		$('#ufPreviewSendNum1').text(ufPreviewSendNum);
		$('#ufPreviewSendNum2').text(ufPreviewSendNum);
		$('#ufPreviewSendNum3').text(ufPreviewSendNum); 
		
		$('#ufPreviewRcvNum1').text(ufPreviewRcvNumArr[0]);
		$('#ufPreviewRcvNum2').text(ufPreviewRcvNumArr[1]);
		$('#ufPreviewRcvNum3').text(ufPreviewRcvNumArr[2]); 
	});
	 
	
	
	
	/* 전송하기 */
	$('#ufSendMsgBtn').on('click', function(){	

		var ufTitle = $('#ufTitle').val();
		var ufContent = $('#ufContent').text();
		var ufMmsinfo = "";//$('#ufContent').html();
		var ufContentCookie = getCookie("ufBeforeContent");
		

		/* 옵션  --  직전 동일내용 전송체크 메세지 */ 
		if( g_dupMessageUseFlag == "Y" ){
			
			if( ufContent ==  ufContentCookie ){
				var r = confirm("이전 내용과  동일한 메세지내용입니다. 전송하시겠습니까?");
				if (r == true) {
				} else {
					toastr.error("전송이 취소되었습니다");
					return false;
				}
			}
		}
 
		
		
		/**  최대 전송가능 갯수 체크  **/
		/*
			그룹별 totalcnt의 합 + 개인별 list 갯수
		*/
		/* 	var indivArr = arrUFPLst.filter(function(item){    
			  return item.isGroup === "N";
		});
		
		var grpArr = arrUFPLst.filter(function(item){    
			  return item.isGroup === "Y";
		});
		
		var grpArrCntList = grpArr.map(function(obj){ 				
			   var rObj = [];
			   if(obj.key == "totalcnt"){   rObj.push(obj.value);   }
			   return rObj;
		});
		
		var grpTotal = grpArrCntList.reduce(function(accumulator, currentValue, currentIndex, array) {
			  return accumulator + currentValue;
		}, 0);
			
		var total_cnt = indivArr.size() + grpTotal;		
		
		if( total_cnt > max_receive_cnt ){
    		toastr.error("최대  전송가능한 갯수는 " + max_receive_cnt + "개  입니다.");
			return false;
		} */
		/**  최대 전송가능 갯수 체크  **/		
		
		

		/* 옵션  --  080 수신거부 메세지 첨가 */
		if(sending_refusal_check == "Y"){
			ufContent += refusal_txt;
		} 
		 

		var ufTitleLen = getTextLength(ufTitle);		 
		var ufContentLen = getTextLength(ufContent);
		 
		
		if( ufTitleLen < 10 ) { 
     		toastr.error('제목을 입력하세요'); 
     		$('#ufTitle').focus();
     		return false;
		}
		 
		
		if( ufContentLen < 20 ) { 
     		toastr.error('내용을 입력하세요'); 
     		$('#ufContent').focus();
     		return false; 
		} 

		/*
		 옵션  -- 
		이미지만 보내기 가능
		*/
		if(mms_only_image == "Y"){
			
			if( ufContentLen == 0 ){
				/* continue */
			}
		}else{ 
		}
		

		if( !maxLengthCheck("ufTitle","제목",30) ){
			$('#ufTitle').focus();
			return false;
		} 


		if( !maxLengthCheck("ufContent","내용",1800) ){
			$('#ufContent').focus();
			return false;
		}
		      
		var checkMsgType = "3";  //친구톡
		

		
		/* 이미지 처리에 따르는  친구톡 msgType 구분    FileCnt 2 메세지 이미지 둘다 payCode */
		var checkMsgType = "3";  //PayCode FRT 텍스트만 FRI 이미지만 FIT 이미지 + 메세지   ( FileCnt = 2)
		var payCode = "FRT";
		var isImage = false;	
		isImage = Object.keys(ufImgFile).length; 
		 
		ufContent = $('#ufContent').text();   //umContent.replace("/<img(.*?)>/gi", "");  
		if( !isImage && Object.keys(ufContent).length ){ payCode = "FRT"; }//텍스트만
		if( isImage && !Object.keys(ufContent).length ){ payCode = "FRI"; }//이미지만
		if( isImage && Object.keys(ufContent).length ){ payCode = "FIT"; }//이미지만

		////console.log("-----isImage------" + Object.keys(ufImgFile).length + ": checkMsgType = " + checkMsgType);  
		
		
		/* 
		var isImage = false;
		
		if(contentLen > 90 ) checkMsgType = "1";  //LMS
		if(contentLen > 90 && isImage ) checkMsgType = "2"; //MMS 
		*/
		
		
	 	//check snd_number  부서원소속 사무실, 사용자핸드폰, 직접입력
	 	var sendPhoneType = $('input:radio[name=uf_send_num]:checked').val(); 
	 	//var sendPhone = $('input:text[name=umSendNum]').val(); 
	 	var sendPhone = $('input[name=ufSendNum]').val();
	 	//alert("sendPhoneType: " + sendPhoneType + ": phone " + sendPhone + ": phone x " + sendP );

		var sendPhoneLen = getTextLength(sendPhone);
		if( sendPhoneLen < 8 ) { 
     		toastr.error('발신번호를 입력하세요'); 
     		$('input[name=ufSendNum]').focus();
     		return false;
		}		
		
		
		
		//수동입력체크
		var manualbtnftalkInput = $('#phonelistftalk').val();  
		
		if(manualbtnftalkInput.length > 0) {
     		toastr.error('수동입력창에 자료가 남아 있습니다'); 
     		$('#phonelistftalk').focus();
			return false;
		}
		

		/*********예약발송시 시간********************/
	 	var currentDate = getTimeStamp(); 
	 	var startDate = new Date();
	 	//즉시 에약 테스트
	 	var sendTimeValue = $('input:radio[name=ufSendTime]:checked').val(); 
	 	//alert(sendTimeValue);  //on
	 	//즉시 현재시각  , 예약 예약시각 ,  테스트 즉시
	 	if( sendTimeValue == "1"){
	 		//alert("예약");
	 		var iDate = $('#ufDataPicker').val();
	 		var iTime = $('#ufTimePicker').val();
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

 		if( sendTimeValue == "2" && isEmpty($("#ufTestInput").val())){
 			toastr.error("테스트수신번호를 입력해주세요");
 			return;
 		}
		/*********예약발송시 시간********************/
	 	

		var ufJobOpt = $('#ufJobOpt option:selected').val();  //$('select[name=ufJobOpt]').val(); 
		if( ufJobOpt == "0" ){
			toastr.error("업무분류를 선택하세요");
			return false;
		}
	 	
	 	$('.wrap-loading').removeClass('display-none');   
	 	
 		var param;
	 	
 		
 		
 		
 		/* 테스트발송일때 한개만 발송 */
	 	if( sendTimeValue != "2"){
	 		param = tableToJsonFTALK(document.getElementById("tblsendftalk"), checkMsgType, startDate, ufTitle, ufContent, ufMmsinfo, sendPhone, ufJobOpt, ufImgFile, payCode); // table id를 던지고 함수를 실행한다.
	    }else{
	 		param = tableToJsonFTALKTest($("#ufTestInput").val(), checkMsgType, startDate, ufTitle, ufContent, ufMmsinfo, sendPhone, ufJobOpt, ufImgFile, payCode); // table id를 던지고 함수를 실행한다.
	         
	 	}  

		if( !Object.keys(param).length ){
			toastr.error("수신자목록을 입력하세요");
			return false;
		}  
		//////console.log("===== param ======" + param);
		
        var obj = JSON.stringify(param); 
        
        //////console.log(param.btnList);
		//////console.log(obj);

        
		
		/* 주소록 개별문자 입력 */
		/* 엑셀불러오기에서 컬럼명을 가져온다 */
		/* 주소록불러오기에서 head명을 가져온다 */
		/* 컬럼내용을 자동으로 입력한다 */
		
		if( $("input:checkbox[name='checkVars']").is(":checked")  ){			
		}
		
		/* 광고 옵션 */
		if( $("input:checkbox[name='checkAD']").is(":checked")  ){
			ufContent = "[광고]" + ufContent;
		}	
		
		
		/* 대체 문자 */
		
        //$('#result').text(obj);  
		$('#ufSendMsgBtn').attr('disabled', true);	 
		
		//loading
		$('.loading_bar').show(0).delay(3000).hide(0);

    	$.ajax({
        	url: "/sendSMS.do",
        	type: "POST",
            dataType: "json",          // ajax 통신으로 받는 타입
            contentType: "application/json",  // ajax 통신으로 보내는 타입
            data: obj,
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
        		$('#ufSendMsgBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#ufSendMsgBtn').attr('disabled', false);
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
        		
        		//clear
        		if(jsondata['result_msg'] == "ok"){
        			$("#tblsendftalk tbody").empty(); 
            		$('#ufTitle').val(""); 
            		$('#ufContent').empty();  
            		$('#ufTotalCnt').text("");
            		$('#ufPrice').text("");
            		
            		ufImgFile = {};
            		
            		/* 배열 데이타 처리  */
            		arrUFLst = [];
            		
                    /* CLEAR */
                    /* 입력버튼 처리 */ 
            		$('#ufPopExcelBtn').removeClass("background-efefef");
            		$('#ufPopExcelBtn').removeClass("disable"); 
            		$('#ufPopGrpLstBtn').removeClass("background-efefef");
            		$('#ufPopGrpLstBtn').removeClass("disable");
            		$('#ufManualInputBtn').removeClass("background-efefef");
            		$('#ufManualInputBtn').removeClass("disable");
        		}
        		
				/* 버튼 Clear */
				arrButtonF = [];
				arrButtonJSON = "";
        		$("#ufButtonTbody").empty();
        		$('#ufPopBtnAddBtn').text("버튼 ( 0 / 5 )");
        		$('#ufButtonTitle').text("친구톡버튼 ( 0 / 5 )");
        		
        		//$('#result').text("전송시간:" + res); 
        		////console.log("전송시간:" + res);
                toastr.success('성공적으로 전정되었습니다');       		
        		
                
                   /* $(".pop_templet").css('display','none'); */
                   
        		/* 		바로 직전 콘텐츠 저장    		*/ 
                setCookie("ufBeforeContent",ufContent);

                $('.wrap-loading').addClass('display-none');
        		$('#ufSendMsgBtn').attr('disabled', false);
        		//close popup
        		
        		 var srvcNm = '전송 >> 친구톡';
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
        		$('#ufSendMsgBtn').attr('disabled', false);
                $('.wrap-loading').addClass('display-none');
        	}
   		});
	}); 
	
	

	/* 최근 전송 5건 */	
	PopupRecentLst("#ufRecentLstBtn","#ufRecentLst","#ufPopRecentLayer",arrUFRecentLst);
	
	// clear
	ufImgFile = {};
	
});
/* document.ready */


function tableToJsonFTALKTest(table, type, startDate, title, content, mmsinfo, senderNum, jobOpt, imgFileName, payCode) { 
	    
	    
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

		var img = imgFileName.string;
		if(img !== undefined){  		
			var ext = img.slice(img.lastIndexOf(".") + 1).toLowerCase();
			if(ext =="jpg" || ext == "png" || ext == "gif") ext = "IMG";
			
			tempData["imgFileName"] = img; 
			tempData["fileType"] = ext;
		}else{
			tempData["imgFileName"] = ""; 
			tempData["fileType"] = "";
		}
		
		/* 친구톡 */ 
		tempData["reContents"] = "";
		
		/* 친구톡 알림톡 */
		tempData["btnList"] = "";
		
		/* 알림톡 변수 5개 리스트 */
		tempData["tmpVars"] = "";

		/* 친구톡 FRI FRT FIT */
		tempData["payCode"] = payCode;
		

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

function tableToJsonFTALK(table, type, startDate, title, content, mmsinfo, senderNum, jobOpt, imgFileName, payCode) { 
	
	/*
	* 버튼 스트링 처리
	*/ 
	//console.log("---buttons---" + arrButtonJSON);
	//return;
	
	/* 
	* RF_049_01 수신자  건수 제한
	*
	*/
	if( arrUFLst.length > max_receive_cnt ){
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

		var img = imgFileName.string;
		if(img !== undefined){  		
			var ext = img.slice(img.lastIndexOf(".") + 1).toLowerCase();
			if(ext =="jpg" || ext == "png" || ext == "gif") ext = "IMG";
			
			tempData["imgFileName"] = img; 
			tempData["fileType"] = ext;
		}else{
			tempData["imgFileName"] = ""; 
			tempData["fileType"] = "";
		}
		
		
		/* 친구톡 */  
 		var reContent = "";
 		var reType = ""; //4다문 6장문멀티
 		
 		if( arrUFReContent.length > 0 ){
 			arrUFReContent.forEach(function(element){ 
	    		reContent = element.content; 
	    		reType = element.type;
			});  
 		}
 		
 		var reTypeInt = 4;
 		if(reType==="SMS"){
 			reTypeInt = 4;
 		}else{
 			reTypeInt = 6;
 		}
 		//console.log("=======대체문자======" + reContent + ":" + reType);
		tempData["reContents"] = reContent;
		tempData["reType"] = reTypeInt; 
		 
		
		/* 친구톡 알림톡 */
		tempData["btnList"] = arrButtonJSON;
		
		/* 알림톡 변수 5개 리스트 */
		tempData["tmpVars"] = "";

		
		/* 친구톡 FRI FRT FIT */
		tempData["payCode"] = payCode;

		var payCode = "FRT";
		
		if(payCode === "FRT") typeName = "FRT";
		if(payCode === "FIT" || payCode === "FRI") typeName = "FRI";
		
		tempData["price"] = getPriceByCode(typeName);
		
		 
		var row = [];
		var rowG = []; 
		for ( var r = 0; r < arrUFLst.length; r++ ){ 
			
			
	        var rowData = {};   
			var isGroup = "N";
			isGroup = arrUFLst[r].isGroup;
	        rowData["isgroup"] = arrUFLst[r].isGroup; //비고란 
	        
	        if(isGroup == "Y"){ 
	        	
	            rowData["column1"] = arrUFLst[r].name; //이름
	            rowData["rcv_number"] = arrUFLst[r].phone; //수신번호
	            rowData["rcv_etc"] = ""; //비고란

	            rowData["grp_category"] = arrUFLst[r].code; //비고란 
	            rowData["grp_name"] = arrUFLst[r].name; //비고란
	            rowData["grp_type"] = arrUFLst[r].type; //비고란 
	            rowData["grp_cnt"] = Number(arrUFLst[r].phone); //비고란
	        	rowG.push(rowData); 
	            
	        }else{

	            rowData["column1"] = arrUFLst[r].name; //이름
	            rowData["rcv_number"] = arrUFLst[r].phone; //수신번호
	            rowData["rcv_etc"] = ""; //비고란
	            rowData["grp_name"] = ""; //비고란
	            rowData["grp_category"] = ""; //비고란 
	            rowData["grp_type"] = ""; //비고란 
	            rowData["grp_cnt"] = 0; //비고란
		    	row.push(rowData); 
	            
	        }
	         
	         
			arrUFRecentLst.push({
				isGroup : "N", 
				title : rowData["column1"],  
				code : null,     
				phone : rowData["rcv_number"],
				name : rowData["column1"]
			});
	    	
	    	if(arrUFRecentLst.length > 5){
	    		arrUFRecentLst[arrUFRecentLst.length - 1]
	    		arrUFRecentLst.pop();
	    	}
		}  
	    
	    
		tempData["group"] = rowG.slice();  /* 전체내용넣기 */
		tempData["data"] =  row.slice();  /* 전체내용넣기 */

	    var totalPrice = Number(tempData["data"].length) * Number(tempData["price"]); 
	    var uCashChk = usrCashCheck(payCode, totalPrice);
	    
	    if(uCashChk < 0){
			toastr.error("캐쉬 잔액이 부족합니다");
	    	return false;
	    }	 
	    
	 	return tempData;
	    
}

/************************** 메세지 버튼처리 **********************************/ 
function registerButton() {
	
	/* 리셋  */
	$("#ufContent").find("a").remove();
	////console.log("-------register---" + JSON.stringify(arrButtonF));
 
	//console.log(arrButtonF);
	console.log($("#ufButtonTbody").html());
	
	for(var i in arrButtonF){ 
		var p_seq = arrButtonF[i]; 
		var bType = $("#link_type" + p_seq + " option:selected ").val();
		var tName = "";
		var url_mo = "";
		var url_pc = ""; 
		var buttons = {};
		/*
		4 배송조회
		3 웹링크
		2 앱링크
		1 메세지전달
		0 봇키워드
		*/ 
		
		//content에 button추가하기
		/* MMS_CONTENTS_INFO sql에 넣을 데이타 */
		if(bType === "4"){ 
			tName ="배송 조회하기";buttons = {"name": "배송 조회하기", "type" : "DS"  };
		} /* 배송조회 */ 
		if(bType === "3"){ 
			tName = $("#link_name_al").val(); 
			link_andr = $("#link_andr").val();
			link_ios = $("#link_ios").val();
			buttons = {"name": tName, "type" : "AL", "link_andr": link_andr, "link_ios": link_ios }; /* 앱링크 */ 
		} 
		if(bType === "2"){ 
			tName = $("#link_name_wl").val(); 
			url_mo = $("#link_mo").val();
			url_pc = $("#link_pc").val();
			buttons = {"name": tName, "type" : "WL", "url_mobile": url_mo, "url_pc": url_pc }; /* 웹링크 */ 
		}   
		if(bType === "1"){ 
			tName = $("#link_name_md").val(); buttons = {"name": tName, "type" : "MD" };} /* 메세지버튼 */ 
		if(bType === "0"){ 
			tName = $("#link_name_bk").val(); buttons = {"name": tName, "type" : "BK" };} /* 봇키워드 */

		//console.log(buttons);
		//console.log("==== count =====" + i);
		if(i=="0"){
			arrButtonJSON += JSON.stringify(buttons);
		}else{
			arrButtonJSON += "," + JSON.stringify(buttons);
		}
		//console.log(arrButtonJSON);
		$("#ufContent").append("<a id='b" + p_seq +"' class=\"width-100 height-50px line-height-50px text-center margin-top-5 border-radius-5 background-efefef font-14px font-053c72\">" + tName + "</a>");
	}

	$('.pop_bg').css("display","none");
	$('#ufMsgBtnPopUp').css("display","none");
	////console.log("==== arrButtonJSON =====" + arrButtonJSON);
}

function removeButton(el,seq) {
		/* data 제거 */
		const idx = arrButtonF.indexOf(seq);
		arrButtonF.splice(idx,1);
	
		$(el).parents("tr").remove();
		p_seq = p_seq-1;
		//console.log(p_seq);
		$('#ufButtonTitle').text("친구톡버튼 (" + arrButtonF.length + " / 5 )");
		$('#ufPopBtnAddBtn').text("버튼 (" + arrButtonF.length + " / 5 )");
}
function chgBtntype(p_seq) {
	var btn_name = "";
	var buttonsHtml = "";
	var s_index = $("select[name=link_type"+p_seq).val();
	
	$("td[id=c"+p_seq+"]").html(arrTypeHtml[s_index]); 
}

function optLinkTypeList(p_seq) {
	var optLinkTypeList = "<select class='select_white_small width-130px' style='background-color:#f9fbfd;' id='link_type"+p_seq+"' name='link_type"+p_seq+"' onchange='javascript:chgBtntype("+p_seq+");'><option value=''>=선택=</option><option value='4'>배송조회</option><option value='2'>웹링크</option><option value='3'>앱링크</option><option value='0'>봇키워드</option><option value='1'>메시지전달</option></select>";
	var repOptLinkTypeList = optLinkTypeList.replace(/\*\*TEMPSEQ\*\*/g, p_seq);
	repOptLinkTypeList = repOptLinkTypeList.replace(/\*\*BTNSEQ\*\*/g, p_seq);
	return repOptLinkTypeList;
}
/************************** 메세지 버튼처리 **********************************/ 


</script>

<style>
#ufContent {
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
<input type="radio"  name="sendM_tabmenu" id="tabmenu-2"  value="F">
							<label for="tabmenu-2">친구톡</label>
							<div class="tabCon">
								<ul class="width-100 margin-bottom-100">
									<li class="float-left  width-350px margin-right-30">
										<div class="width-350px height-620px border-radius-5 background-f7fafc padding-20 border-box">
											<textarea type="text" name="ufTitle" id="ufTitle" placeholder="제목 (최대 30Byte)" class="width-100 height-50 border-e8e8e8 background-transparent font-16px padding-left-20 padding-right-20 border-box row-1 margin-bottom-5"></textarea>
											<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 50px;">
												<!-- 
												<textarea type="text" name="ufContent" id="ufContent" placeholder="내용 (텍스트 최대 1000자 or 이미지+텍스트 400자)" class="width-100 height-100 background-transparent font-16px line-height-default" style="overflow-y: auto;"></textarea>
												 -->
								<div id="ufContent" contentEditable="true"></div>
												<a id="ufPopImgUploadBtn"  class="icon_photo width-30px height-30px background-8bc5ff border-radius-40 absolute position-bottom-10px position-left-10px open_pop_imgupload"></a>
												<a id="ufPopBtnAddBtn" class="open_pop_button width-160px height-30px line-height-30px text-center border-radius-5 border-8bc5ff font-174962 font-14px border-box absolute position-bottom-10px position-text-center">버튼추가(0/5)</a>
												<a id="ufContentClearBtn" class="icon_trash width-30px height-30px background-8bc5ff border-radius-40 absolute position-bottom-10px position-right-10px"></a>
											</div>
											<ul class="margin-bottom-20">
												<li class="float-left width-50 padding-right-5 border-box"><a id="ufPopMyBox" class=" width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">내 저장함</a></li>
												<li class="float-left width-50 padding-left-5 border-box"><a id="ufMyBoxSave" class="width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">저장하기</a></li>
											</ul>
											<ul>
											
								<li class="width-100"> 
									<ul class="width-100 height-70px">
										<li class="float-left width-80px height-70px">
											<span class="inline-block width-80px height-40px margin-top-40 text-left font-16px font-4d4f5c">발신번호</span>
										</li>
										
										<!--***옵션:직접선택일 경우-->
										<li id="ufSendNumDirect" class="float-right width-230px height-70px padding-top-5"> 
											<div class="radio-box_s font-14px font-053c72 margin-right-10">
												<div class="radio_s">
													<input type="radio" id="ufOfficeNum" name="uf_send_num" value="1"  />
													<label for="ufOfficeNum"><span></span></label>
												</div> 사무실
											</div>
											<div class="radio-box_s font-14px font-053c72 margin-right-10">
												<div class="radio_s">
													<input type="radio" id="ufPhoneNum" name="uf_send_num" value="2" checked />
													<label for="ufPhoneNum"><span></span></label>
												</div> 핸드폰
											</div>						
											<div class="radio-box_s font-14px font-053c72 ">
												<div class="radio_s">
													<input type="radio" id="ufDirectNum" name="uf_send_num" value="3" />
													<label for="ufDirectNum"><span></span></label>
												</div> 직접입력
											</div>				
											<input name="ufSendNum" id="ufSendNum" type="text" maxlength="12" value="" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'  class="width-230px background-transparent font-14px height-40px line-height-40px border-e8e8e8 border-radius-5 padding-left-10 margin-top-10"  />
										</li>
										<!--//***옵션:직접선택일 경우-->
										
										<!--***옵션:등록번호콤보표시일 경우-->
										<li id="ufSendNumCombo" class="float-right width-230px height-70px padding-top-5">	 
											<!--***옵션:등록번호표시일 경우-->
											<select id="ufSendNum" class="select_blank_lightblue width-230px float-right" style="margin-top:10px;">
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
														
														<div id="phonelistftalk" name="phonelistftalk"  contentEditable="true"  onkeydown='return onlyNumberEnter(event)' onkeyup='removeCharEnter(event, this)' placeholder="전화번호를 직접 입력하거나 메모장, 엑셀을 붙여넣기 한 후에 우측의 입력버튼을 눌러주세요. 두 개 이상의 전화번호는 꼭 엔터키로 구분해주세요."  class="width-100 height-70px background-transparent font-14px line-height-default"  style="overflow:scroll;overflow-x:hidden;overflow-y:hidden;" ></div>														
													
													<!-- 	<textarea onkeydown='return onlyNumberEnter(event)' onkeyup='removeCharEnter(event)' type="text" id="phonelistftalk" placeholder="전화번호를 직접 입력하거나 메모장, 엑셀을 붙여넣기 한 후에 우측의 입력버튼을 눌러주세요. 두 개 이상의 전화번호는 꼭 엔터키로 구분해주세요." class="width-100 height-70px background-transparent font-14px line-height-default"/></textarea>
													 -->
													</div>
													<ul class="float-left width-160px height-90px margin-left-10">
														<li class="width-100 margin-bottom-5"><a id="ufPopGrpLstBtn" class=" width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-16px font-053c72">주소록 불러오기</a></li>
														<li class="width-100"><a id="ufPopExcelBtn" class=" width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-16px font-053c72">엑셀 불러오기</a></li>
													</ul>
													<a id="ufManualInputBtn" class="float-right width-100px height-90px line-height-90px font-16px background-8bc5ff font-053c72 text-center border-radius-5">입력</a>
													<div class="clear margin-bottom-20"></div>


													<h3 class="font-18px font-174962 margin-bottom-10">수신자 목록 <span class="font-bold"  id="ufRcvCnt"></span></h3>
													<div class="height-210px border-box scroll-y">
														<table  id="tblsendftalk" class="con_tb width-100" cellpadding="0" cellspacing="0" border="0">
															<thead>
																<tr>
																	<th class="width-20">이름</th>
																	<th class="width-20">전화번호</th>
																	<th class="width-20">비고</th>
																	<th class="width-20">관리</th>
																</tr>
															</thead>
															<tbody></tbody>
														</table>
													</div>

													<div class="width-100 margin-top-10 padding-left-10 border-box">
														<!-- <div class="checkbox-small_2">
															<input type="checkbox" id="check_all" name="checkVars" />
															<label for="check_all"></label>
														</div> -->
														<span class="inline-block margin-left-5 margin-right-5 font-12px font-aaa">주소록 개별문자 </span>
														<select id="ufContentsChangeOpt" class="select_white_small width-120px">
															<option value="이름" selected>이름</option>
															<option value="비고">비고</option>
														</select>
														<a id="ufContentsChangeBtn" class="width-55px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">입력</a>
														
														<c:if test="${workSeqRequiredFlag != 'ND'}" >
														<span class="inline-block margin-left-20 margin-right-5 font-12px font-aaa">업무분류</span>
														<select id="ufJobOpt" name="ufJobOpt" class="select_white_small width-120px">
												
														</select>
														</c:if>
														<span id="ufCost" class="float-right inline-block margin-top-5 margin-right-10 font-14px font-aaa font-bold font-053c72"><span class="inline-block margin-right-10 font-12px font-aaa font-normal">예상비용</span><span id="ufPrice"></span></span>
													</div>
													<div class="clear margin-bottom-15"></div>
													<div class="float-left width-430px padding-left-10 border-box margin-bottom-15 background-f9fbfd">
														<span class="inline-block margin-left-10 margin-right-5 font-12px font-aaa checkbox-small "> 
																<div class="checkbox-small">
																<input type="checkbox" id="ufReContentCheck" name="ufReContents" />
																<label for="ufReContentCheck"></label>
																<span class="font-16px font-053c72 margin-left-5">친구톡 실패시</span>
																</div><a id="ufContentsRePopUpBtn" class="width-80px height-24px line-height-24px text-center border-radius-5 background-efefef font-12px font-fff box-shadow-smallest margin-left-10">대체문자</a>
														 
														</span>
														<span class="inline-block margin-left-20 margin-right-5 font-12px font-aaa checkbox-small ">
														<div class="checkbox-small" style="display:block; margin-bottom:10px;">
																<input type="checkbox" checked id="check_ad" name="checkAD" />
																<label for="check_ad"></label>
																<span class="font-16px font-053c72 margin-left-5">광고포함</span>
														</div>
														</span>
													</div>
													<div class="relative float-left width-650px height-110px border-box border-radius-5 margin-bottom-10 hidden box-shadow-smallest background-f9fbfd">
														<ul class="absolute position-left position-vertical-center">
															<li class="relative width-100 height-30px margin-bottom-5 padding-left-10">
																<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
																	<div class="radio_s">
																		<input type="radio" id="prompt" name="ufSendTime" value="0" checked/>
																		<label for="prompt"><span></span></label>
																	</div> 즉시발송
																</div>
															</li>
															<li class="relative width-100 height-30px margin-bottom-5 padding-left-10">
																<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
																	<div class="radio_s">
																		<input type="radio" id="book" name="ufSendTime" value="1" />
																		<label for="book"><span></span></label>
																	</div> 예약발송
																</div>
																<!--예약발송 달력박스 -->

																
												<!--예약발송 달력박스 -->
												<div class="absolute position-vertical-center width-330px" style="left:100px; _display:none;">  
													<div class="inline-block relative width-140px height-30px line-height-30px text-right  border-radius-5 border-8bc5ff border-box margin-right-5">
 	
										<input type="date" id="ufDataPicker" name="ufDataPicker"	value="" 
													class="text-right font-174962 font-14px padding-0 margin-0 height-30px line-height-30px background-transparent" />
													</div>
													<div class="inline-block relative width-140px height-30px line-height-30px text-right  border-radius-5 border-8bc5ff border-box margin-right-5">
 	
										<input type="time" id="ufTimePicker" name="ufTimePicker" value=""
													class="text-right font-174962 font-14px padding-0 margin-0 height-30px line-height-30px background-transparent" />

													</div>
												</div>

														
															</li>
															<li class="relative width-100 height-30px padding-left-10">
																<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
																	<div class="radio_s">
																		<input type="radio" id="test" name="ufSendTime" value="2" />
																		<label for="test"><span></span></label>
																	</div> 테스트발송
																</div>
																<!--테스트발송 체크시 입력박스-->
																<div class="absolute position-vertical-center width-330px none test_sand" id="frd_test_send" style="left:115px;"> 
																	<select class="select_blank_lightblue_small width-140px" style="margin-right:5px;">
																		<option>선택해주세요</option>
																		<option>친구톡</option>
																		<option>대체문자</option>
																		<option>친구톡+대체문자</option>
																	</select>

																	<input type="text" id="ufTestInput" name="ufTestInput" placeholder="" class="width-160px height-30px line-height-30px border-e8e8e8 background-fff border-box border-radius-5 font-14px line-height-default" />


																</div>
															</li>
														</ul>
													</div>
													<ul class="float-right width-230px height-120px">
														<li   class="width-100 margin-bottom-10"><a  id="ufPreviewBtn" class="width-100 height-50px line-height-50px text-center border-radius-5 background-efefef font-20px font-bold font-053c72">미리보기</a></li>
														<li id="ufSendMsgBtn" class="width-100"><a class="width-100 height-50px line-height-50px text-center  border-radius-5 background-8bc5ff font-20px font-bold  font-053c72"><span id="ufTotalCnt"></span>전송하기</a></li>
													</ul>
													<div class="clear"></div>
												</li>
											</ul>
										</div>
									</li>
								</ul>
							</div>

 
 	 <!-- popup 이미지 업로드 -->
         <div class="pop_wrap ufPopImgUpload width-600px padding-20 border-radius-5 background-f7fafc">
            <div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">이미지 업로드</div>
            
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
<!-- 
		 	<form id="uploadForm" enctype="multipart/form-data" method="POST" action="/msg/imgFileupload.do"> 
		 	<label for="file1">파일 첫 번째</label> 
		 	<div><input type="file" id="file1" name="file" required="required" /></div> 
		 	<label for="file2">파일 두 번째</label> 
		 	<div><input type="file" id="file2" name="file" required="required" /></div> 
		 	</form>
 --> 	
		 	
		 	
		 	<form id="ufForm" enctype="multipart/form-data" method="POST" action="/msg/imgFileupload.do"> 
				<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-50">
					이미지선택
					<input id="uf_img_name" class="upload-name" value="" disabled="disabled" placeholder="제목 (최대 30Byte)" />
					<label for="uf_img_file">찾아보기</label> 
					<input type="file" id="uf_img_file" name="uf_img_file" required="required"  />		
				</div> 
        	</form>
			
				<!-- <div id="thumbnailUrl"></div> -->
				<ul class="pop_notice">
					<li>확장자는 jpg만 가능합니다.</li>
					<li>오리지널 사진 업로드를 체크해제하면 700 * 700  기준으로 사이즈가 자동조절됩니다.</li>
					<li>파일크기 100Kbyte 이상의 사진은 등록할 수 없습니다.</li>
					<li>
						오지리널 사진 업로드
						<span>
							<div class="checkbox">
									<input type="checkbox" id="uf_img_resize_check" name="체크" />
									<label for="uf_img_resize_check"></label>
							</div> 체크하면 오리지널 이미지 파일이 올라갑니다.</span>
					</li>
				</ul>
			</div>
			
			<!--버튼-->
			<div class="pop_btn-big">
				<a id="ufImgRegBtn" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>
 
 
		
 		<!-- popup 엑셀 -->		
		<div id="ftalk_pop_excel" class="pop_wrap width-730px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">친구톡 엑셀 등록하기</div>
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
			  
			  	<form id="umFrmModal" action=/msg/excelFileupload.do" method="post" enctype="multipart/form-data">
			  	<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-90">
					엑셀파일 찾기
					<input class="upload-name" value="" disabled="disabled" placeholder="파일명" />
					<label for="ufInputImgFile">찾아보기</label> 
					<input type="file" id="ufInputImgFile" class="upload-hidden" /> 
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
				<a id="ufPopExcelRegBtn" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>


 		<!-- popup 주소록 -->
        <div id="ftalk_pop_group" class="pop_wrap width-730px" style="background:transparent;">
			<div class="width-100">
				<ul class="pop_tabmenu_excel_ftalk">
					<li id="pop_tab_2" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_excel_ftalk" id="pop_tabmenu_excel_ftalk_2">
						<label for="pop_tabmenu_excel_ftalk_2">친구톡 주소록 불러오기</label>
						<div class="pop_tabCon">
							<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000 padding-20">
							<table cellpadding="0" cellspacing="0" border="0" class="width-100 height-210px margin-auto">
								<tr>
									<td class="width-330px height-240px vertical-top">
										<h5 class="font-18px font-normal font-174962 text-left">주소록보기</h2>
										
										<ul class="tabmenu_small_ftalk"> 
											
											<li id="small_tab_1" class="btnCon">
												<input type="radio" checked name="tabmenu_small_ftalk" id="tabmenu_small_ftalk_1" value="0">
												<label for="tabmenu_small_ftalk_1">개인</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="uf_pop_my_group_list ftalk_send_my width-100 li-h30">
														 
														</ul>
													</div>
												</div>
											</li>
											
											<li id="small_tab_2" class="btnCon ufPartTab">
												<input type="radio" name="tabmenu_small_ftalk" value="1" id="tabmenu_small_ftalk_2">
												<label for="tabmenu_small_ftalk_2" id="ufPartTab"></label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="uf_pop_part_group_list  width-100 li-h30">
														</ul>
													</div>
												</div>
											</li>											
											<li id="small_tab_3" class="btnCon ufEmployTab">
												<input type="radio" name="tabmenu_small_ftalk" value="3" id="tabmenu_small_ftalk_3">
												<label for="tabmenu_small_ftalk_3">직원</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scrol-y font-12px">
														<ul class="uf_pop_employ_group_list  width-100 li-h30">
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_4" class="btnCon ufShareTab">
												<input type="radio" name="tabmenu_small_ftalk"  value="2" id="tabmenu_small_ftalk_4">
												<label for="tabmenu_small_ftalk_4" id="ufShareTab"></label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="uf_pop_share_group_list width-100 li-h30">
														</ul>
													</div>
												</div>
											</li> 
										</ul>
										
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="ufGrpPrvBtn icon_group">그룹</a>
									</td>
									<td rowspan="2" class="vertical-top width-230px">
										<h5 class="font-18px font-normal font-174962 text-left">연락 받을 사람<a class="width-55px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest float-right">최근</a></h2>
										 
<div id="ufPopRecentLayer">
<ul id="ufRecentLst"></ul>
</div>
<!-- //폼 레이어  -->
										<div class="width-230px height-480px hidden scroll-y font-12px border-radius-5 border-e8e8e8" style="height:485px;">
											<ul class="uf_pop_receiver width-100 li-h30">
											
											</ul>
										</div>
									</td>
								</tr>
								<tr>
									<td class="width-330px height-240px vertical-top ">
										<h5 class="font-18px font-normal font-174962 text-left">선택그룹 상세보기</h2>
										<div class="width-330px height-210px hidden scroll-y font-12px border-radius-5 border-e8e8e8">
											<ul class="uf_pop_detail_list width-100 li-h30">
											
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
										<a class="ufIndivPrvBtn icon_each">개별</a>
									</td>
								</tr>
							</table>
							<div class="margin-top-5 text-right">
								<a id="ufPopDelSelect" class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest ">선택삭제</a>
								<a id="ufPopDelAll" class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">전체삭제</a>
							</div>
							</div>
							<!--버튼-->
							<div class="pop_btn-big margin-auto text-center margin-bottom-10">
								<a id="ufPopRegisterBtn" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
								<a id="ufPopCancelBtn" class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>




		 <!-- popup 대체문자 -->
         <div id="ufContentsRePopUp" class="pop_wrap width-540px" style="background:transparent;">
			<div class="width-100">
				<ul class="pop_tabmenu_uf_contens_re">
					<li id="pop_tab01" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_uf_contens_re" id="pop_tabmenu01" value="SMS">
						<label for="pop_tabmenu01">단문</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 id="ufReContentSMSTitle" class="font-18px font-bold font-174962 text-center background-8bc5ff padding-10 "></h2>
									<div id="ufReContentSMSContent" class="word-break-break-all width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"></div>
								</div>
							</div>							
							<!--버튼-->
							<div class="pop_btn-big">
							    <a OnClick="ReContentEditMode('ufReContentSMSContent','ufReContentSMSRegBtn')"  class="margin-right-30 font-053c72 font-bold width-100px background-8bc5ff box-shadow">편집하기</a>
								<a id="ufReContentSMSRegBtn" OnClick="ReContentRegister('ufReContentSMSContent','ufReContentSMSRegBtn','SMS','UF');" class="margin-right-30 font-053c72 font-bold width-200px background-8bc5ff box-shadow">대체문자로 지정</a>
								<a id="ufReContentSMSCloseBtn" class="background-efefef width-70px font-053c72 font-normal">닫기</a>
							</div>
						</div>
					</li>
					<li id="pop_tab02" class="btnCon">
						<input type="radio" name="pop_tabmenu_uf_contens_re" id="pop_tabmenu02" value="LMS">
						<label for="pop_tabmenu02">장문</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 id="ufReContentLMSTitle" class="font-18px font-bold font-174962 text-center background-8bc5ff padding-10"></h2>
									<div id="ufReContentLMSContent" class="word-break-break-all width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"></div>
								</div>
							</div>							
							<!--버튼-->
							<div class="pop_btn-big">
								<a OnClick="ReContentEditMode('ufReContentLMSContent','ufReContentLMSRegBtn');" class="margin-right-30 font-053c72 font-bold width-100px background-8bc5ff box-shadow">편집하기</a>
								<a id="ufReContentLMSRegBtn"  OnClick="ReContentRegister('ufReContentLMSContent','ufReContentLMSRegBtn','LMS','UF')" class="margin-right-30 font-053c72 font-bold width-200px background-8bc5ff box-shadow">대체문자로 지정</a>
								<a class="pop_close background-efefef width-70px font-053c72 font-normal">닫기</a>
							</div>
						</div>
					</li>
					<li id="pop_tab03" class="btnCon">
						<input type="radio" name="pop_tabmenu_uf_contens_re" id="pop_tabmenu03" value="MMS">
						<label for="pop_tabmenu03">멀티</label>
						<div class="pop_tabCon">
							<div class="flex width-100 padding-right-15 border-box">
								<div class="width-100">
									<h5 id="ufReContentMMSTitle" class="font-18px font-bold font-174962 text-center background-8bc5ff  padding-10"></h2>									
									<div id="ufReContentMMSContent" class="word-break-break-all width-100 height-340px font-4d4f5c font-16px text-left border-e8e8e8 border-radius-5 background-transparent padding-10 line-height-default"></div>
								</div>
							</div>							
							<!--버튼-->
							<div class="pop_btn-big">
								<a OnClick="ReContentEditMode('ufReContentMMSContent','ufReContentMMSRegBtn');" class="margin-right-30 font-053c72 font-bold width-100px background-8bc5ff box-shadow">편집하기</a>
								<a id="ufReContentMMSRegBtn"  OnClick="ReContentRegister('ufReContentMMSContent','ufReContentMMSRegBtn','MMS','UF')"  class="margin-right-30 font-053c72 font-bold width-200px background-8bc5ff box-shadow">대체문자로 지정</a>
								<a class="pop_close background-efefef width-70px font-053c72 font-normal">닫기</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>


 		  
        <!-- popup 미리보기 -->
         <div id="ufPreviewPopUp" class="pop_wrap width-800px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">미리보기</div>
				<!--내용-->
				<div class="flex-between margin-top-20">
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="ufPreviewTitle1"></h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="ufPreviewContents1"  contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="ufPreviewRcvNum1">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="ufPreviewRcvNum1">01087654387</span>
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="ufPreviewTitle2">내용 (최대 30Byte)</h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="ufPreviewContents2"   contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="ufPreviewRcvNum2">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="ufPreviewSendNum2">01087654387</span>
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="ufPreviewTitle3">테스트</h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="ufPreviewContents3"   contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="ufPreviewRcvNum3">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="ufPreviewSendNum3">01087654387</span>
							</div>
						</div>
					</div>		
				</div>
				<!--버튼-->
				<div class="margin-auto text-center margin-top-30 margin-bottom-10">
					<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
				</div>
        </div>

    


		 <!-- popup 버튼추가 -->
         <div id="ufMsgBtnPopUp" class="pop_wrap width-730px padding-20 border-radius-5 background-fff">
     	    <div class="width-100 margin-bottom-10 padding-bottom-10 border-bottom-e9eced">
          	  <div id="ufButtonTitle" class="font-20px font-000 font-bold text-left  float-left">버튼입력 (2/5)</div>
          	  <button id="ufButtonAdd" class="plus_btn float-left" style="margin-top: -3px;"><span>+</span></button>
            </div>
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-12px font-000">
			 
			
				<table class="con_tb width-100" cellpadding="0" cellspacing="0" border="0"  id="t_btn_1">
					<thead>
						<tr>
							<th class="width-30">버튼타입</th>
							<th class="width-20">버튼명</th>
							<th class="width-35">링크</th>
							<th class="width-15">관리</th>
						</tr>
					</thead>
					<tbody id="ufButtonTbody">
					</tbody>
				</table>
			</div>
			<!--버튼-->
			<div class="pop_btn-big">
				<a  OnClick="registerButton()" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>

</body>
</html>
