$(".set_time").click(function() {
  var min = Number($(".min").val());
  var sec = $(".sec").val();

  if (0 <= min && min <= 9999 && 0 <= sec && sec <= 59 && min + sec >= 1) {
    s = String(sec).length;
    if (s === 1) {
      sec = 0 + sec;
      window.location.href = "/timer?minute=" + min + "&second=" + sec;
    } else if (s >= 3) {
      $(".fail").css("display", "block");
    } else {
      window.location.href = "/timer?minute=" + min + "&second=" + sec;
    }
  } else {
    $(".fail").css("display", "block");
  }
});
