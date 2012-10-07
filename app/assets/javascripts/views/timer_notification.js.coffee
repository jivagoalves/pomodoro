class Pomodoro.Views.TimerNotification extends Backbone.View
  el: '#notification'

  template: JST['notification']

  initialize: ->
    @msg = @options.msg

  setMessage: (msg) ->
    @msg = (msg)

  hideLaterOn: ->
    hideLaterOn = =>
      this.$el.fadeOut 1000
    setTimeout hideLaterOn, 2500

  renderMessage: (msg) ->
    @setMessage(msg)
    @render()

  render: ->
    this.$el.html(@template(msg: "(#{@msg})")).
      hide().
      fadeIn 1000, =>
        @hideLaterOn()
    this
