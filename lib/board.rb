require "byebug"

class Board
  attr_reader :size

  def self.print_grid(array)
    array.each do |sub_array|
      puts sub_array.join(" ")
    end
  end
  
  def initialize(n)
     @grid = Array.new(n) { Array.new(n, :N) }
     @size = n * n
  end

  def [](indices)
    @grid[indices[0]][indices[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = value
  end

  def num_ships
    ship_count = Hash.new(0)

    @grid.flatten.each { |ele| ship_count[ele] += 1}
    ship_count[:S]
  end

  def attack(pos)
    if self[pos] == :S
      self[pos] = :H
      puts "You sunk my battleship!"
      return true
    else
      self[pos] = :X
      false
    end

  end

  def place_random_ships
    quater = @size * 0.25
    while self.num_ships < quater
      rand_row = rand(0..@grid.length - 1)
      rand_col = rand(0..@grid.length - 1)
      self[[rand_row, rand_col]] = :S
    end
  end

  def hidden_ships_grid
    hidden_grid = @grid.map do |sub_array|
      sub_array.map do |ele|
        if ele == :S
          ele = :N
        else
          ele
        end
      end
    end
    hidden_grid
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end

end
