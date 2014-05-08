class SteppingPiece < Piece

  def moves(board)
    possible_moves = []
    move_dirs.each do |delta|
      last_position = @position.dup
      last_position[0] += delta[0]
      last_position[1] += delta[1]

      possible_moves << last_position.dup if on_board?(last_position)
    end

    possible_moves.reject do |pos|
      (board[pos].color == @color unless board[pos].nil?)
    end
  end

  private

  def move_dirs
    raise NotImplementedError
  end

end