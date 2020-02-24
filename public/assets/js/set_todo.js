$(function() {
  $(".set_todo").on("click", function() {
    var content = $(".content").val();
    var day = $(".day").val();
    var hour = Number($(".hour").val());
    var min = Number($(".min").val());
    $.post("/todo", {
      content: content,
      deadline: day + " " + hour + ":" + min + "+0900"
    })
      .done(function(data) {
        window.location.href = "/todo";
      })
      .fail(function(data) {
        window.location.href = "/todo";
      });
  });
});

$(function() {
  $("#toggle").on("click", function() {
    var element = document.getElementById("toggle");
    $.post("/todo_status/" + element.className);
  });
});
