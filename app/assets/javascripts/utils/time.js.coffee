class Pomodoro.Utils.Time
  constructor: (@time)->

  toHMS: ->
    time = parseInt(@time)
    hours   = Math.floor(time / 3600)
    minutes = Math.floor((time - (hours * 3600)) / 60)
    seconds = time - (hours * 3600) - (minutes * 60)
    to_return = []
    to_return.push("#{hours}h") if hours > 0
    to_return.push("#{minutes}m") if minutes > 0
    to_return.push("#{seconds}s") if seconds > 0
    return '0s' if to_return.length == 0
    to_return.join(' ')
