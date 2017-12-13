input    = File.open("#{File.dirname(__FILE__)}/input", 'rb').read.to_i
distance = 0

# Gonna need to start doing real programming if this logic gets any more complicated
(0..999).each do |radius|
  base      = (radius * 2) - 1
  range_min = (base * base) + 1
  range_max = (base + 2) * (base + 2)

  next unless input >= range_min && input <= range_max

  x       = radius
  y       = -radius + 1
  dx      = 0
  dy      = 1
  min     = -radius
  max     = radius
  current = range_min

  until current == input
    x += dx
    y += dy

    if x == max && y == max
      dx = -1
      dy = 0
    elsif x == min && y == max
      dx = 0
      dy = -1
    elsif x == min && y == min
      dx = 1
      dy = 0
    elsif x == max && y == min
      dx = 0
      dy = 1
    end

    current += 1
  end

  distance = x.abs + y.abs
  break
end

p "Solution 1: #{distance}"

points     = []
directions = [{ x: 1,  y: 0  },
              { x: 0,  y: 1  },
              { x: -1, y: 0  },
              { x: 0,  y: -1 }]

directions_index = 0
position         = { x: 0, y: 0 }
layer_index      = 1
val              = 0

class Point
  attr_reader :index, :x, :y

  def initialize(index, x, y)
    @index = index
    @x     = x
    @y     = y
  end

  def val(points)
    @val ||= begin
      return 1 if index.zero?

      valid_points = points.select do |p|
        p.index < index &&
          (p.x - x).abs <= 1 &&
          (p.y - y).abs <= 1
      end

      valid_points.sum { |p| p.val(points) }
    end
  end
end

(0..999).each do |index|
  points << Point.new(index, position[:x], position[:y])

  position[:x] = position[:x] + directions[directions_index][:x]
  position[:y] = position[:y] + directions[directions_index][:y]

  if [(position[:x] + directions[directions_index][:x]).abs,
      (position[:y] + directions[directions_index][:y]).abs].max > layer_index
    directions_index += 1

    if directions_index == 4
      directions_index = 0
      layer_index += 1
    end
  end

  val = points.last.val(points)
  break if val > input
end

p "Solution 2: #{val}" # Brute force malarkey since I couldn't think of an algorithm for the spiral
