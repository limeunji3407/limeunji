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


/* 팝업주소록 리스트 */
var arrRcv;

/* 테스트용 전송전 데이타 */
var arrMsg = [];  
var arrNoti = [];
var arrFtalk = [];
var arrCong = [];

var changeQueue = (function() {
	  var list = [];
	  var index = 0;

	  return {
	    enqueue: function(c) {
	      list.push(c);
	    },

	    dequeue: function() {
	      var o = list[index];
	      index++;

	      return o;
	    },
	    getList: function () {
	    	return list;
	    },
	    clear: function () {
	    	list =  [];
	    	index = 0;
	    },

	    isEmpty: function() {
	      return list.length - index === 0;
	    }
	  }
})();


	
/******* WORK LOOP ******/ 
function createItem(d,length,fn) { 
	  /* 
		var trData = "<tr>" +
						"<td class=\"relative\">" + 
					 		"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
					 			"<input type=\"checkbox\" id=\"check_4\" name=\"체크\" class=\"msgcheck\" />" + 
					 			"<label for=\"check_4\"></label>" + 
					 		"</div> <a class=\"rev_name\">" + d['수신자명'] + "</a>" + 
					 	"</td>" + 
					 	"<td>" + d['수신번호'] + "</td><td>엑셀입력</td>" + 
					 	"<td class=\"tb_btn\">" + 
					 		"<a class=\"open_pop icon_modify\">수정</a>" + 
		             		"<a href=\"#\" class=\"icon_delete\"onclick=\"deleteLine(this);\" >삭제</a>" + 
		             	"</td></tr>";
	  
	  //elem.appendChild(trData);
	  //elem.html(trData);
	  elem.textContent = d['수신자명'] + ":" + d['수신번호'] + "\r\n";
	  elem.classList.add('item'); */

	  /* elem.addEventListener('click', function() {
	    $('#title').html(d);
	    $('#popup').hide();
	  }); */
	  var elem = document.createElement('tr');
	  	var trData =  
		"<td class=\"relative\">" + 
	 		"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
	 			"<input type=\"checkbox\" id=\"check_4\" name=\"체크\" class=\"msgcheck\" />" + 
	 			"<label for=\"check_4\"></label>" + 
	 		"</div> <a class=\"rev_name\">" + d['수신자명'] + " </a>" + 
	 	"</td>" + 
	 	"<td>" + d['수신번호'] + "</td><td></td>" + 
	 	"<td class=\"tb_btn\">" + 
	 		"<a class=\"open_pop icon_modify\">수정</a>" + 
   		"<a href=\"#\" class=\"icon_delete\"onclick=\"" + fn + "(" + length + ");deleteLine(this);\" >삭제</a>" + 
   		"</td>" ;
   		
		//$('#tblsendmsg tbody').append(trData); 
	  
	    //elem.appendChild(trData);
		elem.innerHTML  = trData;
 

	  
	  return elem;
}

function processExit(deadline){
	arrUMLst = [];
	chkError = false;
	var list = changeQueue.getList();
	//console.log("========남은 LIST======" + JSON.stringify(list))
}

function processChanges(deadline) {
	  while (deadline.timeRemaining() > 0 && !changeQueue.isEmpty()) {;
	  	var c = changeQueue.dequeue();

	    if (c)
	      c.execute();

	    if(chkError){
		    //console.log("---CLEAR chkError------" + chkError);
	    	changeQueue.clear();
	    }
	  }

	  if (!changeQueue.isEmpty()){ 
		    
		    if(chkError){
			    //console.log("---------------------------CLEAR chkError-----------------------" + chkError);
		    	changeQueue.clear();
		    	arrUMLst = [];
		    	chkError = false;
		    }else{ 
		  		requestIdleCallback(processChanges);
		    }
	  }
	  else{
		    console.timeEnd();
		    //console.log("----------isEmpty----------"); 
			/* RF_048_03 수신번호 출처에 따른 목록표시
			* 
			*/
			if(arrUMLst.length > 0){ //유효한 전화번호명
		    	$('#tblsendmsg thead').html("<tr><th class=\"width-20\">이름</th><th class=\"width-20\">파일명</th>" + 
						"<th class=\"width-20\">비고</th><th class=\"width-20\">관리</th></tr>");
		  		var trData =  
					"<tr><td class=\"relative\">" + 
		 				"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
		 				"<input type=\"checkbox\" id=\"check_4\" name=\"체크\" class=\"msgcheck\" />" + 
		 				"<label for=\"check_4\"></label>" + 
		 				"</div> <a class=\"rev_name\"> 엑셀 </a>" + 
		 				"</td>" + 
		 				"<td>" + umExcelFileName + "[ " + arrUMLst.length + "건 ]" + "</td><td></td>" + 
		 				"<td class=\"tb_btn\">" + 
		 					"<a class=\"open_pop icon_modify\">수정</a>" + 
	 						"<a href=\"#\" class=\"icon_delete\"onclick=\"arrUMLstPop(0);deleteLine(this);\" >삭제</a>" + 
	 					"</td></tr>" ;
				$('#tblsendmsg tbody').html(trData);

				arrUMLstFlag = 2;
				$('#umPopGrpLstBtn').addClass("background-efefef");
				$('#umPopGrpLstBtn').addClass("disable");
				$('#umManualInputBtn').addClass("background-efefef");
				$('#umManualInputBtn').addClass("disable"); 
				$("#umTotalCnt").text("총 " + arrUMLst.length + "건");
			}	
			


			/*예상비용*/
			SetPrice("um", arrUMLst.length); 
	  }
}


function processChangesFragment(deadline) {
	  // DocumentFragment 생성
	  var fragment = document.createDocumentFragment();

	  while (deadline.timeRemaining() > 0 && !changeQueue.isEmpty()) {
	    var c = changeQueue.dequeue();

	    if (c)
	      c.execute(fragment);
	  }

	  requestAnimationFrame(function() {
	    // 개별 <li>태그 대신 fragment를 추가
	    //document.getElementById('msglist').appendChild(fragment);
	    //console.log("------requestAnimationFrame------");
	  });

	  if( !changeQueue.isEmpty() ){
		    //console.log("-----Not-isEmpty------");
		  requestIdleCallback(processChangesFragment);
	  } else {
		    //console.log("------isEmpty------");
		  console.timeEnd();
	  }
}

 

/* 최종리스트 삭제 */
function arrUMLstPop(idx){
	////console.log(arrUMLst);
	var idx = arrUMLst.indexOf(idx);
	//console.log("------arrUMLst.length:" + arrUMLst.length + "-----idx:" + idx);
	arrUMLst.splice(idx,1);
	if(!arrUMLst.length){
		//console.log("------disable -> enable -----:" + idx);
		arrUMLstFlag = 0;
		$('#umPopExcelBtn').removeClass("background-efefef");
		$('#umPopExcelBtn').removeClass("disable"); 
		$('#umPopGrpLstBtn').removeClass("background-efefef");
		$('#umPopGrpLstBtn').removeClass("disable");
		$('#umManualInputBtn').removeClass("background-efefef");
		$('#umManualInputBtn').removeClass("disable");
	}
	
	$("#umTotalCnt").text("총 " + arrUMLst.length + "건");

	/*예상비용*/
	SetPrice("um", arrUMLst.length); 
}



var isPressed = false; 
function doInterval(ID,MANUAL,LEN,e) {
	if (isPressed) { 

		var content = $("#"+ ID ).text(); 
	
		if ( Number(getByteLength(content)) == g_MaxByte_smsurl ){  
		    	 
		    	toastr.error("단문최대 " + g_MaxByte_smsurl + "BYTE까지만 입력 가능합니다.");
		    	toastr.success("장문으 로 변경되었습니다."); 
		}

		    
	 	if( Number(getByteLength(content)) > g_MaxByte_smsurl ){
	 			totalCnt = "1800";
	 	}else{
	 			totalCnt = "90";
	 	}


		if ( Number(getByteLength(content)) > g_MaxByte_lmsmms + 1 ){  
		  	$('#umContent').focus();
			toastr.error("최대 " + g_MaxByte_lmsmms + "BYTE까지만 입력 가능합니다.");  
		   	return onlyBackspace(event); 
		}
		
		
		/* 전송목록이 있을때 내용처리시 예상비용이 수정되어야 한다*/
        if(arrUMLst.length){
        	SetPrice("um", LEN);
        }
        
		
        $('#counter').html(getByteLength(content) + '/' + totalCnt ); 
        
	    setTimeout(function() {
	    	doInterval(ID,MANUAL,LEN,e);
	    }, 200);
	}
};




