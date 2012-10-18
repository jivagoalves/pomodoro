class Pomodoro.Routers.Activities extends Backbone.Router
  initialize: (options) ->
    @activities = new Pomodoro.Collections.Activities options.activities
    @spentTimes = new Pomodoro.Collections.SpentTimes options.spentTimes

  routes:
    ".*" : "index"

  index: ->
    timerView = new Pomodoro.Views.Timer()

    new Pomodoro.Views.Activities(
      collection: @activities
      spentTimes: @spentTimes
      timerView: timerView
    ).render()

    new Pomodoro.Views.Form
      collection: @activities

    new Pomodoro.Views.TotalSpentTime(
      collection: @spentTimes
    ).render()

    new Pomodoro.Views.TimerCommands
      timerView: timerView
