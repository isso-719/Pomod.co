$(function() {
  $(".set_goal").on("click", function() {
    var hour = Number($(".hour").val());
    $.post("/set_goal", {
      goal: hour
    })
      .done(function(data) {
        window.location.href = "/";
      })
      .fail(function(data) {
        window.location.href = "/";
      });
  });
});
