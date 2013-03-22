class Pomodoro.Views.Activity extends Backbone.View
  template: JST['activity']

  events:
    'click .destroy'          : 'destroy'
    'click .spent-time-today' : 'toggleSpentTimeList'

  tagName: 'li'

  className: 'activity clearfix'

  initialize: ->
    @setProperties()
    @bindEventsOnTimeSpentOnActivity()

  setProperties: ->
    @timerView = @options.timerView
    @spentTimesCollection = @options.spentTimes

  bindEventsOnTimeSpentOnActivity: ->
    moveActivityToTop = =>
      @$el.prependTo(@$el.parent())
    @timesSpentOnActivity().on("add", moveActivityToTop)

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

  toggleSpentTimeList: ->
    @spentTimeListView.toggle()
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
    ).render()

  appendSpentTimeList: ->
    @spentTimeListView = new Pomodoro.Views.SpentTimeList(
      collection: @timesSpentOnActivity()
    )
    @$('.info').append @spentTimeListView.
      render().
      hide().
      el

  appendNotification: ->
    view = new Pomodoro.Views.Notification
      collection: @timesSpentOnActivity()
    @$('.info').append(view.render().el)
