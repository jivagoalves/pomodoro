class Pomodoro.Views.Timer extends Backbone.View
  el: '#timer'

  defaultOptions: ->
    time_in_seconds: 25 * 60
    autostart: false
    tick: (timer, currentTime, formattedTime) =>
      @trigger('running')
    buzzer: (timer) =>
      @alarm.play()
      @resetTimerGracefully()

  initialize: ->
    @alarm = new buzz.sound('/alarm.wav')
    @options = _.extend @defaultOptions(), @options
    @createTimer()

  totalTime: ->
    @$el.
      data('countdown.settings').
      time_in_seconds

  remainingTime: ->
    time = Math.round(@$el.data('countdown.duration') / 1000)
    return 0 if time <= 0
    time

  spentTime: ->
    @totalTime() - @remainingTime()

  createTimer: (options)->
    @$el.createTimer _.extend(@options, options)
    @trigger('ready')

  startTimer: (options = {})->
    @$el.hide().fadeIn(1000)
    @$el.startTimer _.extend(@options, options)
    @trigger('ready')

  pauseTimer: ->
    @$el.pauseTimer()
    @trigger('paused')

  resetTimer: (options = {})->
    @$el.resetTimer _.extend(@options, options)
    @trigger('ready')

  resetTimerGracefully: ->
    @trigger('reset')

  isRunning: ->
    @$el.data('countdown.state') == 'running'

  isPaused: ->
    @$el.data('countdown.state') == 'paused'

  isReady: ->
    @$el.data('countdown.state') == 'ready'
