# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#fails').imagesLoaded -> 
  		$('#fails').masonry itemSelector: '.box'  

  if $(".pagination").length
      $(window).scroll ->
      	url = $(".pagination .next a").attr("href")
      	if url and $(window).scrollTop() > $(document).height() - $(window).height() - 25
       		$('.pagination').text 'Fetching more fails...'
        	$.getScript(url)

  $(window).scroll()