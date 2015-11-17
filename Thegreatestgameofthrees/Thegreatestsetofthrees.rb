#!/usr/bin/env ruby
user_input = gets.chomp.to_i
steps = []

while user_input != 1 do
  if user_input <= 0
    puts "MISSION IMPOSSIBLE"
    break
  end

  remainder = user_input % 3
  divisible = remainder == 0

  if divisible
    puts "#{user_input} / 3"
    user_input = user_input / 3
  else
    if remainder == 1
      possible_steps = [-1, 2]
    elsif remainder == 2
      possible_steps = [1, -2]
    end

    op1 = [steps, possible_steps[0]].flatten.inject(:+)
    op2 = [steps, possible_steps[1]].flatten.inject(:+)

    if op1.abs < op2.abs
      puts "#{user_input} + #{possible_steps[0]}"
      user_input = user_input + possible_steps[0]
      steps << possible_steps[0]
    else
      puts "#{user_input} + #{possible_steps[1]}"
      user_input = user_input + possible_steps[1]
      steps << possible_steps[1]
    end
  end
end

sum_array = steps.inject(:+)
if sum_array == 0
  puts "WE WIN! #{sum_array}"
else
  puts "WE LOST! #{sum_array}"
end
