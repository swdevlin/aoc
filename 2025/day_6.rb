# frozen_string_literal: true

class Problem
  attr_accessor :operator, :numbers

  def initialize(operator: '', numbers: [])
    @operator = operator
    @numbers = numbers
  end

  def <<(n)
    @numbers << n
  end

  def ==(other)
    other.operator == @operator && other.numbers == @numbers
  end

  def compute
    case @operator
    when '+'
      @numbers.sum
    when '*'
      @numbers.inject(1, :*)
    end
  end
end

class Challenge
  attr_reader :problems

  def load_file(file_name:)
    @problems = Array.new(0)
    File.foreach(file_name, chomp: true) do |line|
      line.strip!
      tokens = line.split(/\s+/)
      tokens.each_with_index do |token, index|
        if index == @problems.length
          @problems << Problem.new
        end
        if ["+", "*"].include?(token)
          @problems[index].operator = token
        else
          @problems[index] << token.to_i
        end
      end
    end
  end

  def column_indexes(line)
    indexes = Array.new
    line.chars.each_with_index do |char, index|
      indexes << index if char != ' '
    end

    indexes
  end

  def column_numbers(col)
    start_column = @columns_start_at[col]
    end_column = col < @columns_start_at.length - 1 ? @columns_start_at[col+1] - 2 : @lines[0].length-1
    numbers = Array.new
    (start_column..end_column).each do |c|
      ni = c - start_column
      if ni == numbers.length
        numbers << ''
      end

      @lines[0..-2].each {|line|numbers[ni] += line[c] if line[c] != ' '}
    end
    numbers.map!(&:to_i)
  end

  def right_to_left_loader(file_name:)
    @problems = Array.new(0)
    @lines = Array.new
    File.foreach(file_name, chomp: true) {|line| @lines << line}
    @columns_start_at = column_indexes(@lines[-1])
    @columns_start_at.each_with_index do |column, index|
      numbers = column_numbers(index)
      @problems << Problem.new(operator: @lines[-1][column], numbers: numbers)
    end
  end

  def grand_total
    @problems.sum {|p| p.compute }
  end
end

def run()
  data_file = File.join(__dir__, "data", "day_6.txt")
  challenge = Challenge.new

  total = challenge.load_file(file_name: data_file)
  total = challenge.grand_total()
  puts "Math problems add to #{total}"

  challenge = Challenge.new
  challenge.right_to_left_loader(file_name: data_file)
  total = challenge.grand_total()
  puts "Proper cephalopod math problems add to #{total}"

end

if __FILE__ == $0
  run()
end
