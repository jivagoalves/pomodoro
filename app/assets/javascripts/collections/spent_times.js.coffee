class Pomodoro.Collections.SpentTimes extends Backbone.Collection
  url: ->
    @options ||= {}
    if id = @options.activityId || false
      return "/activities/#{id}/spent_times"
    '/spent_times'

  getTotalTime: ->
    iterator = (totalTime, spentTime) ->
      totalTime + spentTime.get('time')
    @reduce iterator, 0

  removeByActivity: (activity)->
    @findByActivity(activity).each (a) =>
      @remove(a)

  findByActivity: (activity)->
    criteriaFunction = (spentTime)->
      spentTime.get('activity_id') == activity.get('id')
    @filtered criteriaFunction, activityId: activity.get('id')

_.extend(
  Pomodoro.Collections.SpentTimes.prototype,
  Pomodoro.Collections.Mixins.Filterable
)
