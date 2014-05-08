require_relative 'all_pieces'

class Board

  DIMENSION = 8

  attr_accessor :grid

  def initialize
    @grid = Board.generate_board
    setup_pieces
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @grid[x][y]
  end

  def []=(pos,piece)
    x, y = pos[0], pos[1]
    @grid[x][y] = piece
  end

  def in_check?(color)
    opp_color = (color == :white ? :black : :white)
    all_possible_moves = []
    colors_king_position = []


    @grid.flatten.compact.each do |piece|
      if (piece.is_a? King) && piece.color == color
        colors_king_position = piece.position
      elsif opp_color == piece.color
        all_possible_moves += piece.moves(self)
      end
    end
    all_possible_moves.include?(colors_king_position)
  end

  def move(start_pos, end_pos, color)
    piece = self[start_pos]

    if valid_move?(piece,end_pos,color)
      # move!(dfead)
      piece.position  = end_pos
      self[start_pos], self[end_pos] = nil, piece
    end
  end

  def move!(start_pos, end_pos)
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = nil        # move self from start to end
    piece.position = end_pos
  end

  def check_mate?(color)
     no_valid_moves?(color) && in_check?(color)
  end

  def draw?(color)
    no_valid_moves?(color) && !in_check?(color)
  end

  def dup
    duped_board = Board.new
    @grid.flatten.compact.each do |piece|
      duped_board[piece.position] = piece.dup(duped_board)
    end
    duped_board
  end

  def to_s
    # render_board
  end

  private

  def self.generate_board
    Array.new(DIMENSION) { Array.new(DIMENSION) }
  end

  def setup_pieces
    DIMENSION.times do |col|
      #self.[]=
      self[[1,col]] = Pawn.new(self,:white,[1,col])
      self[[6,col]] = Pawn.new(self,:black,[6,col])

      case
      when col == 0 || col == 7
        self[[0,col]] = Rook.new(self,:white,[0,col])
        self[[7,col]] = Rook.new(self,:black,[7,col])
      when col == 1 || col == 6
        self[[0,col]] = Knight.new(self,:white,[0,col])
        self[[7,col]] = Knight.new(self,:black,[7,col])
      when col == 2 || col == 5
        self[[0,col]] = Bishop.new(self,:white,[0,col])
        self[[7,col]] = Bishop.new(self,:black,[7,col])
      when col == 3
        self[[0,col]] = Queen.new(self,:white,[0,col])
        self[[7,col]] = Queen.new(self,:black,[7,col])
      when col == 4
        self[[0,col]] = King.new(self,:white,[0,col])
        self[[7,col]] = King.new(self,:black,[7,col])
      end
    end
  end

  def pieces

  end

  def valid_move?(piece, end_pos, color)
    raise "No piece at this position!" if piece.nil?

    unless color == piece.color
      raise "You cannot move your opponent's piece!"
    end

    unless piece.moves(self).include?(end_pos)
      raise "Invalid move for #{piece.color}'s #{piece.class}!"
    end

    if piece.move_into_check?(end_pos, self)
      raise "cannot move #{piece.color}'s #{piece.class} into check!"
    end

    true
  end

  def no_valid_moves?(color)
    @grid.flatten.compact.select do |piece|
      piece.color == color
    end.map(&:valid_moves).flatten.empty?

  end

  # def render_board

  #   board_string = ('a'..'h').inject('') { |str, ltr| str += " #{ltr} " } + "\n"

  #   @grid.reverse.each_with_index do |row, i|
  #     row.each_with_index do |tile, j|
  #       icon = (tile.nil? ? ' ' : "#{tile.to_s}").colorize(color: :red)
  #       color = ((i + j).even? ? :white : :light_green)
  #       board_string << " #{icon} ".colorize(:background => color)
  #     end
  #     board_string << " #{DIMENSION - i}\n"
  #   end

  #   board_string
  # end

end