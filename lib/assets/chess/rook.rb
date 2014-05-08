require_relative 'all_pieces'

class Rook < SlidingPiece

  def to_s
    @color == :white ? "\u2656" : "\u265C"
  end

  private

  def move_dirs
    ORTHOGONAL
  end
end
