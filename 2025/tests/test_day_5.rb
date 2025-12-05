# frozen_string_literal: true
require 'minitest/autorun'

require_relative '../day_5'

class DayTest < Minitest::Test
  def setup
    @challenge = Challenge.new
    @data_file = File.join(__dir__, "data", "day_5_test.txt")
  end

  def test_count_of_fresh
    count = @challenge.count_of_fresh(file_name: @data_file)
    assert_equal(3, count)
  end

  def test_number_of_fresh_ids
    count = @challenge.number_of_fresh_ids(file_name: @data_file)
    assert_equal(14, count)
  end

end