require 'yaml'
require './classes/update_checker.rb'

checker = UpdateChecker.new("http://tencarat.com/talent/talent042/diary/")

every 1.minute do
	checker.check
end
