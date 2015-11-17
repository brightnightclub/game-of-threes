class Game
  def initialize(number)
    @number = number
    puts number
  end

  def find_next
    return 1 if @number == 1

    mod = @number % 3
    if mod == 0
      puts "#{@number} / 3 = #{@number / 3}"
      @number /= 3
    elsif mod == 2
      puts "#{@number} + 2 = #{@number + 2}"
      @number += 2
    else
      puts "#{@number} - 1 = #{@number - 1}"
      @number -= 1
    end

    find_next
  end
end
