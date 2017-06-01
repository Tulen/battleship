require './board.rb'
require './player.rb'
require './animation.rb'

###
# H v C works!
### TODO:
# BUG: Overlapping ship locations during rand pop?
# refactor code
# Add smart computer, if prior move is a hit, check adjacent
# Allow human to manually populate ships

## DOCUMENTATION
#
# initialize
#   creates animation class instance
#
#  setup
#    displays game intro animation
#    prompts user for input for player select(human or computer players)
#    HELPER: player_set
#    humans player populate
#    computers random populate
#
#  play_turn
#    takes current player input for firing
#    updates opposing player board
#  run_game
#    runs game until one of the boards is won?
#  missle_animation
#    runs missle animation based on current player fire data
#  myships data table??

class Game
  def initialize
    @animation = Animation.new
    @players = Hash.new(nil)
    @boards = Hash.new(nil)
    @attacker = 1
    @defender = 2
    @turn_screen = 0
  end

  def setup
    puts 'Welcome to Battleship!!!'.yellow
    puts 'Player 1 is a... (H => Human, C => Computer)'
    player_set(1)

    puts 'Player 2 is a... (H => Human, C => Computer)'
    player_set(2)
    system('clear')
  end

  def player_set(player)
    player_select = gets.chomp
    @boards[player] = Board.new
    if player_select.upcase == 'H'
      @players[player] = HumanPlayer.new
      @boards[player].rand_populate
      @turn_screen += 1
      # @boards[player].player_populate
    elsif player_select.upcase == 'C'
      @players[player] = ComputerPlayer.new
      @boards[player].rand_populate
    else
      puts 'Please select Human(H) or Computer(C)'
      player_set(player)
    end
  end

  def play_turn
    @boards[@defender].turn_update(@players[@attacker].fire)
    system('clear')
    missle_animation
    turn_screen if @turn_screen == 2
    @boards[@attacker].render
    @boards[@defender].render_shown
    switch_current
  end

  def turn_screen
    puts "Player #{@defender}'s turn...".yellow
    puts 'Ready? (Y)'.yellow
    if gets.chomp.upcase == 'Y'
      return 0
    else
      turn_screen
    end
  end

  def switch_current
    @attacker, @defender = @defender, @attacker
  end

  def run_game
    setup
    until @boards[@defender].won?
      play_turn
    end
  end

  def missle_animation
    15.times do
      1.times do
        puts '  :**:  '
      end
      sleep(0.05)
    end
    puts ' |\**/| '
    puts ' \ == / '
    puts '  |  |  '
    puts '  |  |  '
    puts '  \  /  '
    puts '   \/   '
    sleep(1.5)
    system('clear')
    if @boards[@defender].ship_sunk
      @animation.sinking
    elsif @boards[@defender].fire_msg == 'Prior move: HIT!'.red
      @animation.explosion
    else
      @animation.splash
    end
  end
end

ng = Game.new
ng.run_game
