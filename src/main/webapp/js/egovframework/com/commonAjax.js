/**
 * AJAX 공통소스
 */
function ajaxCallPost(url, param, callbackSuccess, callbackFail){
	console.log("=========================================================")
	console.log("endPoint : " + url);
	console.log(JSON.stringify(param));
	$.ajax({
		url: url,
       	type: "POST",
        data: JSON.stringify(param),
        dataType: "json",
        contentType:"application/json",
		success : function(res) {
			console.log(JSON.parse(res));
    		console.log("=========================================================")
			callbackSuccess(JSON.parse(res));
		},
		error : function(xhr, status, error) {
			console.log(error);
    		console.log("=========================================================")
			callbackFail(error);
		}
	});
}

function ajaxCallGet(url, callbackSuccess, callbackFail){
	console.log("=========================================================")
	console.log("endPoint : " + url);
	$.ajax({
		type : "GET",
		url : url,
		dataType: "json",
		contentType : "application/json",
		success : function(res) {
			console.log(JSON.parse(res));
    		console.log("=========================================================")
			callbackSuccess(JSON.parse(res));
		},
		error : function(xhr, status, error) {
			console.log(error);
    		console.log("=========================================================")
			callbackFail(error);
		}
	});
}

function ajaxCallGetNoParse(url, callbackSuccess, callbackFail){
	console.log("=========================================================")
	console.log("endPoint : " + url);
	$.ajax({
		type : "GET",
		url : url,
		dataType: "json",
		contentType : "application/json",
		success : function(res) {
			console.log(res);
			console.log("=========================================================")
			callbackSuccess(res);
		},
		error : function(xhr, status, error) {
			console.log(error);
			console.log("=========================================================")
			callbackFail(error);
		}
	});
}