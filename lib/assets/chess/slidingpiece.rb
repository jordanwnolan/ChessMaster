class SlidingPiece < Piece

  def moves(board)
    possible_moves = []
    move_dirs.each do |delta|

     last_position = @position.dup

      loop do
        # new_pos = [last_position[0] + delta[0], last_position[1] + delta[1]]
        last_position[0] += delta[0]
               last_position[1] += delta[1]
       # last_position = [@position[0] + delta[0], @position[1] + delta[1]]
        break unless on_board?(last_position)
        break if own_piece?(last_position, board)  #don't add to poss moves
        if opp_piece?(last_position, board)
          possible_moves << last_position   # add to poss moves and stop moving
          break
        end
        possible_moves << last_position.dup #unless last_position == @position

      end
    end
    possible_moves
  end

  private

  def move_dirs
    raise NotImplementedError
  end

  # don't move on/past your own pieces
  def own_piece?(pos, board)
    board[pos].color == @color unless board[pos].nil?
  end

  def opp_piece?(pos, board)
    board[pos].color != @color unless board[pos].nil?
  end

end
