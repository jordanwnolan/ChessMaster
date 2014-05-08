class Queen < SlidingPiece
  def to_s
    @color == :white ? "\u2655" : "\u265B"
  end

  private

  def move_dirs
    ORTHOGONAL + DIAGONAL
  end
end