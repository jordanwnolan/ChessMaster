class Game < ActiveRecord::Base
  require 'all_pieces'

  serialize :board
  attr_accessor :game_board
end
