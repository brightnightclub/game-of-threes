require 'pry'

class Three
  attr_accessor :number

  REMAINDER_HASH = { 0 => 0, 1 => -1, 2 => 1}


  def initialize(number)

    if number.match(/^[1-9]\d*$/)
      @number = number.to_i
    else
      raise ArgumentError.new("Please enter a number")
    end
  end


  def calc
    print "#{number} "

    if (number == 1)
      puts
      return
    end

    mod = number % 3

    puts action = REMAINDER_HASH[mod]

    @number = ((number + action) / 3)

    calc
  end
end

if __FILE__ == $0
  puts "Please enter a number..."
  input = gets.chomp
  puts "-" * 80
  Three.new(input).calc
  `open 'https://www.youtube.com/embed/Kdsxho2Cnog?start=210&autoplay=1'`
end
