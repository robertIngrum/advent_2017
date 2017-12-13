input = File.open("#{File.dirname(__FILE__)}/input", 'rb').read.split(/\n/).map! { |row| row.split(/\t/).map(&:to_i) }

sum = input.sum do |row|
  row.max - row.min
end

p "Solution 1: #{sum}"

sum = input.sum do |row|
  res = nil

  row.each_with_index do |n1, i|
    row[i + 1..-1].each do |n2|
      options = [n1, n2]
      max     = options.max
      min     = options.min

      res = max / min if (max % min).zero?

      break unless res.nil?
    end

    break unless res.nil?
  end

  res
end

p "Solution 2: #{sum}"
