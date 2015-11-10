try
  window.pp = _.bind(window.console.log, console)
catch ex
  window.pp = ->
