$(function() {
  var time = 1500;
  var timer = time;
  var setI;
  var min;
  var sec;
  var outer;
  var inner;
  var count = 0;

  function display() {
    min = Math.floor(time / 60);
    sec = time % 60;
    min = ("00" + min).slice(-2);
    sec = ("00" + sec).slice(-2);
    $("#timer").html(min + ":" + sec);
    $(".outer").css("stroke-dashoffset", outer);
    $(".inner").css("stroke-dashoffset", inner);
  }

  $("#plusMin").on("click", function addMinute() {
    if (time >= 5939) {
      time = 5999;
      timer = 5999;
    } else {
      time += 60;
      timer += 60;
    }
    display();
  });
  $("#minusMin").on("click", function removeMinute() {
    if (time <= 60) {
      time = 1;
      timer = 1;
    } else {
      time -= 60;
      timer -= 60;
    }
    display();
  });

  function startTimer() {
    time -= 1;
    outer = 880 - (880 * ((time / timer) * 100)) / 100;
    inner = 10 - (880 * ((time / timer) * 100)) / 100;
    display();

    count += 1;
    $.post("/time", { time: count });

    if (time <= 0) {
      $("#timer").html("Time&nbspUP!");
      clearInterval(setI);
      $(".percent").css({ "box-shadow": "none" });
      $("#alarm")
        .get(0)
        .play();
      setTimeout(function() {
        window.location.href = "/interval";
      }, 5000);
    }
  }
  $("#start").on("click", function() {
    $("#start").prop("disabled", true);
    $("#stop").prop("disabled", false);
    startInterval();
  });
  $("#stop").on("click", function stopTimer() {
    clearInterval(setI);
    $("#start").prop("disabled", false);
    $("#stop").prop("disabled", true);
  });

  function startInterval() {
    setI = setInterval(startTimer, 1000);
  }
});
