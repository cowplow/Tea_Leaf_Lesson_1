SUITS = { "C" => "Clubs", "D" => "Diamonds", "H" => "Hearts", "S" => "Spades"}

VALUES = { "A" => [11,"Ace"], "2" => [2, "Two"], "3" => [3, "Three"], "4" => [4, "Four"],
            "5" => [5,"Five"], "6" => [6, "Six"], "7" => [7, "Seven"], "8" => [8, "Eight"],
            "9" => [9, "Nine"], "T" => [10, "Ten"], "J" => [10, "Jack"], "Q" => [10, "Queen"],
            "K" => [10, "King"]}

def shuffle_deck
  new_deck = []
  VALUES.each do |key, value|
    SUITS.each do |letter, word|
      card = "#{key}#{letter}"
      new_deck << card
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
  if hand_value(dealer_cards) == 21
    true
  else
    false
  end
end

begin
  busted = false
  natural_21 = false

  player_cards = []
  dealer_cards = []

  deck = shuffle_deck

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
    say "Your hand now has a value of #{hand_value(player_cards)}. The Dealer is showing a value of #{VALUES[dealer_cards[0][0]][0]}"
    sleep 1
    if bust?(hand_value(player_cards))
      say "You bust, the Dealer wins this round."
      busted = true
      break
    elsif (hand_value(player_cards) == 21  && natural_21)
      say "Both players have 21, it's a push!"
      busted = true
      break
    elsif natural_21
        say "You lose the Dealer has 21, what a luck sack!" 
    elsif (hand_value(player_cards) == 21 && player_cards.length == 2)
      say "Congratulations, you got a Black Jack"
      natural_21 = true
      break
    elsif hand_value(player_cards) == 21
      say "Congratulations, you have 21!"
      break     
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
  end until player_choice == 'S'

  if !natural_21
    sleep 0.5

    say "The Dealer reveals the #{VALUES[dealer_cards[1][0]][1]} of #{SUITS[dealer_cards[1][1]]}"
  
    sleep 0.5

   say "The Dealer has a value of #{hand_value(dealer_cards)}"
 end

  if !busted && !natural_21
    sleep 1
    comp_value = hand_value(dealer_cards)

    while comp_value < 17
      say "The Dealer's hand is less than 17, they take another card..."
      dealer_cards << deal_card(deck)
      sleep 1
      say "The Dealer reveals the #{VALUES[dealer_cards[-1][0]][1]} of #{SUITS[dealer_cards[-1][1]]}"
      comp_value = hand_value(dealer_cards)
      say "The Dealer now has a value of #{comp_value}"
      sleep 1
    end


    if hand_value(player_cards) > comp_value && !bust?(comp_value)
      say "Player has the higher hand this round!"
    elsif bust?(comp_value)
      say "Player wins, the Dealer busts!"
    elsif hand_value(player_cards) == comp_value
      say "This round is a push"
    else
      say "Sorry you lose this round, the Dealer has the higher hand."
    end
  end
        

end

