class Pomodoro.Views.Activities extends Backbone.View
  el: '#activities'

  initialize: ->
    @collection.on('reset', @reset)
    @collection.on('add', @prependOne)
    @timerView = @options.timerView
    @timerNotificationView = @options.timerNotificationView

  reset: =>
    @removeAll()
    @addAll()

  removeAll: =>
    this.$el.html('')

  addAll: () =>
    @collection.each(@appendOne)

  activityAttributes: ->
    timerView: @timerView
    timerNotificationView: @timerNotificationView
    spentTimes: @options.spentTimes

  appendOne: (activity) =>
    this.$el.append new Pomodoro.Views.Activity(
      _.extend { model: activity }, @activityAttributes()
    ).render().el

  prependOne: (activity) =>
    this.$el.prepend(new Pomodoro.Views.Activity(
      _.extend { model: activity }, @activityAttributes()
    ).render(timer: { isStarted: false, isPaused: false }).el)

  render: =>
    @addAll()
    return this
