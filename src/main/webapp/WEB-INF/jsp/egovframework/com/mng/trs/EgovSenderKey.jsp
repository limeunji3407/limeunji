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
</head>

<script type="text/javaScript" language="javascript" defer="defer"> 

$(document).ready(function() {


    $('.bs-callout-info').toggleClass('hidden', true);
    $('.bs-callout-warning').toggleClass('hidden', true);
	
	
	$('#sdky-form').parsley().on('field:validated', function() {
	    var ok = $('.parsley-error').length === 0;
	  
	    $('.bs-callout-info').toggleClass('hidden', !ok);
	    $('.bs-callout-warning').toggleClass('hidden', ok);
	  })
	  .on('form:submit', function() {
	    return false; // Don't submit form for this demo
	  });

	 var oTable = $('#tblsenderkey').DataTable({
	     dom: "frtip",
	     ajax: {
	     	"type" : "POST",
	        "url" : "<c:url value='/getSenderKey.do' />",
	        "dataType": "JSON"
	     },
	    columns: [  
	                   { data: "senderKey" },
	                   { 
		   			    	data: "senderKeyType",
		   		    		render: function(data) { 
	                              		if(data == 'S') {
	                                		return '발신'; 
			   	                	   	  }else if(data == 'G'){
			   	                		   return '그룹';
			   	                	   	  }else{
			                           	   return '';
			                              }
	                            }  
	   			   	   },
	                   { data: "profileName" },
	                   { data: "profileUuid" },
	                   { data: "regDate" },
                   	   { data: "useYn" },
                   	   { data: "partName" },
                   	   {
                   		   data: null,
                          	className: "center",
                            defaultContent: '<a id="deleteData" class="icon_delete ">삭제</a>'
                   	   }
	     ],
	     paging : true,
		info : true,
		filter : false,
		language : {"url" : "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"}
	 });

	 $('#tblsenderkey tbody').on( 'click', '#deleteData', function (e) {
		 	e.stopPropagation();
			if (confirm("정말 삭제하시겠습니까??") == true){    //확인
				var obj = oTable.row($(this).closest('tr')).data();
			    $.ajax({
			    	url: "<c:url value='/mng/delSenderKey.do' />",
			       	type: "POST",
		        	data: obj,
			    	dataType: "json",
			       	success: function(jsondata){ 
			            if(jsondata["data"]==0){
			            	$(".pop_bg").css('display','none');
			    			$(".pop_modify").css('display','none');
			            	oTable.ajax.reload();
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

	 $('#tblsenderkey tbody').on( 'click', 'tr', function (e) {
			var obj = oTable.row($(this).closest('tr')).data();
			$(".pop_bg").css('display','block');
			$(".pop_modify").css('display','block');
			$("#Selsenderkey").val(obj.senderKey);
			$("#Selsenderkey_type").val(obj.senderKeyType);
			$("#Selprofile_name").val(obj.profileName);
			$("#Selprofile_uuid").val(obj.profileUuid);
			$("#SelUsePart").val(obj.partId);
			$("#SelSenderKeySeq").val(obj.senderKeySeq);
	    } );
	 
	 $('#updateSenderKey').on( 'click',  function () {
		 
		var senderKey = $("#Selsenderkey").val();
		var senderKeyType = $("#Selsenderkey_type").val();
		var	senderKeyName = $("#Selprofile_name").val();
		var	senderKeyUuid = $("#Selprofile_uuid").val();
		var	senderKeyUsePart = $("#SelUsePart").val();
		var	senderKeySeq = $("#SelSenderKeySeq").val();
			
		 var obj = {
				"senderKey": senderKey, 
				"senderKeyType" : senderKeyType,
				"profileName" : senderKeyName,
				"profileUuid" : senderKeyUuid,
				"partId" : senderKeyUsePart,
				"senderKeySeq" : senderKeySeq
		 }
		    $.ajax({
		    	url: "<c:url value='/mng/updSenderKey.do' />",
		       	type: "POST",
	        	data: obj,
		    	dataType: "json",
		       	success: function(jsondata){ 
		            
		            if(jsondata["data"]==0){
		            	$(".pop_bg").css('display','none');
		    			$(".pop_modify").css('display','none');
		            	oTable.ajax.reload();
		            }else{
		          	  alert("수정 할 수 없습니다.");
		            }
		       	},
		       	error: function(request,status,error){
		       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
		       	}
		   	});
		}); 
});

function validateForm() {
	$('#sdky-form').parsley().validate();
    if (!$('#sdky-form').parsley().isValid()) {
    	return;
    }
	
	$('#addSenderKeyBtn').attr('disabled', true);		
	
    var skey = $('input[name="senderkey"]').val(); 
    var skeytype = $("#senderkey_type option:selected").val();
    var pname = $('input[name="profile_name"]').val(); 
    var puuid = $('input[name="profile_uuid"]').val(); 
    var part_id = $("#part_id option:selected").val();
	
	var obj = {
		"senderKey": skey, 
		"senderKeyType" : skeytype,
		"profileName" : pname,
		"profileUuid" : puuid,
		"partId" : part_id
	};
 	$.ajax({
    	url: "<c:url value='/mng/insSenderKey.do' />",
    	type: "POST",
        data: obj,
        dataType: "json",
        beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
    		$('#addSenderKeyBtn').attr('disabled', false);
        },
		complete:function(){
            $('.wrap-loading').addClass('display-none');
    		$('#addSenderKeyBtn').attr('disabled', false);
        },
        success: function(jsondata){  
            if(jsondata["data"]==0){
                toastr.success("성공적으로 입력 되었습니다.");
                $('#addSenderKeyBtn').attr('disabled', false);
           		location.href  ="/mng/senderkey"
          	  
            }else{
          	  alert("양식을 다시 확인하길 바랍니다.");
            }
       	},
    	error: function(request,status,error){
    		console.log("[ajax error]");
    		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
        	$('#result').text(jsondata);
    		$('#addSenderKeyBtn').attr('disabled', false);
    	}
	});
}
</script>
<body>
	<!--contents-->
	<div class="con-inner">
		<!--타이틀-->
		<h1 class="con-title">
			<ul>
				<li>카카오senderkey관리</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>전송관리</li>
				<li><span class="dot"></span>카카오senderkey관리</li>
			</ul>
		</h1>


		<!-- 검색하기 -->
		<div
			class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">

			<!-- 검색결과 -->
			<div
				class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
				<div class="table_result_tit">
					<a class="background-053c72 open_pop_new">신규등록</a>
				</div>
				<table id="tblsenderkey" class="con_tb width-100" cellpadding="0"
					cellspacing="0" border="0" style="table-layout: fixed">
					<thead>
						<tr>
							<th class="width-25">senderkey</th>
							<th class="width-10">키타입</th>
							<th class="width-10">프로필명</th>
							<th class="width-10">UUID</th>
							<th class="width-15">등록일</th>
							<th class="width-10">사용여부</th>
							<th class="width-15">사용부서</th>
							<th class="width-10">수정/삭제</th>
						</tr>
					</thead>
				</table>
			</div>
			<!-- //검색결과 -->
		</div>
	</div>






	<!-- popup_신규등록 -->
	<div class="pop_wrap pop_new width-430px">
		<div class="pop_tit">카카오senderkey 신규등록</div>
		<form id="sdky-form" data-parsley-validate="">
			<div class="width-100 padding-bottom-10 border-bottom-e9eced">
				<table class="width-100" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th class="width-100px font-000 font-16px text-left">Senderkey</th>
						<td class="text-left"><input type="text" name="senderkey"
							placeholder=""
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" required=""
							data-parsley-required="true" data-parsley-trigger="change"
							data-parsley-type="digits" data-parsley-maxlength="11" /></td>
					</tr>
					<tr>
						<th class="font-000 font-16px text-left">키타입</th>
						<td class="text-left"><select title=""
							class="select_blank_blue width-100 border-8bc5ff"
							name="senderkey_type" id="senderkey_type" required=""
							data-parsley-required="true" data-parsley-trigger="change">
								<option value="">키 타입을 선택하세요</option>
								<option value="G">그룹</option>
								<option value="S">발신</option>
						</select> <!-- <input type="text" name="senderkey_type" placeholder="" class="input_blank width-100 border-box border-8bc5ff" style="padding-left:10px;" /> -->
						</td>
					</tr>
					<tr>
						<th class="font-000 font-16px text-left">프로필명</th>
						<td class="text-left"><input type="text" name="profile_name"
							placeholder=""
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" required=""
							data-parsley-required="true" data-parsley-trigger="change"
							data-parsley-maxlength="200" /></td>
					</tr>
					<tr>
						<th class="font-000 font-16px text-left">UUID</th>
						<td class="text-left"><input type="text" name="profile_uuid"
							placeholder=""
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" required=""
							data-parsley-required="true" data-parsley-trigger="change"
							data-parsley-maxlength="200" /></td>
					</tr>
					<tr>
						<th class="font-000 font-16px text-left vertical-align-top"><span
							class="inline-block margin-top-15">사용부서</span></th>
						<td class="text-left height-60px vertical-align-top">
							<!-- 검색박스 -->
							<div class="widht-100 margin-top-10">
								<select title="part_id" id="part_id" name="part_id" required=""
									class="select_white width-100 border-box border-8bc5ff">
									<c:forEach var="part_id" items="${partIdList}"
										varStatus="status">
										<option value="${part_id.orgnztId}"
											${part_id.orgnztId == provider ? 'selected="selected"' : '' }>${part_id.orgnztNm}</option>
									</c:forEach>
								</select>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<!-- 버튼 -->
		<div class="pop_btn">
			<!-- <a class=" background-8bc5ff border-8bc5ff font-fff margin-right-20" id="addSenderKeyBtn">등록</a> -->
			<input id="addSenderKeyBtn" type="submit" onClick="validateForm();"
				class="background-053c72 font-fff" value="등록"> <a
				class="pop_close background-fff border-6f6f6f font-6f6f6f">취소</a>
		</div>
	</div>

	<!-- popup_상세보기 -->
	<div class="pop_wrap pop_modify width-430px">
		<div class="pop_tit">카카오senderkey 상세보기</div>
		<input type="text" id="SelSenderKeySeq" hidden=""/>

		<form id="Selectsdky-form" data-parsley-validate="">
			<div class="width-100 padding-bottom-10 border-bottom-e9eced">
				<table class="width-100" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th class="width-100px font-000 font-16px text-left">Senderkey</th>
						<td class="text-left"><input type="text" id="Selsenderkey"
							placeholder=""
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" /></td>
					</tr>
					<tr>
						<th class="font-000 font-16px text-left">키타입</th>
						<td class="text-left"><select title=""
							class="select_blank_blue width-100 border-8bc5ff"
							name="Selsenderkey_type" id="Selsenderkey_type" required=""
							data-parsley-required="true" data-parsley-trigger="change">
								<option value="">키 타입을 선택하세요</option>
								<option value="G">그룹</option>
								<option value="S">발신</option>
						</select></td>
					</tr>
					<tr>
						<th class="font-000 font-16px text-left">프로필명</th>
						<td class="text-left"><input type="text" id="Selprofile_name"
							placeholder=""
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" /></td>
					</tr>
					<tr>
						<th class="font-000 font-16px text-left">UUID</th>
						<td class="text-left"><input type="text" id="Selprofile_uuid"
							placeholder=""
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;" /></td>
					</tr>
					<tr>
						<th class="font-000 font-16px text-left vertical-align-top"><span
							class="inline-block margin-top-15">사용부서</span></th>
						<td class="text-left height-60px vertical-align-top">
							<!-- 검색박스 -->
							<div class="widht-100 margin-top-10">
								<select title="SelUsePart" id="SelUsePart" name="SelUsePart" required=""
									class="select_white width-100 border-box border-8bc5ff">
									<option value="" disabled selected hidden>부서를 선택해주세요.</option>
									<c:forEach var="part_id" items="${partIdList}"
										varStatus="status">
										<option value="${part_id.orgnztId}"
											${part_id.orgnztId == provider ? 'selected="selected"' : '' }>${part_id.orgnztNm}</option>
									</c:forEach>
								</select>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<!-- 버튼 -->
		<div class="pop_btn">
			<a class=" background-8bc5ff border-8bc5ff font-fff margin-right-20" id="updateSenderKey">수정</a>
			<a class="pop_close background-fff border-6f6f6f font-6f6f6f">취소</a>
		</div>
	</div>
</body>
</html>
