class Pomodoro.Routers.ActivitiesRouter extends Backbone.Router
  initialize: (options) ->
    @activities = new Pomodoro.Collections.ActivitiesCollection()
    @activities.reset options.activities

  routes:
    ".*" : "index"

  index: ->
    new Pomodoro.Views.ActivitiesView(
      collection: @activities
    ).render()
    new Pomodoro.Views.FormView
      collection: @activities
