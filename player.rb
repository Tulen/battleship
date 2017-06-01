class HumanPlayer
  COL_CONVERT = {
    'A' => 0,
    'B' => 1,
    'C' => 2,
    'D' => 3,
    'E' => 4,
    'F' => 5,
    'G' => 6,
    'H' => 7,
    'I' => 8,
    'J' => 9
  }.freeze

  def initialize
    @fire_history = []
  end

  def fire
    p 'Target which column? (A-J)'
    col_target = gets.chomp.upcase
    until COL_CONVERT.keys.include?(col_target)
      p 'Valid column values: (A-J)'
      col_target = gets.chomp.upcase
    end
    col_target = COL_CONVERT[col_target]

    p 'Target which row? (0-9)'
    row_target = gets.chomp
    until (0..9).to_a.map(&:to_s).include?(row_target)
      p 'Valid row values: (0-9)'
      row_target = gets.chomp
    end

    if @fire_history.include?([col_target, row_target.to_i])
      p 'You already targeted this position!'
      fire
    else
      @fire_history << [col_target, row_target.to_i]
      [col_target, row_target.to_i]
    end
  end
end

class ComputerPlayer
  def initialize
    @fire_history = []
  end

  def fire
    col_target = rand(0..9)
    row_target = rand(0..9)
    if @fire_history.include?([col_target, row_target])
      fire
    else
      @fire_history << [col_target, row_target]
      [col_target, row_target]
    end
  end
end
