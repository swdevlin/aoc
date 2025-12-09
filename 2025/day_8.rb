# frozen_string_literal: true
require_relative 'challenge'
require 'set'

Coordinate = Data.define(:x, :y, :z) do
  def distance_to(coord)
    (x - coord.x)**2 + (y-coord.y)**2 + (z-coord.z)**2
  end
end

class BoxPair
  attr_reader :box1, :box2, :distance

  def initialize(box1:, box2:)
    @box1 = box1
    @box2 = box2
    @distance = box1.distance_to(box2)
  end

  def eql?(other)
    other.is_a?(BoxPair) && box1.eql?(other.box1) && box2.eql?(other.box2)
  end

  def hash
    [box1, box2].hash
  end

  def <=>(other)
    distance <=> other.distance
  end
end

class Day8 < Challenge
  attr_reader :boxes
  attr_reader :pairs
  attr_reader :circuits

  def initialize(filename: nil)
    @pairs = Array.new
    @boxes = Array.new
    @circuits = Array.new
    super(filename: filename)
  end

  def parse_lines
    @lines.each do |line|
      (x, y, z) = line.split(",")
      @boxes << Coordinate.new(x: x.to_i, y: y.to_i, z: z.to_i)
    end
  end

  def calculate_distances
    (0..@boxes.length-2).each do |i|
      box1 = @boxes[i]
      (i+1...@boxes.length).each do |j|
        box2 = @boxes[j]
        @pairs << BoxPair.new(box1: box1, box2: box2)
      end
    end
    @pairs.sort!
  end

  def add_circuit
    pair = @pairs.shift

    circuit1 = nil
    circuit2 = nil

    @circuits.each do |circuit|
      circuit1 = circuit if circuit.include?(pair.box1)
      circuit2 = circuit if circuit.include?(pair.box2)
      break if circuit1 && circuit2
    end

    if circuit1 && circuit2
      unless circuit1.equal?(circuit2)
        circuit1.merge(circuit2)
        @circuits.delete(circuit2)
      end
    elsif circuit1
      circuit1 << pair.box2
    elsif circuit2
      circuit2 << pair.box1
    else
      @circuits << Set[pair.box1, pair.box2]
    end
    pair
  end

  def part_two
    parse_lines
    calculate_distances
    number_of_boxes = @boxes.length
    loop do
      pair = add_circuit
      if @circuits[0].length == number_of_boxes
        return pair.box1.x * pair.box2.x
      end

    end
  end

  def part_one(connections)
    parse_lines
    calculate_distances
    connections.times do
      add_circuit
    end
    sizes = @circuits.map(&:size)
    sizes.sort! {|a, b| b <=> a}
    sizes.first(3).reduce(1,:*)
  end
end

def run()
  data_file = File.join(__dir__, "data", "day_8.txt")
  challenge = Day8.new(filename: data_file)
  top_3 = challenge.part_one(1000)
  puts "Top 3 product #{top_3}"

  challenge = Day8.new(filename: data_file)
  x = challenge.part_two
  puts "x product is #{x}"

end

if __FILE__ == $0
  run()
end
