Pomodoro.Collections.Mixins.Filterable =
  filtered: (criteriaFunction)->
    new @constructor(@select(criteriaFunction))

class Pomodoro.Collections.TotalSpentTimes extends Backbone.Collection
  url: '/spent_times'

  findByActivity: (activity)->
    @filtered (spentTime)->
      spentTime.get('activity_id') == activity.get('id')

_.extend(Pomodoro.Collections.TotalSpentTimes.prototype, Pomodoro.Collections.Mixins.Filterable)
