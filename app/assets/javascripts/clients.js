$(document).on('turbolinks:load', function(){
  var box_height = $(window).height() / 2 - $("#home-content").height() / 2;
  var box_width = $(window).width() / 2 - $("#home-content").width() / 2;
  $("#home-content").css({position: "absolute"});
  $("#home-content").css({top: box_height});
  $("#home-content").css({left: box_width});
});
$(window).on('resize', function(){
  var box_height = $(window).height() / 2 - $("#home-content").height() / 2;
  var box_width = $(window).width() / 2 - $("#home-content").width() / 2;
  $("#home-content").css({top: box_height});
  $("#home-content").css({left: box_width});
});

