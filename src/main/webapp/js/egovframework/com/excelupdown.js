/*
 * 엑셀 다운로드
 */
var excelHandler = {
        getExcelFileName : function(filename){
            return filename;
        },
        getSheetName : function(name){
            return name;
        },
        getExcelData : function(tableId){
            return document.getElementById(tableId); 
        },
        getWorksheet : function(tableId){
            return XLSX.utils.table_to_sheet(this.getExcelData(tableId));
        }
}


function s2ab(s) { 
    var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
    var view = new Uint8Array(buf);  //create uint8array as viewer
    for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
    return buf;    
}
function exportExcel(tableId, name, filename){ 
	filename = filename + getTimeStamp() + ".xlsx";
    // step 1. workbook 생성
    var wb = XLSX.utils.book_new();

    // step 2. 시트 만들기 
    var newWorksheet = excelHandler.getWorksheet(tableId);
    
    // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName(name));

    // step 4. 엑셀 파일 만들기 
    var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

    // step 5. 엑셀 파일 내보내기 
    saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName(filename));
}
/*
 * 엑셀 다운로드
 */




/*
 * 엑셀업로드  JSON //엑셀을 테이블ID에 넣기
 */


function excelExport(event, target, tableId){
	console.log("------excelUpload");
	console.log(event);
	console.log(target);
	console.log(tableId);
    var input = document.getElementById("filemsg").files[0];;
    console.log(input);

    var reader = new FileReader();
    reader.onload = function(){
        var fileData = reader.result;
        var wb = XLSX.read(fileData, {type : 'binary'});
        wb.SheetNames.forEach(function(sheetName){
           //var toHtml = XLSX.utils.sheet_to_html(wb.Sheets[sheetName], { header: '' });
  	       //target.html(toHtml); 	       
  	       var rowObj = XLSX.utils.sheet_to_json(wb.Sheets[sheetName]); 
  	       makeTR(json2array(rowObj), tableId); 
        })
    };
    reader.readAsBinaryString(input);
}

/* JSON을 자바스크립트 배열로 전환 */
function json2array(json){
    var result = [];
    var keys = Object.keys(json);
    keys.forEach(function(key){
        result.Push(json[key]);
    });
    return result;
}

function makeTR(jArr, tableId){

      alert(jArr + ": tableId = " + tableId );

		for (i = 0; i < jArr.length; i++)
		{
			var trData = "<tr><td></td><td>" + jArr[i] + 
			"</td><td></td><td class=\"tb_btn\"><a class=\"open_pop icon_modify\">수정</a>" + 
			"<a href=\"#\" class=\"icon_delete\"onclick=\"deleteLine(this);\" >삭제</a></td></tr>";
			
			$(tableId).append(trData); 
		} 
      
	/*jsondata.forEach(function(item){
		
		$(tableId).append( );
		+= '<tr><td>' + item.firstName + '</td><td>' + item.seName + '</td></tr>' 
	})
	
	$.each(jsondata, function (index, item) { 
    	var result = ''; 
     	result += index + ' : ' + item; 
     	$(tableId).append(result); 
	});
	$(tableId).innerHTML = result;*/
}


function getTimeStamp() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
}



function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
} 


function getCurrentDate() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2);
	  return s;	
}

function f_chk_byte(aro_name,ari_max) {

	var ls_str= aro_name.value;
	var li_str_len = ls_str.length;
	var li_max= ari_max;
	var i= 0;
	var li_byte= 0;
	var li_len= 0;
	var ls_one_char = "";
	var ls_str2= "";

	for(i=0; i< li_str_len; i++) {
		ls_one_char = ls_str.charAt(i);
		
		if (escape(ls_one_char).length > 4)
			li_byte += 2;
		else
			li_byte++;

		if (li_byte <= li_max) li_len = i + 1;

	}

	if(li_byte > li_max) {
		toastr.error("한글 " + ari_max + "글자를 초과 입력할수 없습니다. 초과된 내용은 자동으로 삭제 됩니다.");
		ls_str2 = ls_str.substr(0, li_len);
		aro_name.value = ls_str2;
	}

	aro_name.focus();
}


function onlyBackspace(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8  ) 
        return;
    else
        return false;
}

function onlyNumber(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        return false;
}

function onlyNumberEnter(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || keyID == 13 || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39) 
        return;
    else
        return false;
}

/* div */
function removeCharEnter(event, obj) {
	/*
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    //alert( keyID );
    if ( keyID == 13 ||  keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39) 
        return;
    else
        event.target.value = event.target.value.replace(/[^(0-9)|^\n]/g, '');
    
    */
}

/* textarea */
function removeChar(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        event.target.value = event.target.value.replace(/[^0-9]/g, '');
}

function getTextLength(str) {
    var len = 0;
    for (var i = 0; i < str.length; i++) {
        if (escape(str.charAt(i)).length == 6) {
            len++;
        }
        len++;
    }
    return len;
}

function chkByte(id){
    var obj = $("#"+id);
    var max = Number(byteCheck(obj));
    
    if(max > 10){
    	alert(max);
    	
    }
	
} 

/**
 * 바이트 문자 입력가능 문자수 체크
 * 
 * @param id : tag id 
 * @param title : tag title
 * @param maxLength : 최대 입력가능 수 (byte)
 * @returns {Boolean}
 */
function maxLengthCheck(id, title, maxLength){
     var obj = $("#"+id);
     if(maxLength == null) {
         maxLength = obj.attr("maxLength") != null ? obj.attr("maxLength") : 1000;
     }
     toastr.success( Number(byteCheck(obj)) + ":" + Number(maxLength) );
     if(Number(byteCheck(obj)) > Number(maxLength)) {
         toastr.error(title + "이(가) 입력가능문자수를 초과하였습니다.\n(영문, 숫자, 일반 특수문자 : " + maxLength + " / 한글, 한자, 기타 특수문자 : " + parseInt(maxLength/2, 10) + ").");
         obj.focus();
         return false;
     } else {
         return true;
    }
}
 
/**
 * 바이트수 반환  
 * 
 * @param el : tag jquery object
 * @returns {Number}
 */
function byteCheck(el){
    var codeByte = 0;
    for (var idx = 0; idx < el.val().length; idx++) {
        var oneChar = escape(el.val().charAt(idx));
        if ( oneChar.length == 1 ) {
            codeByte ++;
        } else if (oneChar.indexOf("%u") != -1) {
            codeByte += 2;
        } else if (oneChar.indexOf("%") != -1) {
            codeByte ++;
        }
    }
    return codeByte;
}
 


/* 현재 행 삭제 */
function deleteLine(obj) {
    var tr = $(obj).parent().parent();
 
    //라인 삭제
    tr.remove();
}
 
function handlePaste (e) {
    var clipboardData, pastedData;

    // Stop data actually being pasted into div
    e.stopPropagation();
    e.preventDefault();

    // Get pasted data via clipboard API
    clipboardData = e.clipboardData || window.clipboardData;
    pastedData = clipboardData.getData('Text');

    // Do whatever with pasteddata
    alert(pastedData);
}