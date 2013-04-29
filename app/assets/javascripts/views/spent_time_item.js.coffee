class Pomodoro.Views.SpentTimeItem extends Backbone.View
  template: JST['spent_time_item']

  tagName: 'li'

  className: 'spent-time-item'

  events:
    'click .spent-time-delete' : 'destroySpentTime'

  destroySpentTime: ->
    if confirm("Are you sure?")
      @model.destroy
        error: ->
          alert('Something went wrong!')

  render: ->
    this.$el.html @template(
      model: @model,
      time: new Pomodoro.Utils.Time(@model.get('time'))
      updatedAt: new Date(@model.get('updated_at'))
    )
    this
