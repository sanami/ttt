class Board
  attr_reader :players, :cells, :current_player, :message

  def initialize(params = {})
    @players = params[:players] || ['Player 1', 'Player 2']
    @cells = params[:cells] || Array.new(3) { Array.new(3) }
    @current_player = params[:current_player].to_i || 0

    player_message
  end

  def as_json
    {
      players: players,
      cells: cells,
      message: message,
      is_finished: false,
      current_player: current_player
    }
  end

  def name(player)
    players[player]
  end

  def player_message
    @message = "#{name(current_player)} move"
  end

  def play(move)
    r = move[:row]
    c = move[:column]
    @current_player = 1 - current_player
    player_message
  end
end
