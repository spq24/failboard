# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#pins').imagesLoaded ->
		$('#pins').masonry({
		 itemSelector: ".box",
		 isAnimated: !Modernizr.csstransitions
	    });
	    
jQuery ->
    $(window).scroll ->
    	if $(window).scrollTop() > $(document).height() - $(window).height() - 50
      		alert "near bottom"