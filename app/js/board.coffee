class window.BoardView extends Backbone.View
  el: '.board'

  events:
    'click .cell': 'play'

  initialize: (@board)->
    pp 'initialize', @board
    @draw()

  play: (ev)->
    ev.preventDefault()
    return unless @can_play

    el = $(ev.currentTarget)
    r = el.data('row')
    c = el.data('column')

    unless @cell(r, c)
      @can_play = false

      $.ajax
        type: 'POST'
        url: '/play'
        dataType: 'json'
        data:
          board: @board
          move:
            row: r
            column: c
        success: (res)=>
          pp 'success', res
          @board = res
          @draw()
        error: (res)=>
          pp 'error', res

  draw: ->
    for r in [0..2]
      for c in [0..2]
        cell = @cell(r, c)
        if cell
          @$(".cell-#{r}-#{c}").text cell

    $('.message').text(@board.message)
    @can_play = !@board.is_finished

  cell: (r, c)->
    @board.cells[r][c]
