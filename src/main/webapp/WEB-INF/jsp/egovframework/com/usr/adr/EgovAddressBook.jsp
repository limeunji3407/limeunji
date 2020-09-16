<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_empAddressTabDisplayFlag" var="g_empAddressTabDisplayFlag" />
<spring:message code="addressTabAll" var="addressTabAll" />
<spring:message code="g_address_capyCnt" var="g_address_capyCnt" />
<spring:message code="g_AddressGroupOrderBy" var="g_AddressGroupOrderBy" />
<spring:message code="g_addressTotalCountFlag" var="g_addressTotalCountFlag" />
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
.deleteBtn{
    width: 70px;
    height: 22px;
    line-height: 22px;
    text-align: center;
    border-radius: 15px;
    border: 1px solid #174962;
    background: #174962;
    color: #fff;
    font-size: 14px;
}
</style>
</head>
<body>
			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>개인주소록</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>주소록</li>
						<li><span class="dot"></span>개인주소록</li>
					</ul>
				</h1>

			<div class="width-1350px height-710px margin-bottom-100">
					<ul class="filetree_tabmenu">
						<li id="tab-1" class="btnCon">
	<c:import url="/usr/addressbookmy.do"></c:import>						
						</li>
						<li id="tab-2" class="btnCon">
	<c:import url="/usr/addressbookpart.do"></c:import>	
						</li>
						<li id="tab-3" class="btnCon">
	<c:import url="/usr/addressbookshare.do"></c:import>
						</li>
						<c:if test="${g_empAddressTabDisplayFlag eq 'Y'}" >	
						<li id="tab-4" class="btnCon">	
	<c:import url="/usr/addressbookemploy.do"></c:import>	
						</li>
						</c:if>
					</ul>
				</div>
			</div>




		 <!-- popup 그룹 -->
         <div class="pop_wrap pop_group width-430px border-radius-5 background-f7fafc" style="padding:0;">
			<ul class="group_wrapper border-bottom-e3e3e3">
				<li class="group_tit">그룹생성</li>
				<li class="group_inner">
					<table class="width-90 margin-auto con_tb" border="0">
						<colgroup>
							<col style="width:100px"/>
							<col style="width:40px"/>
							<col style=""/>
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
					<table class="width-90 margin-auto con_tb" border="0">
						<colgroup>
							<col style="width:125px"/>
							<col style=""/>
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

		 <!-- popup 주소록복사 -->
         <div class="pop_wrap pop_address width-730px" style="background:transparent;">
			<div class="width-100">
				<ul class="pop_tabmenu_excel">
					<li id="pop_tab_1" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_excel" id="pop_tabmenu_1">
						<label for="pop_tabmenu_1">주소록 불러오기</label>
						<div class="pop_tabCon">
							<div class="width-100 margin-auto text-center font-16px font-000 padding-20">
							<table cellpadding="0" cellspacing="0" border="0" class="width-100 height-210px margin-auto con_tb">
								<tr>
									<td class="width-330px height-200px vertical-top padding-bottom-40">
										<h5 class="font-18px font-normal font-174962 text-left">가져올 그룹/주소 선택</h5><span>한번에 최대 복사가능한 개수는 ${g_address_capyCnt }개 입니다.</span>
										<ul class="tabmenu_small">
											<li id="small_tab_0" class="btnCon">
												<input type="radio" name="tabmenu_small" value="0" id="tabmenu_small_0">
												<label for="tabmenu_small_0">개인</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30" id="AddressTextLeft">
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_1" class="btnCon">
												<input type="radio" checked name="tabmenu_small" value="1" id="tabmenu_small_1">
												<label for="tabmenu_small_1">부서</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30" id="pAddressText">
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_2" class="btnCon">
												<input type="radio" name="tabmenu_small" value="3" id="tabmenu_small_2">
												<label for="tabmenu_small_2">직원</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30" id="eAddrssText">
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_3" class="btnCon">
												<input type="radio" value="2" name="tabmenu_small" id="tabmenu_small_3">
												<label for="tabmenu_small_3">공유</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30" id="sAddressText">
														</ul>
													</div>
												</div>
											</li>
										</ul>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="icon_group groupCopy">그룹</a>
									</td>
									<td rowspan="2" class="vertical-top width-220px">
										<h5 class="font-18px font-normal font-174962 text-left">주소록</h5>
										
										
										<ul class="tabmenu_small2">
											<li id="small_tab_4" class="btnCon">
												<input type="radio" value="0" checked name="tabmenu_small2" id="tabmenu_small_4">
												<label for="tabmenu_small_4">개인</label>
												<div class="small_tabCon">
													<div class="width-255px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30" id="AddressText">
														</ul>
													</div>
												</div>
											</li>
											
											<li id="small_tab_5" class="btnCon">
												<input type="radio" value="1" name="tabmenu_small2" id="tabmenu_small_5">
												<label for="tabmenu_small_5">부서</label>
												<div class="small_tabCon">
													<div class="width-255px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30" id="pAddressTextRight">
														</ul>
													</div>
												</div>
											</li>
											
											<li id="small_tab_6" class="btnCon">
												<input type="radio" value="2" name="tabmenu_small2" id="tabmenu_small_6">
												<label for="tabmenu_small_6">공유</label>
												<div class="small_tabCon">
													<div class="width-255px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30" id="sAddressTextRight">
														</ul>
													</div>
												</div>
											</li>
										</ul>
										
										
										
										
										
										
										
										
										
										
									</td>
								</tr>
								<tr>
									<td class="width-330px height-220px vertical-top ">
										<h5 class="font-18px font-normal font-174962 text-left">선택그룹 상세보기</h5>
										<div class="width-330px height-220px hidden scroll-y font-12px border-radius-5 border-e8e8e8">
											<ul class="width-100 li-h30" id="searchAddressText">
											</ul>
										</div>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="icon_each othderCopy">개별</a>
									</td>
								</tr>
							</table>
							<div class="margin-top-5 text-right">
								<a class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest addressUserDetailDelete">선택삭제</a>
								<a class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5 addressUserAllDelete">전체삭제</a>
							</div>
							</div>
							<!--버튼-->
							<div class="pop_btn-big margin-auto text-center margin-bottom-10">
