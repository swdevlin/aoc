# frozen_string_literal: true

class Challenge

  def initialize(filename: nil)
    super()
    @lines = []
    load_file(filename) unless filename.nil?
  end

  def load_file(filename)
    File.foreach(filename, chomp: true) {|line| @lines << line}
  end

  def line(i)
    @lines.length > i ? @lines[i] : nil
  end

  def part_one
    puts 'not implemented'
  end

  def part_two
    puts 'not implemented'
  end
end
