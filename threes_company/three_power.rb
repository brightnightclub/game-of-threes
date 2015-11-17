require 'ascii_charts'

def get_threes_steps(number)
  return nil unless number > 0

  steps = []

  while number != 1
    steps << number

    exponent = Math.log(number) / Math.log(3)
    upper_power = 3 ** exponent.ceil
    lower_power = 3 ** exponent.floor

    x = if (number - lower_power) <= 2 and lower_power != 1
      lower_power - number
    elsif (upper_power - number) <= 2
      upper_power - number
    else
      -(number % 3)
    end

    steps << x
    number = (number + x) / 3
  end
  steps << number

  steps
end

graph_data = []
if ARGV.size == 1
  min_number = 1
  max_number = ARGV.first.to_i
else
  min_number = ARGV[0].to_i
  max_number = ARGV[1].to_i
end
(min_number..max_number).each do |number|
  steps = get_threes_steps(number)
  steps_without_zeroes = steps.find_all { |step| step != 0 }
  graph_data << [number, steps_without_zeroes.size]
end

puts AsciiCharts::Cartesian.new(graph_data, :bar => true).draw
