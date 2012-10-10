Pomodoro.Collections.Mixins ||= {}

Pomodoro.Collections.Mixins.Filterable =
  filtered: (criteriaFunction)->
    new @constructor(@select(criteriaFunction))
