input = File.open("#{File.dirname(__FILE__)}/input", 'rb').read

class Group
  def initialize

  end
end

class Solution
  attr_reader :input

  def initialize(input)
    @input = format_input input
  end

  def part_1; end
  def part_2; end

  private

  def format_input(input)
    fuck_non_json(fuck_bangs(input))
  end

  def fuck_bangs(input)
    input.replace(/!./, '')
  end

  def fuck_non_json(input)
    input.replace(/[^\{\}\<\>\,]+/, '')
  end
end

solution = Solution.new(input)

p "Solution 1: #{solution.part_1}"
p "Solution 2: #{solution.part_2}"
