Pomodoro.Collections.Mixins ||= {}

Pomodoro.Collections.Mixins.Filterable =
  filtered: (criteriaFunction, options = {})->
    filteredCollection = new @constructor(options)

    applyFilter = =>
      filteredCollection.reset(
        @select(criteriaFunction)
      )

    @on 'change', applyFilter
    @on 'add', applyFilter
    @on 'remove', applyFilter
    applyFilter()

    filteredCollection
