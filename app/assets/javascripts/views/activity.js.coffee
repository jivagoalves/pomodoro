class Pomodoro.Views.Activity extends Backbone.View
  enterKeyCode: 13

  template: JST['activity']

  events:
    'click .destroy'          : 'destroy'
    'click .spent-time-today' : 'toggleSpentTimeList'
    'dblclick .description'   : 'showInput'
    'blur input'              : 'hideInput'
    'keyup input'             : 'saveOnEnter'

  tagName: 'li'

  className: 'activity clearfix'

  initialize: ->
    @setProperties()

  setProperties: ->
    @timerView = @options.timerView
    @spentTimesCollection = @options.spentTimes

  inputEl: ->
    @$('input')

  descriptionEl: ->
    @$('.description')

  destroy: ->
    if confirm('Are you sure?')
      @model.destroy
        success: (model, response)=>
          @spentTimesCollection.removeByActivity(model)
          @timerView.resetTimer()
          this.$el.fadeOut =>
            @remove()
        error: =>
          alert('Something went wrong!')
    false

  toggleSpentTimeList: ->
    @spentTimeListView.toggle()
    false

  showInput: ->
    @inputEl().toggleClass('hidden').focus()
    @descriptionEl().toggleClass('hidden')
    false

  hideInput: ->
    @inputEl().toggleClass('hidden')
    @descriptionEl().toggleClass('hidden')

  saveOnEnter: (e)->
    if e.keyCode == @enterKeyCode
      @model.save {
        description: @inputEl().val()
      }, {
        success: (model, response) =>
          @render model: model.toJSON()
        error: (model, response) =>
          alert('Please try again')
      }

  updateControl: ->
    if @timerView.isReady()
      @timerView.off('ready paused', @updateControl, @)
      @timerView.off('reset', @saveSpentTime, @)
    else
      @render()

  render: (options = {})->
    @setHtml(options)
    @renderTotalTime()
    @appendNotification()
    @renderActions()
    @appendSpentTimeList()
    this.$el.hide().fadeIn(1000)
    this

  setHtml: (options = {})->
    this.$el.html @template(
      _.extend {
        model: @model.toJSON()
      }, options
    )

  renderTotalTime: ->
    new Pomodoro.Views.TotalSpentTime(
      el: this.$('.spent-time-today')
      collection: @spentTimesCollection.findByActivity(@model)
    ).render()

  renderActions: ->
    new Pomodoro.Views.ActivityActions(
      el: this.$('.actions')
      model: @model
      timerView: @timerView
      spentTimesCollection: @spentTimesCollection
    ).render()

  appendSpentTimeList: ->
    @spentTimeListView = new Pomodoro.Views.SpentTimeList(
      collection: @spentTimesCollection.findByActivity(@model)
    )
    this.$('.info').append @spentTimeListView.
      render().
      hide().
      el

  appendNotification: ->
    view = new Pomodoro.Views.Notification
      collection: @spentTimesCollection.findByActivity(@model)
    this.$('.info').append(view.render().el)
