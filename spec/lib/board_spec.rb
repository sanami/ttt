require 'spec_helper'
require 'board.rb'

describe Board do
  X = Board::PLAYER1
  O = Board::PLAYER2

  subject do
    Board.new
  end

  it 'subject' do
    expect(subject).to be_a described_class
  end

  it '#as_json' do
    expect(subject.as_json).to eq({ :players => ['Player 1', 'Player 2'],
                                    :cells => [[nil, nil, nil],
                                               [nil, nil, nil],
                                               [nil, nil, nil]],
                                    :message => 'Player 1 move',
                                    :board_status => :playing,
                                    :current_player => 0 })
  end

  it '#name' do
    expect(subject.name(0)).to eq 'Player 1'
  end

  it '#play' do
    subject.play(row: 0, column: 0)
    expect(subject.cells[0][0]).to eq X

    subject.play(row: 1, column: 1)
    expect(subject.cells[1][1]).to eq O

    subject.play(row: 2, column: 2)
    expect(subject.cells[2][2]).to eq X
  end

  describe '#update_board_status' do
    it 'playing' do
      expect(subject.board_status).to eq :playing
    end

    it 'player1_win' do
      b1 = Board.new 'cells' => [[X, X, X],
                                 [O, nil, nil],
                                 [nil, O, nil]]

      expect(b1.board_status).to eq :player1_win

      b1 = Board.new 'cells' => [[X, O, X],
                                 [nil, X, nil],
                                 [O, O, X]]

      expect(b1.board_status).to eq :player1_win
    end

    it 'player2_win' do
      b1 = Board.new 'cells' => [[X, O, X],
                                 [nil, O, nil],
                                 [nil, O, nil]]

      expect(b1.board_status).to eq :player2_win

      b1 = Board.new 'cells' => [[X, O, O],
                                 [nil, O, nil],
                                 [O, X, nil]]

      expect(b1.board_status).to eq :player2_win
    end

    it 'draw' do
      b1 = Board.new 'cells' => [[X, O, X],
                                 [O, X, O],
                                 [O, X, O]]

      expect(b1.board_status).to eq :draw
    end
  end
end
