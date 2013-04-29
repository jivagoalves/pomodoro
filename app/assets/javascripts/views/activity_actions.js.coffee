class Pomodoro.Views.ActivityActions extends Backbone.View
  template: JST['activity_actions']

  events:
    'click .start'  : 'startTimer'
    'click .stop'   : 'stopTimer'
    'click .pause'  : 'pauseTimer'
    'click .resume' : 'resumeTimer'

  started: false

  initialize: ->
    @timerView = @options.timerView
    @spentTimesCollection = @options.spentTimesCollection

  unbindTimerEvents: ->
    @timerView.off()

  bindTimerEvents: ->
    @timerView.on 'ready paused', =>
      if @timerView.isReady()
        @unbindTimerEvents()
        @started = false
      @render()
    @timerView.on 'reset', =>
      @saveSpentTime()

  saveSpentTime: ->
    new Pomodoro.Models.SpentTime().save {
      activity_id: @model.id
      time: @timerView.spentTime()
    }, {
      success: (model, response)=>
        @spentTimesCollection.add(model)
        @timerView.resetTimer()
      error: =>
        alert('Something went wrong!')
        @timerView.resetTimer()
    }

  templateAttributes: ->
    if @started
      timer:
        isRunning: @timerView.isRunning()
        isPaused: @timerView.isPaused()
    else
      timer:
        isRunning: false
        isPaused: false

  render: ->
    this.$el.html @template(@templateAttributes())
    this.$el.hide().fadeIn(1000)
    @

  canUseTimer: ->
    return true if @timerView.isReady()
    msg = "Timer's going to restart. Are you sure?"
    confirm(msg) ? true : false

  prepareToStartTimer: ->
    @bindTimerEvents()
    @started = true
    @trigger("start")

  startTimer: ->
    return unless @canUseTimer()
    if @timerView.isReady()
      @prepareToStartTimer()
      @timerView.startTimer(time_in_seconds: 25 * 60)
    else
      @startTimerOnReady()
      @timerView.resetTimerGracefully()

  startTimerOnReady: ->
    start = =>
      @timerView.off('ready', start, @)
      @prepareToStartTimer()
      @timerView.startTimer(time_in_seconds: 25 * 60)
    @timerView.on('ready', start, @)

  stopTimer: ->
    @timerView.resetTimerGracefully()

  pauseTimer: ->
    @timerView.pauseTimer()

  resumeTimer: ->
    @timerView.startTimer()
