require_relative "board"
require_relative "player"

class Battleship
  attr_reader :board, :player
  
  def initialize(length)
    @player = Player.new
    @board = Board.new(length)
    @remaining_misses = @board.size / 2.0
  end

  def start_game
    @board.place_random_ships
    puts "Number of ships: #{board.num_ships}"
    @board.print
  end

  def lose?
    if @remaining_misses <= 0
      puts "you lose"
      true
    else
      false
    end
  end

  def win?
    if board.num_ships == 0
      puts "you win"
      true
    else
      false
    end
  end

  def game_over?
    return true if win? || lose?
    false
  end

  def turn
    if !@board.attack(player.get_move)
      @remaining_misses -= 1
    end
    @board.print
    puts "Remaining misses: #{@remaining_misses}"
  end
end
