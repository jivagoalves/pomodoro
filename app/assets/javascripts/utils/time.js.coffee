class Pomodoro.Utils.Time
  constructor: (@time)->

  toHHMMSS: ->
    t = parseInt(@time)
    hours   = Math.floor(t / 3600)
    minutes = Math.floor((t - (hours * 3600)) / 60)
    seconds = t - (hours * 3600) - (minutes * 60)
    hours = '0' + hours if (hours < 10)
    minutes = '0' + minutes if (minutes < 10)
    seconds = '0' + seconds if (seconds < 10)
    "#{hours}h #{minutes}m #{seconds}s"
