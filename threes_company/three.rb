number = ARGV.first.to_i
if number > 0
  steps = []

  while number != 1
    steps << number
    x = case number % 3
    when 2
      1
    when 1
      -1
    when 0
      0
    end
    steps << x
    number = (number + x) / 3
  end
  steps << number

  puts steps.join(" ")
end
