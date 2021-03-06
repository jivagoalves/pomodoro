class Pomodoro.Views.Activity extends Backbone.View
  template: JST['activity']

  events:
    'click .destroy'          : 'destroy'
    'click .spent-time-today' : 'toggleSpentTimeArea'

  tagName: 'li'

  className: 'activity clearfix'

  initialize: ->
    @setProperties()

  setProperties: ->
    @timerView = @options.timerView
    @spentTimesCollection = @options.spentTimes

  moveActivityToTop: ->
    @$el.
      hide().
      prependTo(@$el.parent()).
      fadeIn(1000)

  timesSpentOnActivity: ->
    @spentTimesCollection.findByActivity(@model)

  destroy: ->
    if confirm('Are you sure?')
      @model.destroy
        success: (model, response)=>
          @spentTimesCollection.removeByActivity(model)
          # FIXME Check if the timer is running for this
          # activity before doing this.
          @timerView.resetTimer()
          @$el.fadeOut =>
            @remove()
        error: =>
          alert('Something went wrong!')
    false

  toggleSpentTimeArea: ->
    @spentTimeListView.toggle()
    @spentTimeFormView.toggle()
    false

  updateControl: ->
    if @timerView.isReady()
      @timerView.off('ready paused', @updateControl, @)
      @timerView.off('reset', @saveSpentTime, @)
    else
      @render()

  render: (options = {})->
    @setHtml(options)
    @renderDescription()
    @renderTotalTime()
    @appendNotification()
    @renderActions()
    @appendSpentTimeList()
    @appendSpentTimeForm()
    @$el.hide().fadeIn(1000)
    @

  setHtml: (options = {})->
    @$el.html @template(
      _.extend {
        model: @model.toJSON()
      }, options
    )

  renderDescription: ->
    new Pomodoro.Views.ActivityDescription(
      el: @$el
      model: @model
    ).render()

  renderTotalTime: ->
    new Pomodoro.Views.TotalSpentTime(
      el: @$('.spent-time-today')
      collection: @timesSpentOnActivity()
    ).render()

  renderActions: ->
    new Pomodoro.Views.ActivityActions(
      el: @$('.actions')
      model: @model
      timerView: @timerView
      spentTimesCollection: @spentTimesCollection
    ).render().on("start stop", => @moveActivityToTop())

  appendSpentTimeList: ->
    @spentTimeListView = new Pomodoro.Views.SpentTimeList(collection: @timesSpentOnActivity())
    @$('.info').append(@spentTimeListView.render().hide().el)

  appendSpentTimeForm: ->
    @spentTimeFormView = new Pomodoro.Views.SpentTimeForm {
      model: @model
      collection: @spentTimesCollection
    }
    @$('.info').append(@spentTimeFormView.render().hide().el)

  appendNotification: ->
    view = new Pomodoro.Views.Notification
      collection: @timesSpentOnActivity()
    @$('.info').append(view.render().el)
