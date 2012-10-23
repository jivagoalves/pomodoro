Pomodoro.Collections.Mixins ||= {}

Pomodoro.Collections.Mixins.Filterable =
  filtered: (criteriaFunction, options = {})->
    filteredCollection = new @constructor(options)

    applyFilter = =>
      filteredCollection.reset(
        @select(criteriaFunction)
      )

    addModel = (model)->
      if criteriaFunction(model)
        filteredCollection.add(model)

    @on 'change', applyFilter
    @on 'add', addModel
    @on 'remove', applyFilter
    applyFilter()

    filteredCollection
