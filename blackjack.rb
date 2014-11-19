SUITS = { "C" => "Clubs", "D" => "Diamonds", "H" => "Hearts", "S" => "Spades"}

VALUES = { "A" => [11,"Ace"], "2" => [2, "Two"], "3" => [3, "Three"], "4" => [4, "Four"],
            "5" => [5,"Five"], "6" => [6, "Six"], "7" => [7, "Seven"], "8" => [8, "Eight"],
            "9" => [9, "Nine"], "T" => [10, "Ten"], "J" => [10, "Jack"], "Q" => [10, "Queen"],
            "K" => [10, "King"]}

def shuffle_deck(deck_count)
  new_deck = []
  VALUES.each do |key, value|
    SUITS.each do |letter, word|
      deck_count.to_i.times do
        card = "#{key}#{letter}"
        new_deck << card
      end
    end
  end
  new_deck.shuffle!
end

def deal_card(deck)
  deck.pop  
end

def bust?(value)
  value > 21
end

def say(msg)
  puts "=> #{msg}"
end

def dealer_showing(hand)
  say "The Dealer is showing the #{VALUES[hand[0][0]][1]} of #{SUITS[hand[0][1]]}"
end

#Calculate method should calculate Aces as the last card
#^^Early thought, thinking about the problem.
#If a hand busts with one or more Aces, we will reduce the hand value
#until, we are < 21 or we can reduce no further, returning the final value.
def hand_value(hand)
  value = 0
  cards = []
  hand.each do |card|
    cards << card[0]
  end
  ace_count = cards.count("A")
  cards.each do |x|
    value += VALUES[x][0]
  end

  ace_count.times do  
    if bust?(value)
      value -= 10
      return (value) if !bust?(value)
    end
  end

  value
end

def hole_card(dealer_cards)
  hand_value(dealer_cards) == 21
end

def dbl_down(player_cards, deck)
  say "You take 1 final card"
  player_cards << deal_card(deck)
  say "You were dealt the #{VALUES[player_cards.last[0]][1]} of #{SUITS[player_cards.last[1]]}"
  return hand_value(player_cards)
end

say "Welcome to TeaLeaf Black Jack.  Can we have your name please?"
player_name = gets.chomp

begin
  say "How many decks would you like to play with? (1-999)"
  deck_count = gets.chomp
end until deck_count.to_i < 1000

deck = shuffle_deck(deck_count)

begin
  busted = false
  natural_21 = false
  double_down = false

  player_cards = []
  dealer_cards = []

  deck = shuffle_deck(deck_count) if deck.length < 30

  player_cards << deal_card(deck)
  say "You were dealt the #{VALUES[player_cards.last[0]][1]} of #{SUITS[player_cards.last[1]]}"
  
  2.times do
    dealer_cards << deal_card(deck)
  end

  dealer_showing(dealer_cards)

  case dealer_cards.first[0]
  when "A"
    natural_21 = hole_card(dealer_cards)
  when "T"
    natural_21 = hole_card(dealer_cards)
  when "J"
    natural_21 = hole_card(dealer_cards)
  when "Q"
    natural_21 = hole_card(dealer_cards)
  when "K"
    natural_21 = hole_card(dealer_cards)
  end
    

  begin
    player_choice = 'S'
    player_cards << deal_card(deck)
    say "You were dealt the #{VALUES[player_cards.last[0]][1]} of #{SUITS[player_cards.last[1]]}"
    sleep 1
    puts "\n
    *-------------------------------------------------------------*
    |Your Hand:#{hand_value(player_cards)}                                 Dealer's Hand:#{VALUES[dealer_cards[0][0]][0]} |
    *-------------------------------------------------------------*"
    sleep 1
    if bust?(hand_value(player_cards))
      say "You bust, the Dealer wins this round."
      busted = true
      break
    elsif (hand_value(player_cards) == 21  && natural_21)
      say "The Dealer reveals their hole card, the #{VALUES[dealer_cards[1][0]][1]} of #{SUITS[dealer_cards[1][1]]}"
      say "Both players have 21, it's a push!"
      busted = true
      break
    elsif natural_21
        say "The Dealer reveals their hole card, the #{VALUES[dealer_cards[1][0]][1]} of #{SUITS[dealer_cards[1][1]]}"
        say "You lose the Dealer has 21, what a luck sack!" 
    elsif (hand_value(player_cards) == 21 && player_cards.length == 2)
      say "Congratulations, you have a Black Jack"
      say "The Dealer reveals their hole card, the #{VALUES[dealer_cards[1][0]][1]} of #{SUITS[dealer_cards[1][1]]}"
      natural_21 = true
      break
    elsif hand_value(player_cards) == 21
      say "Congratulations, you have 21!"
      break     
    else
      if player_cards.length == 2
        say "Would you like to Hit, Stay or Double Down. (H/S/D)"
        player_choice = gets.chomp.upcase
        if player_choice != 'H' && player_choice !='S' && player_choice != 'D'
          begin
            say "Invalid command. H for Hit, S for Stay, D for Double Down"
            player_choice = gets.chomp.upcase
          end until player_choice == 'H' || player_choice =='S' || player_choice == 'D'
        elsif player_choice == 'D'
          if bust?(dbl_down(player_cards, deck))
            say "You bust, the Dealer wins this round."
            busted = true
          end
          double_down = true
        end
      else
        say "Would you like to Hit or Stay? H for hit, S for Stay"
        player_choice = gets.chomp.upcase

        if player_choice != 'H' && player_choice !='S'
          begin
            say "Invalid command. H for Hit, S for Stay"
            player_choice = gets.chomp.upcase
          end until player_choice == 'H' || player_choice =='S'
        end  
      end
    end
  end until player_choice == 'S' || player_choice == 'D'

  if ( !busted && !natural_21 ) || (double_down && !busted)
    say "The Dealer reveals the #{VALUES[dealer_cards[1][0]][1]} of #{SUITS[dealer_cards[1][1]]}"
    sleep 0.5
    puts "\n
      *-------------------------------------------------------------*
      |Your Hand:#{hand_value(player_cards)}                                 Dealer's Hand:#{hand_value(dealer_cards)} |
      *-------------------------------------------------------------*"
    sleep 1
    comp_value = hand_value(dealer_cards)

    while comp_value < 17
      say "The Dealer's hand is less than 17, they take another card..."
      dealer_cards << deal_card(deck)
      sleep 2
      say "The Dealer reveals the #{VALUES[dealer_cards[-1][0]][1]} of #{SUITS[dealer_cards[-1][1]]}"
      sleep 2
      comp_value = hand_value(dealer_cards)
      puts "\n
        *-------------------------------------------------------------*
        |Your Hand:#{hand_value(player_cards)}                                 Dealer's Hand:#{comp_value} |
        *-------------------------------------------------------------*"
      sleep 1
    end


    if hand_value(player_cards) > comp_value && !bust?(comp_value)
      say "#{player_name} has the higher hand this round!"
    elsif bust?(comp_value)
      say "#{player_name} wins, the Dealer busts!"
    elsif hand_value(player_cards) == comp_value
      say "This round is a push"
    else
      say "Sorry #{player_name}, you lose this round, the Dealer has the higher hand."
    end
  end
  sleep 2
  begin        
    say "Would you like to play another hand? (Y/N)"
    again = gets.chomp.downcase
  end until again == 'y' || again == 'n'
end until again == 'n'

