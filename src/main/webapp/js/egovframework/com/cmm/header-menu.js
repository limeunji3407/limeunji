/* select */
$(function(){	
	$(".h-menu li").hover(function() {
		$(this).children("ul").stop().slideToggle(500)
	})
});