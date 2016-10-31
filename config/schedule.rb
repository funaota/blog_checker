require 'dotenv'
Dotenv.load

require './classes/update_checker.rb'

every 1.minute do
	UpdateChecker.check("http://tencarat.com/talent/talent042/diary/")
end
