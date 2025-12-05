require 'dotenv/load'
require 'net/http'
require 'optparse'
require 'fileutils'

options = {}
OptionParser.new do |parser|
  parser.banner = "Usage: day_fetcher.rb [options]"

  parser.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  parser.on("-dDAY", "--day=DAY", "which day") do |d|
    options[:day] = d
  end

  parser.on("-yYEAR", "--year=YEAR", "which year") do |y|
    options[:year] = y
  end
end.parse!

dir_path = "#{options[:year]}/data"
FileUtils.mkdir(dir_path) unless File.directory?(dir_path)

url = "https://adventofcode.com/#{options[:year]}/day/#{options[:day]}/input"

session = ENV.fetch('SESSION') do
  puts "SESSION environment variable not set"
  exit 1
end

file_name = "#{dir_path}/day_#{options[:day]}.txt"
uri = URI(url)
headers = {'Cookie' => "session=#{session}"}
File.write(file_name, Net::HTTP.get(uri, headers))
