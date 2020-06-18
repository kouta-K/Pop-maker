$(document).on('turbolinks:load', function(){
  function errorMessage(ary){
    if(ary[0] && ary[1]){
      return ary[0] + "," + ary[1]
    }else{
      return ary[0] + ary[1]
    }
  }
  $(function(){
    let janError = document.getElementById("jan-error")
    let error = ["", ""]
    $("#jancode").on("input", function(e){
      value = e.target.value
      if(value.match(/[a-zA-Z]/g)){
        $("#jancode").css({
          borderColor: "red"
        })
        error[1] = "数字のみにしてください"
      }else{
        error[1] = ""
      }
      
      if(value.length != 13){
        $("#jancode").css({
          borderColor: "red"
        })
        error[0] = "文字数が違います"
      }else{
        error[0] = ""
      }
      
      if(value.length == 13 && !value.match(/[a-zA-Z]/g)){
        error[0] = ""
        error[1] = ""
        $("#jancode").css({
          borderColor: "black"
        })
      }
      janError.textContent = errorMessage(error)
    })
  })
})
