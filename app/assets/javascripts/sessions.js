$(document).on("turbolinks:load",function(){
  var content;
  content = $("#login-content");
  if(content){
    var box_height = $(window).height() / 2 - content.height() / 2;
    var box_width = $(window).width() / 2 - content.width() / 2;
    content.css({position: "absolute"});
    content.css({top: box_height});
    content.css({left: box_width});
  }
})
$(window).on('resize', function(){
  var content;
  content = $("#login-content");
  if(content){
    var box_height = $(window).height() / 2 - content.height() / 2;
    var box_width = $(window).width() / 2 - content.width() / 2;
    content.css({position: "absolute"});
    content.css({top: box_height});
    content.css({left: box_width});
  }
});
