input = File.open("#{File.dirname(__FILE__)}/input", 'rb').read

class Solution
  attr_reader :input, :order_history

  def initialize(input)
    @input         = formatted_input(input)
    @order_history = []
  end

  def part_1
    count         = 0
    bank          = input.dup

    until order_history.include? stringify(bank)
      @order_history << stringify(bank)

      target_index       = bank.index(bank.max)
      value              = bank[target_index]
      bank[target_index] = 0

      while value > 0
        target_index       += 1
        target_index        = 0 if target_index >= bank.length
        bank[target_index] += 1
        value              -= 1
      end

      count += 1
    end

    @order_history << stringify(bank)

    count
  end

  def part_2
    dup = @order_history.delete_at(-1)

    @order_history.length - @order_history.index(dup)
  end

  private

  def formatted_input(input)
    input.split(/\t/).map(&:to_i)
  end

  def stringify(arr)
    arr.join('-')
  end
end

solution = Solution.new(input)

p "Solution 1: #{solution.part_1}"
p "Solution 2: #{solution.part_2}"
