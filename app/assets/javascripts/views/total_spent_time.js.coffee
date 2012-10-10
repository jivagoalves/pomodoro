class Pomodoro.Views.TotalSpentTime extends Backbone.View
  el: '#total-spent-time'

  initialize: ->
    @collection.on 'add', @addSpentTime, @
    @options.activities.on 'remove', @fetchTotalSpentTime, @
    @sumSpentTime()

  addSpentTime: (spentTime) ->
    @totalSpentTime += spentTime.get('time')
    @render()

  sumSpentTime: ->
    @totalSpentTime = 0
    @collection.each (spentTime) =>
      @totalSpentTime += spentTime.get('time')

  fetchTotalSpentTime: ->
    @collection.fetch
      success: =>
        oldTotalSpentTime = @totalSpentTime
        @sumSpentTime()
        @render() if oldTotalSpentTime != @totalSpentTime

  formatTime: (time)->
    new Pomodoro.Utils.Time(time).toHHMMSS()

  render: ->
    this.$el.html(@formatTime(@totalSpentTime))
    this.$el.hide().fadeIn(1000)
