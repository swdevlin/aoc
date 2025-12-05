# frozen_string_literal: true

class Challenge

  def get_total_power(file_name:)
    total_power = 0
    File.foreach(file_name, chomp: true) do |line|
      power = '0'
      batteries = line.split(//)
      (0..batteries.length-2).each do |index |
        battery = batteries[index]
        (index+1..batteries.length-1).each do |second|
          if power < battery + batteries[second]
            power = battery + batteries[second]
          end
        end
      end
      total_power += power.to_i
    end
    total_power
  end

  def get_total_power_for_12(file_name:)
    total_power = 0
    File.foreach(file_name, chomp: true) do |line|
      p = get_battery_power(line, 12)
      total_power += p
    end
    total_power
  end

  def get_battery_power(batteries, to_turn_on)
    turned_on = batteries.dup
    index = 1
    while turned_on.length > to_turn_on
      c = turned_on[index]
      if index == turned_on.length
        return turned_on.slice(0,to_turn_on).to_i
      elsif turned_on[index] > turned_on[index-1]
        turned_on.slice!(index-1)
        if index > 1
          index -= 1
        end
      else
        index += 1
      end
    end
    return turned_on.to_i
  end

end

def run()
  data_file = File.join(__dir__, "data", "day_3.txt")
  challenge = Challenge.new
  power = challenge.get_total_power(file_name: data_file)
  puts power

  power = challenge.get_total_power_for_12(file_name: data_file)
  puts power

end

# ---- entry point -----------------------------------------------------------

if __FILE__ == $0
  run()
end
