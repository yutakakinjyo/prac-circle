require 'circleci'
require 'dotenv'
require 'date'

Dotenv.load

CircleCi.configure do |config|
  config.token = ENV['CIRCLE_CI_TOKEN']
end

res = CircleCi.organization 'my-org'
res.body.each do |info|
  next unless info["start_time"]
  DateTime.parse(info["start_time"]).new_offset(Rational(9,24))   
end
