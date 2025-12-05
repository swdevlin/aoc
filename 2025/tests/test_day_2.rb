# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../day_2'

class Day2Test < Minitest::Test
  def setup
    @checker = IdChecker.new
    @data_file = File.join(__dir__, "data", "day_2_test.txt")
  end

  def test_invalid_ids
    total = 0
    invalids = @checker.get_invalid_ids(file_name: @data_file)
    invalids.each do |id|
      total += id
    end
    assert_equal(1227775554, total)
  end

  def test_repeating_ids
    total = 0
    invalids = @checker.get_repeating_ids(file_name: @data_file)
    invalids.each do |id|
      total += id
    end
    assert_equal(4174379265, total)
  end
end