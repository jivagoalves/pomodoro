class Pomodoro.Views.Notification extends Backbone.View
  tagName: 'span'

  className: 'notification'

  message: ''

  initialize: ->
    @collection.on 'add', =>
      @message = '(Saved!)'
      @render()

  animate: (afterAnimation = ->) ->
    this.$el.hide().
      fadeIn 1000, afterAnimation

  fadeOutLaterOn: ->
    fadeOut = =>
      this.$el.fadeOut(1000)
    setTimeout fadeOut, 5000

  render: ->
    this.$el.html(@message)
    @animate =>
      @fadeOutLaterOn()
    this
