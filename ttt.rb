#Tic Tac Toe

WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
puts "Let's play:"
#a method that takes a hash of picks and generates a game board
#to show those picks
def draw_board(hash_of_picks) 
  board = "
       |     |     
    #{hash_of_picks[1]}  |  #{hash_of_picks[2]}  |  #{hash_of_picks[3]}  
       |     |    
  -----+-----+-----
       |     |     
    #{hash_of_picks[4]}  |  #{hash_of_picks[5]}  |  #{hash_of_picks[6]}  
       |     |    
  -----+-----+-----
       |     |     
    #{hash_of_picks[7]}  |  #{hash_of_picks[8]}  |  #{hash_of_picks[9]}  
       |     |     "

  puts board
end

starting_board = { 1 => 'T', 2 => 'I', 3 => 'C', 4 => 'T', 5 => 'A',
6 => 'C', 7 => 'T', 8 => 'O', 9 => 'E'}

draw_board(starting_board)

def player_picks(board)
  begin
    puts "Please pick a sqaure 1-9:"
    player_pick = gets.chomp

  end until player_pick =~ /^[1-9]$/ && board[player_pick.to_i] == ' ' 
  return player_pick.to_i
end

def computer_picks(open_spaces)
  comp_choice = open_spaces.sample
end


def winning(board)
  WINNING_LINES.each do |box|
    if board[box[0]] == 'X' && board[box[1]] == 'X' && board[box[2]] == 'X'
      puts "Congratulations Player, you are victorious!"
      return true
    elsif board[box[0]] == 'O' && board[box[1]] == 'O' && board[box[2]] == 'O'
      puts "Sadly the Computer triumphs this round."
      return true
    end
  end
  nil
end
      




begin
  picks = Hash.new
  1.upto(9) do |square|
    picks[square] = ' '
  end

  begin
    picks[player_picks(picks)] = 'X' #pass the current board, and set the choice = 'X'

    draw_board(picks)

    outcome = winning(picks)

    open_spaces = []

    picks.each do |k, v|
      if v == ' '
        open_spaces << k
      end
    end

    if open_spaces.length == 0 && !outcome
      puts "Looks like this one is tie!"
      outcome == true
    end

    if !outcome
      picks[computer_picks(open_spaces)] = 'O'
      draw_board(picks)
      outcome = winning(picks)
    end
  end until outcome
  exit
end
