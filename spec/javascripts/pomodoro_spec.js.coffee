describe 'activities', ->

  it 'should create the timer after loading the page', ->
    @stub $.fn, 'createTimer'
    App.init()
    expect($.fn.createTimer).toHaveBeenCalled()

  describe 'timer', ->
    beforeEach ->
      setFixtures(sandbox({id: 'timer'}))
      @stub $.fn, 'startTimer'
      App.init()

    it 'should initialize the timer with 25:00', ->
      expect($('#timer').text()).toBe('25:00')

    it 'should not start the timer', ->
      expect($.fn.startTimer).not.toHaveBeenCalled()

  describe 'when clicking on start button', ->
    beforeEach ->
      setFixtures(sandbox({id: 'start_timer'}))
      @stub $.fn, 'startTimer'
      App.init()

    it 'should start the timer', ->
      $('#start_timer').trigger('click')
      expect($.fn.startTimer).toHaveBeenCalled()
