class Pomodoro.Models.SpentTime extends Backbone.Model
  urlRoot: ->
    "/activities/#{@get('activity_id')}/spent_times"
