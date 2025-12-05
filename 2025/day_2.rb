# frozen_string_literal: true

# frozen_string_literal: true

class IdChecker

  def each_id_from_file(file_name)
    File.foreach(file_name, chomp: true) do |line|
      line.split(',').each do |range|
        min, max = range.split('-').map!(&:to_i)
        (min..max).each do |id|
          yield id.to_s
        end
      end
    end
  end

  def get_invalid_ids(file_name:)
    ids = []
    each_id_from_file(file_name) do |id|
      next unless id.length.even?

      left = id[0, id.length / 2]
      right = id[id.length / 2, id.length]
      if left == right
        ids << id.to_i
      end
    end

    ids
  end

  def get_repeating_ids(file_name:)
    ids = []
    each_id_from_file(file_name) do |id|
      l = id.length
      (1..l/2).select { |i| l.modulo(i).zero? }.each do |i|
        chunks = id.scan(/.{#{i}}/)
        if chunks.all? {|chunk| chunk == chunks[0]}
          ids << id.to_i
          break
        end
      end
    end

    ids
  end
end

def run()
  data_file = File.join(__dir__, "data", "day_2.txt")
  checker = IdChecker.new
  invalid_ids = checker.get_invalid_ids(file_name: data_file)
  puts invalid_ids.sum

  invalid_ids = checker.get_repeating_ids(file_name: data_file)
  puts invalid_ids.sum
end

# ---- entry point -----------------------------------------------------------

if __FILE__ == $0
  run()
end
