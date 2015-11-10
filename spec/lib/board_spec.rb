require 'spec_helper'
require 'board.rb'

describe Board do
  subject do
    Board.new
  end

  it 'subject' do
    expect(subject).to be_a described_class
    ap subject
  end
end
