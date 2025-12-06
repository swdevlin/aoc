# frozen_string_literal: true
require 'minitest/autorun'

require_relative '../day_6'

class DayTest < Minitest::Test
  def setup
    @challenge = Challenge.new
    @data_file = File.join(__dir__, "data", "day_6_test.txt")
  end

  def test_input_parser
    @challenge.load_file(file_name: @data_file)
    expected = Problem.new
    expected.operator = '*'
    expected.numbers =[123, 45, 6]
    assert_equal(expected, @challenge.problems[0])

    expected.operator = '+'
    expected.numbers = [328, 64, 98]
    assert_equal(expected, @challenge.problems[1])
  end

  def test_column_indexes
    indexes = @challenge.column_indexes('*   +   *   +  ')
    assert_equal([0,4,8,12], indexes)
  end

  def test_right_to_left_parser
    @challenge.right_to_left_loader(file_name: @data_file)

    expected = Problem.new
    expected.operator = '*'
    expected.numbers =[1, 24, 356]
    assert_equal(expected, @challenge.problems[0])

    expected.operator = '+'
    expected.numbers = [369, 248, 8]
    assert_equal(expected, @challenge.problems[1])

    expected.operator = '+'
    expected.numbers = [623, 431, 4]
    assert_equal(expected, @challenge.problems[-1])
  end

  def test_grand_total
    @challenge.load_file(file_name: @data_file)
    assert_equal(4277556, @challenge.grand_total)
  end

  def test_right_to_left_grand_total
    @challenge.right_to_left_loader(file_name: @data_file)
    assert_equal(3263827, @challenge.grand_total)
  end
end