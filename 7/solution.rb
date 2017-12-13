input = File.open("#{File.dirname(__FILE__)}/input", 'rb').read

class Tower
  attr_reader :name, :weight, :subtower_names

  def initialize(name, weight, subtower_names)
    @name           = name
    @weight         = weight
    @subtower_names = subtower_names || []
  end

  def total_weight(towers)
    @total_weight ||= begin
      return weight.to_i if @subtower_names.length == 0

      [weight.to_i, *subtowers(towers).map { |t| t.total_weight(towers).to_i }].sum.to_i
    end
  end

  def subtowers(towers)
    @subtowers ||= subtower_names.map { |name| towers[name] }
  end

  def unbalanced_tower(towers)
    return if subtower_names.length == 0

    subtowers = subtowers(towers)

    return if (weights = subtowers.map { |tower| tower.total_weight(towers).to_i }).uniq.length == 1
    return if subtowers.any? { |tower| !tower.unbalanced_tower(towers).nil? }

    weight_counts = weights.each_with_object(Hash.new(0)) { |weight, count| count[weight] += 1 }
    weight_counts = weight_counts.sort_by { |_weight, count| count }
    bad_weight, correct_weight = weight_counts.map(&:first)

    bad_tower        = subtowers.select { |tower| tower.total_weight(towers) == bad_weight }.first
    difference       = correct_weight - bad_weight
    corrected_weight = bad_tower.weight.to_i + difference

    return nil, corrected_weight
  end
end

class Towers < Hash; end

class Solution
  attr_reader :towers

  def initialize(input)
    @towers     = towerify input
    @root_tower = nil
  end

  def part_1
    root_tower(towers.values.first).name
  end

  def part_2
    towers.values.each do |tower|
      _unbalanced_name, correct_weight = tower.unbalanced_tower(towers)
      return correct_weight unless correct_weight.nil? || correct_weight.zero?
    end

    nil
  end

  private

  def root_tower(starting_tower)
    return @root_tower unless @root_tower.nil?

    current_name = starting_tower.name

    towers.each do |_name, tower|
      return root_tower(tower) if tower.subtower_names.include? current_name
    end

    @root_tower = starting_tower
  end

  def towerify(input)
    lines = input.split(/\n/)

    Towers.new.tap do |towers|
      lines.each do |line|
        tower_data, subtower_data = line.split(' -> ')
        name, weight              = tower_data.split(' ')
        subtower_names            = subtower_data&.split(', ')

        weight.tr!('()', '')

        towers[name] = Tower.new(name, weight, subtower_names)
      end
    end
  end
end

solution = Solution.new(input)

p "Solution 1: #{solution.part_1}"
p "Solution 2: #{solution.part_2}"
