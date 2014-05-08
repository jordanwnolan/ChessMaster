require 'all_pieces'
class Piece
include ActiveModel::Serialization
  DIAGONAL   = [[1,1],[-1,1],[-1,-1],[1,-1]]
  ORTHOGONAL = [[1,0],[0,1],[-1,0],[0,-1]]

  attr_accessor :board, :position, :color

  def initialize(board, color, position)
    @color, @position = color.to_sym, position
  end

  def moves(board)
    raise NotImplementedError
  end

  def on_board?(pos)
    pos.map{|i| i.between?(0, Board::DIMENSION - 1)}.all?
  end

  def dup(duped_board)
    duped_position = self.position.dup
    self.class.new(duped_board, @color, duped_position)
  end

  def move_into_check?(pos, board)
    duped_board = board.dup
    duped_self = self.dup(duped_board)
    duped_board.move!(duped_self.position, pos)

    duped_board.in_check?(@color)
  end

  def valid_moves
    # only see if remaining moves for a piece results in a check
    self.moves.reject do |move|
      move_into_check?(move)
    end
  end

  def inspect
    p self.class
  end
end






