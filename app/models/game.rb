class Game < ActiveRecord::Base
  require 'all_pieces'
  # require 'yaml'

  serialize :board
  attr_accessor :game_board
end
