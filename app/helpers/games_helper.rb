module GamesHelper

  def render_board
    html = ''
    @game.game_board.grid.reverse.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        
        unless tile.nil?
          color = tile.color == :white ? 'white' : 'black'
          insert = "<div class='piece #{color}'>#{tile.to_s}</div>"
        else
          insert = ''
        end
        html << ""
      end
    end

    html
  end

end
