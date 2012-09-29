class Pomodoro.Views.TimerView extends Backbone.View
  el: '#timer'

  defaultOptions: ->
    time_in_seconds: 10
    autostart: false
    tick: (timer, currentTime, formattedTime) =>
      @trigger('running')
    buzzer: (timer) =>
      @resetTimer()

  initialize: ->
    @createTimer()

  createTimer: ->
    this.$el.createTimer @defaultOptions()
    @trigger('ready')

  startTimer: ->
    this.$el.startTimer @defaultOptions()
    @trigger('ready')

  pauseTimer: ->
    this.$el.pauseTimer()
    @trigger('paused')

  resetTimer: ->
    this.$el.resetTimer @defaultOptions()
    @trigger('ready')

  isRunning: ->
    this.$el.data('countdown.state') == 'running'

  isPaused: ->
    this.$el.data('countdown.state') == 'paused'

  isReady: ->
    this.$el.data('countdown.state') == 'ready'
