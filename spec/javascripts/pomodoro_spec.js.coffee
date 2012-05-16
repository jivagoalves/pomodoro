describe 'App.init()', ->

  it 'should create the timer after loading the page', ->
    @stub $.fn, 'createTimer'
    App.init()
    expect($.fn.createTimer).toHaveBeenCalled()

  it 'should create an instance of a buzz.sound', ->
    @stub buzz, 'sound'
    App.init()
    expect(buzz.sound).toHaveBeenCalledWith('/alarm.wav')

  describe 'timer', ->
    beforeEach ->
      setFixtures(sandbox({id: 'timer'}))
      @stub $.fn, 'startTimer'
      App.init()

    it 'should be initialized with 25:00', ->
      expect($('#timer').text()).toBe('25:00')

    it 'should not be started', ->
      expect($.fn.startTimer).not.toHaveBeenCalled()

  describe 'when clicking on start button', ->
    beforeEach ->
      setFixtures(sandbox({id: 'start_timer'}))
      @stub $.fn, 'startTimer'
      App.init()

    it 'should start the timer', ->
      $('#start_timer').trigger('click')
      expect($.fn.startTimer).toHaveBeenCalled()

  describe 'when the timer stops', ->
    beforeEach ->
      setFixtures(sandbox({id: 'timer'}))
      setFixtures(sandbox({id: 'start_timer'}))
      @snd = {}
      @stub(@snd, 'play').andCallFake(->)
      @stub(buzz, 'sound').andReturn(@snd)
      @stub($.fn, 'startTimer').andCallThrough()
    it 'should play the sound', ->
      App.init()
      $('#start_timer').trigger 'click'
      $.fn.startTimer.mostRecentCall.args[0].buzzer()
      expect(@snd.play).toHaveBeenCalled()
