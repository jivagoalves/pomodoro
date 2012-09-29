Pomodoro.Views.Activities ||= {}

class Pomodoro.Views.ActivityView extends Backbone.View
  initialize: ->
    @timerView = @options.timerView

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
    msg = 'Current task is going to be stopped. Are you sure?'
    unless @timerView.isReady()
      unless confirm(msg)
        return false
    true

  startTimer: ->
    return unless @canProceed()
    if @timerView.isReady()
      @timerView.on('ready paused', @updateControl, @)
      @timerView.startTimer()
    else
      @timerView.resetTimer()
      startLaterOn = =>
        @timerView.on('ready paused', @updateControl, @)
        @timerView.startTimer()
      setTimeout startLaterOn, 1000

  pauseTimer: ->
    @timerView.pauseTimer()

  resumeTimer: ->
    @timerView.startTimer()

  updateControl: ->
    if @timerView.isReady()
      @timerView.off('ready paused', @updateControl, @)
    @render()

  render: ->
    @setHtml()
    this.$el.hide().fadeIn()
    this

  setHtml: ->
    this.$el.html @template
      model: @model.toJSON()
      timer:
        isStarted: @timerView.isRunning()
        isPaused: @timerView.isPaused()
