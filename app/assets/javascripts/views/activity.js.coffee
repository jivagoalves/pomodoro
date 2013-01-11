class Pomodoro.Views.Activity extends Backbone.View
  template: JST['activity']

  events:
    'click .destroy'          : 'destroy'
    'click .spent-time-today' : 'toggleSpentTimeList'

  tagName: 'li'

  className: 'activity clearfix'

  initialize: ->
    @setProperties()

  setProperties: ->
    @timerView = @options.timerView
    @spentTimesCollection = @options.spentTimes

  destroy: ->
    if confirm('Are you sure?')
      @model.destroy
        success: (model, response)=>
          @spentTimesCollection.removeByActivity(model)
          # FIXME Check if the timer is running for this
          # activity before doing this.
          @timerView.resetTimer()
          this.$el.fadeOut =>
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
    this.$el.hide().fadeIn(1000)
    this

  setHtml: (options = {})->
    this.$el.html @template(
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
