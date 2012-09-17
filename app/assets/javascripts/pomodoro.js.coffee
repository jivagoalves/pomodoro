window.App =
  init: ->
    alarmSound = new buzz.sound('/alarm.wav')

    $('.stop').hide()

    $('#timer').createTimer
      autostart: false
      time_in_seconds: 25 * 60

    $('.start').click ->
      startLink = this
      $(startLink).hide()
      $('.stop').show()

      $('#timer').startTimer
        buzzer: (timer) ->
          alarmSound.play()
          $(this).resetTimer()
          $(startLink).show()
          $('#timer').createTimer
            autostart: false
            time_in_seconds: 25 * 60

    $('.stop').click ->
      $('#timer').pauseTimer()
      $(this).hide()
      $('.start').show()

    $('#activity_description').focus ->
      $(this).attr('value','')

$(document).ready ->
  App.init()
