class Knight < SteppingPiece
  def to_s
    @color == :white ? "\u2658" : "\u265E"
  end

  private

  def move_dirs
    [[2,1],[-2,1],[-2,-1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
  end
end