<!-- 								<a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">복사하기</a> -->
								<a class="pop_close background-efefef width-70px font-053c72 font-normal">닫기</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
        </div>

		 <!-- popup 엑셀등록 -->
         <!-- <div class="pop_wrap pop_call_excel width-730px background-f7fafc border-radius-5">
			<div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">엑셀 주소 등록</div>
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
				<div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-90">
					엑셀파일 찾기
					<input class="upload-name" value="" disabled="disabled" placeholder="선택된 파일 없음" />
					<label for="fileadr">찾아보기</label> 
					<input type="file" id="fileadr" class="upload-hidden" /> 
				</div>
				<ul class="pop_notice" style="padding-left:90px">
					<li>엑셀양식파일 : <a href="#">엑셀양식 다운로드</a></li>
					<li>최대 10만건 까지 등록할 수 있습니다.</li>
					<li>엑셀등록시 휴대폰 번호는 필수값입니다.</li>
					<li>휴대폰 번호는 반드시 0으로 시작해야 합니다.</li>
				</ul>
			</div>
			버튼
			<div class="pop_btn-big margin-auto text-center margin-bottom-10">
				<a id="adr_reg_excel" class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
				<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
			</div>
        </div> -->

</body>
</html>
<script type="text/javaScript" language="javascript" defer="defer"> 

var g_addressTotalCountFlags = "${g_addressTotalCountFlag}";



var adrRol = "${loginVO.adr_role}";
var u_orgnztId = "${loginVO.orgnztId}";
var g_AddressGroupOrderBy = "${g_AddressGroupOrderBy}";
var jstreePlugins = ['state','dnd','contextmenu','wholerow'];
if(g_AddressGroupOrderBy == '2'){
	jstreePlugins = ['state','contextmenu','wholerow'];
}
var g_group_my = {}; 
var g_group_employ = {}; 
var g_group_part = {}; 
var g_group_share = {};

var g_address_obj = {};
var g_address_type = "";
var groupArray = [];
var groupArrayE = [];
var groupArrayP = [];
var groupArrayS = [];

var treedataM = []; 
var treedataP = []; 
var treedataE = []; 
var treedataS = []; 

var oTableM;
var oTableP;
var oTableE;
var oTableS;

var jsTreeM;
var jsTreeP;
var jsTreeE;
var jsTreeS;

var editorM;
var editorP;
var editorE;
var editorS;

