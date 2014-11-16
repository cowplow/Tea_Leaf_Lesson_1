#calculator.rb

def say(msg)
  puts "=> #{msg}"
end

begin
  say "Please enter a number:"
  num_1 = gets.chomp

  if num_1.to_i == 0  && num_1 != '0'
    bad = true 
  else
    bad = false
  end
end while bad

begin
  say "Please enter a 2nd number:"
  num_2 = gets.chomp

  if num_2.to_i == 0  && num_2 != '0'
    bad = true 
  else
    bad = false
  end
end while bad

begin
  say "Please enter the number of your desired function"
  say "1 - Addition"
  say "2 - Subtraction"
  say "3 - Multiplication"
  say "4 - Division"
  function = gets.chomp
end while function.to_i < 1  || function.to_i > 4

case function
  when '1'
    function = "Addition"
    result = num_1.to_f + num_2.to_f
  when '2'
    function = "Subtraction"
    result = num_1.to_f - num_2.to_f
  when '3'
    function = "Multiplication"
    result = num_1.to_f * num_2.to_f
  else
    function = "Division"
    result = num_1.to_f / num_2.to_f
  end

say "You picked #{num_1} and #{num_2} and selected #{function}"

say "The result is #{result}"



    
    