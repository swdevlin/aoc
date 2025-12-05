# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../day_4'

class Day3Test < Minitest::Test
  def setup
    @challenge = Challenge.new
    @data_file = File.join(__dir__, "data", "day_4_test.txt")
  end

  def test_moveable_rolls
    rolls = @challenge.moveable_rolls(file_name: @data_file)
    assert_equal(13, rolls)
  end

  def test_remove_rolls
    rolls = @challenge.remove_rolls(file_name: @data_file)
    assert_equal(43, rolls)
  end


end