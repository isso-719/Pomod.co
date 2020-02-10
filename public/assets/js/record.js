$(function() {
  $("#ajax").on("click", function() {
    $(".dammy").css("display", "block");
    $(".done").css("display", "none");
    $(".fail").css("display", "none");
    $.post("/tQQBu3FNVhG2AKRv4G9aRRuiqc4nWbmx", {
      did: $("#did").val(),
      understand: $("#understand").val(),
      next: $("#next").val()
    })
      .done(function(data) {
        $(".dammy").css("display", "none");
        $(".done").css("display", "block");
      })
      .fail(function(data) {
        $(".dammy").css("display", "none");
        $(".fail").css("display", "block");
      });
  });
});