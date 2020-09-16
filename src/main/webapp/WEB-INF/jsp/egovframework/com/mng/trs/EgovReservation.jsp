<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="EXCEL_SHEET_DATA_COUNT" var="EXCEL_SHEET_DATA_COUNT" />
<spring:message code="statYearActive" var="statYearActive" />
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
	display: none;
}
</style>
<script type="text/javaScript" language="javascript" defer="defer">  
var partg_role = "${loginVO.partg_role}";
$(document).ready(function() {
	
	var statYearActive = "${statYearActive}";
	if(statYearActive){
		$("#start_dt").val(statYearActive + "-01-01");
	}
	
	//엑셀다운로드
	$("#resExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('tblReservationU', '예약관리' ,'예약관리');
	    global.htmlTableToExcel('tblReservationU','예약관리','예약관리', "${EXCEL_SHEET_DATA_COUNT}");
	});
	 
	var oTable = $('#tblReservationU').DataTable({
		"scrollX": true,
	     dom: "frtip",
	     ajax:{
		    	"url" : "/mng/reservationU.do"
		    }, 
		     columns: [ 
			    { 
			    	data: "msg_id",
			    	render:function(data){
			    		return "일반";
			    	}
			    },
			    { 
			    	data: "pay_code",
		    		render: function(data) { 
                          if(data == 'SMS') {
                            return '단문'; 
	                	   }else if(data == 'LMS'){
	                		   return '장문';
                          }else if(data == 'MMS'){
	                		   return '멀티';
                          }else if(data == 'NOT'){
	                		   return '알림톡';
                          }else if(data == 'FRT'){
	                		   return '친구톡(텍스트)';
                          }else if(data == 'FRI'){
	                		   return '친구톡(이미지)';
                          }else if(data == 'FIT'){
                        	  return '친구톡(텍스트 + 이미지)';
                          }else{
                       	   return '';
                          }
                        }  
		   	   },
		    	{ data: "req_date" },
		    	{ data: "call_from" },
		    	{ 
		    		data: "call_from",
		    		render: function(data, type, row) { 
		    			//수신번호
		    			return "<a class='call-to-list' data-msg-id='"+row.msg_id+"' style='background: #eee;padding: 5px 10px 5px 10px;border-radius: 13px;'>자세히보기</a>"
		    		}
		    	},
		        { data: "pay_code",
		             render: function(data, type, row) {
	                     if(data == 'SMS') {
	                          return ''; 
	                    }else if(data == 'LMS'){
	                       return row.mms_subject; 
	                     }else if(data == 'MMS'){
	                        return row.mms_subject;
	                     }else if(data == 'NOT'){
	                        return row.mms_noticetalk_subject;
	                     }else if(data == 'FRT'){
	                        return row.mms_friend_subject
	                     }else if(data == 'FRI'){
	                        return row.mms_friend_subject;
	                     }else if(data == 'FIT'){
	                        return row.mms_friend_subject;
	                     }else{
	                        return '';
	                     }
	                   }  
				},
				{ data: "pay_code",
		             render: function(data, type, row) {
	                     if(data == 'SMS') {
                         	return contentShort(row.sms_txt); ; 
	                    }else if(data == 'LMS'){
	                       return contentShort(row.mms_body); 
	                     }else if(data == 'MMS'){
	                        return contentShort(row.mms_body);
	                     }else if(data == 'NOT'){
	                        return contentShort(row.mms_noticetalk_body);
	                     }else if(data == 'FRT'){
	                        return contentShort(row.mms_friend_body);
	                     }else if(data == 'FRI'){
	                        return contentShort(row.mms_friend_body);
	                     }else if(data == 'FIT'){
	                        return contentShort(row.mms_friend_body);
	                     }else{
	                        return '';
	                     }
                	}
				},
	        	{ data: "cnt" },
	       		{ 
	        		data: null,
	                defaultContent: "<button class='icon_modify'>수정</button> <button class='icon_delete'>삭제</button>"
	        	}
	         ],
   	 	    paging:   true, 
		    info:     true,
		    language: {		    	 
		    	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"		    	
		    }
		 });
	global.settingTableCnt($("#table-cnt"), oTable);
	
	$(document).on( 'click','#tblReservationU .call-to-list', function () {
		var msg_id = $(this).attr("data-msg-id");
		var obj1 = oTable.row($(this).closest('tr')).data();
		console.log("msg_id :: "+obj1.msg_id);
		var obj = {
				"msg_id":msg_id
		}
		$.ajax({
			url : "<c:url value='/usr/reservationsTo.do' />",
			type : "POST",
			data : obj,
			dataType : "json",
			success : function(jsondata) {
				var str = "";
				for(var i = 0 ; i < jsondata.data.length ; i++){
					str +='<div class="width-100 height-30px line-height-30px text-center  border-radius-5 border-eaeaea font-000 font-16px border-box margin-bottom-5">'+jsondata.data[i].call_to+'</div>'
				}
				$(".call-to-div").html(str);
				$(".pop_receive_list").show();
			}
		});
		
	});
	$(document).on( 'click','#tblReservationU .icon_modify', function () {
		var obj = oTable.row($(this).closest('tr')).data();
		send_date = obj.req_date;
		send_date = send_date.slice(0, 10);
		send_time = obj.req_date;
		send_time = send_time.slice(11, 19);
		
		if(!global.checkTime(obj.req_date, 5)){
			alert("예약 발송까지 5분 이상 남은 예약만 수정 가능합니다.");
			return;
		}
		
		$("#send_date").val(send_date);
		$("#send_time").val(send_time);
		$(".pop_bg").css('display','block');
		$(".pop_modify").css('display','block');
    });

   	$('#tblReservationU tbody').on('click', ':nth-child(7)', function(e) {
		var rowData = oTable.row(this).data();
		var dataContent;
		if(rowData['pay_code'] == 'SMS') {
       	 	dataContent = rowData['sms_txt'];
    	}else if(rowData['pay_code'] == 'LMS'){
    		dataContent =  rowData['mms_body']; 
        }else if(rowData['pay_code'] == 'MMS'){
        	dataContent = rowData['mms_body'];
        }else if(rowData['pay_code'] == 'NOT'){
        	dataContent = rowData['mms_noticetalk_body'];
        }else if(rowData['pay_code'] == 'FRT'){
        	dataContent = rowData['mms_friend_body'];
        }else if(rowData['pay_code'] == 'FRI'){
        	dataContent = rowData['mms_friend_body'];
        }else if(rowData['pay_code'] == 'FIT'){
        	dataContent = rowData['mms_friend_body'];
        }else{
        	dataContent = '';
        }
		$("#tooltip").text(dataContent).animate({ left: e.pageX, top: e.pageY }, 1);
		if (!$("#tooltip").is(':visible')) $("#tooltip").show()
   	})
	
    $('#tblReservationU').on('mouseleave', function(e) {
    	  $("#tooltip").hide()
    })

	$('#searchBtn').on( 'click', function () {
		var typeOptVal = "";
		if($("#typeOpt option:selected").val() == '0') typeOptVal = '단문';
		if($("#typeOpt option:selected").val() == '1') typeOptVal = '장문';
		if($("#typeOpt option:selected").val() == '2') typeOptVal = '멀티';
		if($("#typeOpt option:selected").val() == '3') typeOptVal = '알림톡';
		if($("#typeOpt option:selected").val() == '4') typeOptVal = '친구톡(텍스트)';
		if($("#typeOpt option:selected").val() == '5') typeOptVal = '친구톡(이미지)';
		oTable.columns(1).search(typeOptVal);
	   if($("#filterOpt option:selected").val()){
		   oTable.columns( $("#filterOpt option:selected").val()  ).search( $("input[type=text][name=searchKeyword]").val() )
	   }
	   oTable.draw();
	});
    
    $.fn.dataTable.ext.search.push(
   	    function( settings, data, dataIndex ) {
   	    	if($("#dateOpt").val() && $("#start_dt").val() && $("#end_dt").val()){
    	        var min = $('#start_dt').val(); min = global.replaceNumber(min);
    	        var max = $('#end_dt').val(); max = global.replaceNumber(max);
    	        var tableDate = data[$("#dateOpt").val()] || 0; tableDate = global.replaceNumber(tableDate); tableDate = global.parse(tableDate);
    	        
    	        if (min <= tableDate && tableDate <= max){
    	            return true;
    	        }else{
	    	        return false;
    	        }
   	    	}else{
   	    		return true;
   	    	}
   	    }
    );

	
	$(document).on( 'click', '#tblReservationU .icon_delete', function () {
		
		if (confirm("정말 삭제하시겠습니까?") == true){    //확인
			var obj = oTable.row($(this).closest('tr')).data();
		
			if(!global.checkTime(obj.req_date, 5)){
				alert("예약 발송까지 5분 이상 남은 예약만 취소 가능합니다.");
				return;
			}
		
			if(!obj.userManageVOList){
				obj.userManageVOList = new Array();
			}
			
			console.log(obj);
		    $.ajax({
		    	url: "<c:url value='/deletelistallsU.do' />",
		       	type: "POST",
	        	data: obj,
		    	dataType: "json",
		       	success: function(jsondata){  
		            if(jsondata["data"]==0){
		                alert("성공적으로 삭제 되었습니다.");
		                oTable.ajax.reload();
		                global.settingTableCnt($("#table-cnt"), oTable);
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

});
</script>
</head>
<body>

	<!--contents-->
	<div class="con-inner">
		<!--타이틀-->
		<h1 class="con-title">
			<ul>
				<li>예약관리</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>전송관리</li>
				<li><span class="dot"></span>예약관리</li>
			</ul>
		</h1>


		<!-- 검색하기 -->
		<div
			class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
			<!-- 검색설정 -->
			<div
				class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">
				<select class="select_blank_lightblue width-120px" style="margin-right:10px" title="part_id" id="part_id_day" name="part_id_day">
					<option selected value="">부서선택</option>
					<c:forEach var="part_id" items="${partIdList}" varStatus="status">
						<option value="${part_id.orgnztId}" ${part_id.orgnztId == provider ? 'selected="selected"' : '' }>${part_id.orgnztNm}</option>
					</c:forEach>
				</select>
				<!--유형 셀렉박스-->
				<select id="typeOpt" class="select_blank_lightblue width-150px"
					style="margin-right: 10px">
					<option value="" selected>유형</option>
					<option value="0">단문</option>
					<option value="1">장문</option>
					<option value="2">멀티</option>
					<option value="3">알림톡</option>
					<option value="4">친구톡(텍스트)</option>
					<option value="5">친구톡(이미지)</option>
				</select>

				<!-- 예약등록일 셀렉박스-->
				<select id="dateOpt" class="select_blank_lightblue width-140px"
					style="margin-right: 10px">
					<option value="" selected>날짜</option>
					<option value="2">예약전송일</option>
				</select>



				<!-- 날짜선택-->
				<div
					class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box">
					<input type="date" id="start_dt" name="start_dt"
						class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent" />
				</div>
				<div
					class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
				<div
					class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
				<div
					class="inline-block width-5px height-5px border-radius-5 background-d3e6ff"></div>
				<div
					class="inline-block relative width-150px height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box margin-right-10">
					<input type="date" id="end_dt" name="end_dt"
						class="text-right font-174962 font-16px padding-0 margin-0 width-100 height-40px line-height-40px background-transparent"/>
				</div>

				<!--발신번호 체크박스-->
				<select id="filterOpt" class="select_blank_lightblue width-180px"
					style="margin-right: 10px">
					<option selected value="4">발신번호</option>
					<option value="5">수신번호</option>
					<option value="6">메시지제목</option>
					<option value="7">메시지내용</option>
				</select>

				<!--검색-->
				<div class="inline-block width-180px">
					<input id="searchKeyword" type="text" name="searchKeyword"
						placeholder=""
						class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
				</div>
				<a id="searchBtn"
					class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">검색</a>
			</div>
			<!-- //검색설정 -->


			<!-- 검색결과 -->
			<div
				class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
				<div class="table_result_tit">
					총 <span id="table-cnt">000</span>개를 검색하였습니다.
					<a id="resExlBtn" class="icon_btn width-100px background-00e04e"><span
						class="icon_clip"></span>엑셀 다운로드</a>
				</div>
				<div id="tooltip"></div>
				<table id="tblReservationU" width="100%" class="rsv_u con_tb">
					<thead>
						<tr>
							<th class="width-6">구분</th>
							<th class="width-6">유형</th>
							<th class="width-11">예약전송일시</th>
							<th class="width-10">발신번호</th>
							<th class="width-10">수신번호</th>
							<th class="width-10">메세지 제목</th>
							<th class="width-10">메세지 내용</th>
							<th class="width-6">건수</th>
							<th class="width-12">수정/삭제</th>
						</tr>
					</thead>
				</table>
			</div>
			<!-- //검색결과 -->
		</div>
	</div>


	<!-- popup_예약메세지수정 -->
	<div class="pop_wrap pop_modify width-430px">
		<div class="pop_tit">예약메세지 수정</div>
		<div class="width-100 padding-bottom-10 border-bottom-e9eced">
			<table class="width-100" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<th
						class="width-40 font-000 font-16px text-left vertical-align-top"><span
						class="inline-block margin-top-15">예약전송일시</span></th>
					<td class="text-left height-60px vertical-align-top">
						<!-- 날짜선택 -->
						<div class="inline-block relative width-100 height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box margin-bottom-10">
							<input type="date" id="send_date" class="font-174962 font-16px padding-0 padding-right-15 margin-0 width-100 height-40px line-height-40px background-transparent" />
						</div> <!-- 셀렉박스 --> 
						<input type="time" id="send_time" name="send_time" value="" 
							class="text-right font-174962 font-14px padding-0 margin-0 height-30px line-height-30px background-transparent" />

					</td>
				</tr>
				<tr>
					<th
						class="width-40 font-000 font-16px text-left vertical-align-top"><span
						class="inline-block margin-top-15">예약된 수신번호</span></th>
					<td class="text-left height-60px vertical-align-top">
						<!-- 검색박스 -->
						<div class="widht-100 margin-top-10">
							<input type="text" name="" placeholder="검색할 번호를 입력하세요"
								class="input_blank width-100 border-box border-8bc5ff"
								style="padding-left: 10px;" />
						</div>
						<div
							class="widht-100 margin-top-10 padding-left-5 height-24px line-height-24px font-16px font-174962">
							검색할 번호를 입력하세요<a
								class="float-right icon_modify width-55px height-20px line-height-20px background-eee border-radius-10 font-000 font-10px text-right padding-right-10 margin-top-2 border-box">수정</a>
						</div>
						<div
							class="widht-100 margin-top-10 padding-left-5 height-24px line-height-24px font-16px font-174962">
							검색할 번호를 입력하세요<a
								class="float-right icon_modify width-55px height-20px line-height-20px background-eee border-radius-10 font-000 font-10px text-right padding-right-10 margin-top-2 border-box">저장</a>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div
			class="width-100 font-16px font-000 text-left margin-top-20 margin-bottom-30">
			<span class="font-bold line-height-default">2개</span>의 수신번호가 <span
				class="font-bold">수정</span>되어 <span class="font-bold">2019-12-20
				14:00 예약전송</span>으로 수정됩니다.
		</div>
		<!-- 버튼 -->
		<div class="pop_btn">
			<a class=" background-8bc5ff border-8bc5ff font-fff margin-right-20">로그인</a>
			<a class="pop_close background-fff border-6f6f6f font-6f6f6f">취소</a>
		</div>
	</div>
	
	
	<!-- popup 수신번호 -->
	<div class="pop_wrap pop_receive_list width-430px">
		<div class="width-100 font-18px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">수신번호</div>
		<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000 call-to-div">
		</div>
		<!--버튼-->
		<div class="pop_btn">
			<a class="pop_close background-8bc5ff border-8bc5ff font-fff">확인</a>
		</div>
	</div>
</body>
</html>
