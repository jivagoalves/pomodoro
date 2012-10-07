class Pomodoro.Views.Activity extends Backbone.View
  initialize: ->
    @timerView = @options.timerView
    @timerNotificationView = @options.timerNotificationView
    @spentTimes = @options.spentTimes

  template: JST['activity']

  events:
    'click .destroy' : 'destroy'
    'click .start' : 'startTimer'
    'click .pause' : 'pauseTimer'
    'click .resume' : 'resumeTimer'

  tagName: 'li'

  class: 'activity'

  destroy: () ->
    if confirm('Are you sure?')
      @model.destroy()
      @timerView.off('ready paused', @updateControl, @)
      @timerView.resetTimer()
      this.$el.fadeOut =>
        @remove()
    false

  canProceed: ->
    return true if @timerView.isReady()
    msg = "Timer's going to restart. Are you sure?"
    confirm(msg) ? true : false

  bindEvents: ->
    @timerView.on('ready paused', @updateControl, @)
    @timerView.on('reset', @saveSpentTime, @)

  startTimerOnReady: ->
    start = =>
      @timerView.off('ready', start, @)
      @timerView.resetTimer(time_in_seconds: 25 * 60)
      @bindEvents()
      @timerView.startTimer()
    @timerView.on('ready', start, @)

  startTimer: ->
    return unless @canProceed()
    if @timerView.isReady()
      @timerView.resetTimer(time_in_seconds: 25 * 60)
      @bindEvents()
      @timerView.startTimer()
    else
      @startTimerOnReady()
      @timerView.resetTimerGracefully()

  pauseTimer: ->
    @timerView.pauseTimer()

  resumeTimer: ->
    @timerView.startTimer()

  saveSpentTime: =>
    new Pomodoro.Models.SpentTime().save {
      activity_id: @model.id
      time: @timerView.spentTime()
    }, {
      success: (model, response)=>
        @timerNotificationView.renderMessage('Saved!')
        @spentTimes.add(model)
      error: =>
        @timerNotificationView.renderMessage('Something went wrong!')
    }
    @timerView.resetTimer()

  updateControl: ->
    if @timerView.isReady()
      @timerView.off('ready paused', @updateControl, @)
      @timerView.off('reset', @saveSpentTime, @)
    @render()

  render: (options = {})->
    @setHtml(options)
    this.$el.hide().fadeIn(1000)
    this

  setHtml: (options = {})->
    this.$el.html @template(
      _.extend {
        model: @model.toJSON()
        timer:
          isStarted: @timerView.isRunning()
          isPaused: @timerView.isPaused()
      }, options
    )
