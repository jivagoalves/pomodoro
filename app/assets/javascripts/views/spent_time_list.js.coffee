class Pomodoro.Views.SpentTimeList extends Backbone.View
  tagName: 'ul'

  className: 'spent-time-list'

  initialize: ->
    @bindEvents()

  bindEvents: ->
    @collection.on 'all', =>
      @render()

  removeAll: ->
    # TODO Call remove for each view
    # instantiated in appendOne
    this.$el.html('')

  appendOne: (spentTime)=>
    view = new Pomodoro.Views.SpentTimeItem(model: spentTime)
    this.$el.append(view.render().el)

  addAll: ->
    @collection.each(@appendOne)

  render: ->
    @removeAll()
    @addAll()
    this

  toggle: ->
    this.$el.fadeToggle(400)
    this

  hide: ->
    this.$el.hide()
    this
