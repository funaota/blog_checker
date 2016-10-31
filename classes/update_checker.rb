require 'watir'
require 'sinatra'
require './classes/send_mail.rb'
require './models/post.rb'

class UpdateChecker

  def self.check(url)
    browser = Watir::Browser.start(url, :phantomjs)
    browser.refresh
    new_content = browser.div(class: "box")
                          .ul(class: "datelist")
                          .li(class: "page").text

    if Post.exists?(:title => new_content)
      not_updated
    else
      updated(new_content)
    end

  end

  def self.updated(new_content)
    SendMail.notice(new_content)
    new_post = Post.new(:title => new_content)
    new_post.save
  end

  def self.not_updated
    SendMail.notice("takuji.funao@gmail.com").deliver
  end
end