var ajaxDataM = {};
var ajaxDataP = {};
var ajaxDataE = {};
var ajaxDataS = {};


	
	var g_address_capyCnt = "${g_address_capyCnt}";
	var globalGroupArray = new Array();
	var globalGroupArrayP = new Array();
	var globalGroupArrayS = new Array();
	var globalGroupArrayE = new Array();
	
	var globalId = "${loginVO.id}";
	var globalOrgnztId = "${loginVO.orgnztId}";
	var addressTabAll = "${addressTabAll}";
	
	
	function getListFilter(data, key, value){
		var retObj = [];
		
			$.each(data, function(){
				if(this[key]==value){
					retObj.push(this);
				}
			});
			
		return retObj;
	}

	
	function myAddressFun(isRefresh){
		$(".searchAddressLi2").remove();
		
		groupArray = new Array();
		globalGroupArray = new Array();
		g_group_my = {};
		treedataM = []; 
		
		/*
			개인, 직원
		*/
		$.ajax({
	    	url: "/grp/AddrGroupListByType.do?type=0",  //msg/rcv/EgovRcvaddrList
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
    			g_group_my = getListFilter(jsondata.data, "type", "0");
    			
    			
    			g_group_my.sort(function(a,b){ //내림차순
    				return a.sequence < b.sequence ? -1 : a.sequence > b.sequence ? 1 : 0;
    			});
    			
    			g_group_my.sort(function(a,b){ //내림차순
    				return a.parent < b.parent ? -1 : a.parent > b.parent ? 1:0;
    			}); 
    			
    			
    			$.each(g_group_my, function(idx, row){

	    			if(row.parent == 0 ){ //상위그룹일때
	    				
	    				var groupInfo = {};
	    				groupInfo.code = row.code;
	    				groupInfo.id = row.code;
	    				
	    				if(g_addressTotalCountFlags == 'Y'){
		    				groupInfo.text = row.title + "(" +row.groupcnt + ")";
	    				}else{
		    				groupInfo.text = row.title;
	    				}
	    				
	    				
	    				
	    				var k = g_group_my.filter(function(element){ 
	    			        return element.parent == row.code;
	    			    }); 
	    				
	    				groupInfo.nodes = k;
	    					
						var kk = k.length;
						groupInfo.nodes = k;
	    				if(kk == 0){    					
	    	    			groupArray.push(groupInfo);
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
	    	    			groupArray.push(groupInfo);
	    	    			
	    	    			idx = idx + kk;    	    			
	    				}
	    				
	    			}
	    		}); 
	    		 
	  		
				treedataM = [
					{ 
						'text' : '전체',
						'state' : {
							'opened' : true,
							'selected' : true
						},
						'children' : groupArray
					}
				];
	    		
	    		
	    		
	    		if(isRefresh){
	 	    		$('#menuTreeMy').jstree(true).settings.core.data = treedataM;
		    		$('#menuTreeMy').jstree(true).refresh();
	    		}else{
	    			if(addressTabAll == '1'){
		    			$('#menuTreeMy').jstree({
							'core' : {
								'data' : treedataM,
								'force_text' : true,
								'check_callback' : true,
								'themes' : {
									'responsive' : false
								}
							},
							'plugins' : jstreePlugins
							
						}).bind("loaded.jstree", function (event, data) {
					        $(this).jstree("open_all");
					    }).bind("move_node.jstree", function (event, data) {
							global.jstreeUpdateSequence(data, function(){});
					    }).bind("rename_node.jstree", function (event, data) {
							global.jstreeUpdate(data, function(){});
					    });
		    		}else{
		    			$('#menuTreeMy').jstree({
							'core' : {
								'data' : treedataM,
								'force_text' : true,
								'check_callback' : true,
								'themes' : {
									'responsive' : false
								}
							},
							'plugins' : jstreePlugins
						}).bind("move_node.jstree", function (event, data) {
							global.jstreeUpdateSequence(data, function(){});
					    }).bind("rename_node.jstree", function (event, data) {
							global.jstreeUpdate(data, function(){});
					    });
		    		}
	    		}
				
				
				$('.wrap-loading').addClass('display-none');
	    		$('#sendMsgBtn').attr('disabled', false);
	    		
	    		globalGroupArray = groupArray;
	    		console.log("----------------------")
	    		console.log(g_group_my)
	    		console.log("----------------------")
	    		var str = "";
	    		for(var i = 0 ; i < globalGroupArray.length ; i++){
	    			
	    			str+='\
	    				<li class="myAddressRadioListLi">\
		    			';
		    			var isChild = 'style="margin-left:30px"';
		    			if(!globalGroupArray[i].nodes || globalGroupArray[i].nodes.length <= 0){
		    				isChild = '';
			    			str+='\
			    				<div class="checkbox-small_2">\
									<input type="checkbox" class="myAddressRadioList" data-address-category="'+globalGroupArray[i].code+'" data-address-type="0" value="'+globalGroupArray[i].text+'" id="check4-'+i+'" name="체크" />\
									<label for="check4-'+i+'"></label>\
								</div> \
							';
		    			}
						str+='	<span '+isChild+'  >'+globalGroupArray[i].text+'<span></span></span>\
						</li>\
					';	
	    			
	    			
		    		for(var x = 0 ; x < globalGroupArray[i].nodes.length ; x++){
		    			str+='\
			    			<li class="myAddressRadioListLi">\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="myAddressRadioList" data-address-category="'+globalGroupArray[i].nodes[x].code+'"  data-address-type="0" value="'+globalGroupArray[i].nodes[x].title + "(" +globalGroupArray[i].nodes[x].groupcnt + ")"+'" id="check4-'+i+'" name="체크" />\
									<label for="check4-'+x+'"></label>\
								</div> \
								<span style="margin-left:30px" >'+globalGroupArray[i].nodes[x].title + "(" +globalGroupArray[i].nodes[x].groupcnt + ")"+'<span></span></span>\
							</li>\
						';	   
		    		}
						
						
						
	    		}
	    		$("#AddressText").html(str);
	    		
	    		
	    		var str = "";
	    		for(var i = 0 ; i < globalGroupArray.length ; i++){
	    			str+='\
		    			<li class="searchAddressLi">\
		    			';
		    			var isChild = 'style="margin-left:30px"';
		    			if(!globalGroupArray[i].nodes || globalGroupArray[i].nodes.length <= 0){
		    				isChild = '';
			    			str+='\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="searchCheck" id="check1-'+i+'" name="체크" />\
									<label for="check1-'+i+'"></label>\
								</div> \
							';
		    			}
							
						str+='	<span '+isChild+' class="searchAddressSpan" data-address-type="0" data-address-category="'+globalGroupArray[i].code+'">'+globalGroupArray[i].text+'<span></span></span>\
						</li>\
					';	    			
	    			for(var x = 0 ; x < globalGroupArray[i].nodes.length ; x++){
		    			str+='\
							<li class="searchAddressLi">\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="searchCheck" id="check1-'+x+'" name="체크" />\
									<label for="check1-'+x+'"></label>\
								</div> \
								<span style="margin-left:30px" class="searchAddressSpan" data-address-type="0" data-address-category="'+globalGroupArray[i].nodes[x].code+'">'+globalGroupArray[i].nodes[x].title + "(" +globalGroupArray[i].nodes[x].groupcnt + ")"+'<span></span></span>\
							</li>\
						';	   
		    		}
	    		}
	    		$("#AddressTextLeft").html(str);
    	    },
    	    error: function(request,status,error){
    	    		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    	    		$('#sendMsgBtn').attr('disabled', false);
    	            $('.wrap-loading').addClass('display-none');
    	    }
    	    
    	});	
	}
	
	/*
		부서
	*/
	function partAddressFun(isRefresh){
		
		
		groupArrayP = new Array();
		globalGroupArrayP = new Array();
		g_group_part = {};
		treedataP = []; 
		
		$.ajax({
	    	url: "/grp/AddrGroupListByType.do?orgnzt_id="+globalOrgnztId+"&type=1",  //msg/rcv/EgovRcvaddrList
	    	type: "POST",
	        dataType: "json",          // ajax 통신으로 받는 타입
	        contentType: "application/json",  // ajax 통신으로 보내는 타입
	    	success: function(jsondata){ 
	    		
	    		g_group_part = getListFilter(jsondata.data, "type", "1");
	    		
	    		
	    		g_group_part.sort(function(a,b){ //내림차순
					return a.sequence < b.sequence ? -1 : a.sequence > b.sequence ? 1 : 0;
				});
				
				g_group_part.sort(function(a,b){ //내림차순
					return a.parent < b.parent ? -1 : a.parent > b.parent ? 1:0;
				});	
				
				
				
				$.each(g_group_part, function(idx, row){
	
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
	    				
	    				
	    				var k = g_group_part.filter(function(element){ 
	    			        return element.parent == row.code;
	    			    }); 
						var kk = k.length;
						groupInfo.nodes = k;
	    				if(kk == 0){    					
	    	    			groupArrayP.push(groupInfo);
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
	    	    			groupArrayP.push(groupInfo);
	    	    			
	    	    			idx = idx + kk;    	    			
	    				} 
	    			}
	    		}); 
				treedataP = [
					{ 
						'text' : '전체',
						'state' : {
							'opened' : true,
							'selected' : true
						},
						'children' : groupArrayP
					}
				];
	    		
				
				if(isRefresh){
	 	    		$('#menuTreePart').jstree(true).settings.core.data = treedataP;
		    		$('#menuTreePart').jstree(true).refresh();
	    		}else{
	    			if(addressTabAll == '1'){
						$('#menuTreePart').jstree({
							'core' : {
								'data' : treedataP,
								'force_text' : true,
								'check_callback' : true,
								'themes' : {
									'responsive' : false
								}
							},
							'plugins' : jstreePlugins
						}).bind("loaded.jstree", function (event, data) {
					        $(this).jstree("open_all");
					    }).bind("move_node.jstree", function (event, data) {
							global.jstreeUpdateSequence(data, function(){});
					    }).bind("rename_node.jstree", function (event, data) {
							global.jstreeUpdate(data, function(){});
					    });
					}else{
						$('#menuTreePart').jstree({
							'core' : {
								'data' : treedataP,
								'force_text' : true,
								'check_callback' : true,
								'themes' : {
									'responsive' : false
								}
							},
							'plugins' : jstreePlugins
						}).bind("move_node.jstree", function (event, data) {
							global.jstreeUpdateSequence(data, function(){});
					    }).bind("rename_node.jstree", function (event, data) {
							global.jstreeUpdate(data, function(){});
					    });
					}
	    		}
				
				
				
				
				globalGroupArrayP = groupArrayP;
				
				var str = "";
	    		for(var i = 0 ; i < globalGroupArrayP.length ; i++){
	       			str+='\
	    				<li class="myAddressRadioListLi">\
		    			';
		    			var isChild = 'style="margin-left:30px"';
		    			if(!globalGroupArrayP[i].nodes || globalGroupArrayP[i].nodes.length <= 0){
		    				isChild = '';
			    			str+='\
			    				<div class="checkbox-small_2">\
									<input type="checkbox" class="myAddressRadioList" data-address-category="'+globalGroupArrayP[i].code+'" data-address-type="1" value="'+globalGroupArrayP[i].text+'" id="check4-'+i+'" name="체크" />\
									<label for="check4-'+i+'"></label>\
								</div> \
							';
		    			}
						str+='	<span '+isChild+'  >'+globalGroupArrayP[i].text+'<span></span></span>\
						</li>\
					';		
						
	    			for(var x = 0 ; x < globalGroupArrayP[i].nodes.length ; x++){
		    			str+='\
			    			<li class="myAddressRadioListLi">\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="myAddressRadioList" data-address-category="'+globalGroupArrayP[i].nodes[x].code+'" data-address-type="1" value="'+globalGroupArrayP[i].nodes[x].title + "(" +globalGroupArrayP[i].nodes[x].groupcnt + ")"+'" id="check4-'+i+'" name="체크" />\
									<label for="check4-'+x+'"></label>\
								</div> \
								<span style="margin-left:30px" >'+globalGroupArrayP[i].nodes[x].title + "(" +globalGroupArrayP[i].nodes[x].groupcnt + ")"+'<span></span></span>\
							</li>\
						';	   
		    		}
						
	    		}
	    		$("#pAddressTextRight").html(str);
				
	    		var str = "";
	    		for(var i = 0 ; i < globalGroupArrayP.length ; i++){
	    			
	    			str+='\
		    			<li class="searchAddressLi">\
		    			';
		    			var isChild = 'style="margin-left:30px"';
		    			if(!globalGroupArrayP[i].nodes || globalGroupArrayP[i].nodes.length <= 0){
		    				isChild = '';
			    			str+='\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="searchCheck" id="check1-'+i+'" name="체크" />\
									<label for="check1-'+i+'"></label>\
								</div> \
							';
		    			}
							
						str+='	<span '+isChild+'  class="searchAddressSpan" data-address-type="1" data-address-category="'+globalGroupArrayP[i].code+'">'+globalGroupArrayP[i].text+'<span></span></span>\
						</li>\
					';
						
	    			for(var x = 0 ; x < globalGroupArrayP[i].nodes.length ; x++){
		    			str+='\
							<li class="searchAddressLi">\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="searchCheck" id="check1-'+x+'" name="체크" />\
									<label for="check1-'+x+'"></label>\
								</div> \
								<span style="margin-left:30px" class="searchAddressSpan" data-address-type="1" data-address-category="'+globalGroupArrayP[i].nodes[x].code+'">'+globalGroupArrayP[i].nodes[x].title + "(" +globalGroupArrayP[i].nodes[x].groupcnt + ")"+'<span></span></span>\
							</li>\
						';	   
		    		}
	    		}
	    		$("#pAddressText").html(str);
	    		
	    	}
		})	
	}
	
	
	
	/*
		공유
	*/
	function ahareAddressFun(isRefresh){
			
		groupArrayS = new Array();
		globalGroupArrayS = new Array();
		g_group_share = {};
		treedataS = []; 
		
		$.ajax({
	    	url: "/grp/AddrGroupListByType.do?type=2",  //msg/rcv/EgovRcvaddrList
	    	type: "POST",
	        dataType: "json",          // ajax 통신으로 받는 타입
	        contentType: "application/json",  // ajax 통신으로 보내는 타입
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
	    			if(addressTabAll == '1'){
						$('#menuTreeShare').jstree({
							'core' : {
								'data' : treedataS,
								'force_text' : true,
								'check_callback' : true,
								'themes' : {
									'responsive' : false
								}
							},
							'plugins' : jstreePlugins
						}).bind("loaded.jstree", function (event, data) {
					        $(this).jstree("open_all");
					    }).bind("move_node.jstree", function (event, data) {
							global.jstreeUpdateSequence(data, function(){});
					    }).bind("rename_node.jstree", function (event, data) {
							global.jstreeUpdate(data, function(){});
					    });
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
							'plugins' : jstreePlugins
						}).bind("move_node.jstree", function (event, data) {
							global.jstreeUpdateSequence(data, function(){});
					    }).bind("rename_node.jstree", function (event, data) {
							global.jstreeUpdate(data, function(){});
					    });
					}
	    		}
	    		
				
				globalGroupArrayS = groupArrayS;
	    		var str = "";
	    		
	    		for(var i = 0 ; i < globalGroupArrayS.length ; i++){
					
						str+='\
		    				<li class="myAddressRadioListLi">\
			    			';
			    			var isChild = 'style="margin-left:30px"';
			    			if(!globalGroupArrayS[i].nodes || globalGroupArrayS[i].nodes.length <= 0){
			    				isChild = '';
				    			str+='\
				    				<div class="checkbox-small_2">\
										<input type="checkbox" class="myAddressRadioList" data-address-category="'+globalGroupArrayS[i].code+'" data-address-type="2" value="'+globalGroupArrayS[i].text+'" id="check4-'+i+'" name="체크" />\
										<label for="check4-'+i+'"></label>\
									</div> \
								';
			    			}
							str+='	<span '+isChild+'  >'+globalGroupArrayS[i].text+'<span></span></span>\
							</li>\
						';			
						
						
	    			for(var x = 0 ; x < globalGroupArrayS[i].nodes.length ; x++){
		    			str+='\
			    			<li class="myAddressRadioListLi">\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="myAddressRadioList" data-address-category="'+globalGroupArrayS[i].nodes[x].code+'" data-address-type="2" value="'+globalGroupArrayS[i].nodes[x].title + "(" +globalGroupArrayS[i].nodes[x].groupcnt + ")"+'" id="check4-'+i+'" name="체크" />\
									<label for="check4-'+x+'"></label>\
								</div> \
								<span style="margin-left:30px" >'+globalGroupArrayS[i].nodes[x].title + "(" +globalGroupArrayS[i].nodes[x].groupcnt + ")"+'<span></span></span>\
							</li>\
						';	   
		    		}
	    		}
	    		$("#sAddressTextRight").html(str);
	    		
	    		var str = "";
	    		for(var i = 0 ; i < globalGroupArrayS.length ; i++){
	    			str+='\
		    			<li class="searchAddressLi">\
		    			';
		    			var isChild = 'style="margin-left:30px"';
		    			if(!globalGroupArrayS[i].nodes || globalGroupArrayS[i].nodes.length <= 0){
		    				isChild = '';
			    			str+='\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="searchCheck" id="check1-'+i+'" name="체크" />\
									<label for="check1-'+i+'"></label>\
								</div> \
							';
		    			}
							
						str+='	<span '+isChild+'  class="searchAddressSpan" data-address-type="2" data-address-category="'+globalGroupArrayS[i].code+'">'+globalGroupArrayS[i].text+'<span></span></span>\
						</li>\
					';	    
	    			for(var x = 0 ; x < globalGroupArrayS[i].nodes.length ; x++){
		    			str+='\
							<li class="searchAddressLi">\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="searchCheck" id="check1-'+x+'" name="체크" />\
									<label for="check1-'+x+'"></label>\
								</div> \
								<span style="margin-left:30px" class="searchAddressSpan" data-address-type="2" data-address-category="'+globalGroupArrayS[i].nodes[x].code+'">'+globalGroupArrayS[i].nodes[x].title + "(" +globalGroupArrayS[i].nodes[x].groupcnt + ")"+'<span></span></span>\
							</li>\
						';	   
		    		}
	    		}
	    		$("#sAddressText").html(str);
				
	    		
	    		
	    	}
		})	
	}
	/*
		직원
	*/
	function emAddressFun(isRefresh){
		$.ajax({
	    	url: "/grp/AddrGroupListByType.do?type=3",  //msg/rcv/EgovRcvaddrList
	    	type: "POST",
	        dataType: "json",          // ajax 통신으로 받는 타입
	        contentType: "application/json",  // ajax 통신으로 보내는 타입
	    	success: function(jsondata){ 
	    		console.log(jsondata)
	    		
	    		g_group_employ = getListFilter(jsondata.data, "type", "3");
	    		
	    		g_group_employ.sort(function(a,b){ //내림차순
					return a.sequence < b.sequence ? -1 : a.sequence > b.sequence ? 1 : 0;
				});
				
				g_group_employ.sort(function(a,b){ //내림차순
					return a.parent < b.parent ? -1 : a.parent > b.parent ? 1:0;
				});	
				
				
				$.each(g_group_employ, function(idx, row){
	
	    			if(row.parent == 0 ){ //상위그룹일때
	    				
	    				var groupInfo = {};
	    				groupInfo.code = row.code;
	    				groupInfo.id = row.code;
	    				if(g_addressTotalCountFlags == 'Y'){
		    				groupInfo.text = row.title + "(" +row.groupcnt + ")";
	    				}else{
		    				groupInfo.text = row.title;
	    				}
	    				
	    				
	    				var k = g_group_employ.filter(function(element){ 
	    			        return element.parent == row.code;
	    			    }); 
						var kk = k.length;
						groupInfo.nodes = k;
	    				if(kk == 0){    					
	    	    			groupArrayE.push(groupInfo);
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
	    	    			groupArrayE.push(groupInfo);
	    	    			
	    	    			idx = idx + kk;    	    			
	    				} 
	    			}
	    		}); //each finish
	    		
				treedataE = [
					{ 
						'text' : '전체',
						'state' : {
							'opened' : true,
							'selected' : true
						},
						'children' : groupArrayE
					}
				];  
	    		
	    		if(isRefresh){
	    			
	    		}else{
	    			if(addressTabAll == '1'){
						$('#menuTreeEmploy').jstree({
							'core' : {
								'data' : treedataE,
								'force_text' : true,
								'check_callback' : true,
								'themes' : {
									'responsive' : false
								}
							},
							'plugins' : jstreePlugins
						}).bind("loaded.jstree", function (event, data) {
					        $(this).jstree("open_all");
					    }).bind("move_node.jstree", function (event, data) {
							global.jstreeUpdateSequence(data, function(){});
					    }).bind("rename_node.jstree", function (event, data) {
							global.jstreeUpdate(data, function(){});
					    });
					}else{
						$('#menuTreeEmploy').jstree({
							'core' : {
								'data' : treedataE,
								'force_text' : true,
								'check_callback' : true,
								'themes' : {
									'responsive' : false
								}
							},
							'plugins' : jstreePlugins
						}).bind("move_node.jstree", function (event, data) {
							global.jstreeUpdateSequence(data, function(){});
					    }).bind("rename_node.jstree", function (event, data) {
							global.jstreeUpdate(data, function(){});
					    });
					}
	    		}
				
				globalGroupArrayE = groupArrayE;
	    		var str = "";
	    		for(var i = 0 ; i < globalGroupArrayE.length ; i++){
	    			str+='\
		    			<li class="searchAddressLi">\
		    			';
		    			var isChild = 'style="margin-left:30px"';
		    			if(!globalGroupArrayE[i].nodes || globalGroupArrayE[i].nodes.length <= 0){
		    				isChild = '';
			    			str+='\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="searchCheck" id="check1-'+i+'" name="체크" />\
									<label for="check1-'+i+'"></label>\
								</div> \
							';
		    			}
							
						str+='	<span '+isChild+'  class="searchAddressSpan" data-address-type="3" data-address-category="'+globalGroupArrayE[i].code+'">'+globalGroupArrayE[i].text+'<span></span></span>\
						</li>\
					';	    			
	    			for(var x = 0 ; x < globalGroupArrayE[i].nodes.length ; x++){
		    			str+='\
			    			<li class="myAddressRadioListLi">\
								<div class="checkbox-small_2">\
									<input type="checkbox" class="myAddressRadioList" data-address-category="'+globalGroupArrayE[i].nodes[x].code+'" data-address-type="3" value="'+globalGroupArrayE[i].nodes[x].title + "(" +globalGroupArrayE[i].nodes[x].groupcnt + ")"+'" id="check4-'+i+'" name="체크" />\
									<label for="check4-'+x+'"></label>\
								</div> \
								<span style="margin-left:30px" >'+globalGroupArrayE[i].nodes[x].title + "(" +globalGroupArrayE[i].nodes[x].groupcnt + ")"+'<span></span></span>\
							</li>\
						';	   
		    		}
	    		}
	    		$("#eAddrssText").html(str);
	    		
	    		
	    	}
		})	
	}
	

	function init(){
		myAddressFun(false);
		partAddressFun(false);
		ahareAddressFun(false);
		emAddressFun(false);
	}
	function reInit(){
		myAddressFun(true);
		partAddressFun(true);
		ahareAddressFun(true);
		emAddressFun(true);
	}
	
	setTimeout(function(){
		init()
	},2000)
