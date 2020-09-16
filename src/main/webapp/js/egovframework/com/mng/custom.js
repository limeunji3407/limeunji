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
		    format: "yyyy-mm-dd",	//������ ���� ����(yyyy : �� mm : �� dd : �� )
		    autoclose : true,	//����ڰ� ��¥�� Ŭ���ϸ� �ڵ� Ķ������ ������ �ɼ�
		    calendarWeeks : false, //Ķ���� ���� �� �������� �����ִ� �ɼ� �⺻�� false �����ַ��� true
		    clearBtn : false, //��¥ ������ �� �ʱ�ȭ ���ִ� ��ư �����ִ� �ɼ� �⺻�� false �����ַ��� true
		    disableTouchKeyboard : false,	//����Ͽ��� �÷����� �۵� ���� �⺻�� false �� �۵� true�� �۵� ����.
		    immediateUpdates: false,	//����ڰ� ���� ȭ������ �ٷιٷ� ��¥�� �������� ���� �⺻�� :false 
		    multidate : false, //���� ��¥ ������ �� �ְ� �ϴ� �ɼ� �⺻�� :false 
		    multidateSeparator :",", //���� ��¥�� �������� �� ���̿� ��Ÿ���� ��¥ 2019-05-01,2019-06-01
		    templates : {
		        leftArrow: '&laquo;',
		        rightArrow: '&raquo;'
		    }, //������ �����޷� �Ѿ�� ȭ��ǥ ��� Ŀ���� ����¡ 
		    showWeekDays : true ,// ���� ���� �����ִ� �ɼ� �⺻�� : true
		    title: "�׽�Ʈ",	//Ķ���� ��ܿ� �����ִ� Ÿ��Ʋ
		    todayHighlight : true ,	//���� ��¥�� ���̶����� ��� �⺻�� :false 
		    toggleActive : true,	//�̹� ���õ� ��¥ �����ϸ� �⺻�� : false�ΰ�� �״�� ���� true�� ��� ��¥ ����
		    weekStart : 0 ,//�޷� ���� ���� �����ϴ� �� �⺻���� 0�� �Ͽ��� 
		    language : "ko"	//�޷��� ��� ����, �׿� �´� js�� ��ü������Ѵ�.
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