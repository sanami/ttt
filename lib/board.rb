class Board
  PLAYER1 = 'X'.freeze
  PLAYER2 = 'O'.freeze

  attr_reader :players, :cells, :current_player, :message, :board_status

  def initialize(params = {})
    @players = []
    if params['players']
        @players[0] = params['players'][0].strip.empty? ? 'Player 1' : params['players'][0]
        @players[1] = params['players'][1].strip.empty? ? 'Player 2' : params['players'][1]
    end

    @cells = params['cells'] || Array.new(3) { Array.new(3) }
    @current_player = params['current_player'].to_i || 0

    update_board_status
  end

  # Data for js
  def as_json
    {
      players: players,
      cells: cells,
      message: message,
      board_status: board_status,
      current_player: current_player
    }
  end

  # Player name
  def name(player)
    players[player]
  end

  # Make current player move
  def play(move)
    r = move[:row].to_i
    c = move[:column].to_i

    if r < 0 || r > 2 || c < 0 || c > 2 || cells[r][c]
      raise "Bad move: #{move}"
    end

    if current_player == 0
      cells[r][c] = PLAYER1
    else
      cells[r][c] = PLAYER2
    end
    @current_player = 1 - current_player

    update_board_status
  end

  # Check cells
  def update_board_status
    draw = true
    winner = nil

    3.times do |i|
      # Rows/Columns
      if cells[i][0] && cells[i][0] == cells[i][1] && cells[i][1] == cells[i][2]
        winner = cells[i][0]
        break
      elsif cells[0][i] && cells[0][i] == cells[1][i] && cells[1][i] == cells[2][i]
        winner = cells[0][i]
        break
      end

      # All cells filled
      if draw
        3.times do |j|
          unless cells[i][j]
            draw = false
            break
          end
        end
      end
    end

    # Diagonal
    unless winner
      if (cells[0][0] == cells[1][1] && cells[1][1] == cells[2][2]) ||
        (cells[0][2] == cells[1][1] && cells[1][1] == cells[2][0])
        winner = cells[1][1]
      end
    end

    # Status
    @board_status = if winner == PLAYER1
                      :player1_win
                    elsif winner == PLAYER2
                      :player2_win
                    elsif draw
                      :draw
                    else
                      :playing
                    end

    # Message for status
    case @board_status
      when :player1_win
        @message = "#{name(0)} win"
      when :player2_win
        @message = "#{name(1)} win"
      when :draw
        @message = 'Draw'
      else
        @message = "#{name(current_player)} move"
    end
  end
end
