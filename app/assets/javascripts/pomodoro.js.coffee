window.App =
  init: ->
    $('#timer').createTimer
      autostart: false
      time_in_seconds: 25 * 60

    $('#start_timer').click ->
      $('#timer').startTimer()

$(document).ready ->
  App.init()
