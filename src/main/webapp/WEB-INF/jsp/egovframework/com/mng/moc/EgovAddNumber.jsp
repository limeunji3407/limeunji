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
<script type="text/javaScript" language="javascript" defer="defer">  
$(document).ready(function() {

    $('.bs-callout-info').toggleClass('hidden', true);
    $('.bs-callout-warning').toggleClass('hidden', true);
	
	
	$('#addn-form').parsley().on('field:validated', function() {
	    var ok = $('.parsley-error').length === 0;
	   	/* alert(ok); */
	    $('.bs-callout-info').toggleClass('hidden', !ok);
	    $('.bs-callout-warning').toggleClass('hidden', ok);
	  })
	  .on('form:submit', function() {
	    return false; // Don't submit form for this demo
	  });
	
$('#addNumberBtn').on('click', function(){  
	
		console.log($('.parsley-error').length);
		
		$('#addNumberBtn').attr('disabled', true);		
		
	    var num = $('input[name="num"]').val(); 
	    var num_sub = $('input[name="num_sub"]').val(); 
	    var numtype = $("#numtype option:selected").val();
		var num = num + "" + num_sub;
		
	    var obj = {
			"mo_number" : num,
			"mo_status" : "Y",
			"mo_number_sub" : "0000",
			"mo_type" : numtype
		};

	    console.log(JSON.stringify(obj));
	    $.ajax({
        	url: "<c:url value='/mng/insertnumber.do' />",
        	type: "POST",
            data: obj,
            dataType: "json",
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
        		$('#addNumberBtn').attr('disabled', false);
            },
			complete:function(){
                $('.wrap-loading').addClass('display-none');
        		$('#addNumberBtn').attr('disabled', false);
            },
            success: function(jsondata){  
           	   
                console.log(jsondata["data"]);
                
                if(jsondata["data"]==0){
                    //로딩
                    toastr.success("성공적으로 등록되었습니다");
                    $('#addSenderKeyBtn').attr('disabled', false);
               		//close popup
               		location.href  ="/mng/addnumber"
              	  
                }else if(jsondata["data"]==1){
                	alert("이미 등록된 번호입니다.");
                }else{
                	alert("양식을 다시 확인하길 바랍니다.");
                }
           	},
        	error: function(request,status,error){
        		toastr.error("[ajax error]");
        		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
            	
                $('.wrap-loading').addClass('display-none');
        		$('#addNumberBtn').attr('disabled', false);
        	}
    	});
	});
	  
	  
	  
	 var oTable = $('#tblphone').DataTable({
	     dom: "frtip",
	     ajax: {
	     	"type" : "POST",
	        "url" : "<c:url value='/mng/getnumberlist.do' />",
	        "dataType": "JSON"
	     },
	    columns: [
	                   { data: "mo_number" },
	                   { data: "mo_type",
	                	   render: function(data) { 
	                           if(data == '1') {
	                             return '민원'; 
		                	   }else if(data == '2'){
		                		   return '문자투표';
	                           }else{
	                        	   return '';
	                           }
	                         } 
	                   },
	                   { data: "mo_date" },
                   	   { data: "mo_status",
                   			render: function(data) { 
	                           if(data == 'N') {
	                             return '사용안함'; 
		                	   }else if(data == 'Y'){
		                		   return '사용';
	                           }else{
	                        	   return '';
	                           }
	                         }    
                   	   },
	                   	{ 
	       	        		data: null,
	       	                defaultContent: '<button class="icon_delete">삭제</button>'
	       	        	}
                 ],
     			searching: false,
    		    paging:   true, 
    		    info:     true,
    		    language: { 	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"  }
	 });
	 
	 $('#tblphone tbody').on( 'click', '.deleteData', function () {
			
			alert('DeleteRec() invoked;;');
			
			if (confirm("정말 삭제하시겠습니까??") == true){    //확인

				alert('DeleteRec() 삭제 확인 ;;');
			
				var obj = oTable.row($(this).closest('tr')).data();
				
				alert(JSON.stringify(obj));
			    
			    $.ajax({
			    	url: "<c:url value='/mng/numberdelete.do' />",
			       	type: "POST",
		        	data: obj,
			    	dataType: "json",
			       	success: function(jsondata){  
			     	   
			            alert(jsondata["data"]);
			            
			            if(jsondata["data"]==0){
			                //로딩
			                alert("성공적으로 삭제 되었습니다.");
			           		//close popup
			           		//location.href  ="/usr/receiptrefusal"
			                oTable.destroy();
			                oTable = $('#tblphone').DataTable({
			           	     dom: "frtip",
			           	     ajax: {
			           	     	"type" : "POST",
			           	        "url" : "<c:url value='/mng/getnumberlist.do' />",
			           	        "dataType": "JSON"
			           	     },
			           	    columns: [
			           	    		{ data: "mo_number" },
				                   { data: "mo_type" },
				                   { data: "mo_date" },
			                   	   { data: "mo_status" },
				                   	{ 
				       	        		data: null,
				       	                defaultContent: '<button class="deleteData">해제</button>'
				       	        	}
			                            ],
			                			searching: false,
			               		    paging:   true, 
			               		    info:     true,
			               		    language: { 	"url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Korean.json"  }
			           	 });
			          	  
			            }else{
			          	  alert("삭제할수 없습니다.");
			            }
			       	},
			       	error: function(request,status,error){
			       		  
			       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
			           	//$('#result').text(jsondata);
			           	//alert("serialize err");
			       		//$('#refBtn').attr('disabled', false);
			       	}
			   	});

			 }else{

				 alert('DeleteRec() 삭제 취소;;');
			 }
		}); 

	/* 	$('#searchBtn').on( 'click', function () {
		   if($("#searchFilter option:selected").val() == ""){
				   toastr.error("검색할 항목을 선택하세요");
				   return;
		   }
		   oTableR
		        .columns( $("#searchFilter option:selected").val()  )
		        .search( $("input[type=text][name=searchFilterKeyword]").val() )
		        .draw();  
		} );
 */
});
</script> 
</head>
<body>
			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>#번호등록</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>민원수신/문자투표 </li>
						<li><span class="dot"></span>#번호등록</li>
					</ul>
				</h1>


				<!-- 등록하기 -->
				<div  class="width-100 min-width-1110px margin-auto margin-top-30 margin-bottom-100 ">
					<!-- 검색설정 -->
					<form id="addn-form" data-parsley-validate="">
					<div class="width-100 height-70px padding-15 margin-bottom-30 background-f7fafc border-box box-shadow-small border-radius-5 text-center">
						<div class="inline-block">
							#번호 입력 : 
							<div class="inline-block width-100px" style="margin-left:5px; margin-right:5px">
								<input type="text" name="num" value="#1110" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" required="" data-parsley-required="true" data-parsley-trigger="change" data-parsley-maxlength="5"/>
							</div>
							-
							<div class="inline-block width-100px" style="margin-left:5px; margin-right:50px">
								<input type="text" name="num_sub" placeholder="검색" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" required="" data-parsley-required="true" data-parsley-trigger="change" data-parsley-type="digits" data-parsley-maxlength="6" />
							</div>
							<!--종류-->
							종류 : 
							<select name="typeOpt" id="numtype" class="select_blank_lightblue width-140px" style="margin-left:5px; margin-right:5px" required="" data-parsley-required="true" data-parsley-trigger="change">
                        		<option value="" selected>선택해주세요</option>
                        		<option value="1" >민원</option>
                        		<option value="2" >문자투표</option>
                     		</select> 
							<!--버튼-->
							<input type="submit" id="addNumberBtn" value="등록" class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue">
						</div>
					</div>
					</form>
					<!-- //검색설정 -->


					<!-- 검색결과 -->
					<div class="background-fff padding-15 margin-bottom-100 background-f7fafc border-box box-shadow-small border-radius-5">
						<table id="tblphone" class="con_tb width-100" cellpadding="0" cellspacing="0" border="0" style="table-layout:fixed">
							<thead>
								<tr>
									<th class="width-25">#번호</th>
									<th class="width-20">구분</th>
									<th class="width-25">등록일시</th>
									<th class="width-15">상태</th>
									<th class="width-15">삭제</th>
								</tr>
							</thead>
							<!-- <tbody>
								<tr>
									<td>01012345678</td>
									<td>민원</td>
									<td>2019-01-02 10:30</td>
									<td>사용</td>
									<td class="tb_btn">
										<a href="#" class="icon_delete">삭제</a>
									</td>
								</tr>
							</tbody> -->

							<!--검색결과 없을 시>
							<tfoot>
								<tr>
									<td  colspan="5"></td>
							</tfoot-->
						</table>

						<!-- <div class="text-center">
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
					</div>
					<!-- //검색결과 -->
				</div>
			</div>

 


		 <!-- popup_예약메세지수정 -->
         <div class="pop_wrap pop_modify width-430px" >
            <div class="pop_tit">예약메세지 수정</div>
			<div class="width-100 padding-bottom-10 border-bottom-e9eced">
				<table class="width-100" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th class="width-40 font-000 font-16px text-left vertical-align-top"><span class="inline-block margin-top-15">예약전송일시</span></th>
							<td class="text-left height-60px vertical-align-top">
								<!-- 날짜선택 -->
								<div class="inline-block relative width-100 height-40px line-height-40px text-right  border-radius-5 border-8bc5ff border-box margin-bottom-10">
									<input type="text" id="datePicker" value="2020-02-01" class="datepicker-form text-right font-174962 font-16px padding-0 padding-right-15 margin-0 width-100 height-40px line-height-40px background-transparent" readonly />
								</div>
								
								<!-- 셀렉박스 -->
								<select class="select_blank_lightblue width-120px" style="margin-right:9px">
									<option selected>10시</option>
									<option></option>
									<option></option>
									<option></option>
								</select>
								<select class="select_blank_lightblue width-100px">
									<option selected>20분</option>
									<option></option>
									<option></option>
									<option></option>
								</select>
							</td>
						</tr>
						<tr>
							<th class="width-40 font-000 font-16px text-left vertical-align-top"><span class="inline-block margin-top-15">예약된 수신번호</span></th>
							<td class="text-left height-60px vertical-align-top">
								<!-- 검색박스 -->
								<div class="widht-100 margin-top-10">
									<input type="text" name="" placeholder="검색할 번호를 입력하세요" class="input_blank width-100 border-box border-8bc5ff" style="padding-left:10px;" />
								</div>
								<div class="widht-100 margin-top-10 padding-left-5 height-24px line-height-24px font-16px font-174962">
									검색할 번호를 입력하세요<a class="float-right icon_modify width-55px height-20px line-height-20px background-eee border-radius-10 font-000 font-10px text-right padding-right-10 margin-top-2 border-box">수정</a>
								</div>
								<div class="widht-100 margin-top-10 padding-left-5 height-24px line-height-24px font-16px font-174962">
									검색할 번호를 입력하세요<a class="float-right icon_modify width-55px height-20px line-height-20px background-eee border-radius-10 font-000 font-10px text-right padding-right-10 margin-top-2 border-box">저장</a>
								</div>
							</td>
						</tr>
				</table>
			</div>
            <div class="width-100 font-16px font-000 text-left margin-top-20 margin-bottom-30">
				<span class="font-bold line-height-default">2개</span>의 수신번호가 <span class="font-bold">수정</span>되어 <span class="font-bold">2019-12-20 14:00 예약전송</span>으로 수정됩니다.
			</div>
			<!-- 버튼 -->
			<div class="pop_btn">
				<a class=" background-8bc5ff border-8bc5ff font-fff margin-right-20">예약수정</a>
				<a class="pop_close background-fff border-6f6f6f font-6f6f6f">취소</a>
			</div>
        </div>


		 <!-- popup 수신번호 -->
         <div class="pop_wrap pop_receive width-430px">
            <div class="width-100 font-18px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">수신번호</div>
			<!--정보가 있을 경우-->
			<div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
				<div class="width-100 height-30px line-height-30px text-center  border-radius-5 border-eaeaea font-000 font-16px border-box margin-bottom-5">010-1234-5678</div>
				<div class="width-100 height-30px line-height-30px text-center  border-radius-5 border-eaeaea font-000 font-16px border-box margin-bottom-5">010-1234-5678</div>
			</div>

			<!--정보가 없을 경우-->
			<div class="width-100 margin-auto margin-top-40 margin-bottom-40 text-center font-16px font-000"  style="display:none;">
				직원 주소록에 정보가 존재하지 않습니다.
				<!--div class="width-100 margin-auto margin-top-20 text-center font-14px font-ff6464">*직원주소록을 사용하여 발송한 경우에만 수신자 정보가 표시 됩니다.</div-->			
			</div>
			
			<!--버튼-->
			<div class="pop_btn">
				<a class="pop_close background-8bc5ff border-8bc5ff font-fff">확인</a>
			</div>
        </div>

</body>
</html>
