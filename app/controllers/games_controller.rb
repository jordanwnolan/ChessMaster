class GamesController < ApplicationController

  def index
    @game = Game.new({player_1_id: Player.create({username: 'player1'}).id, 
      player_2_id: Player.create({username: 'player2'}).id,
      board: Board.new})
    # fail
    @turn = "white"
    @game.save
  end

  def make_move
    @game = Game.find(params[:game])

    color = params[:color] == 'white' ? :white : :black
    from_pos = params[:from].map(&:to_i)
    to_pos = params[:to].map(&:to_i);
    begin
      @game.board.move(from_pos, to_pos, color)
      @game.save
      @turn = params[:turn] == 'white' ? 'black' : 'white'
    rescue Exception => e
      @errors = [e.message]
      @game = Game.find(params[:game])
      @turn = params[:turn]
    end

    render partial: 'games/board', locals: { game: @game }
  end
end
