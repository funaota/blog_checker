require 'dotenv'
Dotenv.load

require './classes/update_checker.rb'

every 10.minute do
	runner "UpdateChecker.check"
end
