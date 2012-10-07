class Pomodoro.Views.TotalSpentTimeView extends Backbone.View
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
        @sumSpentTime()
        @render()

  formatTime: (time)->
    t = parseInt(time)
    hours   = Math.floor(t / 3600)
    minutes = Math.floor((t - (hours * 3600)) / 60)
    seconds = t - (hours * 3600) - (minutes * 60)
    hours = '0' + hours if (hours < 10)
    minutes = '0' + minutes if (minutes < 10)
    seconds = '0' + seconds if (seconds < 10)
    "#{hours}h #{minutes}m #{seconds}s"

  render: ->
    this.$el.html(@formatTime(@totalSpentTime))
    this.$el.hide().fadeIn(1000)
