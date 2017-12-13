input = File.open("#{File.dirname(__FILE__)}/input", 'rb').read

class Solution
  attr_reader :input

  def initialize(input)
    @input = format_input(input)
  end

  def part_1
    counter  = 0
    steps    = @input.dup
    position = 0

    while position < steps.length && position >= 0
      next if (instruction = steps[position]).nil?

      steps[position] += 1
      position        += instruction

      counter += 1
    end

    counter
  end

  def part_2
    counter  = 0
    steps    = @input.dup
    position = 0

    while position < steps.length && position >= 0
      next if (instruction = steps[position]).nil?

      if instruction >= 3
        steps[position] -= 1
      else
        steps[position] += 1
      end

      position += instruction
      counter  += 1
    end

    counter
  end

  private

  def format_input(input)
    input.split(/\n/).map(&:to_i)
  end
end

solution = Solution.new(input)

p "Solution 1: #{solution.part_1}"
p "Solution 2: #{solution.part_2}"
