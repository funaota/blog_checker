require './classes/update_checker.rb'

namespace :checker do
	desc "ブログをチェックする"

	task :start do
		UpdateChecker.check
	end
end
