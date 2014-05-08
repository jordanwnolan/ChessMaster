class King < SteppingPiece
  def to_s
    @color == :white ? "\u2654" : "\u265A"
  end

  private

  def move_dirs
    ORTHOGONAL + DIAGONAL
  end
end