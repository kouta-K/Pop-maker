$(document).on('turbolinks:load', function(){
  $("#csv-btn").on("click", function(e){
    e.preventDefault();
    $("#store-csv").fadeIn();
  })
  
  $("#store-csv").on("click", function(e){
    $(this).fadeOut();
  })
  
  $(".csv-form").on("click", function(e){
    e.stopPropagation();
  })
  
  $("#csv-attention").on("click", function(){
    if($(this).hasClass("active")){
      $(this).removeClass("active");
      $("#csv-attention-content").fadeOut();
    }else{
      $(this).addClass("active");
      $("#csv-attention-content").fadeIn();
    }
  })
})