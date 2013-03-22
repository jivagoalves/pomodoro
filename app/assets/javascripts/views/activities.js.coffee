class Pomodoro.Views.Activities extends Backbone.View
  el: '#activities'

  initialize: ->
    @collection.on('reset', @reset)
    @collection.on('add', @prependOne)
    @timerView = @options.timerView

  reset: =>
    @removeAll()
    @addAll()

  removeAll: =>
    @$el.html('')

  addAll: () =>
    @collection.each(@appendOne)

  activityAttributes: ->
    timerView: @timerView
    spentTimes: @options.spentTimes

  appendOne: (activity) =>
    @$el.append new Pomodoro.Views.Activity(
      _.extend { model: activity }, @activityAttributes()
    ).render().el

  prependOne: (activity) =>
    @$el.prepend(new Pomodoro.Views.Activity(
      _.extend { model: activity }, @activityAttributes()
    ).render(timer: { isStarted: false, isPaused: false }).el)

  render: =>
    @addAll()
    @
