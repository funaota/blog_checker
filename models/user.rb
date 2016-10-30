require 'rubygems'
require 'active_record'
require 'mysql2'
require 'securerandom'
require 'erb'
require './classes/send_mail.rb'

ActiveRecord::Base.configurations = YAML::load(ERB.new(File.read('./configs/database.yml')).result)
ActiveRecord::Base.establish_connection(:development)

class User < ActiveRecord::Base
	validates :email, uniqueness: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
	validates :email, presence: true

	before_save :before_save_user
	after_save	:send_confirm_mail

	def before_save_user
		self.status = 0 # status 0 is don't send mail
		self.confirm_id = SecureRandom.uuid.upcase
	end

	def send_confirm_mail
		SendMail.confirm(self.email, self.confirm_id).deliver
	end

	def self.confirm(params_id)
		@user = User.find_by(confirm_id: params_id)
		@user.status = 1
		SendMail.confirm_ok(@user.email).deliver
	end

end
