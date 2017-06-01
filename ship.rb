# carrier 5
# battleship 4
# cruiser 3
# submarine 3
# destroyer 2

class Ship
  attr_accessor :name, :positions

  def initialize (name, start_pos, length, direction)
    @name = name
    @positions = Array.new(length, start_pos)

    @positions.map!.with_index do |el, idx|
      if direction == :vertical
        [el[0] + idx, el[1]]
      else
        [el[0], el[1] + idx]
      end
    end

  end

end
