$(function() {
  $(".set_todo").on("click", function() {
    var day = $(".day").val();
    var hour = Number($(".hour").val());
    var min = Number($(".min").val());
    $.post("/todo", {
      content: "test",
      deadline: day + " " + hour + ":" + min
    })
      .done(function(data) {
        window.location.href = "/";
      })
      .fail(function(data) {
        window.location.href = "/";
      });
  });
});
