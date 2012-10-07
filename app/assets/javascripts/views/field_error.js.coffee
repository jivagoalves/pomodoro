class Pomodoro.Views.FieldError extends Backbone.View
  template: JST['field_error']

  initialize: ->
    @field = @options.field
    @error = @options.error || ''

  setError: (value)->
    @error = value
    this

  destroy: ->
    @field.
      closest('p').
      find('.error').
      remove()
    this.remove()

  render: ->
    @field.
      closest('p').
      find('.error').
      remove()
    @field.
      closest('p').
      append(@template(error: @error)).
      hide().
      fadeIn(1000)
    this
