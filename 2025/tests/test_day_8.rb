# frozen_string_literal: true
require 'minitest/autorun'

require_relative '../day_8'

class CoordinatesTest < Minitest::Test
  def test_distance
    coord0 = Coordinate.new(x: 162, y: 817, z: 812)
    coord1 = Coordinate.new(x: 57, y: 618, z: 57)
    expected = (162-57)**2 + (817-618)**2 + (812-57)**2
    assert_equal(expected, coord0.distance_to(coord1))
  end
end

class DayTest < Minitest::Test
  def setup
    @data_file = File.join(__dir__, "data", "day_8_test.txt")
    @challenge = Day8.new(filename: @data_file)
  end

  def test_pair_sorted
    @challenge.parse_lines
    @challenge.calculate_distances

    assert_equal(190, @challenge.pairs.length)

    pair0 = @challenge.pairs[0]
    pair1 = @challenge.pairs[1]
    assert(pair0.distance < pair1.distance)

    pair2 = @challenge.pairs[2]
    assert(pair1.distance < pair2.distance)
  end

  def test_add_circuit
    @challenge.parse_lines
    @challenge.calculate_distances
    before_count = @challenge.pairs.length

    @challenge.add_circuit
    assert_equal(1, @challenge.circuits.length)
    assert_equal(before_count-1, @challenge.pairs.length)

    @challenge.add_circuit
    assert_equal(1, @challenge.circuits.length)
    assert_equal(3, @challenge.circuits[0].length)
    assert_equal(before_count-2, @challenge.pairs.length)

    @challenge.add_circuit
    assert_equal(2, @challenge.circuits.length)
    assert_equal(3, @challenge.circuits[0].length)
    assert_equal(2, @challenge.circuits[1].length)

    @challenge.add_circuit
    assert_equal(2, @challenge.circuits.length)
    assert_equal(3, @challenge.circuits[0].length)
    assert_equal(2, @challenge.circuits[1].length)
  end

  def test_part_1
    n = @challenge.part_one(10)
    assert_equal(40, n)
  end

  def test_part_2
    n = @challenge.part_two
    assert_equal(25272, n)
  end
end
