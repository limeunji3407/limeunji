
//object를 key value 조건에 따라 분류한후 배열로 리턴
function getListFilter(data, key, value){
	var retObj = [];
	
	
	//if(data.type == value){
		
		$.each(data, function(){
			if(this[key]==value){
				retObj.push(this);
			}
		});
		
	//}else{
	//	console.log(data.)
	//}
	
	return retObj;
}



function addGroupFormShare() {
	var grp_parent = $("#grp_parent option:selected").val();  
	var grp_name = $('input[name=grp_name]').val();  
	var check_grp = $("input[name=check_grp]:checked").val();  
	 
	var obj = {
			"code" : "100000",
			"title" : grp_name,
			"type" : "2",
			"depth": grp_parent,
			"sequence" : 1,
			"parent" : grp_parent
	};
	
	/* alert(JSON.stringify(obj));
	return; */

 	$.ajax({
    	url: "<c:url value='/grp/AddrGroupInsert.do' />",
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

    		/* $('#tree1').tree('loadDataFromUrl', '/grp/AddrGroupSelectOne.do'); */
    		 
    	  $.getJSON('/grp/AddrGroupSelectOne.do/',
    	    	    function(data) {
    	    	    	$('#tree1').tree({
    	    	            data: data["data"],
    	    	            autoOpen: true,
    	    	            openedIcon: $('<a class="minus alt"></a>'),
    	    	            closedIcon: $('<a class="plus"></a>')
    	    	        }); 
    	    	    }
    	    ); 
    		
    		
            	/*    
            	$.each(jsondata["AddrGroup"], function (index, item) {
            	   $("input[type=text][name=" + index + "]").val(item);
            	   //var result = ''; 
            	   //result += index +' : ' + item; 
            	   //$("#result").append(result); 
			   	}); 
            	*/  
            	toastr.success('성공적으로 수정되었습니다'); 
               	/* $(".pop_templet").css('display','none'); */

    		$('#newstaffbtn').attr('disabled', false);
    	 
    	},
    	error: function(request,status,error){
    		  
    		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
        	$('#result').text(jsondata);
        	//alert("serialize err");
    		$('#newstaffbtn').attr('disabled', false);
    	}
	});
} 




function fn_egov_regist_ExcelZip(){
	var varForm				 = document.getElementById("Form");

	// 파일 확장명 확인
	var arrExt      = "xls";
	var arrExt1     = "xlsx";
	var objInput    = varForm.elements["fileNm"];
	var strFilePath = objInput.value;
	var arrTmp      = strFilePath.split(".");
	var strExt      = arrTmp[arrTmp.length-1].toLowerCase();

	if (!(arrExt == strExt || arrExt1 == strExt)) {
		alert("엑셀 파일을 첨부하지 않았습니다.\n확인후 다시 처리하십시오. ");
		abort;
	}
	varForm.action           = "<c:url value='/ExcelAddrBookRegist.do' />";
	//varForm.searchList.value = ${searchList};
	varForm.submit();

}


/*
 * 그룹 Tree 2차 그룹  상위그룹 확인
 */
function findChildren(f,code) { 
    return f.parent === code;
}


function AddNewRowS()
{
	var table = document.getElementById("addressshare");
	var rowlen = table.rows.length;
	var row = table.insertRow(rowlen-(rowlen-1));
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	var cell5 = row.insertCell(4);
	var cell6 = row.insertCell(5);
	
	cell3.innerHTML = "<form id='names-form' data-parsley-validate=''><input id='names' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='주소록 이름' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-maxlength='5'/></form> "
	cell4.innerHTML = "<form id='nums-form' data-parsley-validate=''><input id='nums' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='-제외 숫자만' required='' data-parsley-trigger='change' data-parsley-required='true' data-parsley-type='digits' data-parsley-maxlength='11'/></form>"
	cell5.innerHTML = "<form id='memos-form' data-parsley-validate=''><input id='memos' type='text' class='input_blank width-100 padding-left-20 border-box border-8bc5ff' placeholder ='비고' data-parsley-trigger='change' data-parsley-maxlength='200'/></form>"
	cell6.innerHTML = "<button id='addrSBtn' onclick='AddRefS()'>등록</button> <button onclick='DeleteRowS()'>취소</button>"

}

function DeleteRowS(){
	var table = document.getElementById("addressshare");
	var row = table.deleteRow(1);
}


function AddRefS(){	
	//alert("AddRef() ;;");
	$('#names-form').parsley().validate();
    if (!$('#names-form').parsley().isValid()) {
    	return;
    }
    //alert("name-form ;;");
    
    $('#nums-form').parsley().validate();
    if (!$('#nums-form').parsley().isValid()) {
    	return;
    }
    //alert("num-form ;;");
    
    $('#memos-form').parsley().validate();
    if (!$('#memos-form').parsley().isValid()) {
    	return;
    }
    
    var name = $("#names").val();
    var num = $("#nums").val();
    var memo = $("#memos").val();
    var type = "2";
    
    var obj = {
    		"address_name": name,
    		"address_num": num,
    		"address_ect": memo,
    		"address_type": type
    }
    
	//alert("addref ;; ");
    //alert(JSON.stringify(obj));
    
    $.ajax({
       	url: "<c:url value='/usr/InsertaddressU.do' />",
       	type: "POST",
           data: obj,
           dataType: "json",
           beforeSend:function(){
               $('.wrap-loading').removeClass('display-none');
       		$('#addrSBtn').attr('disabled', false);
           },
		complete:function(){
               $('.wrap-loading').addClass('display-none');
       		$('#addrSBtn').attr('disabled', false);
        },
       	success: function(jsondata){  
     	   
            //alert(jsondata["data"]);
            
            if(jsondata["data"]==0){
                //로딩
                toastr.success("성공적으로 입력 되었습니다.");
                $('#addrSBtn').attr('disabled', false);
           		//close popup
                location.href  ="/mng/addressbook";
            }else{
            	toastr.error("입력에 실패하였습니다. 관리자에게 문의하세요");
            }
       	},
       	error: function(request,status,error){
       		  
       		toastr.error("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
           	$('#result').text(jsondata);
           	//alert("serialize err");
       		$('#addrSBtn').attr('disabled', false);
       	}
   	});
}


var data; 
var listobj = {};



var editor; //관리자 공유주소록 datatable 에디터 변수
var oTableS; //관리자 공유주소록 datatable 변수

/* 그룹TREE 초기 */
var g_group_share = {};
var treedataS = [];
var groupArray = [];
/* 현재 그룹명 */
var currentGroup = "전체";
var ajaxData = {};
var jsTreeS; 


 


