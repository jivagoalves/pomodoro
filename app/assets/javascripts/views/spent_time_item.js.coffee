class Pomodoro.Views.SpentTimeItem extends Backbone.View
  tagName: 'li'

  className: 'spent-time-item'

  template: JST['spent_time_item']

  render: ->
    this.$el.html @template(
      model: @model,
      time: new Pomodoro.Utils.Time(@model.get('time'))
      updatedAt: new Date(@model.get('updated_at'))
    )
    this
