require 'circleci'
require 'dotenv'
require 'date'

Dotenv.load

CircleCi.configure do |config|
  config.token = ENV['CIRCLE_CI_TOKEN']
end

today = DateTime.now
build_sum = 0

res = CircleCi.organization ARGV[0]
res.body.each do |info|
  next unless info["start_time"]
  if DateTime.parse(info["start_time"]).to_date == today.to_date
    build_sum += info["build_time_millis"] if info["build_time_millis"]
  end
end

puts "sum " + (build_sum / 1000.0 / 60).to_s + " min"
