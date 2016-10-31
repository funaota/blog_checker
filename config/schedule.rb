require 'yaml'

every 1.minute do
	checker = UpdateChecker.new("http://tencarat.com/talent/talent042/diary/")
	checker.check
end
