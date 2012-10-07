class Pomodoro.Views.Form extends Backbone.View
  el: '#new-activity'

  defaultInputText: 'Create your awesome activity here...'

  events:
    'focus input[type=text]'    : 'updateFocusDescription'
    'focusout input[type=text]' : 'updateUnfocusDescription'
    'submit'                    : 'saveActivity'

  initialize: ->
    this.$input = this.$('input[type=text]')
    @setDefaultText()

  getDescription: ->
    this.$input.val()

  setDescription: (desc) ->
    this.$input.val(desc)

  clearDescription: ->
    @setDescription('')

  setDefaultText: ->
    @setDescription(@defaultInputText)

  descriptionPresent: ->
    !@hasDefaultInputText() && !@isBlank()

  destroyFieldError: ->
    @fieldErrorView.destroy() if @fieldErrorView

  renderFieldError: (error)->
    @destroyFieldError()
    @fieldErrorView = new Pomodoro.Views.FieldError(
      field: this.$('#activity-description')
      error: error
    ).render()

  saveActivity: ->
    unless @descriptionPresent()
      @renderFieldError("Can't be blank")
      return false
    new Pomodoro.Models.Activity().save {
      description: @getDescription()
    },{
      success: (model, response) =>
        @collection.add(model)
        @clearDescription()
        @setDefaultText() unless @descriptionHasFocus()
        @destroyFieldError()
      error: (model, response) =>
        @renderFieldError('Sorry, something went wrong.')
    }
    false

  hasDefaultInputText: ->
    @getDescription() == @defaultInputText

  isBlank: ->
    @getDescription() == ''

  updateFocusDescription: ->
    @clearDescription() if @hasDefaultInputText()

  updateUnfocusDescription: ->
    @setDefaultText() if @isBlank()

  descriptionHasFocus: ->
    this.$('input[type=text]').is(':focus')
