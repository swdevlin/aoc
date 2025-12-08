# frozen_string_literal: true
require_relative 'challenge'
require 'set'

class Day7 < Challenge
  attr_accessor :beams
  attr_accessor :splits
  attr_accessor :timelines

  def initialize(filename: nil)
    @beams = Set.new
    @splits = 0
    @timelines = Hash.new(0)
    super(filename: filename)
  end

  def parse(line)
    new_beams = Set.new
    stops = Array.new
    line.chars.each_with_index do |c, i|
      case c
      when 'S'
        new_beams << i
        @timelines[i] += 1
      when '^'
        if @beams.include? i
          new_beams << i-1
          new_beams << i+1
          stops << i
          @splits += 1
          @timelines[i-1] += @timelines[i]
          @timelines[i+1] += @timelines[i]
          @timelines[i] = 0
        end
      end
    end
    @beams.subtract(stops)
    @beams.merge(new_beams)
  end

  def parse_lines
    @lines.each {|l| parse(l)}
  end

  def total_timelines
    @timelines.values.sum
  end
end

def run()
  data_file = File.join(__dir__, "data", "day_7.txt")
  challenge = Day7.new(filename: data_file)
  challenge.parse_lines

  puts "There are #{challenge.splits} splits"

  puts "There are #{challenge.total_timelines} timelines"

end

if __FILE__ == $0
  run()
end
