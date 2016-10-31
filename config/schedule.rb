require 'active_record'
require './classes/update_checker.rb'

ActiveRecord::Base.configurations = YAML::load(ERB.new(File.read('./config/database.yml')).result)
ActiveRecord::Base.establish_connection(:development)

every 1.minute do
	UpdateChecker.check("http://tencarat.com/talent/talent042/diary/")
end
