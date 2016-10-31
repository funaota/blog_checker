require 'watir'
require 'sinatra'
require './classes/send_mail.rb'

class UpdateChecker

  def initialize(url)
    @browser = Watir::Browser.start(url, :phantomjs)
    @old_content = nil
  end

  def check
    @browser.refresh
    new_content = @browser.div(class: "box")
                          .ul(class: "datelist")
                          .li(class: "page").text

    unless @old_content.nil?
      if @old_content == new_content
        not_updated
      else
        updated(new_content)
      end
    end

    @old_content = new_content
  end

  def updated(new_content)
    SendMail.notice("takuji.funao@gmail.com").deliver
    puts "#{@browser.title} updated on #{Time.now}"
    puts new_content
  end

  def not_updated
    SendMail.notice("takuji.funao@gmail.com").deliver
    puts "#{@browser.title} not updated"
  end
end
