input = File.open("#{File.dirname(__FILE__)}/input", 'rb').read

class Solution
  attr_reader   :input
  attr_accessor :valid_count

  def initialize(input)
    @input       = format_input(input)
    @valid_count = 0
  end

  def part_1
    @valid_count = 0

    input.each do |row|
      valid = true

      row.each do |word|
        search = row.dup
        search.delete_at(search.find_index(word))

        valid = false if search.include? word
        break unless valid
      end

      @valid_count += 1 if valid
    end

    valid_count
  end

  def part_2
    @valid_count = 0

    input.each do |row|
      valid = true

      row.map! { |word| word.chars.sort(&:casecmp).join }

      row.each do |word|
        search = row.dup
        search.delete_at(search.find_index(word))

        if search.include?(word)
          valid = false
          break
        end
      end

      @valid_count += 1 if valid
    end

    valid_count
  end

  private

  def format_input(input)
    input.split(/\n/).map { |row| row.split(' ') }
  end
end

solution = Solution.new(input)
p "Solution 1: #{solution.part_1}"
p "Solution 2: #{solution.part_2}"
