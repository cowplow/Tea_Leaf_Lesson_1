def take_arr(arr)
  arr.flatten
  arr.uniq!
end

my_arr = [1,2,[3,4],2]

take_arr(my_arr)

print my_arr