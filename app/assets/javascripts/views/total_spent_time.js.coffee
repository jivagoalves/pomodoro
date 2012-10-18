class Pomodoro.Views.TotalSpentTime extends Backbone.View
  el: '#total-spent-time'

  initialize: ->
    @collection.on 'all', =>
      @render()

  getCollectionSpentTime: ->
    @collection.getTotalTime()

  formatTime: (time)->
    new Pomodoro.Utils.Time(time).toHMS()

  render: ->
    return if @totalSpentTime == @getCollectionSpentTime()
    @totalSpentTime = @getCollectionSpentTime()
    this.$el.html(@formatTime(@totalSpentTime))
    this.$el.hide().fadeIn(1000)
