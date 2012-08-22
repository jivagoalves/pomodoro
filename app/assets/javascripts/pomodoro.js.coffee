window.App =
  init: ->
    alarmSound = new buzz.sound('/alarm.wav')

    $('#timer').createTimer
      autostart: false
      time_in_seconds: 25 * 60

    $('#start_timer').toggle ->
      $('#timer').startTimer
        buzzer: (timer) ->
          alarmSound.play()
          $(this).resetTimer()
          $('#start_timer').attr('value','Start')
          $('#timer').createTimer
            autostart: false
            time_in_seconds: 25 * 60
      $(this).attr('value','Stop')
    , ->
      $('#timer').pauseTimer()
      $(this).attr('value','Start')

    $('#activity_description').focus ->
      $(this).attr('value','')

$(document).ready ->
  App.init()
