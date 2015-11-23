require 'circleci'
require 'dotenv'

Dotenv.load

CircleCi.configure do |config|
  config.token = ENV['CIRCLE_CI_TOKEN']
end

res = CircleCi::User.me
puts res.success?
