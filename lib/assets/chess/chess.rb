# further improvements....
# 
# Board: pass boolean to setup pieces
# Board: 'pieces' method for @grid.flatten.compact
# Board: efficient 'setup_pieces' with list of objects (Rook).new
# Board: 'no_valid_moves.all?' method
# Pieces: too much duping in move_into_check?
# Pawns: line23 simplify
# sliding_pieces: use while_loop & shorten
# stepping_pieces: shorten more
# Board: keep track and display captured pieces
# extra features: castling, en passant, pawn promotion


require 'colorize'
require_relative 'board'
require_relative 'piece'
require_relative 'slidingpiece'
require_relative 'steppingpiece'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'game'

Game.new.play
