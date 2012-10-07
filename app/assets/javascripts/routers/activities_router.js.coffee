class Pomodoro.Routers.ActivitiesRouter extends Backbone.Router
  initialize: (options) ->
    @activities = new Pomodoro.Collections.ActivitiesCollection()
    @activities.reset options.activities
    @spentTimes = new Pomodoro.Collections.TotalSpentTimes()
    @spentTimes.reset options.spentTimes

  routes:
    ".*" : "index"

  index: ->
    timerView = new Pomodoro.Views.TimerView()
    timerNotificationView = new Pomodoro.Views.TimerNotificationView()

    new Pomodoro.Views.ActivitiesView(
      collection: @activities
      spentTimes: @spentTimes
      timerView: timerView
      timerNotificationView: timerNotificationView
    ).render()

    new Pomodoro.Views.FormView
      collection: @activities

    new Pomodoro.Views.TotalSpentTimeView(
      collection: @spentTimes
      activities: @activities
    ).render()

    new Pomodoro.Views.TimerCommands
      timerView: timerView
