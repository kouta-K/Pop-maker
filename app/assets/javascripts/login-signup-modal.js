
$(document).on('turbolinks:load', function() {
  $("#login").on("click", function(event){
    event.preventDefault();
    $("#login-form").show();
  });
  $("#login-close").on("click", function(){
    $("#login-form").hide();
  });
  
  $("#signup").on("click", function(event){
    event.preventDefault();
    $("#signup-form").show();
  });
  $("#signup-close").on("click", function(){
    $("#signup-form").hide();
  });
});