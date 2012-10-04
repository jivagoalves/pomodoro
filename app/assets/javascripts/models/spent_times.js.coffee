class Pomodoro.Models.SpentTime extends Backbone.Model
  urlRoot: ->
    "/activities/#{@get('activity_id')}/spent_times"

class Pomodoro.Collections.SpentTimesCollection extends Backbone.Collection
  model: Pomodoro.Models.SpentTime
  url: ->
    "/activities/#{@options.activity_id}/spent_times"
