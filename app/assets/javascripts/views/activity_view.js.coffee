class Pomodoro.Views.ActivityView extends Backbone.View
  initialize: ->
    @timerView = @options.timerView
    @timerNotificationView = @options.timerNotificationView

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
    msg = 'Current one is going to be stopped. Are you sure?'
    unless @timerView.isReady()
      unless confirm(msg)
        return false
    true

  bindEvents: ->
    @timerView.on('ready paused', @updateControl, @)
    @timerView.on('reset', @saveSpentTime, @)

  startTimerOnReady: ->
    start = =>
      @timerView.off('ready', start, @)
      @bindEvents()
      @timerView.startTimer()
    @timerView.on('ready', start, @)

  startTimer: ->
    return unless @canProceed()
    if @timerView.isReady()
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
      success: =>
        @timerNotificationView.renderMessage('Saved!')
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
