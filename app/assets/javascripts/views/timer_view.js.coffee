class Pomodoro.Views.TimerView extends Backbone.View
  el: '#timer'

  defaultOptions: ->
    time_in_seconds: 25 * 60
    autostart: false
    tick: (timer, currentTime, formattedTime) =>
      @trigger('running')
    buzzer: (timer) =>
      @resetTimerGracefully()

  initialize: ->
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

  createTimer: ->
    this.$el.createTimer @options
    @trigger('ready')

  startTimer: ->
    this.$el.startTimer @options
    @trigger('ready')

  pauseTimer: ->
    this.$el.pauseTimer()
    @trigger('paused')

  resetTimer: ->
    this.$el.resetTimer @options
    @trigger('ready')

  resetTimerGracefully: ->
    @trigger('reset')

  isRunning: ->
    this.$el.data('countdown.state') == 'running'

  isPaused: ->
    this.$el.data('countdown.state') == 'paused'

  isReady: ->
    this.$el.data('countdown.state') == 'ready'
