# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../day_3'

class Day3Test < Minitest::Test
  def setup
    @challenge = Challenge.new
    @data_file = File.join(__dir__, "data", "day_3_test.txt")
  end

  def test_batteries
    total = @challenge.get_total_power(file_name: @data_file)
    assert_equal(357, total)
  end

  def test_get_battery_power
    line = '811111111111119'
    power = @challenge.get_battery_power(line, 12)
    assert_equal( 811111111119, power)

    line = '2322212211121222222223222233222323313322222231123322133322343221642232212242223323123222333313912123'
    power = @challenge.get_battery_power(line, 12)
    assert_equal(644333912123, power)

    line = '818181911112111'
    power = @challenge.get_battery_power(line, 12)
    assert_equal(888911112111, power)

    line = '234234234234278'
    power = @challenge.get_battery_power(line, 12)
    assert_equal(434234234278, power)

    line = '987654321111111'
    power = @challenge.get_battery_power(line, 12)
    assert_equal(987654321111, power)

  end

  def test_12_batteries
    total = @challenge.get_total_power_for_12(file_name: @data_file)
    assert_equal(3121910778619, total)
  end

end