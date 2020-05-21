
$(document).on('turbolinks:load', function() {
  $("#login").on("click", function(event){
    event.preventDefault();
    $("#login-form").show();
  });
  $("#login-close").on("click", function(){
    $("#login-form").hide();
  });
  $(".login-modal").on("click", function(e){
    e.stopPropagation() 
  })
  $("#login-form").on("click", function(){
    $("#login-form").hide();
  })
  
  $("#signup").on("click", function(event){
    event.preventDefault();
    $("#signup-form").show();
  });
  $("#signup-close").on("click", function(){
    $("#signup-form").hide();
  });
  $(".signup-modal").on("click", function(e){
    e.stopPropagation() 
  })
  $("#signup-form").on("click", function(){
    $("#signup-form").hide();
  })
});