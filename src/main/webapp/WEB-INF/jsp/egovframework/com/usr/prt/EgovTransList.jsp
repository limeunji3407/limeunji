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
var part_id = "${loginVO.orgnztId}";
part_id = part_id.slice(part_id.length-3, part_id.length);
$(document).ready(function() {
	
	var statYearActive = "${statYearActive}";
	if(statYearActive){
		$("#start_dt").val(statYearActive + "-01-01");
	}
	
	//엑셀다운로드
	$("#tbltranslistExlBtn").click(function(){
		//테이블ID, sheet이름, 파일명+날짜.xlsx
	    //exportExcel('tbltranslist', '부서전송내역' ,'부서전송내역');
	    global.htmlTableToExcel('tbltranslist','부서전송내역','부서전송내역', "${EXCEL_SHEET_DATA_COUNT}");
	});
	
	var oTable = $('#tbltranslist').DataTable({
	     dom: "frtip",
	     ajax:{
		    	"url" : '/usr/listallcontPartg.do'
		    }, 
	    columns: [ 
	                   { data: "rcv_id" },
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
	                   { data: "user_name" },
	                   { data: "call_from" },
	                   { data: "sent_date" },
	                   { data: "call_to" },
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
	                               return contentShort(row.sms_txt); 
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
	                         } },
	                         { data: "rslt_code2" ,
	                         	render: function(data){
	                         		if(data == 0){
	                         			return '성공';
	                         		}else{
	                         			return '실패';
	                         		}
	                         	} },
	                         { data: "msg_type_resend",
	                         	render: function(data){
	                         		if(data == 4){
	                         			return '단문';
	                         		}else if(data == 6){
	                         			return '장문';
	                         		}else {
	                         			return '';
	                         		}
	                         	}},
	                         { data: "msg_type_resend" ,
	                         	render: function(data){
	                         		if(data == null){
	                         			return '';
	                         		}else{
	                         			return '실패';
	                         		}
	                         	}
	                         		
	                         }
                  ],
      	 	    paging:   true, 
    		    info:     true,
    		    language: {		    	 
    		    	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"		    	
    		    }
	 });
	 global.settingTableCnt($("#table-cnt"), oTable);

		$('#searchBtn').on( 'click', function () {
			
			var typeOptVal = "";
			if($("#typeOpt option:selected").val() == '0') typeOptVal = '단문';
			if($("#typeOpt option:selected").val() == '1') typeOptVal = '장문';
			if($("#typeOpt option:selected").val() == '2') typeOptVal = '멀티';
			if($("#typeOpt option:selected").val() == '3') typeOptVal = '알림톡';
			if($("#typeOpt option:selected").val() == '4') typeOptVal = '친구톡(텍스트)';
			if($("#typeOpt option:selected").val() == '5') typeOptVal = '친구톡(이미지)';
			oTable.columns(1).search(typeOptVal);
			
		   if($("#filterOpt option:selected").val() == ""){
				   toastr.error("검색할 항목을 선택하세요");
				   return;
		   }
		   oTable
		        .columns( $("#filterOpt option:selected").val()  )
		        .search( $("input[type=text][name=searchKeyword]").val() )
		        .draw();  
		});
		$.fn.dataTable.ext.search.push(
		   	    function( settings, data, dataIndex ) {
		   	    	if($("#start_dt").val() && $("#end_dt").val()){
		    	        var min = $('#start_dt').val(); min = global.replaceNumber(min);
		    	        var max = $('#end_dt').val(); max = global.replaceNumber(max);
		    	        var tableDate = data[4] || 0; tableDate = global.replaceNumber(tableDate); tableDate = global.parse(tableDate);
		    	        
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
		
		$('#tbltranslist tbody').on('click', ':nth-child(8)', function(e) {
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
	   	
	    $('#tbltranslist').on('mouseleave', function(e) {
	    	  $("#tooltip").hide()
	    })
	    
	    $('#tbltranslist tbody').on('click', ':nth-child(6)', function(e) {
		var rowData = oTable.row(this).data();
		console.log(rowData['call_to']);
		var obj = {
				'address_num': rowData['call_to']
		};
		console.log(obj);
		$.ajax({
			url : "<c:url value='/serchEmpAddr.do' />",
			type : "POST",
			data : obj,
			dataType : "json",
			success : function(jsondata) {
				var list = jsondata['empaddr'];
				console.log(list);
				console.log(list.address_name);
				if(list == null){
					$(".pop_receive").css('display','block');
					$(".pop_bg").css('display','block');
					$(".pop_receive2").css('display','none');
				}else{
					$(".pop_receive2").css('display','block');
					$(".pop_bg").css('display','block');
					$(".pop_receive").css('display','none');
					$("#add_name").val(list.address_name);
					$("#add_id").val(list.user_id);
					$("#add_part").val(list.part_id);
					$("#add_num").val(list.address_num);
				}
			},
			error : function(request, status, error) {

				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error)
			}
		});
   	})
});
</script>
</head>
<body>
	<!--contents-->
	<div class="con-inner">
		<!--타이틀-->
		<h1 class="con-title">
			<ul>
				<li>부서전송내역</li>
				<li class="icon_home"></li>
				<li><span class="dot"></span>부서장기능</li>
				<li><span class="dot"></span>부서전송내역</li>
			</ul>
		</h1>


		<!-- 검색하기 -->
		<div
			class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
			<!-- 검색설정 -->
			<div
				class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5">
				<!--구분 셀렉박스-->
				<select id="sendOpt" class="select_blank_lightblue width-100px"
					style="margin-right: 10px">
					<option selected>구분</option>
					<option value="1">즉시</option>
					<option value="0">예약</option>
				</select>

				<!--유형 셀렉박스-->
				<select id="typeOpt" class="select_blank_lightblue width-140px"
					style="margin-right: 10px">
					<option selected>유형</option>
					<option value="0">단문</option>
					<option value="1">장문</option>
					<option value="2">멀티</option>
					<option value="3">알림톡</option>
					<option value="4">친구톡(텍스트)</option>
					<option value="5">친구톡(이미지)</option>
				</select>

				<!-- 상태 셀렉박스-->
				<select id="successOpt" class="select_blank_lightblue width-100px"
					style="margin-right: 10px">
					<option selected>상태</option>
					<option value="1">성공</option>
					<option value="0">실패</option>
					<option value="2">대체성공</option>
					<option value="3">대체실패</option>
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
				<select id="filterOpt" class="select_blank_lightblue width-120px"
					style="margin-right: 10px">
					<option selected value="3">발신번호</option>
					<option value="5">수신번호</option>
					<option value="6">메시지제목</option>
					<option value="7">메시지내용</option>
					<option value="2">이름</option>
				</select>



				<!--검색-->
				<div class="inline-block width-150px">
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
				class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5" style="width:100%;">
				<div class="table_result_tit">
					총 <span id="table-cnt">000</span>개를 검색하였습니다.
					<a id="tbltranslistExlBtn"
						class="icon_btn width-100px background-00e04e"><span
						class="icon_clip"></span>엑셀 다운로드</a>
				</div>
				<div id="tooltip"></div>
				<table id="tbltranslist" class="con_tb" style="width:100%;">
					<thead>
						<tr>
							<th class="width-6">구분</th>
							<th class="width-6">유형</th>
							<th class="width-6">이름</th>
							<th class="width-10">발신번호</th>
							<th class="width-12">발송일시</th>
							<th class="width-10">수신번호</th>
							<th class="width-12">메세지 제목</th>
							<th class="width-13">메세지 내용</th>
							<th class="width-6">비고</th>
							<th class="width-7">대체문자</th>
							<th class="width-7">대체결과</th>
						</tr>
					</thead>
				</table>

			</div>
			<!-- //검색결과 -->
		</div>
	</div>




	<!-- popup 수신번호 -->
	<div class="pop_wrap pop_receive width-430px">
		<div
			class="width-100 font-18px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">수신번호</div>
		<!--정보가 있을 경우-->
		<div
			class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000"
			style="display: none;">
			<div
				class="width-100 height-30px line-height-30px text-center  border-radius-5 border-eaeaea font-000 font-16px border-box margin-bottom-5">010-1234-5678</div>
			<div
				class="width-100 height-30px line-height-30px text-center  border-radius-5 border-eaeaea font-000 font-16px border-box margin-bottom-5">010-1234-5678</div>
		</div>

		<!--정보가 없을 경우-->
		<div
			class="width-100 margin-auto margin-top-40 margin-bottom-40 text-center font-16px font-000">
			직원 주소록에 정보가 존재하지 않습니다.
			<!--div class="width-100 margin-auto margin-top-20 text-center font-14px font-ff6464">*직원주소록을 사용하여 발송한 경우에만 수신자 정보가 표시 됩니다.</div-->
		</div>

		<!--버튼-->
		<div class="pop_btn">
			<a class="pop_close background-8bc5ff border-8bc5ff font-fff">확인</a>
		</div>
	</div>
	
	<div class="pop_wrap pop_receive width-430px">
            <div class="width-100 font-18px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">수신번호</div>
			
			<!--정보가 없을 경우-->
			<div class="width-100 margin-auto margin-top-40 margin-bottom-40 text-center font-16px font-000" >
				직원 주소록에 정보가 존재하지 않습니다.
				<!--div class="width-100 margin-auto margin-top-20 text-center font-14px font-ff6464">*직원주소록을 사용하여 발송한 경우에만 수신자 정보가 표시 됩니다.</div-->			
			</div>
			
			<!--버튼-->
			<div class="pop_btn">
				<a class="pop_close background-8bc5ff border-8bc5ff font-fff">확인</a>
			</div>
        </div>
        
        <div class="pop_wrap pop_receive2 width-430px">
            <div class="width-100 font-18px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">수신번호</div>
			
			<!--정보가 있을 경우-->
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
				<table class="width-100" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th class="width-100px font-000 font-16px text-left">이름</th>
						<td class="text-left"><input type="text" id="add_name" readonly="readonly"
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;"/></td>
					</tr>
					<tr>
						<th class="width-100px font-000 font-16px text-left">아이디</th>
						<td class="text-left"><input type="text" id="add_id" readonly="readonly"
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;"/></td>
					</tr>
					<tr>
						<th class="width-100px font-000 font-16px text-left">부서</th>
						<td class="text-left"><input type="text" id="add_part" readonly="readonly"
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;"/></td>
					</tr>
					<tr>
						<th class="width-100px font-000 font-16px text-left">전화번호</th>
						<td class="text-left"><input type="text" id="add_num" readonly="readonly"
							class="input_blank width-100 border-box border-8bc5ff"
							style="padding-left: 10px;"/></td>
					</tr>
				</table>
			</div>
			
			<!--버튼-->
			<div class="pop_btn">
				<a class="pop_close background-8bc5ff border-8bc5ff font-fff">확인</a>
			</div>
        </div>
</body>
</html>
