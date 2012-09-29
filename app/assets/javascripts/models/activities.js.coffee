class Pomodoro.Models.Activity extends Backbone.Model
  urlRoot: '/activities'

class Pomodoro.Collections.ActivitiesCollection extends Backbone.Collection
  model: Pomodoro.Models.Activity
  url: '/activities'
