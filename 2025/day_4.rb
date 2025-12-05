# frozen_string_literal: true

class Challenge

  def load_file(file_name:)
    @matrix = Array.new(0)
    File.foreach(file_name, chomp: true) do |line|
      @matrix << line.split(//)
    end
    @columns = @matrix[0].length
    @rows = @matrix.length
  end

  def moveable_rolls(file_name:)
    load_file(file_name: file_name)
    rolls = 0
    (0...@rows).each do |row|
      (0...@columns).each do |col|
        next unless @matrix[row][col] == '@'
        rolls += 1 if adjacent_count(row: row, col: col) < 4
      end
    end

    rolls
  end

  def remove_rolls(file_name:)
    load_file(file_name: file_name)
    removed = 0
    was_removed = false
    begin
      was_removed = false
      (0...@rows).each do |row|
        (0...@columns).each do |col|
          next unless @matrix[row][col] == '@'
          if adjacent_count(row: row, col: col) < 4
            removed += 1
            @matrix[row][col] = '.'
            was_removed = true
          end
        end
      end
    end while was_removed

    removed
  end

  def adjacent_count(row:, col:)
    count = 0
    (row-1..row+1).each do |r|
      (col-1..col+1).each do |c|
        count += 1 if r >= 0 && r < @rows && c >= 0 && c < @columns && @matrix[r][c] == '@'
      end
    end
    count - 1
  end
end

def run()
  data_file = File.join(__dir__, "data", "day_4.txt")
  challenge = Challenge.new
  rolls = challenge.moveable_rolls(file_name: data_file)
  puts "#{rolls} moveable rolls"

  rolls = challenge.remove_rolls(file_name: data_file)
  puts "#{rolls} removed"
end

# ---- entry point -----------------------------------------------------------

if __FILE__ == $0
  run()
end
