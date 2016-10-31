require 'rubygems'
require 'active_record'
require 'mysql2'

ActiveRecord::Base.configurations = YAML::load(ERB.new(File.read('./config/database.yml')).result)
ActiveRecord::Base.establish_connection(:production)
# ActiveRecord::Base.establish_connection(:development)

class Post < ActiveRecord::Base

end
