class Pomodoro.Models.SpentTimes extends Backbone.Model
  urlRoot: ->
    "/activities/#{@get('activity_id')}/spent_times"

class Pomodoro.Collections.SpentTimesCollection extends Backbone.Collection
  model: Pomodoro.Models.SpentTimes
  url: ->
    "/activities/#{@options.activity_id}/spent_times"
