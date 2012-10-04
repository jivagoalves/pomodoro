class Pomodoro.Views.ActivitiesView extends Backbone.View
  el: '#activities'

  initialize: () ->
    @collection.bind('reset', @reset)
    @collection.on('add', @prependOne)
    @timerView = new Pomodoro.Views.TimerView()
    @timerNotificationView = new Pomodoro.Views.TimerNotificationView()

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

  appendOne: (activity) =>
    this.$el.append new Pomodoro.Views.ActivityView(
      _.extend { model: activity }, @activityAttributes()
    ).render().el

  prependOne: (activity) =>
    this.$el.prepend(new Pomodoro.Views.ActivityView(
      _.extend { model: activity }, @activityAttributes()
    ).render(timer: { isStarted: false, isPaused: false }).el)

  render: =>
    @addAll()
    return this
