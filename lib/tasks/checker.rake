require 'dotenv'
require './classes/update_checker.rb'

namespace :checker do
	desc "check blog"

	task :start do
		Dotenv.load
		UpdateChecker.check
	end
end