</script>
<script>
$(function(){
	$('#menuTreeMy').on('activate_node.jstree', function (e, data) { 
		jsTreeM = data.node.text;  
    	var id = data.node.id; 
    	console.log("-----menuTreeMy_select_jstree------" + jsTreeM + ":oTable ajax---"  + JSON.stringify(oTableM.ajax) );

    	oTableM.ajax.reload();
	});
	
	
	$('#menuTreePart').on('activate_node.jstree', function (e, data) {
	
		jsTreeP = data.node.text;  
		var id = data.node.id; 
		console.log("-----menuTreePart_select_jstree------:u_orgnztId " + u_orgnztId + ":id--" + id + ":length"  + data.node.text );
	
		oTableP.ajax.reload();
	});
	
	$('#menuTreeShare').on('activate_node.jstree', function (e, data) {
	
		jsTreeS = data.node.text; 
		var id = data.node.id; 
		console.log("-----menuTreeShare_select_jstree------" + id + ":length"  + data.node.text );
	
	    oTableS.ajax.reload();
	});
	
	
	
	
	$('#menuTreeEmploy').on('activate_node.jstree', function (e, data) {
		jsTreeE = data.node.text;  
		var id = data.node.id; 
		console.log("-----menuTreeEmploy_select_jstree------" + id + ": data "  + data.node.text );
	
	    oTableE.ajax.reload();
	});
	
	
	$(".open_pop_group").click(function(){
		$("input[name='newGroupNm']").val("")
		var tabType = $("input[name='filetree_tabmenu']:checked").attr("data-tab-type");
		var str = "";
		var tempList;
		if(tabType == '0'){
			tempList = globalGroupArray;
		}else if(tabType == '1'){
			tempList = globalGroupArrayP;
		}else if(tabType == '2'){
			tempList = globalGroupArrayS;
		}else if(tabType == '3'){
			return false;
		}
		
		
		
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
		var type = $("input[name='filetree_tabmenu']:checked").attr("data-tab-type");
		if(type == '2'){
			if(adrRol != 'Y'){
				alert("전체권한 사용자가 아닌 사용자는 공유 주소록은 보기 기능만 가능합니다.")
				return;
			}
		}else if(type == '3'){
			alert("직원 주소록은 보기 기능만 가능합니다.")
			return;
		}
		
		var code = $(".group-del-select").val();
		var depth = $(".group-del-select").find("option:selected").data("depth");
		
		
		var url = "";
		if(type == '0'){
			url = "/getaddressbookmy.do";
		}else if(type == '1'){
			url = "/getaddressbookpart.do";
		}else if(type == '2'){
			url = "/getaddressbookshare.do";
		}else if(type == '3'){
			url = "/getaddressbookemploy.do";
		}
		
		var param = {
	        	"address_category":code,
	        	"address_type":type,
	        	"part_id":globalOrgnztId
	        	
	    }
		
		$.ajax({
	   		   type : "POST",
	   	    	url: url,
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
	   	    		    			reInit()
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
		var type = $("input[name='filetree_tabmenu']:checked").attr("data-tab-type");
		
		if(type == '2'){
			if(adrRol != 'Y'){
				alert("전체권한 사용자가 아닌 사용자는 공유 주소록은 보기 기능만 가능합니다.")
				return;
			}
		}else if(type == '3'){
			alert("직원 주소록은 보기 기능만 가능합니다.")
			return;
		}
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
	    			reInit()
	    		}
	    	},error: function(request,status,error){
	     		console.log(status)
	     		console.log(error)
	     	}
		});
	});	
	
	
	$(document).on("click", ".groupCopy", function(){
		
		var betype = $("input[name=tabmenu_small]:checked").val();
		var type = $("input[name=tabmenu_small2]:checked").val();
		
		if(betype == '0' && type != '1' && type != '2'){
			alert("개인주소록에서는 부서주소록, 공유주소록 으로만 복사가 가능합니다.");
			return;
		}
		if(betype == '0' && type == '2' && adrRol != 'Y'){
			alert("전체권한이 없는경우 공유주소록으로 복사를 할수 없습니다.");
			return;
		}
		if(betype == '1' && type != '0'){
			alert("부서주소록에서는 개인주소록 으로만 복사가 가능합니다.");
			return;
		}
		if(betype == '2' && type != '0'){
			alert("공유주소록에서는 개인주소록 으로만 복사가 가능합니다.");
			return;
		}
		if(betype == '3' && type != '0'){
			alert("직원주소록에서는 개인주소록 으로만 복사가 가능합니다.");
			return;
		}
		
		if(confirm("정말 복사하시겠습니까?")){
			
			var isCheck = $(".myAddressRadioList").is(":checked");
			if(!isCheck){
				alert("복사할 개인주소록의 그룹을 지정해주세요");		
				return;
			}
			var isCheck2 = $(".searchCheck").is(":checked");
			if(!isCheck2){
				alert("복사할 그룹을 지정해주세요");		
				return;
			}
			var tempList = $(".otherList");
			var addressIds = new Array();
			for(var i = 0 ; i < tempList.length ; i++){
				var temp = tempList.eq(i);
				var obj = {
					"address_id":temp.val()		
				}
				addressIds.push(obj)
			}
			var addressIdsLength = addressIds.length;
			if(addressIdsLength > parseInt(g_address_capyCnt)){
				alert("한번에 복사할 개수는 최대 "+ g_address_capyCnt + "개 까지 가능합니다.");
				return;
			}
			
			/*
			var address_grp_name = $(".myAddressRadioList:checked").val();
			address_grp_name = address_grp_name.substring(0, address_grp_name.indexOf("("));
			
			var param = {}
			if(type == '0' || type == '2'){
				 param = {
							"addressBookVoList":addressIds,
							"user_id":globalId,
							"address_grp_name": address_grp_name,
							"address_type":type
					}
			}else if(type == '1'){
				param = {
						"addressBookVoList":addressIds,
						"user_id":globalId,
						"address_grp_name": address_grp_name,
						"part_id":globalOrgnztId,
						"address_type":type
				}
			}
			*/
			
			var address_grp_name = $(".myAddressRadioList:checked").val();
			address_grp_name = address_grp_name.substring(0, address_grp_name.indexOf("("));
			
			var address_category = $(".myAddressRadioList:checked").attr("data-address-category");
			var param = {}
			if(type == '0' || type == '2'){
				 param = {
							"addressBookVoList":addressIds,
							"user_id":globalId,
							"address_type":type,
							"address_category":address_category
					}
			}else if(type == '1'){
				param = {
						"addressBookVoList":addressIds,
						"user_id":globalId,
						"part_id":globalOrgnztId,
						"address_type":type,
						"address_category":address_category
				}
			}
			
			
			$.ajax({
		    	url: "/usr/copy/createUser.do",  //msg/rcv/EgovRcvaddrList
		    	type: "POST",
		    	contentType:"application/json",
		    	data: JSON.stringify(param),
		        dataType: "json",          // ajax 통신으로 받는 타입
		    	success: function(res){ 
		    		myAddressFun(true);
		    		partAddressFun(true);
		    		ahareAddressFun(true);
		    	}
			});
		}
	});
	/*개별 복사 버튼 클릭시 */
	$(document).on("click", ".othderCopy", function(){
		
		var betype = $("input[name=tabmenu_small]:checked").val();
		var type = $("input[name=tabmenu_small2]:checked").val();
		//공유주소록으로 옮기면서 전체권한이 없음
		
		if(betype == '0' && type != '1' && type != '2'){
			alert("개인주소록에서는 부서주소록, 공유주소록 으로만 복사가 가능합니다.");
			return;
		}
		if(betype == '0' && type == '2' && adrRol != 'Y'){
			alert("전체권한이 없는경우 공유주소록으로 복사를 할수 없습니다.");
			return;
		}
		if(betype == '1' && type != '0'){
			alert("부서주소록에서는 개인주소록 으로만 복사가 가능합니다.");
			return;
		}
		if(betype == '2' && type != '0'){
			alert("공유주소록에서는 개인주소록 으로만 복사가 가능합니다.");
			return;
		}
		if(betype == '3' && type != '0'){
			alert("직원주소록에서는 개인주소록 으로만 복사가 가능합니다.");
			return;
		}
		
		
		if(confirm("정말 복사하시겠습니까?")){
			
			var isCheck = $(".myAddressRadioList").is(":checked");
			if(!isCheck){
				alert("복사할 개인주소록의 그룹을 지정해주세요");		
				return;
			}
			var isCheck2 = $(".otherList").is(":checked");
			if(!isCheck2){
				alert("복사할 주소를 지정해주세요");		
				return;
			}
			var tempList = $(".otherList");
			var addressIds = new Array();
			for(var i = 0 ; i < tempList.length ; i++){
				var temp = tempList.eq(i);
				if(temp.prop("checked")){
					var obj = {
							"address_id":temp.val()						
					}
					addressIds.push(obj)
				}
			}
			
			var addressIdsLength = addressIds.length;
			if(addressIdsLength > parseInt(g_address_capyCnt)){
				alert("한번에 복사할 개수는 최대 "+ g_address_capyCnt + "개 까지 가능합니다.");
				return;
			}
			
			var address_grp_name = $(".myAddressRadioList:checked").val();
			address_grp_name = address_grp_name.substring(0, address_grp_name.indexOf("("));
			
			var address_category = $(".myAddressRadioList:checked").attr("data-address-category");
			var param = {}
			if(type == '0' || type == '2'){
				 param = {
							"addressBookVoList":addressIds,
							"user_id":globalId,
							"address_grp_name": address_grp_name,
							"address_type":type,
							"address_category":address_category
					}
			}else if(type == '1'){
				param = {
						"addressBookVoList":addressIds,
						"user_id":globalId,
						"address_grp_name": address_grp_name,
						"part_id":globalOrgnztId,
						"address_type":type,
						"address_category":address_category
				}
			}
			$.ajax({
		    	url: "/usr/copy/createUser.do",  //msg/rcv/EgovRcvaddrList
		    	type: "POST",
		    	contentType:"application/json",
		    	data: JSON.stringify(param),
		        dataType: "json",          // ajax 통신으로 받는 타입
		    	success: function(res){ 
		    		myAddressFun(true);
		    		partAddressFun(true);
		    		ahareAddressFun(true);
		    	}
			});
		}
	})
	/*우측 복사받기의 아이템*/
	$(document).on("click", ".myAddressRadioListLi", function(e){
		e.preventDefault();
		var isChk = $(this).find(".myAddressRadioList").prop("checked");
		var isC = $(".myAddressRadioList").is(":checked");
		if(isC){
			$(".myAddressRadioList").prop("checked", false);
		}
		
		if(isChk) $(this).find(".myAddressRadioList").prop("checked", false);
		else $(this).find(".myAddressRadioList").prop("checked", true);
	})
	
	/*개인주소록 전체 삭제*/
	$(document).on("click", ".addressUserAllDelete", function(){
		if(confirm("정말 삭제하시겠습니까?")){
			
			var param = {
					"user_id":globalId
				}
			$.ajax({
		    	url: "/usr/add/deleteUserAll.do",  //msg/rcv/EgovRcvaddrList
		    	type: "POST",
		    	contentType:"application/json",
		    	data: JSON.stringify(param),
		        dataType: "json",                 // ajax 통신으로 받는 타입
		    	success: function(res){
		    		myAddressFun(true);
		    		partAddressFun(true);
		    		ahareAddressFun(true);
		    	}
			})
		}
	})
	
	//주소록 선택삭제
	$(document).on("click", ".addressUserDetailDelete", function(){
		if(confirm("정말 삭제하시겠습니까?")){
			var myAddressRadioList = $(".myAddressRadioList");
			var deleteMyGrps = new Array(); 
			for(var i = 0 ; i < myAddressRadioList.length ; i++){
				if(myAddressRadioList.eq(i).prop("checked")){
					var address_grp_name = myAddressRadioList.eq(i).val();
					address_grp_name = address_grp_name.substring(0, address_grp_name.indexOf("("));
					
					var address_category = myAddressRadioList.eq(i).attr("data-address-category");
					
					var type = myAddressRadioList.eq(i).attr("data-address-type");
					var obj = {}
					
					if(type == '0' || type == '2'){
						obj = {
								"address_grp_name":address_grp_name,
								"address_type":type,
								"address_category":address_category
							}
					}else if(type == '1'){
						obj = {
								"address_grp_name":address_grp_name,
								"address_type":type,
								"part_id":globalOrgnztId,
								"address_category":address_category
							}
					}
					
					
					deleteMyGrps.push(obj)
				}
			}
			var param = {
					"user_id":globalId,
					"addressBookVoList":deleteMyGrps
				}
			console.log(param);
			$.ajax({
		    	url: "/usr/add/deleteUserDetail.do",  //msg/rcv/EgovRcvaddrList
		    	type: "POST",
		    	contentType:"application/json",
		    	data: JSON.stringify(param),
		        dataType: "json",                 // ajax 통신으로 받는 타입
		    	success: function(res){
		    		myAddressFun(true);
		    		partAddressFun(true);
		    		ahareAddressFun(true);
		    	}
			})
		}
	})
	
	/*선택그룹 상세보기 아이템 클릭시*/
	$(document).on("click", ".searchAddressLi2", function(){
		var isChk = $(this).find(".otherList").prop("checked");
		if(isChk) $(this).find(".otherList").prop("checked", false);
		else $(this).find(".otherList").prop("checked", true);
		
	})
	
	/*상단그룹 아이템 클릭시*/
	$(document).on("click", ".searchAddressLi", function(e){
		e.preventDefault();
		
		$("#searchAddressText").html("");
		
		var isChk = $(this).find(".searchCheck").prop("checked");
		var isC = $(".searchCheck").is(":checked");
		if(isC){
			$(".searchCheck").prop("checked", false);
		}
		if(isChk) $(this).find(".searchCheck").prop("checked", false);
		else $(this).find(".searchCheck").prop("checked", true);
		isChk = $(this).find(".searchCheck").prop("checked");
		
		
		var address_grp_name = $(this).find(".searchAddressSpan").text();
		address_grp_name = address_grp_name.substring(0, address_grp_name.indexOf("("));
		
		
		var address_type = $(this).find(".searchAddressSpan").attr("data-address-type");
		var address_category = $(this).find(".searchAddressSpan").attr("data-address-category");
		
		var url = "";
		if(address_type == '0'){
			url = "/getaddressbookmy.do";
		}else if(address_type == '1'){
			url = "/getaddressbookpart.do";
		}else if(address_type == '2'){
			url = "/getaddressbookshare.do";
		}else if(address_type == '3'){
			url = "/getaddressbookemploy.do";
		}
		
		var param = {
			"address_type":address_type,
			"address_grp_name": address_grp_name,
			"part_id":globalOrgnztId,
			"address_category":address_category
		}
		$.ajax({
	    	url: url,  //msg/rcv/EgovRcvaddrList
	    	type: "POST",
	        data: param,          // ajax 통신으로 받는 타입
	        dataType: "json",          // ajax 통신으로 받는 타입
	    	success: function(res){ 
	    		console.log(res);
	    		
	    		if(!isChk){
	    			
	    			for(var x = 0 ; x < res.data.length ; x++){
	    				
		    			var searchAddressLi2 = $(".searchAddressLi2");
		    			var address_id = res.data[x].address_id;
	    				
		    			for(var i = 0 ; i < searchAddressLi2.length ; i++){
			    			if(address_id == searchAddressLi2.eq(i).find(".otherList").val()){
			    				$(".searchAddressLi2").eq(i).remove();
			    			}
			    		}
		    			
	    			}
	    			
	    		}else{
		    		var str = $("#searchAddressText").html();
		    		for(var i = 0 ; i < res.data.length ; i++){
		    			str+='\
			    			<li class="searchAddressLi2">\
								<div class="checkbox-small_2 searchAddressId" >\
									<input type="checkbox" id="check5-'+i+'" class="otherList" value="'+res.data[i].address_id+'" name="체크" />\
									<label for="check5-'+i+'"></label>\
								</div> \
								<span class="searchAddressSpan">'+res.data[i].address_name+'<span>'+res.data[i].address_num+'</span></span>\
							</li>\
						';	    			
		    		}
	    		$("#searchAddressText").html(str);
	    		}
	    		
	    	}
		});
		
	})
	
	
	/*상단그룹 아이템 클릭시*/
	/*
	$(document).on("click", ".searchAddressLi", function(e){
		e.preventDefault();
		
		$("#searchAddressText").html("");
		
		var isChk = $(this).find(".searchCheck").prop("checked");
		var isC = $(".searchCheck").is(":checked");
		if(isC){
			$(".searchCheck").prop("checked", false);
		}
		if(isChk) $(this).find(".searchCheck").prop("checked", false);
		else $(this).find(".searchCheck").prop("checked", true);
		isChk = $(this).find(".searchCheck").prop("checked");
		
		
		var address_grp_name = $(this).find(".searchAddressSpan").text();
		address_grp_name = address_grp_name.substring(0, address_grp_name.indexOf("("));
		
		
		var address_type = $(this).find(".searchAddressSpan").attr("data-address-type");
		
		var url = "";
		if(address_type == '0'){
			url = "/getaddressbookmy.do";
		}else if(address_type == '1'){
			url = "/getaddressbookpart.do";
		}else if(address_type == '2'){
			url = "/getaddressbookshare.do";
		}else if(address_type == '3'){
			url = "/getaddressbookemploy.do";
		}
		
		
		var param = {
			"address_type":address_type,
			"address_grp_name": address_grp_name,
			"part_id":globalOrgnztId
		}
		$.ajax({
	    	url: url,  //msg/rcv/EgovRcvaddrList
	    	type: "POST",
	        data: param,          // ajax 통신으로 받는 타입
	        dataType: "json",          // ajax 통신으로 받는 타입
	    	success: function(res){ 
	    		console.log(res);
	    		
	    		if(!isChk){
	    			
	    			for(var x = 0 ; x < res.data.length ; x++){
	    				
		    			var searchAddressLi2 = $(".searchAddressLi2");
		    			var address_id = res.data[x].address_id;
	    				
		    			for(var i = 0 ; i < searchAddressLi2.length ; i++){
			    			if(address_id == searchAddressLi2.eq(i).find(".otherList").val()){
			    				$(".searchAddressLi2").eq(i).remove();
			    			}
			    		}
		    			
	    			}
	    			
	    		}else{
		    		var str = $("#searchAddressText").html();
		    		for(var i = 0 ; i < res.data.length ; i++){
		    			str+='\
			    			<li class="searchAddressLi2">\
								<div class="checkbox-small_2 searchAddressId" >\
									<input type="checkbox" id="check5-'+i+'" class="otherList" value="'+res.data[i].address_id+'" name="체크" />\
									<label for="check5-'+i+'"></label>\
								</div> \
								<span class="searchAddressSpan">'+res.data[i].address_name+'<span>'+res.data[i].address_num+'</span></span>\
							</li>\
						';	    			
		    		}
	    		$("#searchAddressText").html(str);
	    		}
	    		
	    	}
		});
		
	})*/
	
})
</script>