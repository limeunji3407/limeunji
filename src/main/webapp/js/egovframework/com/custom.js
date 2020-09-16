/* select */
$(function(){	
	var select = $("select");
	select.change(function(){
		var select_name = $(this).children("option:selected").text();
		$(this).siblings("label").text(select_name);
		$(this).siblings("label").css('color','#172b4d');
	});
});

$(document).ready(function(){
  var fileTarget = $('.filebox .upload-hidden');

    fileTarget.on('change', function(){
        if(window.FileReader){
            var filename = $(this)[0].files[0].name;
        } else {
            var filename = $(this).val().split('/').pop().split('\\').pop();
        }

        $(this).siblings('.upload-name').val(filename);
    });
}); 




/* calendar -datePicker */
$(function() {	
	/*$.datepicker.setDefaults({
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		dateFormat : 'yy-mm-dd',
		yearSuffix : '년',
		showOtherMonths: true, //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        showMonthAfterYear:true, //년도 먼저 나오고, 뒤에 월 표시
    	changeMonth: true,
        changeYear: true,
		yearRange: "1930:",
		onSelect : function(selectedDate) {
			var option = this.id == "start_dt" ? "minDate" : "maxDate", instance = $(this).data("datepicker"), date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			dates.not(this).datepicker("option", option, date);
		}
	});//datepicker end
*/	
/*	 $.datepicker.setDefaults({
         dateFormat: 'yy-mm-dd' //Input Display Format 변경
         ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
         ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
         ,changeYear: true //콤보박스에서 년 선택 가능
         ,changeMonth: true //콤보박스에서 월 선택 가능                
         ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
         ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
         ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
         ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
         ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
         ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
         ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
         ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
         ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
         ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
         ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
     });*/
});






/* popup */
	$(function(){		
		$(".open_pop_changPartNum").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_changPartNum").css('display','block');
		});
		$(".open_pop_modify").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_modify").css('display','block');
		});
		$(".open_pop_receive").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_receive").css('display','block');
		});
		$(".open_pop_new").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_new").css('display','block');
		});
		$(".open_pop_blocked").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_blocked").css('display','block');
		});
		$(".open_pop_update_part").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_update_part").css('display','block');
		});
		$(".open_pop_imgupload").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_imgupload").css('display','block');
		});
		$(".open_pop_mybox").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_mybox").css('display','block');
		});
		$(".open_pop_button").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_button").css('display','block');
		});
		$(".open_pop_message").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_message").css('display','block');
		});

		$(".open_pop_preview").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_preview").css('display','block');
		});

		$(".open_pop_templet").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_templet").css('display','block');
		});
		$(".open_pop_call_excel").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_call_excel").css('display','block');
		});
		$(".open_pop_call_excel_my").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_call_excel_my").css('display','block');
		});
		$(".open_pop_call_excel_part").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_call_excel_part").css('display','block');
		});
		$(".open_pop_call_excel_s").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_call_excel_s").css('display','block');
		});
		$(".open_pop_user").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_user").css('display','block');
		});
		$(".open_pop_group").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_group").css('display','block');
		});	
		$(".open_pop_address").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_address").css('display','block');
		});	
		$(".open_pop_level").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_level").css('display','block');
		});		
		$(".open_pop_poll").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_poll").css('display','block');
		});	
		$(".open_pop_pw").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_pw").css('display','block');
		});
		$(".open_pop_cer").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_cer").css('display','block');
		});
		$(".open_pop_changPw").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_changPw").css('display','block');
		});
		$(".open_pop_excel").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_excel").css('display','block');
		});
		$(".open_pop_excel_alarm").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_excel_alarm").css('display','block');
		});
		$(".open_pop_excel_ftalk").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_excel_ftalk").css('display','block');
		});
		$(".open_pop_excel_thanks").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_excel_thanks").css('display','block');
		});
		$(".open_pop_PollRes").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_PollRes").css('display','block');
		});	
		$(".pop_close").click(function(){
			$(".pop_bg").css('display','none');
			$(".pop_wrap").css('display','none');
		});	
		$(".pop_templet_close").click(function(){
			$(".pop_templet").css('display','none');
		});	
	});


