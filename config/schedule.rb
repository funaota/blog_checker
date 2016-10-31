require 'dotenv'
Dotenv.load

require './classes/update_checker.rb'

every 10.minutes do
	runner "UpdateChecker.check"
end
