/* popup */
$(function(){		
	$(".open_pop_order").click(function(){
		$(".pop_bg").css('display','block');
		$(".pop_order").css('display','block');
	});
	$(".open_pop_deposit").click(function(){
		$(".pop_bg").css('display','block');
		$(".pop_deposit").css('display','block');
	});
	$(".open_pop_buyCrown").click(function(){
		$(".pop_bg").css('display','block');
		$(".pop_buyCrown").css('display','block');
	});
	$(".open_pop_sendCrown").click(function(){
		$(".pop_bg").css('display','block');
		$(".pop_sendCrown").css('display','block');
	});
	$(".open_pop_buy").click(function(){
		$(".pop_bg").css('display','block');
		$(".pop_buy").css('display','block');
	});
	$(".open_pop_inquiry").click(function(){
		$(".pop_bg").css('display','block');
		$(".pop_inquiry").css('display','block');
	});
	$(".pop_close").click(function(){
		$(".pop_bg").css('display','none');
		$(".pop_wrap").css('display','none');
	});		
});



/*fileUpload*/
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