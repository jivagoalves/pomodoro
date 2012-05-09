window.App =
  init: ->
    $('#timer').createTimer
      autostart: false
      time_in_seconds: 25 * 60

    $('#start_timer').toggle ->
      $('#timer').startTimer()
      $(this).attr('value','Stop')
    , ->
      $('#timer').pauseTimer()
      $(this).attr('value','Start')

$(document).ready ->
  App.init()
