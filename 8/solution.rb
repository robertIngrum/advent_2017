input = File.open("#{File.dirname(__FILE__)}/input", 'rb').read

class Solution
  attr_reader :command_pairs, :register, :max_val

  def initialize(input)
    @command_pairs = format_input input
    @register      = Hash.new(0)
    @max_val       = 0
  end

  def part_1
    command_pairs.each do |pair|
      command, condition = pair

      next unless condition.check(register)

      @register = command.apply_to(register)

      @max_val = [max_val, *register.values].max
    end

    register.values.max
  end

  def part_2
    max_val
  end


  private

  def format_input(input)
    rows = input.split(/\n/)
    rows.map! do |row|
      command, condition = row.split(' if ')
      [Command.new(command), Condition.new(condition)]
    end
  end

  class Command
    attr_reader :target, :opt, :number

    def initialize(input)
      @target, @opt, @number = process_input(input)
      @number                = number.to_i
    end

    def apply_to(register)
      command = if opt == 'inc'
                  '+'
                elsif opt == 'dec'
                  '-'
                end

      register[target] = register[target].send(command, number)

      register
    end

    private

    def process_input(input)
      input&.split(' ')
    end
  end

  class Condition
    attr_reader :target, :opt, :number

    def initialize(input)
      @target, @opt, @number = process_input input
      @number                = number.to_i
    end

    def check(register)
      return false if target.nil?

      register[target].send(opt, number)
    end

    private

    def process_input(input)
      input&.split(' ')
    end
  end
end

solution = Solution.new(input)

p "Solution 1: #{solution.part_1}"
p "Solution 2: #{solution.part_2}"
