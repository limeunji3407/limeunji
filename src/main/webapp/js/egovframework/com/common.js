function previewImgCreate(e) {
    var $input = $(this);
    var inputFile = this.files[0];
    
    var reader = new FileReader();
    reader.onload = function(event) {
    	$input.before("<img src="+event.target.result+" style='margin-bottom:20px;'>");
        ajaxUpload(inputFile, $input, function(data_url){
        	$input.next().val(data_url);
        })
    };
    reader.readAsDataURL(inputFile);
}
function previewImgUpdate(e) {
    var $input = $(this);
    var inputFile = this.files[0];
    
    var reader = new FileReader();
    reader.onload = function(event) {
    	console.log($input.prev())
    	$input.prev().attr("src", event.target.result);
        ajaxUpload(inputFile, $input, function(data_url){
        	$input.next().val(data_url);
        })
    };
    reader.readAsDataURL(inputFile);
}
function ajaxUpload(inputFile, $input, callback){
	var formData = new FormData();
	formData.append("file", inputFile);
	jQuery.ajax({
		url : "/api/file/ajaxupload"
			, type : "POST"
				, processData : false
				, contentType : false
				, data : formData
				, success:function(data_url) {
					callback(data_url)
				}
	});
}
function ajaxUploadRealName(inputFile, isReal, callback){
	isReal = isReal ? "Y":"N";
	
	var formData = new FormData();
	formData.append("file", inputFile);
	jQuery.ajax({
		url : "/api/file/ajaxupload2?is_real="+isReal
			, type : "POST"
				, processData : false
				, contentType : false
				, data : formData
				, success:function(data_url) {
					callback(data_url)
				}
	});
}
var global = {
		fileSizeChk:function(files, globalFileMaxSize){
			 var fileSize = parseFloat(files.size)/1000; //바이트
			 fileSize = fileSize/1000; //메가
			 fileSize = fileSize.toFixed(1);
			 if(parseInt(fileSize)>parseInt(globalFileMaxSize)){
				 alert("엑셀 업로드 최대 용량은 "+globalFileMaxSize+"MB 입니다.")
				 return true;
			 }else{
				 return false;
			 }
		},
		htmlTableToExcel:function(tableId, fileName, sheetName, sheetRowCnt) {

			/**
			 * tableId : 테이블 id (내용은 tbody안에 있어야함)
			 * fileName : 파일명
			 * sheetName : 시트명 -> 시트가 추가될수록 시트명_1, 시트명_2 로 추가됨
			 * sheetRowCnt : 하나의 시트에 max row 개수
			 * sheetCnt : 엑셀파일의 시트 개수 -> max row 개수에 맞게 계산한값
			 * rstList : row 데이터
			 */


			var ths = $("#"+tableId).find("th");
			var trs = $("#"+tableId).find("tbody").find("tr");
			var rstList = new Array();
			var sheetCnt = Math.ceil(trs.length/sheetRowCnt);

			for(var i = 0 ; i < sheetCnt ; i++){
				var sub = new Array();
				rstList.push(sub);
			}

			for(var i = 0 ; i < trs.length ; i++){
				var tds = trs.eq(i).find("td");
				var obj = {}
				for(var x = 0 ; x < tds.length ; x++){
					var name = ths.eq(x).text(); name = name ? name : "번호";
					var value = tds.eq(x).text();
					
					value = value && name != '번호' ? value : (i+1);
					obj[name] = value;
				}
				
				
				var sheetIndex = i/sheetRowCnt;
				sheetIndex = Math.floor(sheetIndex);
				rstList[sheetIndex].push(obj);
			}
			var sheetNameLastName = 1;
			var opts = new Array();
			for(var i = 0 ; i < rstList.length ; i++){
				var obj = {}
				obj.sheetid = sheetName+"_"+(sheetNameLastName++);
				obj.header = true;
				opts.push(obj);
			}
			var res = alasql('SELECT INTO XLSX("'+fileName+'.xlsx",?) FROM ?',[opts,rstList]);
		},
		settingTableCnt:function(textCnt, table){
			 setTimeout(function(){
				 textCnt.text(table.data().count());	 
			 },1500)
		},
		replaceNumber:function(val){
	    	var pattern = /[^(0-9)]/gi;   // 숫자이외는 제거
	    	if(val){
		    	return val.replace(pattern,"");
	    	}else{
	    		return val;
	    	}
	    },
	    parse:function(str) {
	    	if(str && str.length > 5){
	    	    var y = str.substr(0, 4);
	            var m = str.substr(4, 2);
	            var d = str.substr(6, 2);
	            return y+m+d;
	    	}else{
	    		return str;
	    	}
	    },
	    htmlTemplateToExcel:function(tableId, fileName, sheetName, sheetRowCnt) {
			var trs = $("#"+tableId).find(".first-div");
			var rstList = new Array();
			var sheetCnt = Math.ceil(trs.length/sheetRowCnt);

			for(var i = 0 ; i < sheetCnt ; i++){
				var sub = new Array();
				rstList.push(sub);
			}

			for(var i = 0 ; i < trs.length ; i++){
				var name = trs.eq(i).find(".template-name").text();
				var status = trs.eq(i).find(".template-status").text();
				var content = trs.eq(i).find(".template-content").text();
				var obj = {}
				obj["번호"] = (i+1);
				obj["템플릿명"] = name;
				obj["등록상태"] = status;
				obj["템플릿내용"] = content;
				
				var sheetIndex = i/sheetRowCnt;
				sheetIndex = Math.floor(sheetIndex);
				rstList[sheetIndex].push(obj);
			}
			var sheetNameLastName = 1;
			var opts = new Array();
			for(var i = 0 ; i < rstList.length ; i++){
				var obj = {}
				obj.sheetid = sheetName+"_"+(sheetNameLastName++);
				obj.header = true;
				opts.push(obj);
			}
			var res = alasql('SELECT INTO XLSX("'+fileName+'.xlsx",?) FROM ?',[opts,rstList]);
		},
		jstreeUpdate:function(data, callback){
	        var code = data.node.id;
	        var tempAddr = data.node.text;
        	if(tempAddr.indexOf("(") > -1){
        		tempAddr = tempAddr.substring(0, tempAddr.indexOf("("))
        	}
	        var title = tempAddr;
	        var obj = {
	        		"code":code,
	        		"title":title
	        }
	        $.ajax({
		    	url: "/grp/AddrGroupUpdateName.do",
		       	type: "POST",
	        	data: obj,
		    	dataType: "json",
		       	success: function(jsondata){  
		       		callback();
		       	},
		       	error: function(request,status,error){
		       		console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
		       	}
		   	});
		},
		jstreeUpdateSequence:function(data, callback){
			var code = data.node.id;
			var position = data.position;
			var obj = {
					"code":code,
					"sequence":position
			}
			$.ajax({
				url: "/grp/AddrGroupUpdateSequence.do",
				type: "POST",
				data: obj,
				dataType: "json",
				success: function(jsondata){  
					callback();
				},
				error: function(request,status,error){
					console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
				}
			});
		},
		checkTime:function(time, minute){
			
			if(!time) return true;
			
			var toDay = global.formatTime(null, 0);
			var reservationDay = global.formatTime(time.replace(/-/gi, "").replace(/:/gi, "").replace(/ /gi, ""), minute);
			if(reservationDay <= toDay){
				return false;
			}else{
				return true;
			}

		},
		formatTime:function(time, minute){
			if(time){
				var today = global.parseDetail(time);
			}else{
				var today = new Date(); 
			}
			var year = today.getFullYear();
			var month = (today.getMonth()+1); month = month < 10 ? "0"+month : month;
			var day = today.getDate(); day = day < 10 ? "0"+day : day;
			var hours = today.getHours();  hours = hours < 10 ? "0"+hours : hours;
			var minutes = (today.getMinutes()+minute);   minutes = minutes < 10 ? "0"+minutes : minutes;
			var seconds = today.getSeconds();   seconds = seconds < 10 ? "0"+seconds : seconds;
			var toDay = year+""+month+""+day+""+hours+""+minutes+""+seconds;
			return toDay;
		},
		parseDetail:function(str) {
		    var y = str.substr(0, 4);
		    var m = str.substr(4, 2);
		    var d = str.substr(6, 2);
		    var h = str.substr(8, 2);
		    var mi = str.substr(10, 2);
		    var s = str.substr(12, 2);
		    return new Date(y,m-1,d,h,mi,s);
		}
	}
