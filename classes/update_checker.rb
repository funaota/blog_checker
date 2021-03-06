require 'watir'
require 'sinatra'
require './classes/send_mail.rb'
require './models/post.rb'

class UpdateChecker

  def self.check
    browser = Watir::Browser.start("http://tencarat.com/talent/talent042/diary/", :phantomjs)
    browser.refresh
    new_content = browser.div(class: "box")
                          .ul(class: "datelist")
                          .li(class: "page")
                          .div(class: "title").text

    unless Post.exists?
      first_post = Post.new(title: new_content)
      first_post.save
    end

    if Post.exists?(title: new_content)
      not_updated
    else
      updated(new_content)
    end

  end

  def self.updated(new_content)
    SendMail.notice(new_content).deliver
    new_post = Post.new(title: new_content)
    new_post.save
  end

  def self.not_updated
    p "not update"
  end
end
