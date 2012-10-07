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
    this.$el.
      data('countdown.settings').
      time_in_seconds

  remainingTime: ->
    time = Math.round(this.$el.data('countdown.duration') / 1000)
    return 0 if time <= 0
    time

  spentTime: ->
    @totalTime() - @remainingTime()

  createTimer: (options)->
    this.$el.createTimer _.extend(@options, options)
    @trigger('ready')

  startTimer: (options = {})->
    this.$el.startTimer _.extend(@options, options)
    @trigger('ready')

  pauseTimer: ->
    this.$el.pauseTimer()
    @trigger('paused')

  resetTimer: (options = {})->
    this.$el.resetTimer _.extend(@options, options)
    @trigger('ready')

  resetTimerGracefully: ->
    @trigger('reset')

  isRunning: ->
    this.$el.data('countdown.state') == 'running'

  isPaused: ->
    this.$el.data('countdown.state') == 'paused'

  isReady: ->
    this.$el.data('countdown.state') == 'ready'

  render: ->
    this.$el.hide().fadeIn(1000)
    this
