#game.rb
#Rock Paper Scissors

def play
  begin
    puts "Choose one: (P/R/S)"
    players_choice = gets.chomp

    case players_choice
    when "P"
      players_choice = "Paper"
    when "R"
      players_choice = "Rock"
    when "S"
      players_choice = "Scissors"
    else
      players_choice = "Again"
    end
  end while players_choice == "Again"

  choices = ["Paper", "Rock", "Scissors"]

  comp_choice = choices.sample

  if players_choice == comp_choice
    puts "It's a tie!"
  elsif players_choice == 'Rock' && comp_choice == 'Scissors'
    puts "Rock smashes Scissors, PLayer Wins!"
  elsif players_choice == 'Rock' && comp_choice == 'Paper'
    puts "Paper covers Rock, Computer Wins!"
  elsif players_choice == 'Paper' && comp_choice == 'Rock'
    puts "Paper covers Rock, Player Wins!"
  elsif players_choice == 'Paper' && comp_choice == 'Scissors'
    puts "Scissors cut Paper, Computer Wins!"
  elsif players_choice == 'Scissors' && comp_choice == 'Rock'
    puts "Rock smashes Scissors, Computer Wins!"
  else
    puts "Scissors cut Paper, Player Wins!"
  end
end

begin
  puts "Play Paper Rock Scissors!"
  play
  puts "Press 'Y' to play again"
  input = gets.chomp
end while input == 'Y'
    
    
    