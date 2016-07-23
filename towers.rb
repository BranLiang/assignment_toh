# Generally idea, each plate is a number
# Initialially there will be 1, 2, 3, 4
# Each column will be an array to hold all
# the plates.
# And I am going to use the OOP method.
# Objects Tower, Player, Game
# Action Player: move, quit
# Action Tower : check_move, display
# Action Game  : game_start, game_over

class Game
  attr_accessor :col_1, :col_2, :col_3
  def initialize num_disks
    @num_disks  = num_disks
    @ini_arrange = Array(1..num_disks)
    @col_1 = @ini_arrange
    @col_2 = []
    @col_3 = []
  end

  def find_colmn input
    case input
    when 1
      @col_1
    when 2
      @col_2
    when 3
      @col_3
    else
      puts "invaid input!"
    end
  end

  def valid_move? arr
    disk_from = find_colmn(arr[0])[0]
    disk_to   = find_colmn(arr[1])[0]
    return true if (disk_from != nil) && (disk_to.nil? || disk_from < disk_to)
    false
  end


  def move arr
    if valid_move? arr
      disk_move = find_colmn(arr[0]).shift
      find_colmn(arr[1]).unshift(disk_move)
    else
      puts "Move failed! :("
    end
  end

  def win?
    true if (@col_2 == @ini_arrange) || (@col_3 == @ini_arrange)
  end

  def game_over
    puts win? ? "You win! :)" : "You lose :("
  end

  def array_fill arr
    result = []
    @num_disks.times do |i|
      if arr[i] != nil
        result << arr[i]
      else
        result << 0
      end
    end
    result
  end

  def display_one_line n
    move_distance = @num_disks + 2
    unless n.nil?
      ("=" * n).rjust(move_distance) + "|" + ("=" * n).ljust(move_distance)
    else
      " ".rjust(move_distance) + "|" + " ".ljust(move_distance)
    end
  end

  def display_all
    @num_disks.times do |i|
      print display_one_line array_fill(col_1).sort[i]
      print display_one_line array_fill(col_2).sort[i]
      print display_one_line array_fill(col_3).sort[i]
      puts
    end
  end
end

def game_start
  puts "How many disks do you wish for the game? (maximum 10 for the god sake)"
  num_disks_input = gets.chomp.to_i
  new_game = Game.new num_disks_input
  puts "Type in the format '1' click enter and '2' click enter"
  puts "to move the disk from column 1 to column 2."
  while !new_game.win?
    new_game.display_all
    puts "Where do you want to move? (q for quit)"
    input =[]
    a = gets.chomp
    break if a == 'q'
    b = gets.chomp
    break if b == 'q'
    if a.to_i.between?(1, 3) && b.to_i.between?(1, 3)
      input << a.to_i << b.to_i
    else
      puts "invaid input sorry"
      next
    end
    if input == 'q'
      break
    elsif !!(/\[\d.*\,.*\d\]/.match(input.to_s))
      new_game.move input
    else
      puts "I don't understand."
    end
  end
  game_over
end


puts "Welcome to Tower of Hanoi!"
puts "If you want to start the game"
puts "please type 'game_start' and click enter."
puts "During the game, you can type 'q' to quit at any time. "
