$(document).on("turbolinks:load",function(){
  var content;
  if ($("#home-content").length){
    content = $("#home-content");
  } else if ($("#upload-content").length){
    content = $("#upload-content");
  }
  var box_height = $(window).height() / 2 - content.height() / 2;
  var box_width = $(window).width() / 2 - content.width() / 2;
  content.css({position: "absolute"});
  content.css({top: box_height});
  content.css({left: box_width});
})
$(window).on('resize', function(){
  var content;
  if ($("#home-content").length){
    content = $("#home-content");
  } else if ($("#upload-content").length){
    content = $("#upload-content");
  }
  var box_height = $(window).height() / 2 - content.height() / 2;
  var box_width = $(window).width() / 2 - content.width() / 2;
  content.css({position: "absolute"});
  content.css({top: box_height});
  content.css({left: box_width});
});
