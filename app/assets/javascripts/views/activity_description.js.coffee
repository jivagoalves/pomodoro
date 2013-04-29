class Pomodoro.Views.ActivityDescription extends Backbone.View
  enterKeyCode: 13

  events:
    'dblclick .description'       : 'showInput'
    'blur input.for-description'  : 'hideInput'
    'keyup input.for-description' : 'saveOnEnter'

  initialize: ->
    @model.on('change:description', @render, @)

  inputEl: ->
    @$('input.for-description')

  descriptionEl: ->
    @$('.description')

  showInput: ->
    @descriptionEl().hide()
    @inputEl().show().focus()
    false

  hideInput: ->
    @inputEl().hide()
    @descriptionEl().show()

  saveOnEnter: (e)->
    if e.keyCode == @enterKeyCode
      @model.save {
        description: @inputEl().val()
      }, {
        error: (model, response) =>
          alert('Please try again')
      }

  render: ->
    @descriptionEl().text(@model.get('description'))
    @hideInput()
    @inputEl().val(@model.get('description'))
    @descriptionEl().hide().fadeIn(1000)
    @
