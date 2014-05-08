Rails.application.routes.draw do

  devise_for :players
  root 'games#index'
  resources :games
  # post 'games/make_move', to: 'games#make_move', as: :make_move

end
