class GamesController < ApplicationController

  def index
    @game = Game.new({player_1_id: Player.create({username: 'player1'}).id, 
      player_2_id: Player.create({username: 'player2'}).id,
      board: Board.new})
    # fail
    @game.save
  end

  def make_move
    @game = Game.find(params[:game])
    # debugger
    # fail
    color = params[:color] == 'white' ? :white : :black
    from_pos = params[:from].map(&:to_i)
    to_pos = params[:to].map(&:to_i);

    @game.board.move(from_pos, to_pos, color)
    @game.save
    render partial: 'games/board', locals: { game: @game }
  end
end
