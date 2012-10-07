class Pomodoro.Routers.Activities extends Backbone.Router
  initialize: (options) ->
    @activities = new Pomodoro.Collections.ActivitiesCollection()
    @activities.reset options.activities
    @spentTimes = new Pomodoro.Collections.TotalSpentTimes()
    @spentTimes.reset options.spentTimes

  routes:
    ".*" : "index"

  index: ->
    timerView = new Pomodoro.Views.Timer()
    timerNotificationView = new Pomodoro.Views.TimerNotification()

    new Pomodoro.Views.Activities(
      collection: @activities
      spentTimes: @spentTimes
      timerView: timerView
      timerNotificationView: timerNotificationView
    ).render()

    new Pomodoro.Views.Form
      collection: @activities

    new Pomodoro.Views.TotalSpentTime(
      collection: @spentTimes
      activities: @activities
    ).render()

    new Pomodoro.Views.TimerCommands
      timerView: timerView