$(document).ready(function(){ 
	
	/* 문자보내기 친구톡 개별문자 초기목록가져오기 */
	//console.log(jobOptLst);
	
	/* 문자보내기 친구톡 알림톡 업무분류목록 가져오기 */	
/* 	if( workSeqRequiredFlag != 'Y' ){
		 $('#umContentsChangeOpt').append("<option value=''>선택해주세요</option>");
	}
	
	if( g_workSeqZeroCodeUseYN == 'Y' ){
		 $('#umContentsChangeOpt').append("<option value='0'>미분류</option>");
	} */
	
/* 	$.each(obj,function(key,value) {

		 $('#umContentsChangeOpt').append("<option value='" + key + "'>" + value + "</option>");

	}); */
	
	/* 주소록 없음 */
	arrUMLstFlag = 0;
	
	/* 최초 핸드폰번호 입력*/
	if( isEmpty(uSMobile) ){
		//console.log("--발송번호 isEmpty---"+ uSMobile + ":" + isEmpty(uSMobile) );
	    $("#umSendNum").val("");
	}else{
		//console.log("--발송번호있음---"+uSMobile + ":" + isEmpty(uSMobile) );
	    $("#umSendNum").val(uSMobile);
	}
	
	/* 예약날짜세팅 */
	var currentDate = new Date().toISOString().substring(0, 10);
	var currentTime = new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
	////console.log("--------현재날짜:" + currentDate);
	////console.log("--------현재시간:" + currentTime);
    $("#umDataPicker").val(currentDate);
    $("#umTimePicker").val(currentTime);
	
	
	//input을 datepicker로 선언
    //$("#umDataPicker").datepicker();     
    //From의 초기값을 오늘 날짜로 설정
    //$('#umDataPicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
    //To의 초기값을 내일로 설정
    //$('#datepicker2').datepicker('setDate', '+1D'); 
	
	var tempTitle = "${param.tempTitle}";
	var tempContent = "${param.tempContent}";
	
	if(tempTitle && tempContent){
		$('#umTitle').val(tempTitle);
		$('#umContent').text(tempContent);
	}
	
	
	/* 주소록 보기 */
	$("input:radio[name=tabmenu_small]").change(function() {
		var arrTabName = ["um_pop_my_group_list","um_pop_part_group_list","um_pop_share_group_list","um_pop_employ_group_list"];
		var tab = $('input:radio[name="tabmenu_small"]:checked').val(); 
		
		AjaxGroupList(tab, arrTabName[tab],"m");
	});
	
	/* 친구톡 주소록버튼클릭시 주소록리스트 */
	$('#umPopGrpLstBtn').on('click', function(){
		var arrTabName = ["um_pop_my_group_list","um_pop_part_group_list","um_pop_share_group_list","um_pop_employ_group_list"];
		var tab = $('input:radio[name="tabmenu_small"]:checked').val(); 
		AjaxGroupList(tab, arrTabName[tab],"m");
		
		$(".pop_bg").css('display','block');
		$('#msg_pop_group').css('display','block'); 
	}); /* msgAddressBtn click */
	/* 주소록 보기 */
	
	
	
	
	/* 그룹주소 이동버튼 */
	$("a.umGrpPrvBtn").click(function(){
		
		/* 체크된 그룹탭 값 확인 */
		var tabType = $('input[name="tabmenu_small"]:checked').val();
		 
		var grp = arrUMGLst.find(x => x.rowNo === 1);		
		var grpIdx = arrUMGLst.indexOf(grp);
		if( arrUMPLst.find(x => x.code === grp.code && x.title === grp.title)){
			toastr.error("이미 선택된 그룹입니다");
			return false;
		} 
		
		arrUMPLst.push({
			isGroup : "Y", /* 그룹여부 */
			title : grp.title,  /* 그룹명  */
			code : grp.code,     /* 그룹code Unique */
			phone : grp.groupcnt,
			type : grp.type,  /* 타입  */	 				
		});
			
		var html = "<li><div class=\"checkbox-small_2\">" +
			"<input type=\"checkbox\" id=\"check-" + grpIdx + "g\" name=\"mng_group_check_g" + grpIdx + "\"  />" +
			"<label for=\"check-" + grpIdx + "g\"></label>" + 
			"</div><span>" + grp.title + "(" + grp.groupcnt + ")</span></li>";
		$('ul.um_pop_receiver').append(html);	 
 
	});
	
	
	
	/* 개별주소 이동버튼 */
	$("a.umIndivPrvBtn").click(function(){
		/* 중복제거 */
		
 		$.each(arrUMGDLst, function(idx, row){  
 			//console.log("-----rowNo:" + arrUMGDLst[idx].rowNo); 
 			if(arrUMGDLst[idx].rowNo){
 				arrUMPLst.push({
 	 				isGroup : "N", /* 그룹여부 */
 	 				title : arrUMGDLst[idx].address_name,  /* 타이틀 */
 	 				code : arrUMGDLst[idx].address_id,     /* 그룹code Unique */
 	 				phone : arrUMGDLst[idx].address_num,
 	 				type : ""
 	 			});
 				var html = "<li><div class=\"checkbox-small_2\">" +
 				"<input type=\"checkbox\" id=\"check-" + idx + "i\" name=\"mng_group_check_i" + idx + "\"  />" +
 				"<label for=\"check-" + idx + "i\"></label>" + 
 				"</div><span>" + arrUMGDLst[idx].address_name + "<span>" + arrUMGDLst[idx].address_num + "</span></span></li>";
 				$('ul.um_pop_receiver').append(html);
 			} 			
		});
 		
 		//console.log(arrUMGDLst);
 		//console.log(arrUMPLst);
	});  
	
	
	/*
	* 선택제거
	*/
	$("#umPopDelSelect").click(function(){

		var gb = $('ul.um_pop_receiver li').get();
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
				arrUMPLst.splice(i-1, 1);		
			}
        } 
		
	});	

	/*
	* 전체제거
	*/
	$("#umPopDelAll").click(function(){
		//$('ul.mng_pop_receiver li').remove();  
		$('.um_pop_receiver').empty();	 
		arrUMPLst = [];
	});	
	
	
	/* 팝업 취소 버튼 */
	$('#umPopCancelBtn').click(function(){
		
		$('.um_pop_my_group_list').empty();
		$('.um_pop_employ_group_list').empty();
		$('.um_pop_part_group_list').empty();
		$('.um_pop_share_group_list').empty();
		$('.um_pop_detail_list').empty();
		$('.um_pop_receiver').empty();	 
		arrUMPLst = [];
		arrUMGLst = {};
		arrUMGDLst = {};
		
	});
	
	/* 
	* 최종리스트 #tblsendftalk로 리스트이동
	* 등록하기 버튼
	*/
	$('#umPopRegisterBtn').click(function(){

		//console.log("---등록하기----- : " + arrUMPLst);
		/* arrMCPLst [] rendering */
		
		var arrlen = arrUMLst.length;
		 
		$.each(arrUMPLst, function(idx, row){ 
			
			//console.log("--------arrUMPLst:" + row.title + ":" + row.phone + ":" + row.code + ":" + row.isGroup );
			////console.log("--------arrUMLst:" + arrUMLst);
			//console.log("--------arrUMLst INDEX:" + arrUMLst.length );
			/* //console.log(arrMCPLst[idx].title); */
		 	var trData = "<tr>" + 
						 "<td class=\"relative\">" + 
						 	"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
						 		"<input type=\"checkbox\" id=\"check_" + idx + "s\" name=\"체크\" class=\"mngcheck\" />" + 
						 		"<label for=\"check_" + idx + "s\"></label>" + 
						 	"</div> <a class=\"rev_name\">" + arrUMPLst[idx].title + "</a>" + 
						 "</td>" + 
						 "<td>" + arrUMPLst[idx].phone + "</td><td>주소록</td>" + 
						 "<td class=\"tb_btn\">" + 
						 	"<a class=\"open_pop icon_modify\">수정</a>" + 
			             	"<a href=\"#\" class=\"icon_delete\"onclick=\"arrUMLstPop(" + arrUMLst.length + ");deleteLine(this);\" >삭제</a>" + 
			             "</td>" + 
			             "</tr>";
			$('#tblsendmsg tbody').append(trData); 

			
			
			
			/* 최종에 push */
			arrUMLst.push({ 
				isGroup : row.isGroup, /* 그룹여부 */
 	 			title : "주소록",  /* 타이틀 */
 	 			code : row.code,     /* 그룹code Unique */
 	 			phone : row.phone,  /* 그룹 count  */
 	 			name : row.title, 
 	 			type : row.type   /* 그룹타입 0 개인  1 부서 2 공유 3 직원 */
 	 		});
		}); 
 
		$("#umTotalCnt").text("총 " + arrUMLst.length + "건");
		
		/* 모든 것 clear */
		$('.um_pop_my_group_list').empty();
		$('.um_pop_employ_group_list').empty();
		$('.um_pop_part_group_list').empty();
		$('.um_pop_share_group_list').empty();
		$('.um_pop_detail_list').empty();
		$('.um_pop_receiver').empty();	 
		arrUMPLst = [];
		arrUMGLst = {};
		arrUMGDLst = {};

		/* popup close */
		$(".pop_bg").css('display','none');
		$('#msg_pop_group').css('display','none'); 
		//console.log(arrUMLst);
		
		/*주소목록 모드*/
		arrUMLstFlag = 1;
		$('#umPopExcelBtn').addClass("background-efefef"); 
		$('#umPopExcelBtn').addClass("disable");
		$("#umTotalCnt").text("총 " + arrUMLst.length + "건");
		
		/*예상비용*/
		SetPrice("um", arrUMLst.length);
		
		
	});
	
	/************************************************* 팝업 주소록 보기 스크립트 ***************************************/


	
	/*********************************************** MMSINFO 이미지 업로드 ************************************/
		
	/* 이미지등록 팝업 */
	$('#umPopImgUploadBtn').on('click', function(){	 
		$(".pop_bg").css('display','block');
		$(".umPopImgUpload").css('display','block');
	});
	
	/* 이미지파일 onChange */
	$('#um_img_file').on('change', function(){
		 
	    var timeUID = Math.floor(new Date().getTime() / 1000);
	   //console.log($("#um_img_file")[0].files[0].type); // 파일 타임
	   //console.log($("#um_img_file")[0].files[0].size); // 파일 크기
	       
	       
		var previewTag = "<img id='thumbnailImg" + timeUID + "' src='' width='100' height='100' align='center' data-split=''/>";
		$('#umContent').append(previewTag);
		
		let fileInfo = document.getElementById("um_img_file").files[0];
		let reader = new FileReader();
		
		reader.onload = function() {
			document.getElementById("thumbnailImg" + timeUID ).src = reader.result;
			document.getElementById("um_img_name").value = $('input[name=file]')[0].files[0].name;
			//$('#um_img_name').val("파일명");
		}
		
		if( fileInfo ){
			reader.readAsDataURL( fileInfo );
		}
		//console.log(fileInfo);
	});
	
	
	
	/* 이미지 등록하기 */
	$('#umImgRegBtn').on('click', function(){
		
		var formData = new FormData(document.getElementById("umForm")); 
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
				
				/* MMS 정보에 입력  삭제할 수도 있으니 umContent내의 img태그를 취합해서 입력하도록 해야 */
				//arrUmMMS.push(result);
				
				//console.log(result);
				
				umImgFile = result;
				//document.getElementById("thumbnailImg" + timeUID ).src = result;
				$(".pop_bg").css('display','none');
				$(".umPopImgUpload").css('display','none');
			}, 
			error: function (e) { 
				toastr.error(e);
				$(".pop_bg").css('display','none');
				$(".umPopImgUpload").css('display','none');
				
			} 
		});
 
	});
	
	/*********************************************** MMSINFO 이미지 업로드 ************************************/
	
	
	
	
	
	
	arrRcv = $( 'ul.msg_receiver li' ).get();
	
	//pop_tabmenu_excel_2
	var msgChkVal = $('input:radio[name="pop_tabmenu_excel"]:checked').val(); 
	var msgTab = $('input:radio[name="tabmenu_small"]:checked').val(); 
	  
	
	/*
	제목글자수체크
	*/
	$('#umTitle').keydown(function (e){
	    var title = $(this).val(); 
	    if ( Number(getByteLength(title)) > 30){ 
	    	$('#umContent').focus();
	    	toastr.error("최대 30BYTE까지만 입력 가능합니다.");
	    	f_chk_byte($(this),30);
	    	return onlyBackspace(e); 
	    }
	});
	
	
	
	/* 	내용글자수체크  	*/	
	var umContentKey = document.querySelector('#umContent'); 
	
	umContentKey.addEventListener('keydown', function(event) {
		  isPressed = true;				
		  doInterval("umContent","phonelist",arrUMLst.length,event);
	});
	umContentKey.addEventListener('keypress', function(event) { 
		  isPressed = true; 
		  doInterval("umContent","phonelist",arrUMLst.length,event);  
	});
	umContentKey.addEventListener('keypup', function(event) {
		  isPressed = false;
	});
 
	
	/* 보내는번호입력 */
	$('input:radio[name=um_send_num]').change(function() {
		
		var sendnumType = $('input:radio[name=um_send_num]:checked').val();
		
		if(sendnumType === "3") {
			$('#umSendNum').val("");
			//console.log("-------직접입력--------"+sendnumType);
		}else if(sendnumType === "1"){ //사무실
			//console.log("-------사무실번호--------" + sendnumType + ":" + uSTel);
			if( isEmpty(uSTel) ){
				uSTel = "";
				toastr.error("발송용 사무실번호가 없습니다.입력해주세요");
			}
			$('#umSendNum').val(uSTel);
		}else{ //사무실 핸드폰
			//console.log("-------모바일번호--------" + sendnumType + ":" + uSMobile);
			if( isEmpty(uSMobile) ){
				uSMobile = "";
				toastr.error("발송용 핸드폰번호가 업습니다.입력해주세요");
			}
			$('#umSendNum').val(uSMobile);
		}
		
	});
	
	
	
	//document.getElementById('phonelist').addEventListener('paste', handlePaste);
	
	
