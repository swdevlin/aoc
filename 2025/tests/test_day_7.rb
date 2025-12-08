# frozen_string_literal: true
require 'minitest/autorun'

require_relative '../day_7'

class DayTest < Minitest::Test
  def setup
    @data_file = File.join(__dir__, "data", "day_7_test.txt")
    @challenge = Day7.new(filename: @data_file)
  end

  def test_start
    @challenge.parse('.......S.......')
    expected = Set.new
    expected << 7
    assert_equal(expected, @challenge.beams)
  end

  def test_split
    @challenge.parse('.......S.......')
    @challenge.parse('.......^.......')
    expected = Set.new
    expected << 6
    expected << 8

    s = Set.new
    s << 6
    s << 7
    @challenge.beams = s
    @challenge.parse('......^^.......')
    expected = Set.new
    expected << 5
    expected << 6
    expected << 7
    expected << 8
    assert_equal(expected, @challenge.beams)
  end

  def test_part_1
    @challenge.parse_lines
    expected = 21
    assert_equal(expected, @challenge.splits)
  end

  def test_part_2
    @challenge.parse_lines
    expected = 40
    assert_equal(expected, @challenge.total_timelines)
  end
end