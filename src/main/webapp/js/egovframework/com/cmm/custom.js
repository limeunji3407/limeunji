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
		$('.datepicker-form').datepicker({
		    format: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
		    autoclose : true,	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
		    calendarWeeks : false, //캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
		    clearBtn : false, //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
		    disableTouchKeyboard : false,	//모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
		    immediateUpdates: false,	//사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false 
		    multidate : false, //여러 날짜 선택할 수 있게 하는 옵션 기본값 :false 
		    multidateSeparator :",", //여러 날짜를 선택했을 때 사이에 나타나는 글짜 2019-05-01,2019-06-01
		    templates : {
		        leftArrow: '&laquo;',
		        rightArrow: '&raquo;'
		    }, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징 
		    showWeekDays : true ,// 위에 요일 보여주는 옵션 기본값 : true
		    title: "테스트",	//캘린더 상단에 보여주는 타이틀
		    todayHighlight : true ,	//오늘 날짜에 하이라이팅 기능 기본값 :false 
		    toggleActive : true,	//이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
		    weekStart : 0 ,//달력 시작 요일 선택하는 것 기본값은 0인 일요일 
		    language : "ko"	//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
		});//datepicker end
	});//ready end


/* popup */
	$(function(){		
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
		$(".open_pop_imgupload").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_imgupload").css('display','block');
		});
		$(".open_pop_mybox").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_mybox").css('display','block');
		});
		$(".open_pop_excel").click(function(){
			$(".pop_bg").css('display','block');
			$(".pop_excel").css('display','block');
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
		$(".pop_close").click(function(){
			$(".pop_bg").css('display','none');
			$(".pop_wrap").css('display','none');
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
	});


	/* group */
	$(function(){
		$(".group_tit").click(function(){
			$(this).next(".group_inner").slideToggle();
		});
	});