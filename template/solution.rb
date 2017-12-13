input = File.open("#{File.dirname(__FILE__)}/input", 'rb').read

class Solution
  attr_reader :input

  def initialize(input)
    @input = format_input input
  end

  def part_1; end
  def part_2; end

  private

  def format_input(input); end
end

solution = Solution.new(input)

p "Solution 1: #{solution.part_1}"
p "Solution 2: #{solution.part_2}"