/* 	
$('#phonelist').bind('paste', function(e){
	    $('#focus').focus();
	    setTimeout(function(){
	        var text = $('#focus').val();
	        $('#focus').val('');
	        $('#phonelist').focus();
	        document.execCommand('insertHTML', false, text);
	    }, 10);
	}); 
	
	*/
	
	
	
	
	//수동입력
	$('#umManualInputBtn').on('click', function(){	 
		
		//phonelist 내용을 배열에 담아   다른 리스트로 넣고 삭제한다
		//alert($('#phonelist').html().length);
		if(!$('#phonelist').html().length){
			toastr.error("수신번호를 입력하세요");
			return;
		}
		var strTemp = $('#phonelist').html();	
		strTemp = strTemp.replace("<div>","|");
		strTemp = strTemp.replace("</div><div>","|");
		strTemp = strTemp.replace("</div>","");
		var strTemp2 = strTemp.split('|'); //2번예제 분리
		
		var i;
		var arrlen = arrUMLst.length;
		for (i = 0; i < strTemp2.length; i++)
		{
			var trData = "<tr>" + 
							"<td class=\"relative\">" + 
						 		"<div class=\"absolute position-left-10px position-top-5px checkbox-small_2\">" + 
						 			"<input type=\"checkbox\" id=\"check_4\" name=\"체크\" class=\"msgcheck\" />" + 
						 			"<label for=\"check_4\"></label>" + 
						 		"</div> <a class=\"rev_name\">미입력</a>" + 
						 	"</td>" + 
						 	"<td>" + strTemp2[i] + "</td><td></td>" + 
						 	"<td class=\"tb_btn\">" + 
						 		"<a class=\"open_pop icon_modify\">수정</a>" + 
			             		"<a href=\"#\" class=\"icon_delete\" onclick=\"arrUMLstPop(" + arrUMLst.length + ");deleteLine(this);\" >삭제</a>" + 
			             	"</td>" + 
			             "</tr>";
			
			arrUMLst.push({ 
				isGroup : "N", /* 그룹여부 */
 	 			title : "미입력",  /* 비고 */
 	 			code : null,     /* 그룹code Unique */
 	 			phone : strTemp2[i],
 	 			name : "미입력",
 	 			type : ""
 	 		});
			$('#tblsendmsg tbody').append(trData); 
		}
		
		$('#phonelist').html(null);

		//console.log("-수동입력--시작카운터:"+ arrlen + "::::최종카운트 -" + arrUMLst.length + ":" ); 
		
		arrUMLstFlag = 1;
		$('#umPopExcelBtn').addClass("background-efefef");
		$('#umPopExcelBtn').addClass("disable");
		$("#umTotalCnt").text("총 " + arrUMLst.length + "건");

		/*예상비용*/
		SetPrice("um", arrUMLst.length);
		
	});
	
	//엑셀입력
	$('#umPopExcelRegBtn').on('click', function(){	

		/*excel upload */
  		if( isEmpty($("#umInputImgFile").val()) ) {
			    $("#umInputImgFile").focus();
			    alert("파일을 선택하세요.");
			    return;
		}
  		 
		var formData = new FormData(document.getElementById('umExcelFile')); //umInputImgFile  //
		//formData.append("excelFile", $("#umInputImgFile")[0].files[0]);
		$.ajax({
			url: "/msg/excelFileupload.do",
			data: formData,
			processData: false,
			contentType: false,
			type: "POST",
			async: false,
			success: function(data){
				////console.log(data);
			}
		}); 
 
		
		
		//loading 
		var start = console.time(); //new Date().getTime(); 
		
	    var rowJsonObj = {};
        var files = document.getElementById("umInputImgFile").files[0]; //input file 객체를 가져온다.
        umExcelFileName = files.name;
		//////console.log(files);
		
		/************************* CALLBACK ******************************/
		var result;
		var reader = new FileReader();
		reader.onload = function(e){
			
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
		    	
		    	var phoneNumber;
		      	changeQueue.enqueue({
		        	execute: function() {
		        	//var elm = createItem(rowJsonObj[i], arrUMLst.length, "arrUMLstPop"); 
						phoneNumber = chkPhoneNumber(rowJsonObj[i]['수신번호'],i);

					    /*
					    *
					    * RF_048_03 수신번호 출처에 따른 목록표시
				    	* 
				    	*/ 
			        	if(phoneNumber === "0" ){
			        		arrUMLst = [];
			        		$(".pop_bg").css('display','none');
			        		$('#msg_pop_excel').css('display','none');		                   
			        		//return function(e) {
			                // `e.target.result` or `this.result` // `f.name`.
			                chkError = true;
				        	////console.log("=======유효하지 않은 전화번호가 있습니다========" + chkError); 
			                //};
			        	}else{
					      	////console.log("=====Push======" + chkError + ":" + phoneNumber + ":" + arrUMLst.length);
			        		arrUMLst.push({ 
			    				isGroup : "N", /* 그룹여부 */
			    				title : "엑셀입력",  /* 비고 */
			    				code : null,     /* 그룹code Unique */
			    				phone : phoneNumber,
			    				name : rowJsonObj[i]['수신자명'],
			    				type : ""
			    			});
			        	} 
		    		}		       
		    	});	
    			
                chkError = false;
        		////console.log("=======유효한 번호입니다========" + chkError);
	        	//var chkCount = chkPhoneNumber(rowJsonObj[i]['수신번호'],i);
	    		////console.log("====Excel Push======"+ i + ":" + rowJsonObj[i]['수신번호'] + ":" +rowJsonObj[i]['수신자명'] + ":"  + arrUMLst.length);
		    }

		    requestIdleCallback(processChanges);
		    //return function(e) {
                //chkError = false;
        		////console.log("=======유효한 전화번호입니다========" + chkError);
                // Here you can use `e.target.result` or `this.result`
                // and `f.name`.
            //};
			result = e.target.result;
		};
		reader.readAsBinaryString(files);
		
		/************************* CALLBACK ******************************/
		
 		
 		var end = console.timeEnd();
 		
 		////console.log("finish:" + ( start - end )); 
		////console.log(arrMsg);
		    
		$(".pop_bg").css('display','none');
		$('#msg_pop_excel').css('display','none');
		$('.wrap-loading').css('display','none');    	
	});	
	 
		
	//제목내용 클리어
	$('#umContentClearBtn').on('click', function(){
		$('#umTitle').val(""); 
		$('#umContent').html(""); 
	});	
	
	
	
	//테스트입력
	$('input:radio[name=umSendTime]').change(function() {
		
		  if ($('input:radio[name=umSendTime]:checked').val() == "2") {
		     $('#umTestInput').removeClass("none");
		  }else{
			 $('#umTestInput').addClass("none");
		  } 
	});
	
	//lodingbar hide
	$('.loading_bar').hide();
	
	
	

	/* 내저장함 가져오기*/
	/* 내저장함 */
	$('#umPopMyBoxBtn').on('click', function(){	
		////console.log("----------------내저장함---------------");

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

		$(".pop_bg").css('display','block');
		$('#umMyBoxPopUp').css('display','block');		
	});

	

		
		
	/* 내저장함 팝업시 초기화오류로 인해 */
	$('#umMyBoxCloseBtn').on('click', function(){
		 destroyTableUM();
	});
		
		
	
	
	/* 내저장함에 저장하기 */
	$('#umMyBoxSave').on('click', function(){
		
		var title = $("#umTitle").val();
		//var subject = $("#umContent").val();
		var mmsInfo = $("#umContent").html(); /* 이미지 MMS */ 
		var subject = $("#umContent").html(); 
		var subjectLength = getByteLength(subject); 
		var status;
		
		if(subjectLength<=90){
			status = 'S';
			////console.log("단문입니다. byte : "+subjectLength+", status : "+status);
		}else{
			status = 'L';
			////console.log("장문입니다. byte : "+subjectLength+", status : "+status);
		}
		
		var before = "";
		if(subject.indexOf("<img") > -1){
			before = subject.substring(0, subject.indexOf("<img"));
			after = subject.substring((subject.indexOf("data-split")+14), subject.length)
			subject = before+after;
			status = "M";
		}
		var obj = {
			"title" : title,
			"subject" : subject,
			"status" : status,
			"imgFile" : umImgFile.string
		}
		console.log(obj)
		////console.log("obj :: "+JSON.stringify(obj));
		$.ajax({
	       	url: "<c:url value='/usr/insertMySave' />",
	       	type: "POST",
	        data: obj,
	        dataType: "json",
	       	success: function(jsondata){  
	     	   
	       		////console.log(jsondata["data"]);
	            
	            if(jsondata["data"]==0){
	                //로딩
	                toastr.success("저장되었습니다.");
	            }else{
	            	toastr.error("입력 중에 오류가 발생했습니다. 입력값들 다시한번 확인해주시기 바랍니다.");
	            }
	       	},
	       	error: function(request,status,error){
	       		  
	       		////console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	           	$('#result').text(jsondata);
	           	//////console.log("serialize err");
	       		$('#addrBtn').attr('disabled', false);
	       	}
	   	});
	});
	
	
	

	
	/* 개별문자 입력 umContentsChangeOpt */	
	$('#umContentsChangeBtn').on('click', function(){ 
		////console.log("----arrUMLst-----" + arrUMLst);
		if(!arrUMLst.length){
			 toastr.error("수신자 전송목록이 비어있습니다");
			 return;			
		}
		////console.log('----------------개별문자입력---------------' + $('#umContentsChangeOpt option:selected').val());
		 var variable = "#[" + $('#umContentsChangeOpt option:selected').val() + "]";
		 $('#umContent').append(variable);

		 arrUMVariables.push(variable); /*동일한 컬럼변수가 있으면 푸시안함*/
		 toastr.success("개별문자가 입력되었습니다");
	});
	
	
	


	/* 미리보기용  배열 
	umArrSendNum 초기에 선택된 번호 
	umArrRcvNum 리스트 된 번호
	*/
	var umPreviewSendNum = "01056355959";
	var umPreviewRcvNumArr = ["01012345678","01012345678","01012345678"];
	
	$('#umPreviewBtn').on('click', function(){			
		$(".pop_bg").css('display','block');
		$('#umPreviewPopUp').css('display','block');
		
		var umT = $('#umTitle').val();
		////console.log("----------umTitle-------" + umT);
		var umC = $('#umContent').html();		
		////console.log(":--------------umContent---------" + umC);
		
		 
		
		$('#umPreviewTitle1').html(umT);
		$('#umPreviewTitle2').html(umT);
		$('#umPreviewTitle3').html(umT);

		var umC1, umC2, umC3;
        if(umC.indexOf("#[이름]") != -1 ){
        	umC1 = umC.replaceAll("#[이름]", arrUMLst[0].name);  //이름
        }
        if(umC.indexOf("#[비고]") != -1 ){
        	umC1 = umC.replaceAll("#[비고]", arrUMLst[0].title);  //비고
        } 
		$('#umPreviewContents1').html(umC1);
		

        if(umC.indexOf("#[이름]") != -1 ){
        	umC2 = umC.replaceAll("#[이름]", arrUMLst[1].name);  //이름
        }
        if(umC.indexOf("#[비고]") != -1 ){
        	umC2 = umC.replaceAll("#[비고]", arrUMLst[1].title);  //비고
        } 		
		$('#umPreviewContents2').html(umC2);
		
		

        if(umC.indexOf("#[이름]") != -1 ){
        	umC3 = umC.replaceAll("#[이름]", arrUMLst[2].name);  //이름
        }
        if(umC.indexOf("#[비고]") != -1 ){
        	umC3 = umC.replaceAll("#[비고]", arrUMLst[2].title);  //비고
        } 	
		$('#umPreviewContents3').html(umC3);
		
		
		
		$('#umPreviewSendNum1').text(umPreviewSendNum);
		$('#umPreviewSendNum2').text(umPreviewSendNum);
		$('#umPreviewSendNum3').text(umPreviewSendNum);
		////console.log(":--------------umPreviewSendNum---------" + umPreviewSendNum);
		
		$('#umPreviewRcvNum1').text(umPreviewRcvNumArr[0]);
		$('#umPreviewRcvNum2').text(umPreviewRcvNumArr[1]);
		$('#umPreviewRcvNum3').text(umPreviewRcvNumArr[2]);
		////console.log(":--------------umPreviewRcvNumArr---------" + umPreviewRcvNumArr[0]);
	});
	
	/* 불필요 */
	$('#umPreviewConfirmBtn').on('click', function(){	
	});
	
	
	
	
	
	
	
	/* 전송하기 */
	$('#umSendMsgBtn').on('click', function(){	
		
		
		////console.log("--------전송시작-------");
		var umTitle = $('#umTitle').val();
		var umContent = $('#umContent').text();
		var umMmsinfo = $('#umContent').html();
		
		var umContentCookie = getCookie("umBeforeContent");
		
		////console.log("--이전컨텐츠:--" + umContentCookie);
		////console.log("--현재컨텐츠:--" + umContent);

		/* 옵션  --  직전 동일내용 전송체크 메세지 */ 
		if( g_dupMessageUseFlag == "Y" ){
			
			if( umContent ==  umContentCookie ){
				var r = confirm("이전 내용과  동일한 메세지내용입니다. 전송하시겠습니까?");
				if (r == true) {
				} else {
					toastr.error("전송이 취소되었습니다");
					return false;
				}
			}
		}
		
		

		/* 옵션  --  080 수신거부 메세지 첨가 */
		if(sending_refusal_check == "Y"){
			umContent += refusal_txt;
		} 
		 

		var umTitleLen = getTextLength(umTitle);		 
		var umContentLen = getTextLength(umContent);
		 
		
		if( umTitleLen < 10 ) { 
     		toastr.error('제목을 입력하세요'); 
     		$('#umTitle').focus();
     		return false;
		}
		
		if( umContentLen < 20 ) { 
     		toastr.error('내용을 입력하세요'); 
     		$('#umContent').focus();
     		return false; 
		}
		
		/*
		 옵션  -- 
		이미지만 보내기 가능
		*/
		if(mms_only_image == "Y"){
			if( umContentLen == 0 ){
				/* continue */
			}
		}else{ 
		}
		
		
		
		if( !maxLengthCheck("umTitle","제목",30) ){
			$('#umTitle').focus();
			return false;
		} 


		if( !maxLengthCheck("umContent","내용",1800) ){
			$('#umContent').focus();
			return false;
		}
		      
		
		/* 이미지 처리에 따르는  MMS msgType 구분    FileCnt 2 메세지 이미지 둘다*/
		var checkMsgType = "0";  //SMS
		var isImage = false;	
		isImage = Object.keys(umImgFile).length;
		
		////console.log("------" + umImgFile);
		 
		umContent = $('#umContent').text();   //umContent.replace("/<img(.*?)>/gi", ""); 
		////console.log(umContent);
		
		/* 		
		var isImage = function(umImgFile){ 
			if( umImgFile == "" || umImgFile == null || umImgFile == undefined || ( umImgFile != null && typeof umImgFile == "object" && !Object.keys(umImgFile).length ) ){ 
				return true
			}else{ 
				return false
			} 
		}; */  
	 
		if(umContentLen > 90 ) checkMsgType = "1";  //LMS 
		if( isImage ) checkMsgType = "2"; //MMS

		//console.log("-----isImage------" + Object.keys(umImgFile).length + ": checkMsgType = " + checkMsgType); 
		//return
	 	
		
		
		
		
		
	 	//check snd_number  부서원소속 사무실, 사용자핸드폰, 직접입력
	 	var sendPhoneType = $('input:radio[name=um_send_num]:checked').val(); 
	 	//var sendPhone = $('input:text[name=umSendNum]').val(); 
	 	var sendPhone = $('input[name=umSendNum]').val();
	 	//alert("sendPhoneType: " + sendPhoneType + ": phone " + sendPhone + ": phone x " + sendP );

		var sendPhoneLen = getTextLength(sendPhone);
		if( sendPhoneLen < 8 ) { 
     		toastr.error('발신번호를 입력하세요'); 
     		$('input[name=umSendNum]').focus();
     		return false;
		}
	 	
		/* RF_046_02  발신번호 유효성 체크
		*  
		*/
		if( isNaN(sendPhone) || sendPhoneLen < 8 || sendPhone.substring(1) === "0"  ) {
			//console.log( isNaN(sendPhone) + ":" + sendPhoneLen + ":" + sendPhone.substring(1) );
			toastr.error("유효한 발신번호가 아닙니다");
		}
		
		//수동입력체크
		var manualInputLst = $('#phonelist').val();  
		
		if(manualInputLst.length > 0) {
     		toastr.error('수동입력창에 자료가 남아 있습니다'); 
     		$('#phonelist').focus();
			return false;
		}

		
		/************************************************** 예약발송시 시간  ************************************************/ 
	 	var currentDate = getTimeStamp();
	 	var startDate = new Date();
	 	//즉시 에약 테스트
	 	var sendTimeValue = $('input:radio[name=umSendTime]:checked').val();  
	 	//즉시 현재시각  , 예약 예약시각 ,  테스트 즉시
	 	if( sendTimeValue == "1"){  //alert("예약");
	 		var iDate = $('#umDataPicker').val();
	 		var iTime = $('#umTimePicker').val();
	 		startDate = iDate + " " + iTime;	


	 		var cDate = new Date(currentDate);
	 		var sDate = new Date(startDate);
	 		
	 		var gap = sDate.getTime() - cDate.getTime(); 
	 		
	 		//console.log(":::::cDate:" + cDate + ",current:" + cDate.getTime());
	 		//console.log(":::::sDate:"+ sDate + ",start:" + sDate.getTime());
	 		//console.log(":::::gap:" + gap);
	 		
	 		/* 10분 이후  600초 * 1000*/
	 		if( gap < 600000 ){
	 			toastr.error("--------예약일이 현재시간보다 이전입니다---------");
	 			return;
	 		}

	 		/* TEST */
	 		/* cDate = new Date("2020-09-03 00:00:00");
	 		sDate = new Date("2020-09-03 00:00:10");
	 		var gap = cDate.getTime() - sDate.getTime(); 
	 		console.log(":::::cDate:" + cDate + ",current:" + cDate.getTime());
	 		console.log(":::::sDate:"+ sDate + ",start:" + sDate.getTime());
	 		console.log(":::::gap:" + gap); */
	 		
	 		//현재시간보다 10분
	 		//if(gap < 60*10 )
 			//toastr.success("예약일" + sDate);
	 		//return;
	 	}else{
	 		startDate = '';
	 	}
 
 		if( sendTimeValue == "2" && isEmpty($("#umTestInput").val())){
 			toastr.error("테스트수신번호를 입력해주세요");
 			return;
 		}
		/************************************************** 예약발송시 시간  ************************************************/ 
	 	

		var umJobOpt = $('select[name=umJobOpt]').val(); 
		if( umJobOpt == "0" ){
			toastr.error("업무분류를 선택하세요");
			return false;
		}	
	 	
	 	$('.wrap-loading').removeClass('display-none');   
	 	
	 	//console.log("-------sendTimeValue------:" + sendTimeValue); 
	 	var param;
	 	
	 	
	 	/* 예약발송 */
	 	if( sendTimeValue == "3"){
	 		
	 	}
	 	
 		/* 테스트발송일때 한개만 발송 */
	 	if( sendTimeValue != "2"){
	 		//console.log("---------실발송--------");
	 		param = tableToJson(document.getElementById("tblsendmsg"), checkMsgType, startDate, umTitle, umContent, umMmsinfo, sendPhone, umJobOpt, umImgFile); /*  table id를 던지고 함수를 실행한다. */
	 	}else{
	 		param = tableToJsonTest($("#umTestInput").val(), checkMsgType, startDate, umTitle, umContent, umMmsinfo, sendPhone, umJobOpt, umImgFile); /*  table id를 던지고 함수를 실행한다. */ 	
	 	} 
		 
		/* for(var key in param){
			//console.log("===== param ======" + key + ":" + param[key]);
		} */
		
		if( !Object.keys(param).length ){
			toastr.error("수신자목록을 입력하세요");
			return false;
		}  
		//console.log("===== param ======" + param);
		

        var obj = JSON.stringify(param);
		//console.log("===== obj ======" + obj); 
        
        //$('#result').text(obj);  
		$('#umSendMsgBtn').attr('disabled', true);
		
		//loading
		$('.loading_bar').show(0).delay(3000).hide(0);
		
		//toastr.success("------ajax--start-------");
			console.log("================================================================================")
		console.log(param)
		console.log("================================================================================")
    	$.ajax({
        	url: "/sendSMS.do",
        	type: "POST",
            dataType: "json",          		  // ajax 통신으로 받는 타입
            contentType: "application/json",  // ajax 통신으로 보내는 타입
            data: obj,
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
        		$('#umSendMsgBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#umSendMsgBtn').attr('disabled', false);
            },
        	success: function(jsondata){
        	     /*
       	      * 
       	      * RF_047_01 입력 번호 유효성 체크
       	      * 
       	      */
       	   var srvcNm = '전송 >> 문자메시지';
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
      		
        		if(jsondata['error']){
        			toastr.error(jsondata['errorcode'] + JSON.stringify(jsondata['data']));
        			return;
        		}
        		
        		if(jsondata['data'] == "index.do"){
        			location.href = "index.do";
        		}
        		
        		var res = JSON.stringify(jsondata);
        		//alert(res); //로딩
        		
        		//clear
        		if(jsondata['result_msg'] == "ok"){ 
        			
        			$("#tblsendmsg tbody").empty(); 
            		$('#umTitle').val(""); 
            		$('#umContent').empty(); 
            		$('#umTotalCnt').text("");
            		$('#umPrice').text("");
            		
            		umImgFile = {};
            		
            		/* 배열 데이타 처리  */
            		arrUMLst = [];
           			arrUMGLst = []; 
           			arrUMVariables = [];
           			$("#umTotalCnt").empty();
           			$("#umPrice").empty();

                    /* CLEAR */
                    /* 입력버튼 처리 */ 
            		$('#umPopExcelBtn').removeClass("background-efefef");
            		$('#umPopExcelBtn').removeClass("disable"); 
            		$('#umPopGrpLstBtn').removeClass("background-efefef");
            		$('#umPopGrpLstBtn').removeClass("disable");
            		$('#umManualInputBtn').removeClass("background-efefef");
            		$('#umManualInputBtn').removeClass("disable");
            		
            		
        		}
        		//$('#result').text("전송시간:" + res); 
        		//console.log("전송시간:" + res);
                toastr.success('성공적으로 전정되었습니다'); 
                
                /* $(".pop_templet").css('display','none'); */
                
        		/* 		바로 직전 콘텐츠 저장    		*/ 
                setCookie("umBeforeContent",umContent);
                
        		$('#umSendMsgBtn').attr('disabled', false);
        		//close popup
        	},
        	error: function(request,status,error){
        		  
        		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            	//$('#result').text(error);
            	//alert("serialize err");
        		$('#umSendMsgBtn').attr('disabled', false);
                $('.wrap-loading').addClass('display-none');
        	}
   		});
	});

	/* 최근 전송 5건 */	
	PopupRecentLst("#umRecentLstBtn","#umRecentLst","#umPopRecentLayer",arrUMRecentLst);
	
	// clear
	umImgFile = {};
	
});


