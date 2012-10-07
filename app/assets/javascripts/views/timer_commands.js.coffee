class Pomodoro.Views.TimerCommands extends Backbone.View
  el: '#commands'

  events:
    'click #pomodoro': 'startPomodoro'
    'click #long-break': 'startLongBreak'
    'click #short-break': 'startShortBreak'

  initialize: ->
    @timerView = @options.timerView

  canProceed: ->
    return true if @timerView.isReady()
    msg = "Timer's going to restart. Are you sure?"
    confirm(msg) ? true : false

  startTimerNow: (seconds = 25 * 60)->
    @timerView.on 'reset', =>
      @timerView.off('reset')
      @timerView.resetTimer()
    @timerView.createTimer
      time_in_seconds: seconds
    @timerView.startTimer()


  startTimerOnReady: (seconds = 25 * 60)->
    @timerView.on 'reset', =>
      @timerView.off('reset')

      @timerView.on 'ready', =>
        @timerView.off('ready')
        @startTimerNow(seconds)

      @timerView.resetTimer()

    @timerView.resetTimerGracefully()

  startTimer: (seconds = 25 * 60)->
    return unless @canProceed()
    if @timerView.isReady()
      @startTimerNow(seconds)
    else
      @startTimerOnReady(seconds)

  startPomodoro: ->
    @startTimer()

  startLongBreak: ->
    @startTimer(10 * 60)

  startShortBreak: ->
    @startTimer(5 * 60)
