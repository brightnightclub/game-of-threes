require_relative 'game'

module CLI
  def self.start
    puts "Enter a number: "
    number = gets.chomp.to_i
    CLI.play(number)
  end

  def self.play(number)
    @game = Game.new(number)
    @game.find_next
  end
end
