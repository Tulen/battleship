require 'gosu'

class Animation
  def sinking
    @sfx = Gosu::Sample.new('./sounds/sinking.wav')
    @sfx.play(1, 1)
    ship_arr = [
      "    ,:',:`,:'                          ",
      '          __||_||_||_||__              ',
      '     ____["""""""""""""""]____         ',
      '     \ " """"""""""""""""     |        ',
      '~~jgs~^~^~^^~^~^~^~^~^~^~^~~^~^~^^~~^~^'.cyan
    ]
    print_arr = ship_arr

    print_arr.each_index do |idx|
      print_arr.each { |line| puts line }
      sleep(0.5)
      system('clear')

      print_arr.each_index do |idx2|
        if 4 - idx2 - idx < 0
          print_arr[4 - idx2] = ''
        else
          print_arr[4 - idx2] = ship_arr[4 - idx2 - idx]
        end
      end
    end
  end

  def explosion
    @sfx = Gosu::Sample.new('./sounds/explosion.wav')
    @sfx.play(1, 1)
    puts '     .-^^---....,,--         '.red
    puts '  _--                  --_   '.red
    puts ' <                        >) '.red
    puts ' |                         | '.red
    puts '  \._                   _./  '.red
    puts '     ```--. . , ; .--''      '.red
    puts '           | |   |           '.red
    puts '        .-=||  | |=-.        '.red
    puts '        `-=#$%&%$#=-.        '.red
    puts '           | ;  :|           '.red
    puts '  _____.,-#%&$@%#&#~,._____  '.red
    sleep(2)
    system('clear')
  end

  def splash
    @sfx = Gosu::Sample.new('./sounds/splash.wav')
    @sfx.play(1, 1)
    splash_arr = [
      "                      HH'                    ".cyan,
      "                 XIHH                        ".cyan,
      "    HHHA.            XHIIIX.    .MX     .:HD ".cyan,
      "       HHA.          !HI!IXI    AM:    AMHH' ".cyan,
      "         HA.     .   'HI!:IX   :HH    AHHM'  ".cyan,
      "        XIX:.  AMA:.H!::IX.  !HX   AHHH      ".cyan,
      "            IXX: :HHHHHI. .HMMMXXH: !XIH     ".cyan,
      "             !:IXIMHHXHI.  IHHH!HX.!II       ".cyan,
      "              :.:!IHHXII:  .XH!!HMI::        ".cyan,
      "               I. .!!II!:  :II.!H!.:         ".cyan,
      "          MMHHII!:. :::::   ::.I: .'         ".cyan
    ]
    print_arr = Array.new(11, '')

    print_arr.each_index do |idx|
      print_arr[11 - idx] = splash_arr[11 - idx]
      print_arr.each_with_index do |line|
        puts line
      end
      sleep(0.05)
      system('clear')
    end
    print_arr.each_with_index do |line|
      puts line
    end
    sleep(2)
    system('clear')
  end
end
