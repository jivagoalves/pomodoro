class Pomodoro.Views.Form extends Backbone.View
  el: '#activity-area form'

  defaultInputText: 'Create your awesome activity here...'

  events:
    'focus input[type=text]'    : 'updateFocusDescription'
    'focusout input[type=text]' : 'updateUnfocusDescription'
    'submit'                    : 'submit'

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

  saveActivity: ->
    self = this
    new Pomodoro.Models.Activity().save {
      description: @getDescription()
    },{
      success: (model, response) ->
        self.collection.add(model)
        self.clearDescription()
      error: (model, response) ->
        alert('Sorry, something went wrong.')
    }

  submit: ->
    @saveActivity()
    false

  hasDefaultInputText: ->
    @getDescription() == @defaultInputText

  isBlank: ->
    @getDescription() == ''

  updateFocusDescription: ->
    @clearDescription() if @hasDefaultInputText()

  updateUnfocusDescription: ->
    @setDefaultText() if @isBlank()
