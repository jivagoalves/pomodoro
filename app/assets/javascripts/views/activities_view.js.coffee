class Pomodoro.Views.ActivitiesView extends Backbone.View
  el: '#activities'

  initialize: () ->
    @collection.bind('reset', @reset)
    @collection.on('add', @prependOne)
    @timerView = new Pomodoro.Views.TimerView()

  reset: =>
    @removeAll()
    @addAll()

  removeAll: =>
    this.$el.html('')

  addAll: () =>
    @collection.each(@appendOne)

  appendOne: (activity) =>
    this.$el.append new Pomodoro.Views.ActivityView(
      model: activity
      timerView: @timerView
    ).render().el

  prependOne: (activity) =>
    this.$el.prepend(new Pomodoro.Views.ActivityView(
      model: activity
      timerView: @timerView
    ).render().el)

  render: =>
    @addAll()
    return this