function roughSizeOfObject( object ) {

    var objectList = [];
    var stack = [ object ];
    var bytes = 0;

    while ( stack.length ) {
        var value = stack.pop();

        if ( typeof value === 'boolean' ) {
            bytes += 4;
        }
        else if ( typeof value === 'string' ) {
            bytes += value.length * 2;
        }
        else if ( typeof value === 'number' ) {
            bytes += 8;
        }
        else if
        (
            typeof value === 'object'
            && objectList.indexOf( value ) === -1
        )
        {
            objectList.Push( value );

            for( var i in value ) {
                stack.Push( value[ i ] );
            }
        }
    }
    return bytes;
}

function tableToJsonTest(table, type, startDate, title, content, mmsinfo, senderNum, jobOpt, imgFileName) {
	//console.log("------image------" + imgFileName);
	content = $('#umContent').text();
	//console.log("-------content-----" + content);
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
	tempData["rcv_work_seq"] = jobOpt;
	
	
	/* 전송파일관련 */  

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


function tableToJson(table, type, startDate, title, content, mmsinfo, senderNum, jobOpt, imgFileName) {
	/* 
	* RF_049_01 수신자  건수 제한
	*
	*/
	if( arrUMLst.length > max_receive_cnt ){
		toastr.error("수신목록 가능한 최대갯수는 " + max_receive_cnt + "입니다");
		return;
	}
	
	//console.log("------image------" + imgFileName);
	content = $('#umContent').text();
	//console.log("-------content-----" + content);
	var tempData = {};
	
	//MMS_CONTENTS_INFO 에 필요한 데이타
	tempData["mms_info"] = "";// mmsinfo;
	tempData["title"] = title;
	tempData["content"] = content;
	tempData["snd_number"] = senderNum;
	tempData["rcv_type"] = type;
	tempData["snd_date"] = startDate;
	tempData["rcv_rsvt_chk"] = "1";
	tempData["rcv_mmsinfo"] = mmsinfo;
	tempData["rcv_work_seq"] = jobOpt; 
	tempData["reType"] = 0;
	
	/* MMS 이미지  */  
	/* 전송파일관련 */  

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
	
	var typeName = "SMS";
	if(type === "1") typeName = "LMS";
	if(type === "2") typeName = "MMS";
	
	tempData["price"] = getPriceByCode(typeName);
	
	/* 친구톡 */ 
	tempData["reContents"] = "";
	
	/* 친구톡 알림톡 */
	tempData["btnList"] = "";
	
	/* 알림톡 변수 5개 리스트 */
	tempData["tmpVars"] = "";
	
	
	
	var row = [];
	var rowG = [];
	
	for ( var r = 0; r < arrUMLst.length; r++ ){ 
		
		
        var rowData = {};   
		var isGroup = "N";
		isGroup = arrUMLst[r].isGroup;
        rowData["isgroup"] = arrUMLst[r].isGroup; //비고란 
        
        if(isGroup == "Y"){ 
        	
            rowData["column1"] = arrUMLst[r].name; //이름
            rowData["rcv_number"] = arrUMLst[r].phone; //수신번호
            rowData["rcv_etc"] = ""; //비고란

            rowData["grp_category"] = arrUMLst[r].code; //비고란 
            rowData["grp_name"] = arrUMLst[r].name; //비고란
            rowData["grp_type"] = arrUMLst[r].type; //비고란 
            rowData["grp_cnt"] = Number(arrUMLst[r].phone); //비고란
        	rowG.push(rowData); 
            
        }else{

            rowData["column1"] = arrUMLst[r].name; //이름
            rowData["rcv_number"] = arrUMLst[r].phone; //수신번호
            rowData["rcv_etc"] = ""; //비고란
            rowData["grp_name"] = ""; //비고란
            rowData["grp_category"] = ""; //비고란 
            rowData["grp_type"] = ""; //비고란 
            rowData["grp_cnt"] = 0; //비고란
	    	row.push(rowData); 
            
        }
         
         
		arrUMRecentLst.push({
			isGroup : "N", 
			title : rowData["column1"],  
			code : null,     
			phone : rowData["rcv_number"],
			name : rowData["column1"]
		});
    	
    	if(arrUMRecentLst.length > 5){
    		arrUMRecentLst[arrUMRecentLst.length - 1]
    		arrUMRecentLst.pop();
    	}
	}
	
     /* for (var r = 1, n = table.rows.length; r < n; r++) {
    	
       	var tableRow = table.rows[r];
        var rowData = {};              
        rowData["column1"] = tableRow.cells[0].querySelector('a').innerHTML; //이름
        rowData["rcv_number"] = tableRow.cells[1].innerHTML; //수신번호
        rowData["rcv_etc"] = tableRow.cells[2].innerHTML; //비고란
        
        if(rowData["rcv_number"] == null ){
        	rowG.push(rowData); 
        }else{
        	
	    	row.push(rowData); 
    	}

    	//최근 전송에 담기 
		arrUMRecentLst.push({
			isGroup : "N", //그룹여부  
			title : rowData["column1"],  //이름  
			code : null,     //그룹code Unique  
			phone : rowData["rcv_number"],
			name : rowData["column1"]
		});
    	
    	if(arrUMRecentLst.length > 5){
    		arrUMRecentLst[arrUMRecentLst.length - 1]
    		arrUMRecentLst.pop();
    	} 
    }    */

	
	
	tempData["group"] = rowG.slice();  /* 전체내용넣기 */
	tempData["data"] =  row.slice();  /* 전체내용넣기 */
	//tempData["data"] = row;
    //console.log("-------tableToJson-----------" + tempData);
    
    var totalPrice = Number(tempData["data"].length) * Number(tempData["price"]); 
    var uCashChk = usrCashCheck(typeName, totalPrice);
    
    if(uCashChk < 0 ){
		toastr.error("캐쉬 잔액이 부족합니다");
    	return false;
    }	    	
    
    
 	return tempData;
    
}




/******************************************************************************** 내저장함 INIT *********************************************************/
function umSaveTableInit(talbeId, url, cntTextId){
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

						//console.log(rowData[i]);

						td_body = td_body
								+ "<div id='umSave"+ rowData[i]['status'] + rowData[i]['mysaveSeq'] + "' class='column border-box padding-rl-10 margin-left-33 margin-right-33 cursor_point' style='width:19%' onclick=\"selectRowUM('umSave"+ rowData[i]['status']+ rowData[i]['mysaveSeq'] + "','"+rowData[i]['title']+ "','" + rowData[i]['subject'] + "');\">"
								+ "<div class='width-250'>"
								+ "<h5 class='font-14px font-normal font-174962 text-left'>"
								+ rowData[i]['title']
								+ "</h5>"
								+ "<div class='width-100 height-340px font-4d4f5c font-14px text-left border-e8e8e8 border-radius-5 background-transparent padding-5 line-height-default margin-bottom-10' style='overflow:auto;' >"
								+ rowData[i]['subject'] 
								+ "</div>"	
								+ "<a href=\"#\" class=\"icon_delete margin-left-5\" onclick=\"delRowUM("+rowData[i]['mysaveSeq']+ ");\" >삭제</a>"
								//+ "<a href=\"#\" class=\"icon_save margin-left-5\" onclick=\"selectRowUM('umSave"+ rowData[i]['mysaveSeq'] + "','"+rowData[i]['title']+ "','" + rowData[i]['subject'] + "');\" >선택</a>"
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
function reloadTableUM(){
	umSaveTableS.ajax.reload();
	umSaveTableL.ajax.reload();
	umSaveTableM.ajax.reload();
	umSaveTableF.ajax.reload();
	umSaveTableC.ajax.reload();
}
function destroyTableUM(){

	var idx = umCurMySave["idx"];
	var tab = $("input[name='sendM_tabmenu']:checked").val();
	
	if( idx != "undefined" && idx != null ){
		//console.log("-----선택사항입력있음----");
		var title = umCurMySave["title"];
		var content = umCurMySave["content"]; 
		//console.log("---------선택--idx-----" + idx  );
		//console.log("---------선택--title-----" + title  );
		//console.log("---------선택--content-----" + content  );
		
		if( tab == "M" ){  /*현재 탭체크*/
			$('#umTitle').val(title);
			$('#umContent').html(content);
		}else{
			$('#ufTitle').val(title);
			$('#ufContent').html(content);
		}
		
	}else{ 
		//console.log("-----선택사항입력없음----");
	}
	
	umSaveTableS.destroy();
	umSaveTableL.destroy();
	umSaveTableM.destroy();
	umSaveTableF.destroy();
	umSaveTableC.destroy();
}

function delRowUM(mysave_seq){
	if (confirm("정말 삭제하시겠습니까?") == true){    //확인
	    $.ajax({
	    	url: "/deleteMySave.do?mysaveSeq="+mysave_seq,
	       	type: "GET",
	    	dataType: "json",
	       	success: function(jsondata){  
	            if(jsondata["data"]==0){
	                alert("성공적으로 삭제 되었습니다.");
	                reloadTableUM();
	            }else{
	            	alert("삭제할수 없습니다.");
	            }
	       	},
	       	error: function(request,status,error){
	       		//console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
	       	}
	   	});

	 }
}

function selectRowUM(idx, title, content){ 
	
	/* 선택된 것이면 토클 */
	if($("#"+idx).hasClass("umMybox") === true) { 
		$("#"+idx).removeClass("umMybox");  
		umCurMySave = []; //초기화
		toastr.error("선택이 해제되었습니다");
		return;
	}

	/* 현재 el 클래스 추가 */
	$('#'+idx).addClass("umMybox"); 
	
	
	/* 이전 el 클래스 삭제*/
	if( ( umCurMySave["idx"] != null ) && ( umCurMySave["idx"] != "undefined" ) ){

		$('#'+ umCurMySave["idx"]).removeClass("umMybox");
	}  
	//console.log("-------umCurMySave['idx']" + umCurMySave["idx"]); 
	//console.log("-------idx" + idx); 

	
	
	/* 데이타저장 */
	umCurMySave["idx"] = idx;
	umCurMySave["title"] = title;
	umCurMySave["content"] = content; 
	//console.log("-------title-----" + title); 
	//console.log("-------content-----" + content); 
	
}

/* 최근 발송 5건 */
function recentRcvLst(){
	
	//저장된 최근전송리스트 5건
	$('#umPopRecentLst').addClass("");
	arrUMLstRecent.forEach(function(element){
		
		$('#umPopRecentLst').append(html);
	});
	//$('#umRecent').removeClass('none');
}



</script>

<style>
#umContent {
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
<div id="result"></div>
<div class="wrap-loading"></div>
<input type="radio" checked name="sendM_tabmenu" id="tabmenu-1" value="M">
		<label for="tabmenu-1">문자보내기</label>
			<div class="tabCon">
				<ul class="width-100 margin-bottom-100">
					<li class="float-left  width-350px margin-right-30">
						<div class="width-350px height-620px border-radius-5 background-f7fafc padding-20 border-box">
							
							<textarea type="text" name="umTitle" id="umTitle" placeholder="제목 (최대 30Byte)" class="width-100 height-50 border-e8e8e8 background-transparent font-16px padding-left-20 padding-right-20 border-box row-1 margin-bottom-5"></textarea>
							
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 50px;">
								<!-- 
								<textarea  type="text" name="umContent" id="umContent" placeholder="내용 (최대 90Byte)" class="width-100 height-100 background-transparent font-16px line-height-default" style="overflow-y: auto;"></textarea>
								 -->
								<div id="umContent" contentEditable="true"></div>
								<input type='hidden' name='umContentTmp' id='umContentTmp' />
								<a id="umPopImgUploadBtn" class="icon_photo width-30px height-30px background-8bc5ff border-radius-40 absolute position-bottom-10px position-left-10px"></a>
							    <a id="counter" class="width-100px height-30px absolute  position-bottom-10px" style="left: 35%;">0/90</a>
								<a id="umContentClearBtn" class="icon_trash width-30px height-30px background-8bc5ff border-radius-40 absolute position-bottom-10px position-right-10px"></a>
							</div>
							<ul class="margin-bottom-20">
								<li class="float-left width-50 padding-right-5 border-box"><a id="umPopMyBoxBtn" class=" width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">내 저장함</a></li>
								<li class="float-left width-50 padding-left-5 border-box"><a id="umMyBoxSave" class="width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-174962 font-16px border-box">저장하기</a></li>
							</ul>
							<ul>
								<li class="width-100"> 
									<ul class="width-100 height-70px">
										<li class="float-left width-80px height-70px">
											<span class="inline-block width-80px height-40px margin-top-40 text-left font-16px font-4d4f5c">발신번호</span>
										</li>
										
										<!--***옵션:직접선택일 경우-->
										<li id="umSendNumDirect" class="float-right width-230px height-70px padding-top-5"> 
											<div class="radio-box_s font-14px font-053c72 margin-right-10">
												<div class="radio_s">
													<input type="radio" id="umOfficeNum" name="um_send_num" value="1"  />
													<label for="umOfficeNum"><span></span></label>
												</div> 사무실
											</div>
											<div class="radio-box_s font-14px font-053c72 margin-right-10">
												<div class="radio_s">
													<input type="radio" id="umPhoneNum" name="um_send_num" value="2" checked />
													<label for="umPhoneNum"><span></span></label>
												</div> 핸드폰
											</div>						
											<div class="radio-box_s font-14px font-053c72 ">
												<div class="radio_s">
													<input type="radio" id="umDirectNum" name="um_send_num" value="3" />
													<label for="umDirectNum"><span></span></label>
												</div> 직접입력
											</div>				
											<input  name="umSendNum" id="umSendNum" type="text" maxlength="12" value="" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' class="width-230px background-transparent font-14px height-40px line-height-40px border-e8e8e8 border-radius-5 padding-left-10 margin-top-10"  />
										</li>
										<!--//***옵션:직접선택일 경우-->
										
										<!--***옵션:등록번호콤보표시일 경우-->
										<li id="umSendNumCombo" class="float-right width-230px height-70px padding-top-5">	 
											<!--***옵션:등록번호표시일 경우-->
											<select id="umSendNum" class="select_blank_lightblue width-230px float-right" style="margin-top:10px;">
												<option selected>010-0000-0000</option>
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
						<div class="width-100 height-620px padding-20 border-box border-radius-bottom-5 background-f7fafc">
							<ul class="width-100">
								<li class="width-100">
									<h3 class="inline-block float-left width-650px font-18px font-174962 margin-bottom-10 margin-right-10">수신번호 직접입력</h3>
									<h3 class="inline-block float-left width-140px font-18px font-174962 margin-bottom-10">수신번호 불러오기</h3>													
									
									<div class="float-left width-650px height-90px padding-10 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10">
									<!-- <textarea cols="11"  onkeydown='return onlyNumberEnter(event)' onkeyup='removeCharEnter(event)' type="text" id="phonelist" name="phonelist" placeholder="전화번호를 직접 입력하거나 메모장, 엑셀을 붙여넣기 한 후에 우측의 입력버튼을 눌러주세요. 두 개 이상의 전화번호는 꼭 엔터키로 구분해주세요." /></textarea>
									 -->
									<div id="phonelist" name="phonelist"  contentEditable="true"  onkeydown='return onlyNumberEnter(event)' onkeyup='removeCharEnter(event,this)' placeholder="전화번호를 직접 입력하거나 메모장, 엑셀을 붙여넣기 한 후에 우측의 입력버튼을 눌러주세요. 두 개 이상의 전화번호는 꼭 엔터키로 구분해주세요."  class="width-100 height-70px background-transparent font-14px line-height-default"  style="overflow:scroll;overflow-x:hidden;overflow-y:hidden;" ></div>														
									
									</div>
									
									<ul class="float-left width-160px height-90px margin-left-10">
										<li class="width-100 margin-bottom-5"><a id="umPopGrpLstBtn" class="open_pop_book width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-16px font-053c72">주소록 불러오기</a></li>
										<li class="width-100"><a id="umPopExcelBtn" class="open_pop_excel width-100 height-40px line-height-40px text-center  border-radius-5 border-8bc5ff font-16px font-053c72">엑셀 불러오기</a></li>
									</ul>
									<a id="umManualInputBtn" class="float-right width-100px height-90px line-height-90px font-16px background-8bc5ff font-053c72 text-center border-radius-5">입력</a>
									<div class="clear margin-bottom-20"></div>
	
	
									<h3 class="font-18px font-174962 margin-bottom-10">수신자 목록 <span class="font-bold" id="umRcvCnt"></span></h3>
									<div class="height-210px border-box scroll-y">
										<table id="tblsendmsg" class="con_tb width-100 " cellpadding="0" cellspacing="0" border="0">
											<thead>
												<tr>
													<th class="width-20">이름</th>
													<th class="width-20">전화번호</th>
													<th class="width-20">비고</th>
													<th class="width-20">관리</th>
												</tr>
											</thead>											
											<tbody id="msglist"></tbody>
										</table>
									</div>
	
									<div class="width-100 margin-top-10 padding-left-10 border-box">
										<!-- <div class="checkbox-small_2">
											<input type="checkbox" id="check_1" name="checkInput" />
											<label for="check_1"></label>
										</div> -->
										<span class="inline-block margin-left-5 margin-right-5 font-12px font-aaa">주소록 개별문자 </span>
										<select id="umContentsChangeOpt" class="select_white_small width-120px">
											<option value="이름" selected>이름</option>
											<option value="비고">비고</option>
										</select>
										<a id="umContentsChangeBtn" class="width-55px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">입력</a>
										
										<c:if test="${workSeqRequiredFlag != 'ND'}" >
										<span class="inline-block margin-left-20 margin-right-5 font-12px font-aaa">업무분류</span>
										<select id="umJobOpt" name="umJobOpt" class="select_white_small width-120px">										
										</select>
										</c:if>
										<span id="umCost" class="inline-block float-right margin-top-5 margin-right-10 font-14px font-aaa font-bold font-053c72">
											<span class="inline-block margin-right-10 font-12px font-aaa font-normal">예상비용</span><span id="umPrice"></span>
										</span>
									</div>
									<div class="clear margin-bottom-30"></div>
									<div class="relative float-left width-650px height-110px border-box border-radius-5 margin-bottom-10 hidden box-shadow-smallest background-f9fbfd">
										<ul class="absolute position-left position-vertical-center">
											<li class="relative width-100 height-30px margin-bottom-5 padding-left-10">
												<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
													<div class="radio_s">
														<input type="radio" id="s_1" name="umSendTime" value="0" checked />
														<label for="s_1"><span></span></label>
													</div> 즉시발송
												</div>
											</li>
											<li class="relative width-100 height-30px margin-bottom-5 padding-left-10">
												<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
													<div class="radio_s">
														<input type="radio" id="s_2" name="umSendTime"  value="1"  />
														<label for="s_2"><span></span></label>
													</div> 예약발송
												</div>
												<!--예약발송 달력박스 -->
												<div class="absolute position-vertical-center width-330px" style="left:100px; _display:none;">  
													<div class="inline-block relative width-140px height-30px line-height-30px text-right  border-radius-5 border-8bc5ff border-box margin-right-5">
 	
										<input type="date" id="umDataPicker" name="umDataPicker"	value="" 
													class="text-right font-174962 font-14px padding-0 margin-0 height-30px line-height-30px background-transparent" />
													</div>
													<div class="inline-block relative width-140px height-30px line-height-30px text-right  border-radius-5 border-8bc5ff border-box margin-right-5">
 	
										<input type="time" id="umTimePicker" name="umTimePicker" value="" 
													class="text-right font-174962 font-14px padding-0 margin-0 height-30px line-height-30px background-transparent" />


													</div>
												</div>
										
											</li>
											<li class="relative width-100 height-30px padding-left-10">
												<div class="absolute position-left position-vertical-center radio-box_s font-16px font-053c72 ">
													<div class="radio_s">
														<input type="radio" id="s_3" name="umSendTime"  value="2" />
														<label for="s_3"><span></span></label>
													</div> 테스트발송
												</div>
												<!--테스트발송 체크시 입력박스-->
												<input type="text" id="umTestInput" name="testcontent" placeholder="테스트발송입니다" class="absolute position-vertical-center width-200px height-30px line-height-30px   border-e8e8e8 background-fff border-box border-radius-5 font-14px line-height-default none" style="left:110px;" />
											</li>
										</ul>
									</div>
									<ul class="float-right width-230px height-120px">
										<li class="width-100 margin-bottom-10"><a id="umPreviewBtn" class="open_pop_preview width-100 height-50px line-height-50px text-center border-radius-5 background-efefef font-20px font-bold font-053c72">미리보기</a></li>
										<li class="width-100"><a id="umSendMsgBtn"class="width-100 height-50px line-height-50px text-center  border-radius-5 background-8bc5ff font-20px font-bold  font-053c72"><span id="umTotalCnt"></span>전송하기</a></li>
									</ul>
									<div class="clear"></div>

								</li>
							</ul>
							<div class="loading_bar">
							  <div></div>
							  <div></div>
							  <div></div>
							  <div></div>
							</div>
						</div>
					</li>
				</ul>
			</div>
			
		 <!-- popup 이미지 업로드 -->
         <div class="pop_wrap umPopImgUpload width-600px padding-20 border-radius-5 background-f7fafc">
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
		 	
		 	
		 	<form id="umForm" enctype="multipart/form-data" method="POST" action="/msg/imgFileupload.do"> 
				<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-50">
					이미지선택
					<input id="um_img_name" class="upload-name" value="" disabled="disabled" placeholder="제목 (최대 30Byte)" />
					<label for="um_img_file">찾아보기</label> 
					<input type="file" id="um_img_file" name="file" required="required"  />		
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
									<input type="checkbox" id="um_img_resize_check" name="체크" />
									<label for="um_img_resize_check"></label>
							</div> 체크하면 오리지널 이미지 파일이 올라갑니다.</span>
					</li>
				</ul>
			</div>
			
			<!--버튼-->
			<div class="pop_btn-big">
				<a id="umImgRegBtn" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>





 		<!-- popup 엑셀 --> 		
         <div id="msg_pop_excel" class="pop_wrap pop_excel width-730px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">문자보내기 엑셀 등록하기</div>
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">	
			
			  	<form id="umExcelFile" action=/msg/excelFileupload.do" method="post" enctype="multipart/form-data">		  
				<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-90">
					엑셀파일 찾기
					<input class="upload-name" value="" disabled="disabled" placeholder="파일명" />
					<label for="umInputImgFile">찾아보기</label> 
					<input type="file" id="umInputImgFile" class="upload-hidden" /> 
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
				<a id="umPopExcelRegBtn" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div>
					
	

 		<!-- popup 주소록 가져오기 --> 	
        <div id="msg_pop_group" class="pop_wrap pop_excel_book width-730px" style="background:transparent;">
			<div class="width-100">
				<ul class="pop_tabmenu_excel">
					<li id="pop_tab_2" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_excel" id="pop_tabmenu_excel_2"  >
						<label for="pop_tabmenu_excel_2">주소록 불러오기</label>
						<div class="pop_tabCon">
							<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000 padding-20">
							<table cellpadding="0" cellspacing="0" border="0" class="width-100 height-210px margin-auto">
								<tr>
									<td class="width-330px height-240px vertical-top">
										<h5 class="font-18px font-normal font-174962 text-left">주소록보기</h2>
										<ul class="tabmenu_small">
											<li id="small_tab_1" class="btnCon">
												<input type="radio" checked name="tabmenu_small" value="0" id="tabmenu_small_1">
												<label for="tabmenu_small_1">개인</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="um_pop_my_group_list width-100 li-h30">
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_2" class="btnCon umPartTab">
												<input type="radio" name="tabmenu_small" value="1" id="tabmenu_small_2">
												<label for="tabmenu_small_2" id="umPartTab"></label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="um_pop_part_group_list  width-100 li-h30">
														</ul>
													</div>
												</div>
											</li>
											
											<li id="small_tab_3" class="btnCon umEmployTab">
												<input type="radio" name="tabmenu_small" value="3" id="tabmenu_small_3">
												<label for="tabmenu_small_3">직원</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scrol-y font-12px">
														<ul class="um_pop_employ_group_list  width-100 li-h30">
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_4" class="btnCon umShareTab">
												<input type="radio" name="tabmenu_small"  value="2" id="tabmenu_small_4">
												<label for="tabmenu_small_4" id="umShareTab"></label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="um_pop_share_group_list width-100 li-h30">
														</ul>
													</div>
												</div>
											</li>
											
										</ul>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="umGrpPrvBtn icon_group">그룹</a>
									</td>
									<td rowspan="2" class="vertical-top width-230px">
										<h5 class="font-18px font-normal font-174962 text-left">연락 받을 사람<a  id="umRecentLstBtn" class="width-55px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest float-right">최근</a></h2>
										
<div id="umPopRecentLayer">
<ul id="umRecentLst"></ul>
</div>
<!-- //폼 레이어  -->
										<div id="umRecent" class="width-230px height-480px hidden scroll-y font-12px border-radius-5 border-e8e8e8" style="height:485px;">
											<ul class="um_pop_receiver width-100 li-h30"></ul>
										</div>
										   <!-- 폼 레이어  -->
									</td>
								</tr>
								<tr>
									<td class="width-330px height-240px vertical-top ">
										<h5 class="font-18px font-normal font-174962 text-left">선택그룹 상세보기</h2>
										<div class="width-330px height-210px hidden scroll-y font-12px border-radius-5 border-e8e8e8">
											<ul class="um_pop_detail_list width-100 li-h30">
												<li class="search">
													<select class="select_white_small width-70px">
														<option>이름</option>
													</select>
													<input type="text" name="" />
													<a href="#">입력</a>
												</li>
											</ul>
											<ul class="msg_group_user width-100 li-h30"></ul>
										</div>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="umIndivPrvBtn icon_each">개별</a>
									</td>
								</tr>
							</table>
							<div class="margin-top-5 text-right">
								<a id="umPopDelSelect" class="msg_addr_delete_sel width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest ">선택삭제</a>
								<a id="umPopDelAll" class="msg_addr_delete_all width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">전체삭제</a>
							</div>
							</div>
							<!--버튼-->
							<div class="pop_btn-big margin-auto text-center margin-bottom-10">
								<a id="umPopRegisterBtn" class="margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
								<a id="umPopCancelBtn" class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>
   
   


     
        
        <!-- popup 미리보기 -->
         <div id="umPreviewPopUp" class="pop_wrap width-800px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">미리보기</div>
				<!--내용-->
				<div class="flex-between margin-top-20">
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="umPreviewTitle1"></h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="umPreviewContents1"  contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="umPreviewRcvNum1">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="umPreviewRcvNum1">01087654387</span>
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="umPreviewTitle2">내용 (최대 30Byte)</h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="umPreviewContents2"  contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="umPreviewRcvNum2">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="umPreviewSendNum2">01087654387</span>
							</div>
						</div>
					</div>
					<div class="flex width-30 border-box">
						<div class="width-100">
							<h5 class="font-18px font-normal font-174962 text-left" id="umPreviewTitle3">테스트</h2>
							<div class="relative width-100 height-380px padding-20 border-e8e8e8 background-transparent border-box border-radius-5 margin-bottom-10 hidden" style="padding-bottom: 5px;">
							<div id="umPreviewContents3"  contentEditable="true" readonly></div>
							</div>
							<div class="text-left font-12px font-6f6f6f margin-top-10">
								<span class="inline-block margin-right-10 font-bold">수신번호</span><span id="umPreviewRcvNum3">01087654387</span><br>
								<span class="inline-block margin-right-10 font-bold margin-top-5">발신번호</span><span id="umPreviewSendNum3">01087654387</span>
							</div>
						</div>
					</div>		
				</div>
				<!--버튼-->
				<div class="margin-auto text-center margin-top-30 margin-bottom-10">
					<a class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
				</div>
        </div>
        
        
         <!-- popup 내저장함 -->
         <div id="umMyBoxPopUp" class="pop_wrap"  style="background:transparent; width:1300px;">

			<div class="width-100">
				<ul class="pop_tabmenu_um_mybox">
					<li id="pop_tab1" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_um_mybox" id="pop_tabmenu1" checked>
						<label for="pop_tabmenu1">단문</label>
						<div class="pop_tabCon" style="width: auto;">
							
							
							<!-- 검색하기 --> 
			<div class="margin-bottom-20">

				<!--제목  셀렉박스-->
				<select class="select_blank_lightblue width-120px"
					style="margin-right: 10px">
					<option selected>제목</option>
					<option>내용</option>
					<option>기간</option>
				</select>

				<!--검색-->
				<div class="inline-block width-250px">
					<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
				</div>
				<a class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
				</div>
			<!-- //검색설정 -->
							<!--내용-->
							<div class="flex-between">
								
					<table id="umTemplateS" style="padding-bottom: 10px; width: 100%">
						<thead height="0" style="display: none;">
							<tr height="0">
								<th height="0">검수상태</th>
								<th height="0">내용</th>
							</tr>
						</thead>
					</table>
							 
																
							</div>
							<!--내용--> 
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a OnClick="destroyTableUM()" class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
					<li id="pop_tab2" class="btnCon">
						<input type="radio" name="pop_tabmenu_um_mybox" id="pop_tabmenu2">
						<label for="pop_tabmenu2">장문</label>
						<div class="pop_tabCon" style="width: auto;">
							<!--검색-->
							<div class="margin-bottom-20">
								<select class="select_blank_lightblue width-140px" style="margin-right:10px">
									<option selected>제목</option>
									<option >내용</option>
									<option >기간</option>
								</select>
								<div class="inline-block width-350px">
									<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
								</div>
								<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
							</div>

							<!--내용-->
							<div class="flex-between">

					<table id="umTemplateL" style="padding-bottom: 10px; width: 100%">
						<thead height="0" style="display: none;">
							<tr height="0">
								<th height="0">검수상태</th>
								<th height="0">내용</th>
							</tr>
						</thead>
					</table>		
										
							</div>
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a OnClick="destroyTableUM()" class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
					<li id="pop_tab3" class="btnCon">
						<input type="radio" name="pop_tabmenu_um_mybox" id="pop_tabmenu3">
						<label for="pop_tabmenu3">멀티</label>
						<div class="pop_tabCon" style="width: auto;">
							<!--검색-->
							<div class="margin-bottom-20">
								<select class="select_blank_lightblue width-140px" style="margin-right:10px">
									<option selected>제목</option>
									<option >내용</option>
									<option >기간</option>
								</select>
								<div class="inline-block width-350px">
									<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
								</div>
								<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
							</div>

							<!--내용-->
							<div class="flex-between" style="height: 400px;">
								
					<table id="umTemplateM" style="padding-bottom: 10px; width: 100%">
						<thead height="0" style="display: none;">
							<tr height="0">
								<th height="0">검수상태</th>
								<th height="0">내용</th>
							</tr>
						</thead>
					</table>							
							</div>
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a OnClick="destroyTableUM()" class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
					<li id="pop_tab4" class="btnCon">
						<input type="radio" name="pop_tabmenu_um_mybox" id="pop_tabmenu4">
						<label for="pop_tabmenu4">친구톡</label>
						<div class="pop_tabCon" style="width: auto;">
							<!--검색-->
							<div class="margin-bottom-20">
								<select class="select_blank_lightblue width-140px" style="margin-right:10px">
									<option selected>제목</option>
									<option >내용</option>
									<option >기간</option>
								</select>
								<div class="inline-block width-350px">
									<input type="text" name="" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
								</div>
								<a class="width-50px height-40px line-height-40px margin-left-5 font-16px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
							</div>

							<!--내용-->
							<div class="flex-between">
								
					<table id="umTemplateF" style="padding-bottom: 10px; width: 100%">
						<thead height="0" style="display: none;">
							<tr height="0">
								<th height="0">검수상태</th>
								<th height="0">내용</th>
							</tr>
						</thead>
					</table>
												
							</div>
							<!--버튼-->
							<div class="margin-auto text-center margin-bottom-10">
								<a OnClick="destroyTableUM()" class="pop_close inline-block border-radius-5 text-center font-053c72 font-bold font-18px width-230px height-45px line-height-45px background-8bc5ff box-shadow">확인</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>
</body>
</html>
