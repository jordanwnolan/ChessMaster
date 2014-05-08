class Pawn < Piece

  def moves(board)
    possible_moves = []
    x,y = @position.dup
    @m = (@color == :white ? 1 : -1)

    possible_moves << [x + 1*@m,y] if can_move_forward?(x + 1*@m, y, board)
    possible_moves << [x + 2*@m,y] if first_move?(x, y, board)
    possible_moves << [x + 1*@m, y - 1] if can_capture?(x + 1*@m, y - 1, board)
    possible_moves << [x + 1*@m, y + 1] if can_capture?(x + 1*@m, y + 1, board)

    possible_moves
  end

  def to_s
    @color == :white ? "\u2659" : "\u265F"
  end

  private

  def can_capture?(x, y, board)
    unless board[[x,y]].nil?
      board[[x,y]].color != @color unless can_move_forward?(x, y, board)
    end
    # on_board?([x,y]) && @board[[x,y]] && @board[[x,y]].color != @color
  end

  def can_move_forward?(x, y, board)
    board[[x,y]].nil? && on_board?([x, y])
  end

  def first_move?(x,y, board)
    pawn_row = (@color == :white ? 1 : 6)

    can_move_forward?(x + 2*@m,y, board) &&
    can_move_forward?(x + 1*@m, y, board) &&
    @position[0] == pawn_row
  end

end