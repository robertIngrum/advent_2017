input = File.open("#{File.dirname(__FILE__)}/input", 'rb').read.strip.split('').map!(&:to_i)

previous = input[-1]
sum      = 0

input.each do |current|
  sum += current if current == previous
  previous = current
end

p "Solution 1: #{sum}"

half_length = input.length / 2
sum         = 0

input.each_with_index do |n, i|
  opposite_index = (half_length + i) % input.length

  sum += n if n == input[opposite_index]
end

p "Solution 2: #{sum}"
