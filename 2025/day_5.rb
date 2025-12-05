# frozen_string_literal: true

class IngredientRange
  attr_accessor :min, :max

  def inspect
    "#<IngredientRange: #{@min}-#{@max}>"
  end

  def initialize(min, max)
    @min = min
    @max = max
  end

  def number_of_ingredients
    @max - @min + 1
  end

  def contains?(id)
    id >= @min && id <= @max
  end

  def unique_ranges(range)
    return [range] if range.min > @max
    return [range] if range.max < @min
    return [] if range.min >= @min && range.max <= @max

    ranges = []

    if range.min < @min
      if range.max > @max
        ranges << IngredientRange.new(range.min, @min - 1)
        ranges << IngredientRange.new(@max+1, range.max)
      else
        ranges << IngredientRange.new(range.min, @min - 1)
      end
    else
      ranges << IngredientRange.new(@max+1, range.max)
    end
    ranges
  end

end

class FreshIngredients
  def initialize
    @ingredients = Array.new(0)
  end

  def add(ingredient_range)
    if @ingredients.empty?
      @ingredients << ingredient_range
      return
    end

    unique_ranges = [ingredient_range]

    @ingredients.each_with_index do |range, index|
      r = unique_ranges.shift
      break if r.nil?

      parts = range.unique_ranges(r)
      next if parts.empty?

      if parts[0].max < range.min
        @ingredients.insert(index, parts[0])
        unique_ranges << parts[1] if parts.length > 1
      else
        unique_ranges.concat(parts)
      end
    end
    @ingredients.concat(unique_ranges)
  end

  def total
    @ingredients.sum { |i| i.number_of_ingredients }
  end

end


class Challenge

  def load_file(file_name:)
    @fresh = Array.new(0)
    @ingredients = Array.new(0)
    state = :fresh
    File.foreach(file_name, chomp: true) do |line|
      if line.length == 0
        state = :ingredients
        next
      end
      if state == :fresh
        l, u = line.split('-')
        @fresh << IngredientRange.new(l.to_i, u.to_i)
      else
        @ingredients << line.to_i
      end
    end
  end

  def is_fresh?(id)
    @fresh.any? {|f| f.contains?(id) }
  end

  def count_of_fresh(file_name:)
    load_file(file_name: file_name)
    @ingredients.select {|i| is_fresh?(i) }.count
  end

  def already_present?(id, index)
    if index.zero?
      false
    else
      @fresh.slice(0,index).any? {|f| f.contains?(id) }
    end
  end

  def number_of_fresh_ids(file_name:)
    load_file(file_name: file_name)

    unique_fresh = FreshIngredients.new
    @fresh.each do |range|
      unique_fresh.add(range)
    end
    unique_fresh.total
  end
end

def run()
  data_file = File.join(__dir__, "data", "day_5.txt")
  challenge = Challenge.new

  count = challenge.count_of_fresh(file_name: data_file)
  puts "#{count} fresh ingrediants"

  count = challenge.number_of_fresh_ids(file_name: data_file)
  puts "#{count} total ingredients marked as fresh"

end

# ---- entry point -----------------------------------------------------------

if __FILE__ == $0
  run()
end