/* graph & table */
	$(function(){		

		$("#btn_graphview").click(function(){
			$("#graphview").css('display','block');
			$("#tableview").css('display','none');
			$("#btn_graphview").css('display','none');
			$("#btn_tableview").css('display','block');
		});
		$("#btn_tableview").click(function(){
			$("#graphview").css('display','none');
			$("#tableview").css('display','block');
			$("#btn_graphview").css('display','block');
			$("#btn_tableview").css('display','none');
		});
	





		$(".btn_graphview").click(function(){
			 $(this).parent().nextAll(".graphview").css('display','block');
			 $(this).parent().nextAll(".tableview").css('display','none');
			 $(this).css('display','none');
			 $(this).next(".btn_tableview").css('display','block');
		});
		$(".btn_tableview").click(function(){
			$(this).parent().nextAll(".graphview").css('display','none');
			$(this).parent().nextAll(".tableview").css('display','block');
			$(this).prev(".btn_graphview").css('display','block');
			$(this).css('display','none');
		});		








		$("#btn_graphview_month").click(function(){
			$("#graphview_month").css('display','block');
			$("#tableview_month").css('display','none');
			$("#btn_graphview_month").css('display','none');
			$("#btn_tableview_month").css('display','block');
		});
		$("#btn_tableview_month").click(function(){
			$("#graphview_month").css('display','none');
			$("#tableview_month").css('display','block');
			$("#btn_graphview_month").css('display','block');
			$("#btn_tableview_month").css('display','none');
		});

		$("#btn_graphview_year").click(function(){
			$("#graphview_year").css('display','block');
			$("#tableview_year").css('display','none');
			$("#btn_graphview_year").css('display','none');
			$("#btn_tableview_year").css('display','block');
		});

		$("#btn_tableview_year").click(function(){
			$("#graphview_year").css('display','none');
			$("#tableview_year").css('display','block');
			$("#btn_graphview_year").css('display','block');
			$("#btn_tableview_year").css('display','none');
		});
		
		$("#btn_graphview_als").click(function(){
			$("#graphview_als").css('display','block');
			$("#tableview_als").css('display','none');
			$("#btn_graphview_als").css('display','none');
			$("#btn_tableview_als").css('display','block');
		});
		$("#btn_tableview_als").click(function(){
			$("#graphview_als").css('display','none');
			$("#tableview_als").css('display','block');
			$("#btn_graphview_als").css('display','block');
			$("#btn_tableview_als").css('display','none');
		});
		
		$("#btn_graphview_frs").click(function(){
			$("#graphview_frs").css('display','block');
			$("#tableview_frs").css('display','none');
			$("#btn_graphview_frs").css('display','none');
			$("#btn_tableview_frs").css('display','block');
		});
		$("#btn_tableview_frs").click(function(){
			$("#graphview_frs").css('display','none');
			$("#tableview_frs").css('display','block');
			$("#btn_graphview_frs").css('display','block');
			$("#btn_tableview_frs").css('display','none');
		});
	});


	/* group */
	$(function(){
		$(".group_tit").click(function(){
			$(this).next(".group_inner").slideToggle();
		});
	});
	
	/* pw 패턴*/
	var pwset = ["^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$",
		"^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{9,20}$",
		"^(?=.*[a-zA-Z])(?=.*[0-9]).{10,20}$",
		"^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]).{10,20}$",
		"^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{10,20}$"];
	
	
	
	


	/********************* 이미지업로드 *************************/
	
	/*
	* 이미지파일 체크함수 
	* 파일형태체크
	* 용량체크
	* 크기체크
	* 리사이징
	*/

	function checkImage(el, resize) {

		console.log("------------- image file check -------------");
		console.log(el);
	    //확장자
		var ext = $(el).val().split(".").pop().toLowerCase();
	    
	    if($.inArray(ext,["gif","jpg","jpeg","png","bmp"]) == -1) {
	        alert("gif, jpg, jpeg, png, bmp 파일만 업로드 해주세요.");
	        $(el).val("");
	        return;
	    }

	    //이미지 최대사이즈체크
	    var fileSize = el.files[0].size;
	    var maxSize = 1024 * 1024;
	    if(fileSize > maxSize) {
	        alert("파일용량을 초과하였습니다.");
	        $(el).val("");
	        return;
	    }

	    //이미지 가로 세로 크기체크
	    var file  = el.files[0];
	    var _URL = window.URL || window.webkitURL;
	    var img = new Image();
	    
	    img.src = _URL.createObjectURL(file);
	    img.onload = function() {
	        
	        if(img.width != 700 || img.height != 700) {
	            //alert("이미지 가로 7px, 세로 270px로 맞춰서 올려주세요.");
	            //$(el).val("");
	        } 
	    }	
	    
	    //리사이즈
	    if( resize ) {  
	    	imgResize(img, 700, 700);
	    } 
	    
	    return img;
	}

	/* 
	 * 리사이징 가로/세로 비율상관없이
	 */
	function imgResize(img, maxw, maxh){ 

		   // 원본 이미지 사이즈 저장
		   var width = img.width;
		   var height = img.height;
		 

		   // 가로, 세로 최대 사이즈 설정
		   var maxWidth = maxw; //width * 0.5;   // 원하는대로 설정. 픽셀로 하려면 maxWidth = 100  이런 식으로 입력
		   var maxHeight = maxh; //height * 0.5;   // 원래 사이즈 * 0.5 = 50% 

		   // 가로나 세로의 길이가 최대 사이즈보다 크면 실행  
		   if(width > maxWidth || height > maxHeight){

		 

		      // 가로가 세로보다 크면 가로는 최대사이즈로, 세로는 비율 맞춰 리사이즈
		      if(width > height){
		         resizeWidth = maxWidth;
		         resizeHeight = Math.Round((height * resizeWidth) / width);

		 

		      // 세로가 가로보다 크면 세로는 최대사이즈로, 가로는 비율 맞춰 리사이즈
		      }else{
		         resizeHeight = maxHeight;
		         resizeWidth = Math.Round((width * resizeHeight) / height);
		      }

		 

		   // 최대사이즈보다 작으면 원본 그대로
		   }else{
		      resizeWidth = width;
		      resizeHeight = height;
		   }

		 

		   // 리사이즈한 크기로 이미지 크기 다시 지정
		   img.width = resizeWidth;
		   img.height = resizeHeight;
	}		

	/********************* 이미지업로드 *************************/
	 

	
	

	


		