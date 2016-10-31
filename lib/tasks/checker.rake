require './classes/update_checker.rb'

namespace :checker do
	desc "check blog"

	task :start do
		UpdateChecker.check
	end
end
