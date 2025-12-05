# frozen_string_literal: true

class StopCounter
  attr_accessor :dial
  attr_reader :count

  def turn_dial(line)
    direction = line.slice(0,1)
    turns = line.slice(1,line.length-1)
    turns = turns.to_i
    @dial += (direction == 'R' ? turns : -turns)
    while @dial < 0
      @dial += 100
    end
    while @dial >= 100
      @dial -= 100
    end
  end

  def turn_dial_pass(line, target)
    initial_dial = @dial

    direction = line.slice(0,1)
    turns = line.slice(1,line.length-1)
    turns = turns.to_i
    @dial += (direction == 'R' ? turns : -turns)
    passes = 0
    if direction == 'R' and initial_dial < target && @dial >= target
      passes = 1
    end

    if direction == 'L' and initial_dial > target && @dial <= target
      passes = 1
    end

    passes += @dial.abs.div(100)
    while @dial < 0
      @dial += 100
    end
    while @dial >= 100
      @dial -= 100
    end

    passes
  end

  def stop_check(file_name:, start:, target:)
    @dial = start
    @count = 0
    File.open(file_name).each do |line|
      turn_dial(line.chomp)
      @count += 1 if @dial == target
    end
  end

  def pass_check(file_name:, start:, target:)
    @dial = start
    @count = 0
    File.open(file_name).each do |line|
      @count += turn_dial_pass(line.chomp, target)
    end
  end
end

# ---- main logic ------------------------------------------------------------

def run()
  data_file = File.join(__dir__, "data", "day_1.txt")
  counter = StopCounter.new
  counter.stop_check(file_name: data_file, start:50, target:0)
  puts "Day 1 answer: #{counter.count}"

  counter.pass_check(file_name: data_file, start:50, target:0)
  puts "Day 2 answer: #{counter.count}"
end

# ---- entry point -----------------------------------------------------------

if __FILE__ == $0
  run()
end
