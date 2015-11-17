#!/usr/bin/env ruby
user_input = gets.chomp.to_i
steps = []

while user_input != 1 do
  remainder = user_input % 3
  divisible = remainder == 0

  if divisible
    puts "#{user_input} / 3"
    user_input = user_input / 3
  elsif remainder == 1
    puts "#{user_input} - 1"
    user_input = user_input - 1
    steps << -1
  elsif remainder == 2
    puts "#{user_input} + 1"
    user_input = user_input + 1
    steps << 1
  end
end
