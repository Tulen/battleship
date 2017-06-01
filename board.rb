require './ship.rb'
require 'colorize'

class Board
  attr_reader :grid, :fire_msg, :ships, :ship_sunk
  def initialize
    @grid = Array.new(10) { Array.new(10, ' ? ') }
    @ships = []
  end

  def rand_populate
    direction = seed_direction
    # carrier 5
    populate_ship(location_viability(5, direction), 5, direction)
    @ships << Ship.new('carrier', @start, 5, direction)
    # battleship 4
    direction = seed_direction
    populate_ship(location_viability(4, direction), 4, direction)
    @ships << Ship.new('battleship', @start, 4, direction)
    # cruiser 3
    direction = seed_direction
    populate_ship(location_viability(3, direction), 3, direction)
    @ships << Ship.new('cruiser', @start, 3, direction)
    # submarine 3
    direction = seed_direction
    populate_ship(location_viability(3, direction), 3, direction)
    @ships << Ship.new('submarine', @start, 3, direction)
    # destroyer 2
    direction = seed_direction
    populate_ship(location_viability(2, direction), 2, direction)
    @ships << Ship.new('destroyer', @start, 2, direction)
  end

  def location_viability(ship_length, direction)
    possible_locations = []
    # horizontal viability check
    if direction == :horizontal
      (0..9).to_a.each do |row|
        (0..(10 - ship_length)).to_a.each do |col|
          if @grid[row][col..(col + ship_length)].all? { |pos| pos == ' ? ' }
            possible_locations << [row, col]
          end
        end
      end
    # vertical viability check
    else
      (0..(10 - ship_length)).to_a.each do |row|
        (0..9).to_a.each do |col|
          if @grid[row][col..(col + ship_length)].all? { |pos| pos == ' ? ' }
            possible_locations << [row, col]
          end
        end
      end
    end
    possible_locations
  end

  def populate_ship(locations, ship_length, direction)
    pop_counter = 0
    @start = locations.sample
    if direction == :horizontal
      until pop_counter == ship_length
        @grid[@start[0]][@start[1] + pop_counter] = ' S '
        pop_counter += 1
      end
    else
      until pop_counter == ship_length
        @grid[@start[0] + pop_counter][@start[1]] = ' S '
        pop_counter += 1
      end
    end
  end

  def seed_direction
    seed = rand(0..1)
    if seed.zero?
      return :horizontal
    else
      return :vertical
    end
  end

  def turn_update(pos)
    @ship_sunk = false
    @grid[pos[1]][pos[0]] = if @grid[pos[1]][pos[0]] == ' ? '
                              @fire_msg = 'Prior move: MISS!'.yellow
                              ' X '.yellow
                            else
                              @fire_msg = 'Prior move: HIT!'.red
                              ' ! '.red
                            end
    @ships.each do |ship|
      ship.positions.map! do |location|
        if location == [pos[1],pos[0]]
          'X'
        else
          location
        end
      end

      if ship.positions.all? { |el| el == 'X' }
        @fire_msg = "Prior move: YOU SUNK THEIR #{ship.name.upcase}!".red
        ship.positions << 'PRINTED!'
        @ship_sunk = true
      end
    end


  end

  def render
    puts @fire_msg
    puts '   A  B  C  D  E  F  G  H  I  J '.blue
    row_string = ''
    @grid.each_with_index do |row, idx|
      row.each do |pos|
        row_string << if pos == ' S '
                        ' ? '
                      else
                        pos
                      end
      end
      puts idx.to_s.blue + " #{row_string}"
      row_string = ''
    end
    ''
  end

  def render_shown
    puts '   A  B  C  D  E  F  G  H  I  J '.blue
    row_string = ''
    @grid.each_with_index do |row, idx|
      row.each do |pos|
        row_string << if pos == ' ? '
                        ' . '
                      else
                        pos
                      end
      end
      puts idx.to_s.blue + " #{row_string}"
      row_string = ''
    end
    ''
  end

  def won?
    @grid.each { |row| row.each { |pos| return false if pos == ' S ' } }
    true
  end

end
