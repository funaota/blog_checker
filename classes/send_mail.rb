require 'action_mailer'

ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, 'views')
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	:address => 'localhost'
}


class SendMail < ActionMailer::Base

	default from: 'notice_maimaiblog@nogizaka.co'

	def confirm(address, confirm_id)
		@url = "http://maimaiblog.nogizaka.co/confirm?id=" + confirm_id
		mail to: address
		mail subject: "深川麻衣ブログ通知 確認メール"
		mail do |format|
			format.text
		end
	end

	def confirm_ok(address)
		mail to: address
		mail subject: "深川麻衣ブログ通知 テストメールです"
		mail do |format|
			format.text
		end
	end

	def notice(address)
		mail to: address
		mail subject: "ブログ更新したよー！"
		mail do |format|
			format.text
		end
	end
end
