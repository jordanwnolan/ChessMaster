class Bishop < SlidingPiece
  def to_s
    @color == :white ? "\u2657" : "\u265D"
  end

  private

  def move_dirs
    DIAGONAL
  end
end