class GamesController < ApplicationController
  before_action :authenticate_player!

  def index
    @games = current_player.current_games
  end

  def new
    @game = Game.new
    @players = Player.all.where("id != ?", current_player.id)
  end

  def create
    # fail
    @player1 = current_player
    @player2 = Player.find(game_params[:player_2_id])
    @game = Game.new({player_1_id: @player1.id, 
      player_2_id: @player2.id,
      board: Board.new,
      player_turn: 1,
      game_name: game_params[:game_name] })
    # fail
    @turn = "white"
    @game.save
    render :show
  end

  def show

    @game = Game.find(params[:id])
    @turn = @game.player_turn == 1 ? 'white' : 'black'
    # render partial: 'games/board', locals: { game: @game }
    render :show
  end

  def update
    @game = Game.find(params[:id])

    color = params[:color] == 'white' ? :white : :black
    from_pos = params[:from].map(&:to_i)
    to_pos = params[:to].map(&:to_i);
    begin
      @game.board.move(from_pos, to_pos, color)
      @turn = params[:turn] == 'white' ? 'black' : 'white'
      @game.player_turn = @turn == 'white' ? 1 : 2
      @game.save
      
    rescue Exception => e
      @errors = [e.message]
      @game = Game.find(params[:game])
      @turn = params[:turn]
    end

    render partial: 'games/board', locals: { game: @game }
  end

  def game_params
    params.require(:game).permit(:player_2_id, :game_name)
  end
end
