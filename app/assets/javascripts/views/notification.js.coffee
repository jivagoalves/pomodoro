class Pomodoro.Views.Notification extends Backbone.View
  tagName: 'span'

  className: 'notification'

  message: ''

  initialize: ->
    @collection.on 'add', =>
      @message = '(Saved!)'
      @render()

  animate: (afterAnimation = ->) ->
    @$el.hide().
      fadeIn 1000, afterAnimation

  fadeOutLaterOn: ->
    fadeOut = =>
      @$el.fadeOut(1000)
    setTimeout fadeOut, 5000

  render: ->
    @$el.html(@message)
    @animate =>
      @fadeOutLaterOn()
    @
