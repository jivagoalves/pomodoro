class Pomodoro.Views.SpentTimeForm extends Backbone.View
  template: JST['spent_time_form']

  className: 'spent-time-form'

  events:
    'submit form' : 'saveSpentTime'

  spentTimeValue: ->
    @$("input[type=text]").val() * 60

  saveSpentTime: ->
    new Pomodoro.Models.SpentTime().save {
      activity_id: @model.id
      time: @spentTimeValue()
    }, {
      success: (model, response) =>
        @collection.add(model)
      error: =>
        alert('Something went wrong!')
    }
    false

  hide: ->
    @$el.hide()
    @

  toggle: ->
    @$el.fadeToggle(400)
    @

  render: ->
    @$el.html(@template())
    @
