class GamesController < ApplicationController
  before_action :authenticate_player!

  def index
    @games = current_player.current_games
    @games_to_watch = Game.all.reject { |game| @games.include?(game) }
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

    @turn = "white"
    @game.save
    redirect_to @game
  end

  def show
    # fail

    @game = Game.find(params[:id])
    @turn = @game.player_turn == 1 ? 'white' : 'black'
    @player1 = Player.find(@game.player_1_id)
    @player2 = Player.find(@game.player_2_id)
    @observer = (current_player == @player1 || current_player == @player2) ? false : true
    # fail
    # render partial: 'games/board', locals: { game: @game }
    render :show
  end

  def update
    @game = Game.find(params[:id])

    color = params[:color] == 'white' ? :white : :black
    from_pos = params[:from].map(&:to_i)
    to_pos = params[:to].map(&:to_i);
    # fail
    begin
      @game.board.move(from_pos, to_pos, color)
      @turn = params[:turn] == 'white' ? 'black' : 'white'
      @game.player_turn = @turn == 'white' ? 1 : 2
      @game.save
      push_move(@game, @turn)
    rescue Exception => e
      # fail
      @errors = [e.message]
      @game = Game.find(params[:id])
      @turn = params[:turn]
    end

    # if request.xhr?
    #   head :created
    # else
      render partial: 'games/board', locals: { game: @game, turn: @turn, errors: @errors }
    # end
  end

  def game_params
    params.require(:game).permit(:player_2_id, :game_name)
  end
end
