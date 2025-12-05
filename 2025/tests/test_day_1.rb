require 'minitest/autorun'

require_relative '../day_1'

class Day1Test < Minitest::Test
  def setup
    @counter = StopCounter.new
    @data_file = File.join(__dir__, "data", "day_1_test.txt")
  end

  def test_turn_dial
    @counter.dial = 12
    @counter.turn_dial('L3')
    assert_equal(@counter.dial, 9)
    @counter.turn_dial('L15')
    assert_equal(@counter.dial, 94)
    @counter.turn_dial('R25')
    assert_equal(@counter.dial, 19)
  end

  def test_turn_dial_pass
    @counter.dial = 12
    passes = @counter.turn_dial_pass('L3', 10)
    assert_equal(@counter.dial, 9)
    assert_equal(1, passes)

    passes = @counter.turn_dial_pass('L15', 10)
    assert_equal(@counter.dial, 94)
    assert_equal(0, passes)

    passes = @counter.turn_dial_pass('R125', 10)
    assert_equal(@counter.dial, 19)
    assert_equal(2, passes)
  end

  def test_turn_dial_pass_zero
    @counter.dial = 50
    passes = @counter.turn_dial_pass('L68', 0)
    assert_equal(1, passes)
  end

  def test_stops
    @counter.stop_check(file_name: @data_file, start:50, target:0)
    assert_equal(3, @counter.count)
  end

  def test_passes
    @counter.pass_check(file_name: @data_file, start:50, target:0)
    assert_equal(6, @counter.count)
  end
end
