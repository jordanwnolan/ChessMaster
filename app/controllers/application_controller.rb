class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def push_move(game, turn, errors = nil)
    board_partial = render_to_string(partial: "games/board", locals: {game: @game, turn: @turn, errors: @errors })
    Pusher.trigger("opp-move", "move", board_partial)
  end
end
