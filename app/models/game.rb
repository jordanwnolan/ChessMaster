class Game < ActiveRecord::Base
  require 'all_pieces'

  serialize :board, Board
  attr_accessor :game_board
end
