require 'circleci'
require 'dotenv'
require 'date'
require 'active_support'
require 'active_support/core_ext'


def today?(date)
  today = DateTime.now
  DateTime.parse(date).new_offset(Rational(9, 24)).to_date == today.to_date
end

def yestaday?(date)
  yestaday = DateTime.now.prev_day
  DateTime.parse(date).new_offset(Rational(9, 24)).to_date == yestaday.to_date
end

def this_week?(date)
  current = DateTime.parse(date).new_offset(Rational(9, 24)).to_date
  DateTime.now.beginning_of_week.to_date <= current && current  <= DateTime.now.end_of_week.to_date
end


def this_month?(date)
  current = DateTime.parse(date).new_offset(Rational(9, 24)).to_date
  DateTime.now.beginning_of_month.to_date <= current && current  <= DateTime.now.end_of_month.to_date
end

Dotenv.load

CircleCi.configure do |config|
  config.token = ENV['CIRCLE_CI_TOKEN']
end

build_sum = 0

res = CircleCi.organization ARGV[0]
res.body.each do |hash|
  info = OpenStruct.new(hash)
  next unless info.start_time
  if today?(info.start_time)
    build_sum += info.build_time_millis if info.build_time_millis
  end
end

puts "sum " + (build_sum / 1000.0 / 60).to_s + " min"
