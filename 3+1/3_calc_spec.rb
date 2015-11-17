require "rspec"
require "./3_calc"

RSpec.describe Three do

  it "takes a number as input" do
    number = "5"
    expect{Three.new(number)}.to_not raise_error
    expect(Three.new(number).number).to eq number.to_i
  end

  it "request a number when the input isn't an integer" do
    number = "hello or something"
    expect{Three.new(number)}.to raise_error
  end

  it "request a number when the input isn't an integer" do
    number = "0.05"
    expect{Three.new(number)}.to raise_error
  end

  describe "#calc" do
    it "prints out output of our steps" do
      Three.new("23").calc
    end
  end

end
