function getUrlParameter(name) {
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
  var results = regex.exec(location.search);
  return results === null
    ? ""
    : decodeURIComponent(results[1].replace(/\+/g, " "));
}

$(function() {
  set_min = parseInt(getUrlParameter("minute"));
  set_sec = parseInt(getUrlParameter("second"));
  if (set_min < 10) {
    if (set_sec < 10) {
      $("#timer").text(
        "0" + getUrlParameter("minute") + ":" + "0" + getUrlParameter("second")
      );
    } else {
      $("#timer").text(
        "0" + getUrlParameter("minute") + ":" + getUrlParameter("second")
      );
    }
  } else {
    if (set_sec < 10) {
      $("#timer").text(
        getUrlParameter("minute") + ":" + "0" + getUrlParameter("second")
      );
    } else {
      $("#timer").text(
        getUrlParameter("minute") + ":" + getUrlParameter("second")
      );
    }
  }

  first_time = set_min * 60 + set_sec;
  var time = first_time;
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
    if (time <= 5999) {
      min = ("00" + min).slice(-2);
    } else if (time >= 6000) {
      min = ("000" + min).slice(-3);
    } else if (time >= 60000) {
      min = ("0000" + min).slice(-4);
    }
    sec = ("00" + sec).slice(-2);
    $("#timer").html(min + ":" + sec);
    $(".outer").css("stroke-dashoffset", outer);
    $(".inner").css("stroke-dashoffset", inner);
  }

  $("#plusMin").on("click", function addMinute() {
    if (time >= 599939) {
      time = 599999;
      timer = 599999;
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
    $.post("/pJsDQTKCQSepB8AzkcPmNcEm88VSzwKx", { time: count });

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
