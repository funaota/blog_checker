require 'action_mailer'
require './models/user.rb'

url = Sinatra::Application.root.include?("classes") ? "../views" : "views"

ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, url)
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	:address => 'localhost'
}

class SendMail < ActionMailer::Base

	default from: 'notice_maimaiblog@nogizaka.co'

	def confirm(address, confirm_id)
		@url = "http://maimaiblog.nogizaka.co/confirm?id=" + confirm_id
		mail(to: address, subject: "深川麻衣ブログ通知 確認メール") do |format|
			format.text
		end
	end

	def confirm_ok(address)
		mail(to: address, subject: "深川麻衣ブログ通知 テストメールです") do |format|
			format.text
		end
	end

	def notice(new_content)
		@title = new_content
		users = User.where(status: 1)
		emails = users.map do |user|
			user.email
		end
		mail(bcc: emails, subject: "【深川麻衣】ブログ更新しました！") do |format|
			format.text
		end
	end
end
